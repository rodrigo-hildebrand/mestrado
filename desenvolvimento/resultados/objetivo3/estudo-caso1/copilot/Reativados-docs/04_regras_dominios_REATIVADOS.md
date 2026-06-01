# Regras de negócio e domínios — REATIVADOS
**Base:** BD_BENEFICIOS_HIST.dbo.REATIVADOS

## Regras de negócio

### R01 — Unicidade por benefício e competência
A combinação `(NU_NB, ANO_MES_REF)` deve ser única.

### R02 — Situação anterior e atual devem ser rastreáveis
`CS_SIT_BENEF_ANT` registra a situação anterior e `CS_SITUACAO_BENEF` a situação após a ação; ambas devem pertencer ao domínio `COD_SITUACAO`.

### R03 — Data da ação em `DDMMAAAA`
`D2_ACAO` deve ter 8 dígitos quando preenchida.

### R04 — Efetivação tem formato próprio
`D2_EFETIVACAO` apareceu como `MMYYYY` na amostra (`122013`), indicando regra distinta das demais datas `D2_*`.

### R05 — Ação de reativação exige motivo
Quando houver `D2_ACAO`, espera-se `CS_MOTIVO_ACAO` preenchido.

### R06 — Reativação pressupõe situação anterior conhecida
`CS_SIT_BENEF_ANT` deve ser preenchido para permitir auditoria da transição de estado.

### R07 — Recebedor pode ser o próprio titular
`NM_RECEBEDOR` e `DN_RECEBEDOR` identificam o recebedor efetivo do benefício na reativação.

### R08 — Representante legal é opcional
Os campos `_R` devem permanecer vazios/sentinela quando não houver representante.

### R09 — Representante tipado
`CS_TIPO_R` deve usar domínio controlado; a hipótese mais forte é relacionamento com `COD_TIPO`.

### R10 — Arquivo origem identifica lote de reativação
`NM_ARQUIVO` deve seguir o padrão `D.SUB.APE.000.REAT.AAAAMM.NN`.

## Domínios relevantes
### CS_CLIENTELA
| Código | Descrição |
|--------|-----------|
| U | Urbana |
| R | Rural |

### CS_SITUACAO_BENEF / CS_SIT_BENEF_ANT
Fonte: `raw_data/COD_SITUACAO.csv`

### CS_ESPECIE
Fonte: `raw_data/COD_ESPECIE.csv`

### CS_TRATAMENTO
Fonte: `raw_data/COD_TRATAMENTO.csv`

### CS_TIPO_R
Hipótese de domínio: `raw_data/COD_TIPO.csv`

## Padrões de formato
| Campo | Formato | Exemplo |
|-------|---------|---------|
| NU_NB | 10 dígitos | `6024275424` |
| ANO_MES_REF | AAAAMM | `201401` |
| D2_ACAO | DDMMAAAA | `17122013` |
| D2_EFETIVACAO | MMYYYY | `122013` |
| DN_RECEBEDOR | DDMMAAAA | `02061992` |
| NM_ARQUIVO | D.SUB.APE.000.REAT.AAAAMM.NN | `D.SUB.APE.000.REAT.201401.01` |

## Observações analíticas
- `REATIVADOS` registra a mudança de estado do benefício, não a concessão original.
- A presença simultânea de `CS_SIT_BENEF_ANT` e `CS_SITUACAO_BENEF` permite reconstruir transições.
- O bloco `_R` explicita o representante legal, diferentemente de alguns layouts onde esse papel é mais implícito.
