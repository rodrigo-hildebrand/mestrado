---
name: documenta-base
description: "Documentar tabela SQL Server via ODBC. Use quando: precisar gerar dicionário de dados, modelo ER, JSON Schema, regras de domínio e scripts SQL utilitários para uma tabela de banco de dados. Executa extração automática de metadados via sys.all_columns e gera os 5 artefatos de documentação."
argument-hint: "NomeDaTabela [Servidor] [Banco]"
---

# Skill: documenta-base

Documenta completamente uma tabela SQL Server via introspecção real do banco (ODBC/sys.all_columns), gerando os 5 artefatos padronizados de documentação.

## Quando usar

- Documentar uma tabela desconhecida ou pouco documentada
- Gerar dicionário de dados, modelo ER, JSON Schema, regras de domínio e scripts SQL
- Estudo de caso de engenharia reversa de banco de dados

## Parâmetros

| Parâmetro | Obrigatório | Padrão | Descrição |
|-----------|-------------|--------|-----------|
| `NomeDaTabela` | Sim | — | Nome da tabela a documentar (ex: MACICA) |
| `Servidor` | Não | `labcontas-bd` | SQL Server hostname |
| `Banco` | Não | `BD_BENEFICIOS_HIST` | Nome do banco de dados |
| `PastaDestino` | Não | `.\<NomeDaTabela>-docs` | Pasta onde os artefatos serão salvos |

## Conexão padrão (LabContas)

```
Driver={ODBC Driver 17 for SQL Server}
Server=labcontas-bd
Trusted_Connection=Yes
Encrypt=yes
TrustServerCertificate=yes
```

## Procedimento

### Passo 1 — Extrair metadados da tabela

Execute o script de extração com os parâmetros informados:

```powershell
.\.github\skills\documenta-base\scripts\extrair_metadados.ps1 `
    -TableName "MACICA" `
    -Server "labcontas-bd" `
    -Database "BD_BENEFICIOS_HIST" `
    -OutputFolder ".\MACICA-docs\raw_data"
```

O script gera em `raw_data/`:
- `<TABELA>_colunas.csv` — todos os campos com tipo, tamanho, nullable, object_id
- `<TABELA>_amostra.csv` — 5 linhas de amostra (TOP 5 sem ORDER BY)
- `<TABELA>_tabelas_relacionadas.csv` — tabelas do mesmo banco
- `COD_*.csv` — conteúdo completo de cada tabela de dimensão encontrada

### Passo 2 — Analisar os metadados

Leia os arquivos gerados e identifique:

1. **Grupos de campos** — prefixos/sufixos comuns (VL_, CS_, D2_, DT_, NU_, NM_, etc.)
2. **Tabelas de dimensão** — tabelas prefixadas com `COD_` ou `DIM_` referenciadas por campos da tabela principal
3. **Chaves candidatas** — campos com padrão NB, ID, NU_ de alta cardinalidade
4. **Campos de controle ETL** — DT_ATUALIZACAO_ETL, NM_ARQUIVO, ANO_MES_REF e similares
5. **Papéis de pessoa** — sufixos _T (Titular), _I (Instituidor), _P (Procurador), _R (Representante)
6. **Estruturas repetidas** — grupos numerados (CAMPO_1 … CAMPO_N) como padrão de array denormalizado
7. **Formatos de data** — verificar se são ISO, DDMMAAAA varchar, inteiro ou datetime

### Passo 3 — Gerar os 5 artefatos

Crie os arquivos abaixo na pasta destino. Consulte os detalhes em [./references/artefatos.md](./references/artefatos.md).

#### Artefato 1 — Dicionário de dados (`01_dicionario_dados_<TABELA>.md`)

Tabela com todos os campos documentados:

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|

- Descrever cada campo em português claro
- Indicar FK quando houver correspondência com tabela COD_/DIM_
- Documentar valores sentinela conhecidos (ex: '00000000000' = CPF ausente)
- Organizar por grupos temáticos com subtítulos `###`
- Mesmo se trouxer grupos de campos, trazer ao final a tabela com todos os campos, mesmo os menos relevantes, para garantir cobertura completa

#### Artefato 2 — Modelo ER (`02_modelo_er_<TABELA>.md`)

Diagrama Mermaid `erDiagram` com:
- Entidade principal com ~30–50 campos mais representativos
- Todas as tabelas de dimensão encontradas
- Relacionamentos com cardinalidade (||--o{)

#### Artefato 3 — JSON Schema (`03_schema_<TABELA>.json`)

JSON Schema draft-07 com todos os campos:
- `type` mapeado do SQL (varchar→string, decimal→number, int→integer, bit→boolean, date/datetime→string+format)
- `maxLength` para tipos char/varchar
- `description` em português
- `enum` para campos com cardinalidade ≤ 30 valores distintos na amostra

#### Artefato 4 — Regras e domínios (`04_regras_dominios_<TABELA>.md`)

- Regras de negócio numeradas R01–RNN (integridade, consistência temporal, cálculos derivados)
- Tabelas de domínio para cada código codificado (com código e descrição)
- Padrões de formato (máscaras regex para CPF, NB, datas, etc.)

#### Artefato 5 — Scripts SQL (`05_scripts_sql_utilitarios_<TABELA>.sql`)

Quatro seções:
1. **Profiling geral** — COUNT, distribuição temporal, % nulos por campo, estatísticas de valor
2. **Integridade referencial** — FKs sem correspondência, consistências entre datas, totais calculados
3. **Análise de domínios** — distribuição por cada campo codificado com JOIN nas dimensões
4. **Consultas reutilizáveis** — JOIN padrão com todas as dimensões, filtros comuns, conversões de data, CROSS APPLY para arrays denormalizados, histórico por chave

### Passo 4 — Validar cobertura

Após gerar os artefatos, verificar:
- [ ] Todos os campos do `_colunas.csv` documentados no dicionário
- [ ] Todas as tabelas do `_tabelas_relacionadas.csv` representadas no ER (se relevantes)
- [ ] JSON Schema com o mesmo número de campos do dicionário
- [ ] Ao menos 10 regras de negócio identificadas
- [ ] Scripts testáveis executando sem erro de sintaxe

## Mapeamento SQL Server → JSON Schema

| SQL Server | JSON Schema type | format |
|------------|-----------------|--------|
| varchar, nvarchar, char | string | — |
| decimal, numeric, float, real | number | — |
| int, smallint, tinyint, bigint | integer | — |
| bit | boolean | — |
| date | string | date |
| datetime, datetime2, smalldatetime | string | date-time |
| uniqueidentifier | string | uuid |

## Convenções de nomenclatura de campos (padrão LabContas/INSS)

| Prefixo/Sufixo | Significado |
|----------------|-------------|
| `VL_` | Valor monetário |
| `CS_` | Código (code/status) |
| `NU_` | Número |
| `NM_` | Nome |
| `D2_` | Data no formato DDMMAAAA (varchar 8) |
| `DT_` | Data no formato datetime ou varchar ISO |
| `QT_` | Quantidade |
| `ID_` | Identificador interno |
| `_T` | Papel: Titular |
| `_I` | Papel: Instituidor |
| `_P` | Papel: Procurador |
| `_R` | Papel: Representante Legal |

## Recursos

- [Script de extração](./scripts/extrair_metadados.ps1)
- [Procedimentos detalhados dos artefatos](./references/artefatos.md)
