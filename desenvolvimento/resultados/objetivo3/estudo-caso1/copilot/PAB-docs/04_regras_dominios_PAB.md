# Regras de negócio e domínios — PAB
**Base:** BD_BENEFICIOS_HIST.dbo.PAB

## Regras de negócio

### R01 — Unicidade por benefício e competência
A combinação `(NU_NB, ANO_MES_REF)` não deve se repetir.

### R02 — Datas `D2_*` seguem `DDMMAAAA`
Campos `D2_DER`, `D2_DIB`, `D2_DDB`, `D2_DCB`, `D2_SOLIC_CREDITO`, `D2_VALIDACAO_CRED`, `D2_INI_PERIODO`, `D2_FIM_PERIODO` devem ter 8 dígitos quando preenchidos.

### R03 — Período do crédito consistente
Quando ambos preenchidos, `D2_INI_PERIODO <= D2_FIM_PERIODO`.

### R04 — Solicitação antecede ou coincide com validação
Quando `D2_VALIDACAO_CRED` existe, ela deve ser posterior ou igual a `D2_SOLIC_CREDITO`.

### R05 — Valor líquido do crédito não negativo
`VL_LIQUIDO_CRED >= 0`.

### R06 — Benefício-base deve estar referenciado
`NU_NB` deve existir no universo de benefícios do banco, especialmente em tabelas de concessão/manutenção.

### R07 — Situação do benefício no domínio oficial
`CS_SITUACAO_BENEF` deve existir em `COD_SITUACAO`.

### R08 — Espécie no domínio oficial
`CS_ESPECIE` deve existir em `COD_ESPECIE`.

### R09 — Clientela restrita a domínio pequeno
`CS_CLIENTELA` deve permanecer em domínio controlado, tipicamente `U` ou `R`.

### R10 — CPF do titular com 11 dígitos ou sentinela
`NU_CPF_T` deve ser numérico com 11 posições; `00000000000` indica ausência.

### R11 — Recebedor PAB pode diferir do recebedor do benefício
`NM_RECEBEDOR_PAB` representa quem recebe o crédito PAB e pode divergir de `NM_RECEBEDOR_BENEF`.

### R12 — Arquivo de origem identifica carga PAB
`NM_ARQUIVO` deve seguir o padrão `D.SUB.APE.000.PAB.AAAAMM.NN`.

## Domínios relevantes

### CS_CLIENTELA
| Código | Descrição |
|--------|-----------|
| U | Urbana |
| R | Rural |

### CS_SITUACAO_BENEF
Fonte: `raw_data/COD_SITUACAO.csv`

### CS_ESPECIE
Fonte: `raw_data/COD_ESPECIE.csv`

### CS_TRATAMENTO
Fonte: `raw_data/COD_TRATAMENTO.csv`

### CS_MEIO_PAGTO
Fonte: `raw_data/COD_MEIO_PAGAMENTO.csv`

### CS_DIAGNOSTICO
Relaciona-se a `COD_CID.csv` quando o valor segue codificação CID.

## Padrões de formato
| Campo | Formato | Exemplo |
|-------|---------|---------|
| NU_NB | 10 dígitos | `6038608862` |
| ANO_MES_REF | AAAAMM | `201401` |
| D2_* | DDMMAAAA | `03012014` |
| NU_CPF_T | 11 dígitos | `04515504630` |
| NM_ARQUIVO | D.SUB.APE.000.PAB.AAAAMM.NN | `D.SUB.APE.000.PAB.201401.01` |

## Observações analíticas
- O bloco de crédito indica evento financeiro específico, não a concessão integral do benefício.
- `CS_SEXO_T` apresentou valor `3` na amostra, então o domínio deve ser validado empiricamente antes de assumir somente `1/2`.
- `DT_DIA_UTIL_PAGTO` veio com valor textual como `1.` e `2.`, sugerindo formatação legada de extração.
