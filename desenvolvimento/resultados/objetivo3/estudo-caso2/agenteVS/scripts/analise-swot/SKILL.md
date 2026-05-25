---
name: analise-swot
description: Receba uma politica publica e os riscos relacionados produzidos pela skill analise-risco e elabore uma analise SWOT estruturada (forcas, fraquezas, oportunidades, ameacas) com base exclusivamente nos dados fornecidos. Nao use Python na analise. Use esta skill quando o usuario pedir analise SWOT de uma politica, avaliacao estrategica de programa governamental ou diagnostico de pontos fortes e fracos para fins de auditoria.
compatibility: Any
---

# Analise SWOT

Execute a analise sem usar Python.
Nao use inferencia heuristica para preencher quadrantes ausentes.
Nao invente riscos, normativos, controles ou caracteristicas nao presentes nas entradas.
Cada item dos quadrantes deve ser rastreavel a um campo explicito da entrada.

## Objetivo

Produzir uma analise SWOT de politica publica com foco em auditoria operacional, retornando quatro quadrantes preenchidos com base nos dados de risco fornecidos:

- **Forcas** (Strengths): as características positivas internas que uma organização pode explorar para atingir as suas metas. Referem-se às habilidades, capacidades e competências básicas da organização que atuam em conjunto para ajudá-la a alcançar suas metas e objetivos. Ex.: equipe experiente e motivada, recursos tecnológicos adequados
- **Fraquezas** (Weaknesses): falhas, lacunas e vulnerabilidades internas identificadas nos riscos.  As características negativas internas que podem inibir ou restringir o desempenho da
organização. Referem-se à ausência de capacidades e/ou habilidades críticas. São, portanto, deficiências e características que devem ser superadas ou contornadas para que a organização possa alcançar o nível de desempenho desejado. Ex.: alta rotatividade de pessoal, sistemas de informação obsoletos, processos internos excessivamente burocratizados. 
- **Oportunidades** (Opportunities): Características do ambiente externo, não controláveis
pela organização, com potencial para ajudá-la a crescer e atingir ou exceder as metas planejadas. Ex.: diretrizes governamentais favoráveis ao fortalecimento institucional, novas fontes orçamentárias, parcerias com outras instituições.
.
- **Ameacas** (Threats): Características do ambiente externo, não controláveis pela organização, que podem impedi-la de atingir as metas planejadas e comprometer o crescimento
organizacional. Ex.: dispersão geográfica do públicoalvo, disparidades regionais, conflito de competência.

## Dependencia obrigatoria

Esta skill depende de:

1. **Analise de risco** (saida de `analise-risco`): campos `riscos_especificos`, `riscos_gerais`, `avaliacao_dvr`, `matriz_risco` e `normativos_utilizados`.

Se `riscos_especificos` estiver ausente ou vazio, interrompa e retorne `dependencia_pendente`.

## Entradas

Aceite qualquer combinacao destes campos:

```json
{
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "analise_risco": {
    "arquivo_resultado": "skills/analise-risco/references/generated/seguro-defeso/resultado-analise.json"
  }
}
```

Campos aceitos:

- `politica_publica` (obrigatorio)
- `politica_slug` (recomendado; derivar do nome se ausente)
- `analise_risco.arquivo_resultado` (obrigatorio; caminho para o JSON de analise de risco)

## Regras de interrupcao por dependencia

Se o arquivo de analise de risco nao existir ou `riscos_especificos` estiver vazio:

```json
{
  "status": "dependencia_pendente",
  "politica_publica": "Seguro defeso",
  "dependencias": ["analise-risco"],
  "acao_orquestrador": "Execute a skill analise-risco para a politica e reenvie o resultado para analise-swot.",
  "lacunas": ["riscos_especificos ausentes ou vazios para Seguro defeso."]
}
```

## Regras de mapeamento por quadrante

Cada quadrante e preenchido a partir de campos especificos do JSON de analise de risco. Nenhum item pode ser inventado.

### Forcas

Fontes permitidas (em ordem de preferencia):

1. `normativos_utilizados[*]`: cada normativo com sua `relevancia` representa uma forca do marco legal.
2. Bases de dados identificadas na analise (`riscos_especificos[*].normativos_base` como referencia ao ecossistema de dados existente).

Formato de cada item:

```json
{
  "item": "Marco legal consolidado: Lei 10.779/2003 — Norma central do beneficio de seguro-defeso.",
  "fonte": "normativos_utilizados[0]"
}
```

### Fraquezas

Fontes permitidas:

1. `riscos_especificos[*].causa`: cada causa identificada e uma fraqueza operacional ou de controle.

Formato de cada item:

```json
{
  "item": "Validacao insuficiente do relatorio anual de exercicio da atividade pesqueira.",
  "fonte": "riscos_especificos[RE-01].causa"
}
```

Deduplicar: se duas causas forem identicas ou sinonimas, manter apenas uma.

### Oportunidades

Fontes permitidas:

1. `matriz_risco[*].controle_esperado`: cada controle esperado e uma oportunidade de melhoria.

Formato de cada item:

```json
{
  "item": "Validacao automatizada do RGP ativo com confirmacao de homologacao e bloqueio sistemico.",
  "fonte": "matriz_risco[RE-02].controle_esperado"
}
```

Deduplicar controles redundantes.

### Ameacas

Fontes permitidas:

1. `riscos_especificos` filtrados por `avaliacao_dvr[*].quadrante_dvr in ["critico", "alto"]`.
2. Para cada risco elegivel, usar o campo `descricao`.

Formato de cada item:

```json
{
  "item": "Ocorre quando o beneficio e concedido sem evidencia suficiente de exercicio ininterrupto da atividade pesqueira.",
  "quadrante_dvr": "critico",
  "fonte": "riscos_especificos[RE-01].descricao"
}
```

## Fluxo de execucao

### Etapa 1 – Validar entrada

- Verificar existencia do arquivo `analise_risco.arquivo_resultado`.
- Verificar que `riscos_especificos` nao esta vazio.
- Se qualquer verificacao falhar, retornar `dependencia_pendente`.

### Etapa 2 – Preencher Forcas

- Iterar sobre `normativos_utilizados`.
- Para cada normativo, gerar um item de forca com `normativo + relevancia`.
- Nao inventar forcas adicionais.

### Etapa 3 – Preencher Fraquezas

- Iterar sobre `riscos_especificos`.
- Extrair campo `causa` de cada risco.
- Deduplicar por similaridade de conteudo.

### Etapa 4 – Preencher Oportunidades

- Iterar sobre `matriz_risco`.
- Extrair campo `controle_esperado` de cada item.
- Deduplicar por similaridade de conteudo.

### Etapa 5 – Preencher Ameacas

- Montar conjunto de IDs criticos e altos a partir de `avaliacao_dvr`.
- Filtrar `riscos_especificos` por esse conjunto.
- Extrair campo `descricao` de cada risco elegivel.

### Etapa 6 – Consolidar e salvar

- Montar JSON de saida.
- Salvar em `references/generated/<politica-slug>/analise_swot.json`.

## Formato de saida

```json
{
  "status": "ok",
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "analise_timestamp": "2026-05-15T14:00:00Z",
  "forcas": [
    {
      "item": "Marco legal consolidado: Lei 10.779/2003 — Norma central do beneficio de seguro-defeso.",
      "fonte": "normativos_utilizados[0]"
    }
  ],
  "fraquezas": [
    {
      "item": "Validacao insuficiente do relatorio anual de exercicio da atividade pesqueira.",
      "fonte": "riscos_especificos[RE-01].causa"
    }
  ],
  "oportunidades": [
    {
      "item": "Validacao automatizada do RGP ativo com confirmacao de homologacao e bloqueio sistemico.",
      "fonte": "matriz_risco[RE-02].controle_esperado"
    }
  ],
  "ameacas": [
    {
      "item": "Ocorre quando o beneficio e concedido sem evidencia suficiente de exercicio ininterrupto da atividade pesqueira.",
      "quadrante_dvr": "critico",
      "fonte": "riscos_especificos[RE-01].descricao"
    }
  ],
  "lacunas": [],
  "referencias": {
    "analise_risco": "skills/analise-risco/references/generated/seguro-defeso/resultado-analise.json",
    "generated": "references/generated/seguro-defeso/analise_swot.json"
  }
}
```

Status possiveis:

- `dependencia_pendente`: arquivo de analise de risco ausente ou sem riscos.
- `ok`: todos os quadrantes preenchidos sem lacunas.
- `ok_com_lacunas`: algum quadrante ficou vazio por ausencia de dados na fonte.

## Regras de qualidade

- Nao usar Python na analise.
- Nao inventar itens em nenhum quadrante.
- Cada item deve ter rastreabilidade explicita no campo `fonte`.
- Se um quadrante ficar vazio por ausencia de dados (ex.: `matriz_risco` vazia), registrar em `lacunas` e retornar `ok_com_lacunas`.
- Deduplicar itens redundantes dentro de cada quadrante.
- Timestamp em UTC.
- Salvar sempre o JSON de saida, mesmo que `ok_com_lacunas`.
