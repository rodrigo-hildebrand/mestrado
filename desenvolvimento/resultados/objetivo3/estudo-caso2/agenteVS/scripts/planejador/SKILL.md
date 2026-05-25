---
name: planejador
description: Cria planos estruturados para o trabalho do agente no formato JSON, no estilo ReWOO, com referencias entre etapas (ex.: `#E1`). Use quando for preciso quebrar uma tarefa em passos com tool e input para execucao pelo orquestrador.
compatibility: Any
---

# Planejador

Skill para gerar plano de execução com foco em orquestração.

Não usar Python para análise de tarefas.
Quem executa as skills e consultas é o orquestrador.

## Inspiração ReWOO

Arquitetura inspirada no padrão ReWOO (Reasoning WithOut Observation):

- Planner gera um plano completo de passos.
- Executor (orquestrador) executa os passos.
- Passos podem referenciar resultados anteriores (ex.: `#E1`, `#E2`).
- Paralelismo é permitido para passos sem dependência entre si.
- Evitar replanejamento desnecessário durante a execução.

## Skills de referência permitidas

Utilize como exemplos e repertório do ecossistema atual:

- `analise-risco`
- `analise-swot`
- `analise-swot2`
- `avalia-qualidade`
- `busca-bd-labcontas`
- `busca-legislacao`
- `desenvolve-tipologia`
- `governanca`
- `prepara-relatorio`
- `skill-creator`

## Entrada

Aceita objeto JSON com:

```json
{
  "context": "descreva o objetivo e restrições"
}
```

Alias aceitos:

- `context`
- `query`

## Saída

Retorna JSON com:

- `status`
- `message`
- `plan` (lista de passos)

Cada passo deve conter obrigatoriamente:

- `id` (formato `E1`, `E2`, ...)
- `objective`
- `tool`
- `input`
- `depends_on` (lista de ids, pode ser vazia)
- `expected_output`

Campos opcionais:

- `mode`: `sequential` ou `parallel` (quando aplicável)
- `notes`

## Regras de construção do plano

1. O plano deve começar com os dois passos iniciais:
   - `busca-legislacao`
   - `analise-swot2`
2. `analise-swot` deve ser usada apenas após a etapa `analise-risco`.
3. Ordem base recomendada para fluxo completo:
   - `busca-legislacao`
   - `analise-swot2`
   - `analise-risco`
   - `analise-swot`
   - `busca-bd-labcontas`
   - `desenvolve-tipologia`
   - `avalia-qualidade`
   - `prepara-relatorio`
   - `governanca`
4. O plano deve finalizar com `governanca`.
5. A etapa final do fluxo deve produzir artefato publicável.
6. Acima de 20 etapas, não prosseguir automaticamente: retornar status de autorização pendente.
7. Quando houver falha potencial ou necessidade de replanejamento, sinalizar que o orquestrador deve pedir novo plano.
8. Referências entre etapas devem usar formato `#E<numero>`.
9. Etapas paralelas só podem existir quando `depends_on` não cria dependência entre elas.

## Regra de autorização para planos longos

Se a solução exigir mais de 20 etapas:

```json
{
  "status": "autorizacao_usuario_pendente",
  "message": "Plano com mais de 20 etapas. Solicite autorização do usuário para continuar.",
  "plan_preview": [
    {
      "id": "E1",
      "objective": "...",
      "tool": "busca-legislacao"
    }
  ]
}
```

## Regra de replanejamento

Não incluir fallback automático de execução dentro do plano.
Se o plano depender de nova estratégia por falha, instruir explicitamente o orquestrador a solicitar novo plano ao `planejador`.

## Exemplo de saída

```json
{
  "status": "ok",
  "message": "Plano ReWOO estruturado para execução pelo orquestrador.",
  "plan": [
    {
      "id": "E1",
      "objective": "Levantar base normativa da política.",
      "tool": "busca-legislacao",
      "input": {
        "politica_publica": "Seguro defeso"
      },
      "depends_on": [],
      "expected_output": "Normativos aplicáveis identificados.",
      "mode": "sequential"
    },
    {
      "id": "E2",
      "objective": "Gerar SWOT inicial para entendimento da política.",
      "tool": "analise-swot2",
      "input": {
        "politica_publica": "Seguro defeso"
      },
      "depends_on": [],
      "expected_output": "Matriz SWOT inicial priorizada.",
      "mode": "parallel"
    },
    {
      "id": "E3",
      "objective": "Mapear riscos gerais e específicos.",
      "tool": "analise-risco",
      "input": {
        "politica_publica": "Seguro defeso",
        "normativos": "#E1"
      },
      "depends_on": ["E1"],
      "expected_output": "Resultado de análise de risco.",
      "mode": "sequential"
    },
    {
      "id": "E4",
      "objective": "Gerar SWOT complementar com base na análise de risco.",
      "tool": "analise-swot",
      "input": {
        "politica_publica": "Seguro defeso",
        "analise_risco": "#E3"
      },
      "depends_on": ["E3"],
      "expected_output": "Matriz SWOT complementar.",
      "mode": "sequential"
    },
    {
      "id": "E5",
      "objective": "Mapear estrutura de bases de dados relevantes.",
      "tool": "busca-bd-labcontas",
      "input": {
        "politica_publica": "Seguro defeso",
        "analise_risco": "#E3"
      },
      "depends_on": ["E3"],
      "expected_output": "Estrutura de bases e tabelas relevantes.",
      "mode": "sequential"
    },
    {
      "id": "E6",
      "objective": "Desenvolver tipologias de auditoria.",
      "tool": "desenvolve-tipologia",
      "input": {
        "politica_publica": "Seguro defeso",
        "analise_risco": "#E3",
        "estrutura_bases": "#E5"
      },
      "depends_on": ["E3", "E5"],
      "expected_output": "Tipologias priorizadas.",
      "mode": "sequential"
    },
    {
      "id": "E7",
      "objective": "Avaliar qualidade dos dados.",
      "tool": "avalia-qualidade",
      "input": {
        "politica_publica": "Seguro defeso",
        "estrutura_bases": "#E5",
        "tipologias": "#E6"
      },
      "depends_on": ["E5", "E6"],
      "expected_output": "Indicadores de qualidade e scripts SQL.",
      "mode": "sequential"
    },
    {
      "id": "E8",
      "objective": "Gerar relatório consolidado publicável.",
      "tool": "prepara-relatorio",
      "input": {
        "politica_publica": "Seguro defeso",
        "legislacao": "#E1",
        "analise_risco": "#E3",
        "analise_swot": "#E4",
        "analise_swot2": "#E2",
        "estrutura_bases": "#E5",
        "tipologias_auditoria": "#E6",
        "indicadores_qualidade": "#E7"
      },
      "depends_on": ["E1", "E2", "E3", "E4", "E5", "E6", "E7"],
      "expected_output": "Relatório final publicável.",
      "mode": "sequential"
    },
    {
      "id": "E9",
      "objective": "Executar validação final de governança no produto publicável.",
      "tool": "governanca",
      "input": {
        "relatorio_final": "#E8"
      },
      "depends_on": ["E8"],
      "expected_output": "Parecer de governança e sinalização ao orquestrador.",
      "mode": "sequential"
    }
  ]
}
```

## Regras de qualidade

- Não usar Python para análise de tarefas.
- Plano deve ser claro, executável e rastreável.
- Toda etapa deve ter objetivo verificável.
- Dependências devem ser consistentes.
- Última etapa deve produzir ou validar artefato publicável.
- Se houver mais de 20 etapas, solicitar autorização do usuário.
