---
name: prepara-relatorio
description: Consolida resultados de análise de uma política pública em relatório executivo formatado em Word (.docx), com matriz DVR (Diagrama de Verificação de Risco), tipologias de risco propostas, indicadores de qualidade dos dados, análise SWOT e referências legislativas. Requer ciclo completo de auditoria (legislação, riscos, bases de dados, tipologias e indicadores de qualidade). A análise SWOT é opcional e pode vir de analise-swot, analise-swot2 ou de ambas para consolidação no relatório. Use quando o usuário pedir relatório final de auditoria, consolidação de achados por tema ou entrega de produto auditável.
compatibility: Any
---

# Prepara Relatório

Consolide análise de uma política pública em relatório executivo formatado em Word.

## Objetivo

Gerar um documento Word (.docx) com linguagem clara e formatação visual profissional, consolidando:

1. Descrição e contexto da política fiscalizada.
2. Normativos e bases de dados utilizados na análise.
3. Matriz DVR (Diagrama de Verificação de Risco): mapa visual de riscos críticos.
4. Tipologias e riscos prioritários (top 3–5 por `prioridade_risco`).
5. Indicadores de qualidade dos dados e scripts SQL associados.
6. Demais tipologias desenvolvidas em apêndice.

## Dependências obrigatórias

Esta skill depende de:

1. **Legislação** (saída de `busca-legislacao`): normativos aplicáveis à política.
2. **Análise de risco** (saída de `analise-risco`): riscos geral e específicos.
3. **Estrutura de bases de dados** (saída de `busca-bd-labcontas`): tabelas e colunas disponíveis.
4. **Tipologias de auditoria** (saída de `desenvolve-tipologia`): tipologias e critério de risco.
5. **Indicadores de qualidade** (saída de `avalia-qualidade`): scripts SQL de avaliação de campos.

Se qualquer dependência obrigatória faltar, interrompa com status `dependencia_pendente` e retorne JSON.

## Dependências opcionais

6. **Análise SWOT v1** (saída de `analise-swot`): forças, fraquezas, oportunidades e ameaças.
7. **Análise SWOT v2** (saída de `analise-swot2`): forças, fraquezas, oportunidades e ameaças.

Regra de decisão para relatório:

- Se só `analise_swot2` estiver presente: usar `analise_swot2`.
- Se só `analise_swot` estiver presente: usar `analise_swot`.
- Se ambas estiverem presentes: consolidar as duas por regra objetiva de complemento (sem análise semântica em Python).
- Se nenhuma estiver presente: omitir seção SWOT sem interromper o processamento.

## Entradas

Aceite combinações destes campos:

```json
{
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "descricao_politica": "Programa de proteção de renda do pescador artesanal durante períodos de defeso.",
  "legislacao": {
    "normativo_principal": "Lei 10.779/2003",
    "normativos_complementares": ["Lei 8.212/1991", "Decreto 8.424/2015"]
  },
  "analise_risco": {
    "arquivo_resultado": "skills/analise-risco/references/generated/seguro-defeso/resultado-analise.json"
  },
  "estrutura_bases": {
    "arquivo_resultado": "skills/busca-bd-labcontas/references/generated/seguro-defeso/resultado-estrutura.json"
  },
  "tipologias_auditoria": {
    "arquivo_resultado": "skills/desenvolve-tipologia/references/generated/seguro-defeso/tipologias_auditoria.json"
  },
  "indicadores_qualidade": {
    "arquivo_resultado": "skills/avalia-qualidade/references/generated/seguro-defeso/avaliacao_qualidade.json"
  },
  "analise_swot": {
    "arquivo_resultado": "skills/analise-swot/references/generated/seguro-defeso/analise_swot.json"
  },
  "analise_swot2": {
    "arquivo_resultado": "skills/analise-swot2/references/generated/seguro-defeso/analise_swot2.json"
  },
  "assinante": {
    "nome": "Nome do Auditor",
    "matritura": "XXX.XXX",
    "cargo": "Auditor Federal de Controle Externo"
  },
  "numero_processo": "00001/2026-TCU",
  "data_auditoria": "2026-05-15"
}
```

Campos aceitos:

- `politica_publica` (obrigatório)
- `politica_slug` (obrigatório para nomeação de arquivo)
- `descricao_politica` (recomendado; senão, usar descrição genérica)
- `legislacao` (recomendado; senão, buscar em analise-risco)
- `analise_risco` (obrigatório)
- `estrutura_bases` (obrigatório)
- `tipologias_auditoria` (obrigatório)
- `indicadores_qualidade` (obrigatório)
- `analise_swot` (opcional)
- `analise_swot2` (opcional)
- `assinante` (recomendado; campos vazios se não fornecido)
- `numero_processo` (recomendado)
- `data_auditoria` (recomendado; padrão: hoje)

## Regras de interrupção por dependência

Se faltar qualquer entrada obrigatória, retorne:

```json
{
  "status": "dependencia_pendente",
  "politica_publica": "Seguro defeso",
  "dependencias": ["analise-risco", "busca-bd-labcontas"],
  "acao_orquestrador": "Execute as skills faltantes e reenvie as saidas para prepara-relatorio.",
  "lacunas": ["Análise de risco ausente.", "Estrutura de bases ausente."],
  "referencias": {
    "generated": "references/generated/seguro-defeso/relatorio-pendente.json"
  }
}
```

## Fluxo de execução

### Etapa 1 – Validar dependências

- Validar presença de `analise_risco`, `estrutura_bases`, `tipologias_auditoria`, `indicadores_qualidade`.
- Se alguma faltar, retornar JSON de dependência pendente.
- Verificar se `analise_swot` e/ou `analise_swot2` estão presentes e se os arquivos existem.
- Definir estratégia SWOT para a Etapa 4: `somente_swot2`, `somente_swot1`, `consolidada_swot2_com_swot1` ou `sem_swot`.

### Etapa 2 – Extrair riscos críticos

- Ordenar tipologias por `prioridade_risco`.
- Selecionar top 3–5 (sugestão).
- Montar matriz DVR (tabela simples):

```
| Tipologia ID | Descrição | Prioridade | Critério de Concretização |
| TIP-02       | Risco ... | 1          | Existe requerimento...   |
```

### Etapa 3 – Compilar indicadores de qualidade

- Extrair de `avaliacao_qualidade.json`.
- Organizar scripts SQL por tipo (completude, validade, acuracia).
- Gerar texto formatado com instruções de execução.

### Etapa 4 – Gerar documento Word

- Criar `.docx` com estilo profissional.
- Incluir seções:
  1. **Capa**: Título, política, data, assinante.
  2. **Sumário Executivo**: Resumo de achados.
  3. **1. Contexto**: Descrição da política, normativos.
  4. **2. Matriz DVR**: Tabela de riscos críticos.
  5. **3. Tipologias Críticas**: Descrição de cada top 3–5.
  6. **4. Indicadores de Qualidade**: Scripts SQL por tipo.
  7. **5. Bases de Dados**: Inventário de tabelas e colunas.
  8. **6. Análise SWOT** (se `analise_swot` e/ou `analise_swot2` presentes): tabelas dos quatro quadrantes e estratégia aplicada.
  9. **Tipologias Adicionais**: Todas as demais (apêndice).
  10. **Assinatura**: Nome, cargo, data.

## Formato de saída

Gerar dois arquivos em `references/generated/<politica-slug>/`:

1. **`relatorio_<politica-slug>.docx`**: Documento Word formatado.
2. **`relatorio_<politica-slug>_metadados.json`**: JSON com metadados (status, timestamp, hash, etc.).

### JSON de metadados:

```json
{
  "status": "ok",
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "relatorio_timestamp": "2026-05-15T14:30:00Z",
  "arquivo_saida": "references/generated/seguro-defeso/relatorio_seguro-defeso.docx",
  "total_tipologias": 9,
  "tipologias_criticas": 3,
  "total_campos_avaliados": 56,
  "normativos_inclusos": 5,
  "bases_referenciadas": 3,
  "swot_incluido": true,
  "swot_estrategia": "consolidada_swot2_com_swot1",
  "swot_insumos": ["analise-swot2", "analise-swot"],
  "assinante": {
    "nome": "Nome do Auditor",
    "matricula": "XXX.XXX",
    "cargo": "Auditor Federal de Controle Externo"
  },
  "lacunas": ["Sem regra explicita de validade para BD_SEGURO_DEFESO.dbo.REQUERIMENTO.NUMERO_RGP"],
  "referencias": {
    "generated": "references/generated/seguro-defeso/relatorio_seguro-defeso_metadados.json"
  }
}
```

## Estilo e formatação do Word

- **Fonte**: Calibri, 11pt (corpo), 16pt (títulos principais), 12pt (subtítulos).
- **Cores**: Azul TCU (#003580) para títulos e destaques.
- **Margens**: 2,5 cm (padrão).
- **Tabelas**: bordas cinzentas, cabeçalho azul claro com texto branco.
- **Listas**: numeradas para procedimentos, marcadores para pontos de risco.
- **Rodapé**: "Auditoria Operacional – Tribunal de Contas da União".

## Regras de qualidade

- Não interromper se houver lacunas; incluir como observação no relatório.
- Validar que todos os arquivos de entrada existem antes de processar.
- Gerar sempre um JSON de metadados, mesmo que com status `dependencia_pendente`.
- Não inventar dados; usar apenas informações extraídas das entradas.
- A decisão de uso/consolidação entre `analise_swot` e `analise_swot2` deve seguir regra objetiva definida na skill.
- Se algum campo recomendado faltar, usar valor padrão claro (ex.: "Auditor não informado").
- Scripts SQL devem vir literais (copiáveis) no documento.
- Tipologias críticas devem trazer descrição completa (objetivo, critério de concretização, script).
- Demais tipologias em apêndice: tabela com ID, descrição e prioridade.
- Timestamp em UTC.
