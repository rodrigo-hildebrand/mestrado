# Dicionário de Dados — REATIVADOS
**Base:** BD_BENEFICIOS_HIST.dbo.REATIVADOS  
**Extração:** sys.all_columns (object_id=853578079)  
**Total de campos:** 104  
**NM_ARQUIVO padrão:** `D.SUB.APE.000.REAT.AAAAMM.NN`

## Contexto
Tabela histórica de **reativação de benefícios** do INSS. Cada registro representa um benefício que sofreu uma ação de reativação ou alteração correlata, preservando o bloco cadastral do benefício e acrescentando informações específicas do evento de ação, efetivação e situação anterior.

## Sumário dos grupos
| Grupo | Qtd | Campos centrais |
|-------|-----|-----------------|
| Identificação | 3 | NU_NB, ID_OL_CONCESSAO, ID_OL_MANUTENCAO |
| Valores e classificação | 10 | VL_MR_ATU, VL_RMI, CS_ESPECIE, CS_SITUACAO_BENEF |
| Datas do benefício | 8 | D2_DER, D2_DIB, D2_DDB, D2_DRD |
| Pagamento | 7 | ID_BANCO, CS_MEIO_PAGTO, DT_DIA_UTIL_PAGTO |
| Recebedor | 2 | NM_RECEBEDOR, DN_RECEBEDOR |
| Titular (_T) | 18 | NM_TITULAR_BENEF_T, NU_CPF_T |
| Instituidor (_I) | 13 | NM_INSTITUIDOR_I, NU_CPF_I |
| Procurador (_P) | 18 | NM_PROCURADOR_P, NU_CPF_P |
| Representante (_R) | 13 | NM_REPRESENTANTE_R, NU_CPF_R, CS_TIPO_R |
| Evento de reativação | 5 | D2_EFETIVACAO, D2_ACAO, CS_MOTIVO_ACAO |
| ETL | 4 | DS_ERRO, DT_ATUALIZACAO_ETL, NM_ARQUIVO, ANO_MES_REF |

## Identificação
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NU_NB | varchar | 10 | Sim | Número do benefício. Chave analítica com ANO_MES_REF. |
| ID_OL_CONCESSAO | varchar | 8 | Sim | Identificador on-line da concessão vinculada. |
| ID_OL_MANUTENCAO | varchar | 8 | Sim | Identificador on-line da manutenção vinculada. |

## Valores e classificação
| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| CS_PA | varchar | 1 | Sim | — | Código de ajuste/percentual do benefício. |
| VL_MR_ATU | decimal | 9 | Sim | — | Valor mensal atualizado do benefício na reativação. |
| VL_RMI | decimal | 9 | Sim | — | Renda Mensal Inicial do benefício. |
| CS_TRATAMENTO | decimal | 5 | Sim | COD_TRATAMENTO | Tratamento do benefício. |
| CS_ESPECIE | decimal | 5 | Sim | COD_ESPECIE | Espécie do benefício. |
| CS_RAMO_ATIVIDADE | decimal | 5 | Sim | COD_RAMO_ATIVIDADE | Ramo de atividade do empregador. |
| CS_FORMA_FILIACAO | decimal | 5 | Sim | COD_FORMA_FILIACAO | Forma de filiação. |
| CS_DOC_EMPREGADOR | decimal | 5 | Sim | COD_DOC_EMPREGADOR | Tipo de documento do empregador. |
| NU_DOC_EMPREGADOR | varchar | 14 | Sim | — | Documento do empregador. |
| CS_ESPECIE_NB_ANT | decimal | 5 | Sim | COD_ESPECIE | Espécie do benefício anterior. |
| CS_CLIENTELA | varchar | 1 | Sim | {U,R} | Clientela urbana ou rural. |
| CS_SITUACAO_BENEF | decimal | 5 | Sim | COD_SITUACAO | Situação atual do benefício após a ação. |
| CS_SIT_BENEF_ANT | decimal | 5 | Sim | COD_SITUACAO | Situação do benefício antes da reativação/ação. |

## Benefício anterior e datas do benefício
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NU_NB_ANT | varchar | 10 | Sim | NB anterior associado. |
| D2_DIB_NB_ANT | varchar | 8 | Sim | DIB do benefício anterior em DDMMAAAA. |
| D2_DER | varchar | 8 | Sim | Data de entrada do requerimento. |
| D2_DIB | varchar | 8 | Sim | Data de início do benefício. |
| D2_DDB | varchar | 8 | Sim | Data de despacho do benefício. |
| D2_FORMAT_CONC | varchar | 8 | Sim | Data de formalização da concessão. |
| D2_DAT_DD | varchar | 8 | Sim | Data administrativa/DD. |
| D2_DRD | varchar | 8 | Sim | Data de resolução/registro do despacho. |

## Pagamento e recebedor
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NU_MATR_CONCESSOR | varchar | 8 | Sim | Matrícula do concessor. |
| NU_MATR_HABILITADOR | varchar | 8 | Sim | Matrícula do habilitador. |
| ID_BANCO | varchar | 3 | Sim | Banco pagador. |
| ID_ORGAO_PAGADOR | varchar | 6 | Sim | Órgão pagador. |
| CS_MEIO_PAGTO | decimal | 5 | Sim | Meio de pagamento. |
| NU_CONTA_CORRENTE | varchar | 10 | Sim | Conta corrente. |
| DT_DIA_UTIL_PAGTO | varchar | 2 | Sim | Dia útil do pagamento. |
| NM_RECEBEDOR | varchar | 28 | Sim | Nome do recebedor do benefício. |
| DN_RECEBEDOR | varchar | 8 | Sim | Data de nascimento do recebedor em DDMMAAAA. |

## Titular (_T)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_TITULAR_BENEF_T | varchar | 40 | Sim | Nome do titular. |
| NM_MAE_T | varchar | 32 | Sim | Nome da mãe do titular. |
| NU_CPF_T | varchar | 11 | Sim | CPF do titular. |
| ID_NIT_T | varchar | 11 | Sim | NIT do titular. |
| DT_NASCIMENTO_T | varchar | 8 | Sim | Nascimento do titular em DDMMAAAA. |
| CTPS_T | varchar | 7 | Sim | CTPS do titular. |
| CTPS_SERIE_T | varchar | 5 | Sim | Série da CTPS do titular. |
| CTPS_UF_T | varchar | 2 | Sim | UF da CTPS do titular. |
| NU_IDENTIDADE_T | varchar | 14 | Sim | Identidade do titular. |
| IDENTIDADE_UF_T | varchar | 2 | Sim | UF da identidade do titular. |
| CS_EMISSOR_T | varchar | 2 | Sim | Órgão emissor do titular. |
| CS_SEXO_T | decimal | 5 | Sim | Sexo do titular. |
| TE_ENDERECO_T | varchar | 40 | Sim | Endereço do titular. |
| NM_BAIRRO_T | varchar | 17 | Sim | Bairro do titular. |
| NU_CEP_T | varchar | 8 | Sim | CEP do titular. |
| NM_MUNICIPIO_T | varchar | 24 | Sim | Município do titular. |
| NM_UF_MUNICIPIO_T | varchar | 2 | Sim | UF do titular. |
| D2_OBITO_T | varchar | 8 | Sim | Data de óbito do titular. |

## Instituidor (_I)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_INSTITUIDOR_I | varchar | 40 | Sim | Nome do instituidor. |
| NM_MAE_I | varchar | 32 | Sim | Nome da mãe do instituidor. |
| NU_CPF_I | varchar | 11 | Sim | CPF do instituidor. |
| ID_NIT_I | varchar | 11 | Sim | NIT do instituidor. |
| DT_NASCIMENTO_I | varchar | 8 | Sim | Nascimento do instituidor. |
| CTPS_I | varchar | 7 | Sim | CTPS do instituidor. |
| CTPS_SERIE_I | varchar | 5 | Sim | Série da CTPS do instituidor. |
| CTPS_UF_I | varchar | 2 | Sim | UF da CTPS do instituidor. |
| NU_IDENTIDADE_I | varchar | 14 | Sim | Identidade do instituidor. |
| IDENTIDADE_UF_I | varchar | 2 | Sim | UF da identidade do instituidor. |
| CS_EMISSOR_I | varchar | 2 | Sim | Órgão emissor do instituidor. |
| CS_SEXO_I | decimal | 5 | Sim | Sexo do instituidor. |
| D2_OBITO_I | varchar | 8 | Sim | Óbito do instituidor. |

## Procurador (_P)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_PROCURADOR_P | varchar | 70 | Sim | Nome do procurador. |
| NM_MAE_P | varchar | 70 | Sim | Nome da mãe do procurador. |
| NU_CPF_P | varchar | 11 | Sim | CPF do procurador. |
| ID_NIT_P | varchar | 11 | Sim | NIT do procurador. |
| DT_NASCIMENTO_P | varchar | 8 | Sim | Nascimento do procurador. |
| CTPS_P | varchar | 7 | Sim | CTPS do procurador. |
| CTPS_SERIE_P | varchar | 5 | Sim | Série da CTPS do procurador. |
| CTPS_UF_P | varchar | 2 | Sim | UF da CTPS do procurador. |
| NU_IDENTIDADE_P | varchar | 14 | Sim | Identidade do procurador. |
| IDENTIDADE_UF_P | varchar | 2 | Sim | UF da identidade do procurador. |
| CS_EMISSOR_P | varchar | 2 | Sim | Órgão emissor do procurador. |
| CS_SEXO_P | decimal | 5 | Sim | Sexo do procurador. |
| NM_BAIRRO_P | varchar | 17 | Sim | Bairro do procurador. |
| NU_CEP_P | varchar | 8 | Sim | CEP do procurador. |
| TE_ENDERECO_P | varchar | 40 | Sim | Endereço do procurador. |
| NM_MUNICIPIO_P | varchar | 40 | Sim | Município do procurador. |
| NM_UF_MUNICIPIO_P | varchar | 2 | Sim | UF do procurador. |
| MUNICIP_NASC_P | decimal | 5 | Sim | Município de nascimento do procurador. |

## Representante (_R)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_REPRESENTANTE_R | varchar | 40 | Sim | Nome do representante legal. |
| NM_MAE_R | varchar | 32 | Sim | Nome da mãe do representante. |
| NU_CPF_R | varchar | 11 | Sim | CPF do representante. |
| ID_NIT_R | varchar | 11 | Sim | NIT do representante. |
| DT_NASCIMENTO_R | varchar | 8 | Sim | Nascimento do representante. |
| CTPS_R | varchar | 7 | Sim | CTPS do representante. |
| CTPS_SERIE_R | varchar | 5 | Sim | Série da CTPS do representante. |
| CTPS_UF_R | varchar | 2 | Sim | UF da CTPS do representante. |
| NU_IDENTIDADE_R | varchar | 14 | Sim | Identidade do representante. |
| IDENTIDADE_UF_R | varchar | 2 | Sim | UF da identidade do representante. |
| CS_EMISSOR_R | varchar | 2 | Sim | Órgão emissor do representante. |
| CS_SEXO_R | decimal | 5 | Sim | Sexo do representante. |
| CS_TIPO_R | decimal | 5 | Sim | Tipo do representante. |

## Evento de reativação
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| D2_EFETIVACAO | varchar | 6 | Sim | Competência ou data resumida de efetivação da reativação. Na amostra veio como `122013`, sugerindo MMYYYY. |
| D2_ACAO | varchar | 8 | Sim | Data da ação administrativa em DDMMAAAA. |
| NU_MATR_EMISSOR | decimal | 5 | Sim | Matrícula do emissor/servidor responsável pela ação. |
| CS_MOTIVO_ACAO | decimal | 5 | Sim | Código do motivo da ação de reativação. |
| CS_SIT_BENEF_ANT | decimal | 5 | Sim | Situação do benefício antes da ação. |

## ETL
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| DS_ERRO | varchar | 1024 | Sim | Mensagem de erro ETL. |
| DT_ATUALIZACAO_ETL | datetime | 8 | Sim | Timestamp da carga. |
| NM_ARQUIVO | varchar | 256 | Sim | Arquivo origem. Padrão `D.SUB.APE.000.REAT.AAAAMM.NN`. |
| ANO_MES_REF | decimal | 5 | Sim | Competência de referência em AAAAMM. |
