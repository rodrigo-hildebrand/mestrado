#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Métricas de Legibilidade (PT) — Versão ajustada
------------------------------------------------
Calcula:
- Flesch Reading Ease (FRE) — constante ajustada para 248.835
- Índice de Gulpease
- Índice Gunning Fog — fórmula ajustada
- Índice de Coleman–Liau (CLI) — coeficientes ajustados
- Índice ARI — coeficientes ajustados

Uso (linha de comando):
    python legibilidade_pt.py --texto "Seu texto aqui..."
    # ou
    python legibilidade_pt.py --arquivo caminho/para/arquivo.txt
    # com interpretações resumidas:
    python legibilidade_pt.py --texto "Seu texto aqui..." --interpretar
"""

from __future__ import annotations
import argparse
import re
from dataclasses import dataclass
from typing import List, Dict

# -------------------- Configuração --------------------
FLESCH_CONST = 248.835  # constante solicitada para o Flesch Reading Ease

# Conjunto de vogais (PT/EN) para heurística de sílabas
VOGAIS = "aeiouáéíóúâêîôûãõàäëïöüAEIOUÁÉÍÓÚÂÊÎÔÛÃÕÀÄËÏÖÜ"


# -------------------- Utilidades de texto --------------------

def normalizar_espacos(texto: str) -> str:
    """Colapsa espaços em branco e remove espaços nas bordas."""
    return re.sub(r"\s+", " ", texto).strip()

def separar_frases(texto: str) -> List[str]:
    """Separa em sentenças (heurística simples para PT/EN)."""
    texto = texto.replace("…", ".")
    # Evita quebrar em abreviações comuns (Dr., Sr., Sra., Prof., etc.)
    seguro = re.sub(r"\b([Dd]r|[Ss]r|[Ss]ra|[Pp]rof|[Mm]r|[Mm]rs|[Mm]s)\.\s",
                    r"\1<ABREV> ", texto)
    partes = re.split(r"(?<=[.!?])\s+", seguro)
    partes = [p.replace("<ABREV>", ".") for p in partes if p.strip()]
    return partes if partes else [texto]

def tokenizar_palavras(texto: str) -> List[str]:
    """Extrai palavras (suporta acentos e hífens/apóstrofos internos)."""
    return re.findall(r"[A-Za-zÀ-ÖØ-öø-ÿ]+(?:[-'][A-Za-zÀ-ÖØ-öø-ÿ]+)*", texto)

def contar_letras(texto: str) -> int:
    """Conta apenas letras (com acentos)."""
    return len(re.findall(r"[A-Za-zÀ-ÖØ-öø-ÿ]", texto))


# -------------------- Sílabas e complexidade --------------------

def contar_silabas(palavra: str) -> int:
    """
    Heurística PT/EN: conta grupos vocálicos; garante >= 1.
    Nota: não é um separador silábico perfeito, mas serve para índices.
    """
    w = palavra.lower()
    w = re.sub(r"[^a-zà-öø-ÿ]", "", w, flags=re.IGNORECASE)
    if not w:
        return 0
    grupos = re.findall(rf"[{VOGAIS}]+", w, flags=re.IGNORECASE)
    sil = len(grupos)
    # 'e' final silencioso (mais útil em EN; inofensivo em PT)
    if w.endswith("e") and sil > 1 and not re.search(rf"[{VOGAIS}]e$", w):
        sil -= 1
    return max(1, sil)

def palavra_complexa(palavra: str) -> bool:
    """
    Palavra complexa = 3+ sílabas (ignora acrônimos curtos em CAIXA ALTA).
    Usado no índice Gunning Fog.
    """
    if palavra.isupper() and len(palavra) <= 4:
        return False
    return contar_silabas(palavra) >= 3


# -------------------- Métricas --------------------

@dataclass
class Contagens:
    frases: int
    palavras: int
    letras: int
    caracteres: int  # não brancos
    silabas: int
    palavras_complexas: int

def obter_contagens(texto: str) -> Contagens:
    frases = separar_frases(texto)
    palavras = tokenizar_palavras(texto)
    letras = contar_letras(texto)
    caracteres = len(re.findall(r"\S", texto))  # não brancos (para ARI)
    silabas = sum(contar_silabas(w) for w in palavras)
    palavras_cx = sum(1 for w in palavras if palavra_complexa(w))
    return Contagens(
        frases=max(1, len(frases)),
        palavras=max(1, len(palavras)),
        letras=letras,
        caracteres=caracteres,
        silabas=silabas,
        palavras_complexas=palavras_cx,
    )

def flesch_reading_ease(c: Contagens) -> float:
    # FRE = FLESCH_CONST − 1.015*(W/S) − 84.6*(SYL/W)
    wps = c.palavras / c.frases
    spw = c.silabas / c.palavras
    return FLESCH_CONST - 1.015 * wps - 84.6 * spw

def gulpease(c: Contagens) -> float:
    # Gulpease = 89 + (300*S − 10*L)/W
    return 89 + (300 * c.frases - 10 * c.letras) / c.palavras

def gunning_fog(c: Contagens) -> float:
    """
    Fórmula ajustada conforme solicitado:
    Fog = 0.49 * (W/S) + 47.5 * (CW/W)

    Implementação conforme trecho enviado:
        pct_complexas = (CW/W) * 47.5
        return 0.49 * (wps + pct_complexas)
    OBS: Essa implementação resulta em 0.49*(W/S) + 23.275*(CW/W).
    """
    wps = c.palavras / c.frases
    pct_complexas = (c.palavras_complexas / c.palavras) * 47.5
    return 0.49 * (wps + pct_complexas)

def coleman_liau(c: Contagens) -> float:
    """
    CLI ajustado:
    CLI = 0.054 * L100 − 0.21 * S100 − 14
    onde L100 = letras por 100 palavras; S100 = sentenças por 100 palavras
    """
    L100 = (c.letras / c.palavras) * 100.0
    S100 = (c.frases / c.palavras) * 100.0
    return 0.054 * L100 - 0.21 * S100 - 14

def ari(c: Contagens) -> float:
    """
    ARI ajustado:
    ARI = 4.6 * (C/W) + 0.44 * (W/S) − 20
    onde C = caracteres não brancos
    """
    return 4.6 * (c.caracteres / c.palavras) + 0.44 * (c.palavras / c.frases) - 20


# -------------------- Interpretações opcionais --------------------

def interpretar_metricas(c: Contagens, m: Dict[str, float]) -> Dict[str, str]:
    """Retorna frases curtas de interpretação em PT-BR (referenciais aproximados)."""
    out = {}

    # Flesch (quanto maior, mais fácil)
    fre = m["Flesch Reading Ease"]
    if fre >= 60:
        out["Flesch Reading Ease"] = "fácil (acessível ao público geral)."
    elif fre >= 30:
        out["Flesch Reading Ease"] = "médio (exige alguma familiaridade)."
    else:
        out["Flesch Reading Ease"] = "difícil (frases longas/linguagem densa)."

    # Gulpease (quanto maior, mais fácil)
    gp = m["Índice de Gulpease"]
    if gp >= 60:
        out["Índice de Gulpease"] = "fácil."
    elif gp >= 40:
        out["Índice de Gulpease"] = "médio."
    else:
        out["Índice de Gulpease"] = "difícil."

    # Fog (regra prática)
    fog = m["Índice Gunning Fog"]
    if fog <= 12:
        out["Índice Gunning Fog"] = "adequado ao público geral (≤12)."
    elif fog <= 16:
        out["Índice Gunning Fog"] = "intermediário/superior introdutório (12–16)."
    else:
        out["Índice Gunning Fog"] = "avançado (>16)."

    # CLI e ARI (anos/séries escolares aproximadas em EN)
    def faixa_escolar(x: float) -> str:
        if x < 6:
            return "Fundamental I (aprox.)"
        if x < 10:
            return "Fundamental II (aprox.)"
        if x < 13:
            return "Ensino médio (aprox.)"
        return "Nível superior (aprox.)"

    out["Índice de Coleman–Liau"] = faixa_escolar(m["Índice de Coleman–Liau"])
    out["Índice ARI"] = faixa_escolar(m["Índice ARI"])
    return out


# -------------------- Saída --------------------

def imprimir_metricas(texto: str, interpretar: bool = False) -> None:
    c = obter_contagens(texto)
    metricas = {
        "Flesch Reading Ease": flesch_reading_ease(c),
        "Índice de Gulpease": gulpease(c),
        "Índice Gunning Fog": gunning_fog(c),
        "Índice de Coleman–Liau": coleman_liau(c),
        "Índice ARI": ari(c),
    }

    print("\n=== Métricas de Legibilidade (ajustadas) ===")
    print(
        f"Frases: {c.frases} | Palavras: {c.palavras} | Letras: {c.letras} | "
        f"Caracteres (não brancos): {c.caracteres} | Sílabas (heur.): {c.silabas} | "
        f"Palavras complexas (≥3 sílabas): {c.palavras_complexas}"
    )
    for nome, valor in metricas.items():
        print(f"{nome}: {valor:.2f}")

    print("\nReferenciais úteis (aproximados):")
    print("- Flesch: ≥60 fácil; 30–60 médio; <30 difícil. (constante ajustada em 248.835)")
    print("- Gulpease: ≥60 fácil; 40–60 médio; <40 difícil.")
    print("- Fog: ≤12 público geral; 12–16 intermediário; >16 avançado.")
    print("- Coleman–Liau e ARI ≈ séries/anos escolares (base EN; usar como aproximação).")

    if interpretar:
        print("\nInterpretação resumida:")
        interp = interpretar_metricas(c, metricas)
        for nome, frase in interp.items():
            print(f"- {nome}: {frase}")


# -------------------- CLI --------------------

def main():
    parser = argparse.ArgumentParser(
        description="Calcula índices de legibilidade (Português) — versão com fórmulas ajustadas."
    )
    grupo = parser.add_mutually_exclusive_group(required=True)
    grupo.add_argument("--texto", type=str, help="Texto de entrada entre aspas.")
    grupo.add_argument("--arquivo", type=str, help="Caminho para arquivo .txt com o texto.")
    parser.add_argument("--interpretar", action="store_true",
                        help="Imprime interpretações resumidas em PT-BR.")

    args = parser.parse_args()

    if args.texto:
        texto = args.texto
    else:
        with open(args.arquivo, "r", encoding="utf-8") as f:
            texto = f.read()

    texto = normalizar_espacos(texto)
    imprimir_metricas(texto, interpretar=args.interpretar)


if __name__ == "__main__":
    main()
