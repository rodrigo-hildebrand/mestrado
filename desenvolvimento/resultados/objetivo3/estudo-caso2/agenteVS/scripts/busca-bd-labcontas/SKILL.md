---
name: busca-bd-labcontas
description: Receba uma politica publica ou um comando que envolva uma politica publica, varra os bancos de dados do ambiente LabContas (SQL Server), identifique quais sao de interesse com base nos nomes reais de BDs, tabelas e consultas, e conduza um ciclo interativo de validacao com o usuario ate que ele aceite o conjunto final de bases. Use esta skill sempre que o usuario precisar mapear bases de dados do LabContas para uso em auditoria, cruzamentos, verificacao de elegibilidade ou analise de beneficiarios de uma politica publica.
compatibility: Any
---

# Busca BD LabContas

Execute sem usar Python nas fases analiticas.
Nao use heuristica para inferir relevancia de bases: a selecao deve ser feita exclusivamente com base nos nomes reais dos BDs, tabelas e consultas obtidos da consulta ao metadado do SQL Server.
Nao crie fallback que invente bases ou tabelas nao confirmadas pela consulta ao servidor.

## Objetivo

Identificar e validar interativamente o conjunto de bancos de dados, tabelas e consultas do ambiente LabContas que serao usados em analises futuras de uma politica publica.

O resultado final e um inventario aprovado pelo usuario, com justificativa de relevancia baseada no metadado real.

## Entradas

Aceite qualquer combinacao destes campos:

```json
{
  "politica_publica": "Seguro defeso",
  "comando": "Quais bases do LabContas servem para analisar o Seguro defeso?",
  "server": "labcontas-bd",
  "database": "master",
  "include_system_databases": false,
  "max_databases": 500,
  "max_tables_per_database": 200,
  "max_columns_per_table": 200
}
```

Campos aceitos:

- `politica_publica` (preferencial)
- `comando` ou `query` (alias quando o pedido vier em linguagem natural)
- `server` (opcional, padrao: variavel de ambiente `LABCONTAS_SERVER` ou `labcontas-bd`)
- `database` (opcional, ponto de partida para a enumeracao; padrao: `master`)
- `include_system_databases` (opcional, padrao: `false`)
- `max_databases` (opcional, padrao: `500`)
- `max_tables_per_database` (opcional, padrao: `200`)
- `max_columns_per_table` (opcional, padrao: `200`)

Se a entrada vier apenas em linguagem natural, extraia dela a politica publica principal antes de executar a descoberta.

## Autenticacao no LabContas

Por padrao usa **Windows Authentication** (Trusted Connection), identica ao SSMS.

Variaveis de ambiente opcionais:

- `LABCONTAS_SERVER` (padrao: `labcontas-bd`)
- `LABCONTAS_DEFAULT_DB` (padrao: `master`)
- `LABCONTAS_ENCRYPT` (`yes`/`no`, padrao: `yes`)
- `LABCONTAS_TRUST_CERT` (`yes`/`no`, padrao: `yes`)

Autenticacao SQL (quando necessario):

- `LABCONTAS_USE_SQL_AUTH=true`
- `LABCONTAS_USER=<usuario>`
- `LABCONTAS_PASSWORD=<senha>`

## Fluxo de execucao

### Etapa 1 — Enumeracao de databases

Execute a seguinte consulta SQL no banco de entrada (geralmente `master`) para listar todos os databases do servidor:

```sql
SELECT name
FROM sys.databases
WHERE name LIKE 'BD[_]%'
  AND name NOT LIKE '%BDU%'
  AND name NOT LIKE '%BDA%'
  AND state_desc = 'ONLINE'
ORDER BY name;
```

Regras de filtragem obrigatorias:

- Incluir apenas databases cujo nome comece com `BD_`.
- Excluir databases que contenham `BDU` ou `BDA` no nome.
- Excluir databases offline.

Se a consulta falhar por falta de permissao no `master`, tente consultar `sys.databases` no banco padrao do ambiente e registre o erro na saida.

### Etapa 2 — Coleta de metadado por database

Para cada database listado na Etapa 1, colete:

**a) Nomes das tabelas e views:**

```sql
USE [<nome_do_database>];

SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_SCHEMA, TABLE_NAME;
```

**b) Nomes de stored procedures e functions (consultas):**

```sql
USE [<nome_do_database>];

SELECT ROUTINE_SCHEMA, ROUTINE_NAME, ROUTINE_TYPE
FROM INFORMATION_SCHEMA.ROUTINES
ORDER BY ROUTINE_SCHEMA, ROUTINE_NAME;
```

Colete apenas nomes. Nao colete corpos de procedures, textos de views ou definicoes de funcoes nesta etapa.

Se um database retornar erro de permissao, registre em `erros_acesso` e continue para os demais.

### Etapa 3 — Identificacao de bases relevantes

Compare os nomes de database, tabela, view, procedure e function coletados com os termos da politica publica informada.

Regras obrigatorias:

- Use apenas os nomes reais obtidos da consulta SQL. Nao invente termos nem complete com conhecimento externo.
- A correspondencia deve ser por ocorrencia de termo ou variacao de termo no nome do objeto (ex.: "seguro", "defeso", "pescador", "beneficio").
- Para cada database considerado relevante, registre:
  - quais objetos (tabelas, views, procedures) motivaram a selecao;
  - o termo ou expressao que gerou a correspondencia.

Regra dos pares `_HIST`:

- Se um database sem sufixo `_HIST` for selecionado (ex.: `BD_SISBEN`), inclua automaticamente sua versao historica se ela existir (ex.: `BD_SISBEN_HIST`).
- O mesmo vale no sentido inverso: se apenas a versao `_HIST` for encontrada, inclua tambem a versao base, se existir.

Regra das bases transversais para pessoas fisicas:

- Avalie se a politica publica envolve beneficiarios pessoas fisicas (ex.: beneficios, transferencias, cadastros de individuos).
- Se envolver, inclua automaticamente as seguintes bases transversais no conjunto proposto, desde que existam no servidor:
  - `BD_RECEITA` e `BD_RECEITA_HIST`: cadastro e situacao de CPF.
  - `BD_SIRC`: registro civil, nascimentos e obitos.
  - `BD_ESOCIAL`: vinculos empregatícios, admissao, desligamento e empregador.
  - `BD_CADASTRO_ELEITORAL`: cadastro eleitoral e situacao do titulo.

### Etapa 4 — Apresentacao para validacao pelo usuario

Apresente o conjunto identificado no seguinte formato antes de prosseguir:

```
Bases identificadas para a politica "[nome da politica]":

Bases tematicas:
1. BD_NOME_1 — motivacao: [termos encontrados / objetos identificados]
2. BD_NOME_2 — motivacao: [...]
...

Bases transversais (pessoas fisicas):
- BD_RECEITA / BD_RECEITA_HIST
- BD_SIRC
- BD_ESOCIAL
- BD_CADASTRO_ELEITORAL

Bases historicas vinculadas:
- BD_NOME_1_HIST (par de BD_NOME_1)
...

Voce deseja aceitar esse conjunto, retirar alguma base ou incluir outras bases?
Responda com: "aceitar", "retirar [nome]", "incluir [nome]" ou qualquer combinacao.
```

Aguarde a resposta do usuario.

### Etapa 5 — Ciclo de revisao

Repita as etapas de apresentacao e ajuste ate que o usuario responda com "aceitar" ou equivalente.

A cada iteracao:

- Registre as bases retiradas e as incluidas pelo usuario.
- Se o usuario incluir uma base nao presente no servidor, informe que ela nao foi localizada e mantenha a lista vigente.
- Nao execute nova consulta SQL a menos que o usuario solicite inclusao de base cuja estrutura ainda nao foi coletada.

### Etapa 6 — Coleta de estrutura detalhada do conjunto aprovado

Apos aceitacao do usuario, colete para cada database aprovado:

**Colunas das tabelas e views:**

```sql
USE [<nome_do_database>];

SELECT c.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME,
       c.DATA_TYPE, c.CHARACTER_MAXIMUM_LENGTH,
       c.IS_NULLABLE, c.ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS c
JOIN INFORMATION_SCHEMA.TABLES t
  ON c.TABLE_SCHEMA = t.TABLE_SCHEMA
 AND c.TABLE_NAME   = t.TABLE_NAME
ORDER BY c.TABLE_SCHEMA, c.TABLE_NAME, c.ORDINAL_POSITION;
```

### Etapa 7 — Geracao de sugestoes de consulta SQL

Para cada tabela ou view relevante do conjunto aprovado, gere sugestoes de consultas SQL no formato:

```sql
SELECT TOP (100) *
FROM [<database>].[<schema>].[<tabela>]
-- Filtro sugerido: WHERE <coluna_chave> = '<valor>'
```

Gere no maximo `max_query_suggestions` sugestoes (padrao: 20), priorizando:

1. Tabelas cujo nome coincide diretamente com termos da politica.
2. Tabelas com colunas como CPF, NIS, NB, competencia, data_pagamento, valor_beneficio.
3. Bases transversais com sugestoes de cruzamento por CPF.

### Etapa 8 — Producao da saida final

Retorne um JSON com:

```json
{
  "politica_publica": "<nome>",
  "status": "aprovado",
  "conjunto_aprovado": [
    {
      "database": "BD_NOME",
      "tipo": "tematica | transversal | historica",
      "motivacao": "termos ou objetos que motivaram a inclusao",
      "tabelas": [
        {
          "schema": "dbo",
          "nome": "NOME_TABELA",
          "tipo": "BASE TABLE | VIEW",
          "colunas": [
            { "nome": "CPF", "tipo_dado": "VARCHAR", "tamanho": 11, "nullable": "NO" }
          ]
        }
      ],
      "consultas_disponiveis": ["proc1", "proc2"],
      "sugestoes_sql": [
        "SELECT TOP (100) * FROM [BD_NOME].[dbo].[NOME_TABELA]"
      ]
    }
  ],
  "bases_descartadas": ["BD_X", "BD_Y"],
  "bases_incluidas_pelo_usuario": ["BD_Z"],
  "erros_acesso": ["BD_SEM_PERMISSAO: acesso negado"],
  "iteracoes_de_revisao": 2,
  "lacunas": []
}
```

Campos de status possiveis:

- `aguardando_validacao`: conjunto proposto, aguardando resposta do usuario.
- `aprovado`: conjunto final aceito pelo usuario.
- `erro_conexao`: nao foi possivel conectar ao servidor.

## Regras de qualidade

- Nao usar Python nas fases analiticas.
- Nao usar heuristica para inferir relevancia: use apenas os nomes dos objetos SQL retornados pelas consultas de metadado.
- Nao inventar bases, tabelas ou colunas que nao existam no servidor.
- Nunca incluir databases com `BDU` ou `BDA` no nome.
- Sempre respeitar a regra dos pares `_HIST`.
- Sempre avaliar e propor as bases transversais para politicas com pessoas fisicas.
- O ciclo de validacao e obrigatorio: nunca pular direto para a saida final sem confirmacao do usuario.
- Registrar erros de acesso sem interromper o processo para os demais databases.
