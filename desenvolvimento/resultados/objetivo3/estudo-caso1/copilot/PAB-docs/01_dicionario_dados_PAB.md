# Dicionário de Dados — PAB
**Base:** BD_BENEFICIOS_HIST.dbo.PAB  
**Extração:** sys.all_columns (object_id=837578022)  
**Total de campos:** 100  
**NM_ARQUIVO padrão:** `D.SUB.APE.000.PAB.AAAAMM.NN`

## Contexto
Tabela histórica de **crédito complementar / PAB** associada a benefícios do INSS. O layout preserva a maior parte dos dados cadastrais do benefício e adiciona um bloco específico de solicitação, validação e liquidação de crédito, com período de referência e valor líquido do crédito.

## Sumário dos grupos
| Grupo | Qtd | Campos centrais |
|-------|-----|-----------------|
| Identificação | 3 | NU_NB, ID_OL_CONCESSAO, ID_OL_MANUTENCAO |
| Valores e classificação | 11 | VL_RMI, VL_SB, CS_ESPECIE, CS_SITUACAO_BENEF |
| Datas do benefício | 10 | D2_DER, D2_DIB, D2_DDB, D2_DCB |
| Pagamento | 8 | ID_BANCO, CS_MEIO_PAGTO, DT_DIA_UTIL_PAGTO |
| Titular (_T) | 18 | NM_TITULAR_BENEF_T, NU_CPF_T |
| Instituidor (_I) | 13 | NM_INSTITUIDOR_I, NU_CPF_I |
| Procurador (_P) | 18 | NM_PROCURADOR_P, NU_CPF_P |
| Crédito PAB | 10 | D2_SOLIC_CREDITO, CS_MOTIVO_SOLIC, VL_LIQUIDO_CRED |
| ETL | 4 | DS_ERRO, DT_ATUALIZACAO_ETL, NM_ARQUIVO, ANO_MES_REF |

## Identificação
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NU_NB | varchar | 10 | Sim | Número do Benefício. Chave principal analítica junto com ANO_MES_REF. |
| ID_OL_CONCESSAO | varchar | 8 | Sim | Identificador on-line da concessão original. |
| ID_OL_MANUTENCAO | varchar | 8 | Sim | Identificador on-line da manutenção vigente. |

## Valores e classificação
| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| VL_RMI | decimal | 9 | Sim | — | Renda Mensal Inicial do benefício. |
| CS_PA | varchar | 1 | Sim | — | Código de percentual/ajuste aplicado ao benefício. |
| VL_SB | decimal | 9 | Sim | — | Salário de Benefício, base de cálculo do benefício. |
| CS_TRATAMENTO | decimal | 5 | Sim | COD_TRATAMENTO | Tipo de tratamento cadastral/benefício. |
| CS_ESPECIE | decimal | 5 | Sim | COD_ESPECIE | Espécie do benefício. |
| CS_RAMO_ATIVIDADE | decimal | 5 | Sim | COD_RAMO_ATIVIDADE | Ramo de atividade do empregador. |
| CS_FORMA_FILIACAO | decimal | 5 | Sim | COD_FORMA_FILIACAO | Forma de filiação ao RGPS. |
| CS_DOC_EMPREGADOR | decimal | 5 | Sim | COD_DOC_EMPREGADOR | Tipo do documento do empregador. |
| NU_DOC_EMPREGADOR | varchar | 14 | Sim | — | Documento do empregador (CNPJ/CEI/outro). |
| CS_ESPECIE_ANT | decimal | 5 | Sim | COD_ESPECIE | Espécie do benefício anterior. |
| CS_CLIENTELA | varchar | 1 | Sim | {U,R} | Clientela urbana ou rural. |
| CS_SITUACAO_BENEF | decimal | 5 | Sim | COD_SITUACAO | Situação do benefício na competência. |
| CS_DIAGNOSTICO | varchar | 6 | Sim | COD_CID | Código CID do diagnóstico quando aplicável. |
| CS_DESPACHO | decimal | 5 | Sim | COD_DESPACHO | Tipo de despacho associado ao benefício. |

## Benefício anterior e datas do benefício
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NU_NB_ANT | varchar | 10 | Sim | NB anterior. `0000000000` indica ausência de predecessor. |
| D2_DIB_NB_ANT | varchar | 8 | Sim | DIB do benefício anterior em DDMMAAAA. |
| D2_DER | varchar | 8 | Sim | Data de Entrada do Requerimento em DDMMAAAA. |
| D2_DIB | varchar | 8 | Sim | Data de Início do Benefício em DDMMAAAA. |
| D2_DDB | varchar | 8 | Sim | Data de despacho/decisão em DDMMAAAA. |
| D2_DCB | varchar | 8 | Sim | Data de cessação em DDMMAAAA. |
| D2_FORMAT_CONC | varchar | 8 | Sim | Data de formalização da concessão em DDMMAAAA. |
| D2_ENVIO_BANCO | varchar | 8 | Sim | Data de envio ao banco em DDMMAAAA. |
| D2_DAT_DD | varchar | 8 | Sim | Data associada ao DD/processamento administrativo. |
| D2_DRD | varchar | 8 | Sim | Data de resolução/registro do despacho. |
| NU_NB_APOSENT_PECULIO | varchar | 10 | Sim | NB de aposentadoria/pecúlio relacionado. `0000000000` indica não aplicável. |

## Pagamento
| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| NU_MATR_CONCESSOR | decimal | 5 | Sim | — | Matrícula do servidor concessor. `55555555` indica processo automático. |
| NU_MATR_HABILITADOR | decimal | 5 | Sim | — | Matrícula do habilitador. |
| ID_BANCO | varchar | 3 | Sim | — | Código do banco pagador. |
| ID_ORGAO_PAGADOR | varchar | 6 | Sim | — | Órgão pagador vinculado ao crédito. |
| CS_MEIO_PAGTO | decimal | 5 | Sim | COD_MEIO_PAGAMENTO | Meio de pagamento. |
| NU_CONTA_CORRENTE | varchar | 10 | Sim | — | Conta corrente associada ao pagamento, quando houver. |
| DT_DIA_UTIL_PAGTO | varchar | 2 | Sim | — | Dia útil de pagamento. |
| NM_RECEBEDOR_BENEF | varchar | 28 | Sim | — | Nome do recebedor do benefício-base. |
| NM_RECEBEDOR_PAB | varchar | 28 | Sim | — | Nome do recebedor específico do crédito PAB. |

## Titular (_T)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_TITULAR_BENEF_T | varchar | 40 | Sim | Nome do titular do benefício. |
| NM_MAE_T | varchar | 32 | Sim | Nome da mãe do titular. |
| NU_CPF_T | varchar | 11 | Sim | CPF do titular. `00000000000` indica ausência. |
| ID_NIT_T | varchar | 11 | Sim | NIT/PIS/PASEP do titular. |
| DT_NASCIMENTO_T | varchar | 8 | Sim | Data de nascimento em DDMMAAAA. |
| CTPS_T | varchar | 7 | Sim | Número da CTPS. |
| CTPS_SERIE_T | varchar | 5 | Sim | Série da CTPS. |
| CTPS_UF_T | varchar | 2 | Sim | UF da CTPS. |
| NU_IDENTIDADE_T | varchar | 14 | Sim | Documento de identidade. |
| IDENTIDADE_UF_T | varchar | 2 | Sim | UF da identidade. |
| CS_EMISSOR_T | varchar | 2 | Sim | Órgão emissor da identidade. |
| CS_SEXO_T | decimal | 5 | Sim | Sexo do titular. Na amostra apareceu valor `3`, sugerindo domínio maior que o observado em concessões. |
| TE_ENDERECO_T | varchar | 40 | Sim | Endereço do titular. |
| NM_BAIRRO_T | varchar | 17 | Sim | Bairro do titular. |
| NU_CEP_T | varchar | 8 | Sim | CEP do titular. |
| NM_MUNICIPIO_T | varchar | 24 | Sim | Município do titular. |
| NM_UF_MUNICIPIO_T | varchar | 2 | Sim | UF do titular. |
| D2_OBITO_T | varchar | 8 | Sim | Data de óbito do titular em DDMMAAAA. |

## Instituidor (_I)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_INSTITUIDOR_I | varchar | 40 | Sim | Nome do instituidor. |
| NM_MAE_I | varchar | 32 | Sim | Nome da mãe do instituidor. |
| NU_CPF_I | varchar | 11 | Sim | CPF do instituidor. |
| ID_NIT_I | varchar | 11 | Sim | NIT do instituidor. |
| DT_NASCIMENTO_I | varchar | 8 | Sim | Nascimento do instituidor em DDMMAAAA. |
| CTPS_I | varchar | 7 | Sim | CTPS do instituidor. |
| CTPS_SERIE_I | decimal | 5 | Sim | Série da CTPS do instituidor. |
| CTPS_UF_I | varchar | 2 | Sim | UF da CTPS do instituidor. |
| NU_IDENTIDADE_I | varchar | 14 | Sim | Identidade do instituidor. |
| IDENTIDADE_UF_I | varchar | 2 | Sim | UF da identidade do instituidor. |
| CS_EMISSOR_I | varchar | 2 | Sim | Órgão emissor da identidade do instituidor. |
| CS_SEXO_I | decimal | 5 | Sim | Sexo do instituidor. |
| D2_OBITO_I | varchar | 8 | Sim | Data de óbito do instituidor em DDMMAAAA. |

## Procurador (_P)
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_PROCURADOR_P | varchar | 70 | Sim | Nome do procurador. |
| NM_MAE_P | varchar | 70 | Sim | Nome da mãe do procurador. |
| NU_CPF_P | varchar | 11 | Sim | CPF do procurador. |
| ID_NIT_P | varchar | 11 | Sim | NIT do procurador. |
| DT_NASCIMENTO_P | varchar | 8 | Sim | Nascimento do procurador em DDMMAAAA. |
| CTPS_P | varchar | 7 | Sim | CTPS do procurador. |
| CTPS_SERIE_P | varchar | 5 | Sim | Série da CTPS do procurador. |
| CTPS_UF_P | varchar | 2 | Sim | UF da CTPS do procurador. |
| NU_IDENTIDADE_P | varchar | 14 | Sim | Identidade do procurador. |
| IDENTIDADE_UF_P | varchar | 2 | Sim | UF da identidade do procurador. |
| CS_EMISSOR_P | varchar | 2 | Sim | Órgão emissor da identidade do procurador. |
| CS_SEXO_P | decimal | 5 | Sim | Sexo do procurador. |
| NM_BAIRRO_P | varchar | 17 | Sim | Bairro do procurador. |
| NU_CEP_P | varchar | 8 | Sim | CEP do procurador. |
| TE_ENDERECO_P | varchar | 40 | Sim | Endereço do procurador. |
| NM_MUNICIPIO_P | varchar | 40 | Sim | Município do procurador. |
| NM_UF_MUNICIPIO_P | varchar | 2 | Sim | UF do procurador. |
| MUNICIP_NASC_P | decimal | 5 | Sim | Código do município de nascimento do procurador. |

## Crédito PAB
| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| D2_SOLIC_CREDITO | varchar | 8 | Sim | — | Data de solicitação do crédito em DDMMAAAA. |
| NU_SEQ_SOLIC_CRED | decimal | 5 | Sim | — | Sequencial da solicitação de crédito. |
| D2_VALIDACAO_CRED | varchar | 8 | Sim | — | Data de validação do crédito em DDMMAAAA. |
| D2_FIM_PERIODO | varchar | 8 | Sim | — | Fim do período a que o crédito se refere em DDMMAAAA. |
| D2_INI_PERIODO | varchar | 8 | Sim | — | Início do período a que o crédito se refere em DDMMAAAA. |
| NU_MATRIC_SOLIC | decimal | 5 | Sim | — | Matrícula do servidor/rotina que solicitou o crédito. |
| CS_MOTIVO_SOLIC | decimal | 5 | Sim | — | Código do motivo da solicitação do crédito. |
| ID_OL_SOLIC_CRED | varchar | 8 | Sim | — | Identificador on-line da solicitação do crédito. |
| CS_ORIGEM_CREDITO | decimal | 5 | Sim | COD_TIPO (hipótese) | Código de origem do crédito. |
| VL_LIQUIDO_CRED | decimal | 9 | Sim | — | Valor líquido do crédito complementar gerado. |

## ETL
| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| DS_ERRO | varchar | 1024 | Sim | Mensagem de erro de processamento ETL. |
| DT_ATUALIZACAO_ETL | datetime | 8 | Sim | Data/hora da atualização da carga. |
| NM_ARQUIVO | varchar | 256 | Sim | Arquivo origem. Padrão `D.SUB.APE.000.PAB.AAAAMM.NN`. |
| ANO_MES_REF | decimal | 5 | Sim | Competência de referência em AAAAMM. |
