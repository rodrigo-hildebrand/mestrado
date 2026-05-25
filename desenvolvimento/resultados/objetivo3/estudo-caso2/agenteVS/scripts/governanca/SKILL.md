---
name: governanca
description: Avalie o produto final gerado por prepara-relatorio e aplique verificações de governança com níveis (adequado, parcialmente_adequado, inadequado, incerto), sinalizando etapas candidatas a reprocessamento para decisão do orquestrador. Não use Python para a fase de análise.
compatibility: Any
---

# Governança

Execute a avaliação sem usar Python na fase de análise.
Não use respostas vazias ou genéricas.
Não reescreva o relatório inteiro quando não houver necessidade.

## Objetivo

Revisar o relatório final de auditoria gerado por `prepara-relatorio` e responder as 5 questões de governança com nível de adequação:

1. Mensagem do texto está clara?
2. Análise SWOT está suficiente?
3. Há normativo importante não considerado?
4. Riscos gerais e específicos contemplam as questões mais sensíveis da política?
5. Há informação pessoal, sensível ou errada no texto final?

Padrão esperado:

- Q1: `sim`
- Q2: `sim`
- Q3: `não`
- Q4: `sim`
- Q5: `não`

## Entrada

A entrada vem do orquestrador, após `prepara-relatorio`.

```json
{
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "relatorio_final": {
    "arquivo_docx": "skills/prepara-relatorio/references/generated/seguro-defeso/relatorio_seguro-defeso.docx",
    "arquivo_metadados": "skills/prepara-relatorio/references/generated/seguro-defeso/relatorio_seguro-defeso_metadados.json"
  }
}
```

Campos aceitos:

- `politica_publica` (obrigatório)
- `politica_slug` (recomendado)
- `relatorio_final.arquivo_docx` (obrigatório)
- `relatorio_final.arquivo_metadados` (recomendado)

## Tratamento de documento extenso

Limiar objetivo para documento extenso: **mais de 500 páginas**.

Se o relatório tiver mais de 500 páginas, interrompa com solicitação de confirmação ao usuário:

```json
{
  "status": "confirmacao_usuario_pendente",
  "politica_publica": "Seguro defeso",
  "motivo": "Documento extenso para avaliação segura em uma única passada.",
  "acao_orquestrador": "Pergunte ao usuário se deseja continuar com avaliação resumida ou segmentar por seções."
}
```

## Níveis de avaliação

Cada questão deve receber:

- `adequado`
- `parcialmente_adequado`
- `inadequado`
- `incerto`

Regras de efeito:

- `inadequado`: sinalizar etapa candidata a reprocessamento.
- `parcialmente_adequado`: não reprocessa automaticamente; incluir no parágrafo `Ressalvas`.
- `incerto`: não reprocessa automaticamente; incluir no parágrafo `Ressalvas`.

## Lista obrigatória para dado pessoal/sensível (Q5)

Considere como sensíveis/pessoais para verificação:

- CPF
- RG
- telefone
- e-mail
- endereço
- nomes completos
- matrícula funcional

Também considere informações erradas materialmente relevantes.

## Regra de normativos importantes (Q3)

A skill deve pensar, sem Python e sem heurística mecânica, quais normativos são importantes para a política analisada e verificar se o relatório os contempla de forma suficiente.

Se houver incerteza, use nível `incerto` e registre em `Ressalvas`.

## Mapeamento de etapa candidata (para decisão do orquestrador)

- Q1 com `inadequado` -> etapa candidata: `prepara-relatorio`
- Q2 com `inadequado` -> etapas candidatas: `analise-swot`, `analise-swot2`, `prepara-relatorio`
- Q3 com `inadequado` -> etapas candidatas: `busca-legislacao`, `analise-risco`, `prepara-relatorio`
- Q4 com `inadequado` -> etapas candidatas: `analise-risco`, `desenvolve-tipologia`, `prepara-relatorio`
- Q5 com `inadequado` -> etapa candidata: `prepara-relatorio`

Importante: apenas sinalizar. Quem decide reprocessar é o orquestrador.

## Saída

A skill deve produzir um resultado de governança e o destino do relatório:

- Se não houver ajuste textual: manter relatório original.
- Se houver ao menos um `parcialmente_adequado` ou `incerto`: adicionar parágrafo `Ressalvas` ao produto final.

Formato de saída:

```json
{
  "status": "ok|ok_com_ressalvas|reprocessamento_sugerido|confirmacao_usuario_pendente",
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "governanca_timestamp": "2026-05-15T15:00:00Z",
  "respostas": [
    {
      "id": "Q1",
      "pergunta": "o texto está com sua mensagem clara?",
      "resposta": "sim",
      "nivel": "adequado",
      "justificativa": "..."
    },
    {
      "id": "Q2",
      "pergunta": "a análise SWOT está suficiente?",
      "resposta": "sim",
      "nivel": "parcialmente_adequado",
      "justificativa": "..."
    }
  ],
  "ressalvas": {
    "necessita_paragrafo": true,
    "paragrafo": "Ressalvas: ..."
  },
  "etapas_candidatas_reprocessamento": [
    {
      "questao": "Q3",
      "etapas": ["busca-legislacao", "analise-risco", "prepara-relatorio"],
      "motivo": "Normativo relevante potencialmente ausente."
    }
  ],
  "acao_orquestrador": "Decidir se reprocessa etapas candidatas. Se não reprocessar, manter ou publicar versão com Ressalvas.",
  "produto_final": {
    "tipo": "relatorio_original|relatorio_com_ressalvas",
    "arquivo_saida": "skills/prepara-relatorio/references/generated/seguro-defeso/relatorio_seguro-defeso.docx"
  },
  "referencias": {
    "relatorio_entrada": "skills/prepara-relatorio/references/generated/seguro-defeso/relatorio_seguro-defeso.docx",
    "generated": "skills/governanca/references/generated/seguro-defeso/governanca_resultado.json"
  }
}
```

## Regras de decisão de status

- `ok`: todas as respostas no padrão esperado e sem ressalvas.
- `ok_com_ressalvas`: sem `inadequado`, com ao menos um `parcialmente_adequado` ou `incerto`.
- `reprocessamento_sugerido`: existe ao menos um `inadequado`.
- `confirmacao_usuario_pendente`: documento com mais de 500 páginas para avaliação segura no contexto disponível.

## Regras de qualidade

- Não usar Python na análise.
- Não alterar o relatório quando não houver ressalvas.
- Se houver ressalvas, gerar apenas um parágrafo objetivo e acionável.
- Justificativas devem ser curtas e auditáveis.
- Sempre sinalizar etapas candidatas quando houver `inadequado`.
- Decisão final de reprocessamento é sempre do orquestrador.
