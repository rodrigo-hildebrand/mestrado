# Procedimentos detalhados — Geração dos 5 artefatos

Este arquivo é carregado pela skill `documenta-base` quando o agente precisa de
instruções detalhadas para gerar cada artefato.

---

## Artefato 1 — Dicionário de dados

**Arquivo**: `01_dicionario_dados_<TABELA>.md`

### Estrutura do arquivo

```markdown
# Dicionário de Dados — <TABELA>
**Base:** <Banco>.<Schema>.<TABELA>  
**Data de extração:** <data>  
**Total de campos:** <N>

## Sumário dos grupos
| Grupo | Campos | Descrição |
|-------|--------|-----------|
...

---

## <Grupo 1>
| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
...

## <Grupo 2>
...
```

### Grupos padrão a identificar

1. **Identificação** — chaves primárias, NB, ID_OL, NM_ARQUIVO
2. **Referência temporal** — ANO_MES_REF, competência, DT_ATUALIZACAO_ETL
3. **Valores financeiros** — campos VL_, TOT_
4. **Classificações/Códigos** — campos CS_
5. **Datas** — campos D2_ (DDMMAAAA), DT_ (datetime)
6. **Dados do titular** — sufixo _T
7. **Dados do instituidor** — sufixo _I
8. **Dados do procurador** — sufixo _P
9. **Dados do representante** — sufixo _R
10. **Estruturas repetidas** — grupos _1 … _N
11. **Controle ETL** — campos de carga/processamento

### Valores sentinela comuns (INSS/LabContas)

| Valor | Significado |
|-------|-------------|
| `'00000000000'` (CPF) | CPF ausente/não informado |
| `'0000000000'` (NB 10 dígitos) | NB anterior inexistente |
| `'00000000'` (data DDMMAAAA) | Data não preenchida |
| `0` (CS_SITUACAO_BENEF) | Benefício ativo |

---

## Artefato 2 — Modelo ER

**Arquivo**: `02_modelo_er_<TABELA>.md`

### Template Mermaid

````markdown
```mermaid
erDiagram
    TABELA_PRINCIPAL {
        tipo campo1 PK
        tipo campo2
        ...
    }
    COD_DIMENSAO1 {
        varchar COD_X PK
        varchar DESCR_X
    }
    TABELA_PRINCIPAL ||--o{ COD_DIMENSAO1 : "CS_X = COD_X"
```
````

### Regras do diagrama

- Incluir todos os campos até ~50; acima disso selecionar os mais representativos
- Tipo simplificado: varchar, decimal, int, bit, date, datetime
- Mostrar cardinalidade: `||--o{` (muitos para um obrigatório), `}o--o{` (muitos para muitos opcional)
- Nomear relacionamentos com `"campo_fk = campo_pk"` para rastreabilidade
- Agrupar dimensões no diagrama por tipo (financeiro, geográfico, classificação)

---

## Artefato 3 — JSON Schema

**Arquivo**: `03_schema_<TABELA>.json`

### Template

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "<TABELA>",
  "description": "<Descrição da tabela>",
  "type": "object",
  "properties": {
    "CAMPO_1": {
      "type": "string",
      "maxLength": 10,
      "description": "Descrição do campo 1"
    },
    "CAMPO_VL": {
      "type": ["number", "null"],
      "description": "Valor monetário do benefício"
    },
    "CAMPO_CS": {
      "type": "integer",
      "enum": [0, 1, 2, 5],
      "description": "Código de situação. 0=Ativo, 1=..."
    }
  },
  "required": ["CAMPO_1", "CAMPO_2"]
}
```

### Mapeamento de tipos SQL → JSON Schema

| SQL Server | JSON type | Observações |
|------------|-----------|-------------|
| varchar, nvarchar, char | `"string"` | Adicionar `maxLength` |
| decimal, numeric, money | `"number"` | |
| float, real | `"number"` | |
| int, smallint, tinyint | `"integer"` | |
| bigint | `"integer"` | |
| bit | `"boolean"` | |
| date | `"string"`, `"format": "date"` | |
| datetime, datetime2 | `"string"`, `"format": "date-time"` | |
| uniqueidentifier | `"string"`, `"format": "uuid"` | |

### Campos anuláveis

Para campo com `is_nullable = 1`, usar array de tipos:
```json
"type": ["string", "null"]
```

### Quando usar `enum`

Incluir `enum` quando:
- O campo referencia uma tabela COD_/DIM_ com ≤ 50 valores
- O campo tem cardinalidade conhecida (CS_CLIENTELA: U/R, CS_SEXO: M/F)

---

## Artefato 4 — Regras de negócio e domínios

**Arquivo**: `04_regras_dominios_<TABELA>.md`

### Categorias de regras

| Categoria | Exemplos |
|-----------|---------|
| **Integridade referencial** | CS_ESPECIE deve existir em COD_ESPECIE |
| **Consistência temporal** | D2_DDB ≥ D2_DIB; D2_DCB > D2_DIB se preenchida |
| **Consistência de valores** | VL_LIQUIDO = VL_BRUTO - TOT_DESCONTOS |
| **Unicidade** | (NU_NB, ANO_MES_REF) deve ser único |
| **Obrigatoriedade** | NU_NB e ANO_MES_REF sempre preenchidos |
| **Formato** | CPF 11 dígitos numéricos; NB 10 dígitos numéricos |
| **Valor sentinela** | NU_CPF='00000000000' indica ausência |
| **Domínio implícito** | CS_CLIENTELA ∈ {U, R} |
| **Cálculo** | Rubricas ativas indicadas por QT_RUBRICA_REG |
| **ETL** | NM_ARQUIVO = 'D.SUB.APE.000.MAC.AAAAMM.NN' |

### Formato das regras

```markdown
## Regras de Negócio

### R01 — Unicidade do registro
Cada combinação (NU_NB, ANO_MES_REF) deve ocorrer no máximo uma vez.

**Verificação SQL:**
```sql
SELECT NU_NB, ANO_MES_REF, COUNT(*) AS cnt
FROM [banco].[dbo].[TABELA]
GROUP BY NU_NB, ANO_MES_REF
HAVING COUNT(*) > 1;
```

### R02 — ...
```

### Tabelas de domínio

Para cada campo com domínio fixo, incluir tabela completa:

```markdown
## Domínio: CS_SITUACAO_BENEF

| Código | Descrição |
|--------|-----------|
| 0 | ATIVO |
| 5 | SUSPENSO |
...
```

---

## Artefato 5 — Scripts SQL utilitários

**Arquivo**: `05_scripts_sql_utilitarios_<TABELA>.sql`

### Estrutura obrigatória

```sql
-- ====================================================
-- Seção 1: PROFILING GERAL
-- ====================================================
-- 1.1 Contagem e período
-- 1.2 Distribuição temporal (por ANO_MES_REF ou partição equivalente)
-- 1.3 % Nulos por campo
-- 1.4 Estatísticas de valores numéricos
-- 1.5 Cardinalidade de campos categóricos

-- ====================================================
-- Seção 2: INTEGRIDADE REFERENCIAL
-- ====================================================
-- 2.x Uma query por FK ou regra de consistência identificada

-- ====================================================
-- Seção 3: ANÁLISE DE DOMÍNIOS
-- ====================================================
-- 3.x Distribuição por cada código codificado + JOIN na dimensão

-- ====================================================
-- Seção 4: CONSULTAS REUTILIZÁVEIS
-- ====================================================
-- 4.1 JOIN padrão com todas as dimensões
-- 4.2 Filtro de competência
-- 4.3 Filtro por tipo/grupo principal
-- 4.4 Agregação por dimensão e período
-- 4.5 CROSS APPLY para arrays denormalizados (se aplicável)
-- 4.6 Histórico por chave primária
-- 4.7 Joins com tabelas CID, UF, GEX (se aplicável)
```

### Padrão de conversão de data DDMMAAAA

```sql
-- D2_DIB em DDMMAAAA -> DATE
CASE WHEN LEN(D2_DIB) = 8 AND D2_DIB <> '00000000'
     THEN CONVERT(date,
          SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2))
     ELSE NULL
END AS data_inicio_beneficio
```

### Padrão CROSS APPLY para arrays denormalizados

```sql
-- Explodir CAMPO_1..CAMPO_N com respectivos VL_CAMPO_1..VL_CAMPO_N
CROSS APPLY (
    VALUES
    (1,  m.CS_RUBRICA_1,  m.VL_RUBRICA_1),
    (2,  m.CS_RUBRICA_2,  m.VL_RUBRICA_2),
    -- ...
    (N,  m.CS_RUBRICA_N,  m.VL_RUBRICA_N)
) r(nr, codigo, valor)
WHERE r.codigo IS NOT NULL AND r.codigo <> 0
```
