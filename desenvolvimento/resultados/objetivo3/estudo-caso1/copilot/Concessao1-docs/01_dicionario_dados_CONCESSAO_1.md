# Dicionário de Dados — CONCESSAO_1
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_1  
**Extração:** sys.all_columns (object_id=773577794)  
**Total de campos:** 128  
**NM_ARQUIVO padrão:** `D.SUB.APE.000.CON1.AAAAMM.NN`

## Contexto
Tabela de histórico de **concessões de benefícios** do INSS (arquivo CON1). Cada registro representa um benefício (NU_NB) em uma competência (ANO_MES_REF) com todos os dados do ato de concessão: valores, datas, titulares, instituidores, procuradores, representantes e controle de cessação. Análoga à CONCESSAO_3 (mesmo schema, arquivo CON3).

## Sumário dos grupos
| Grupo | Qtd campos | Campos-chave |
|-------|-----------|--------------|
| Identificação | 4 | NU_NB, ID_OL_CONCESSAO, ID_OL_MANUTENCAO |
| Valores financeiros | 5 | VL_MR_PAGA, VL_MR_ATU, VL_RMI, VL_SB |
| Classificações | 10 | CS_ESPECIE, CS_TRATAMENTO, CS_CLIENTELA, CS_DESPACHO |
| Benefício anterior | 3 | NU_NB_ANT, CS_ESPECIE_ANT |
| Datas | 12 | D2_DIB, D2_DDB, D2_DCB, D2_DER |
| Matrículas | 5 | NU_MATR_CONCESSOR, NU_MATR_HABILITADOR |
| Pagamento | 6 | ID_BANCO, CS_MEIO_PAGTO, NU_AGENCIA_PAG |
| Titular (_T) | 26 | NM_TITULAR_BENEF_T, NU_CPF_T, DT_NASCIMENTO_T |
| Instituidor (_I) | 16 | NM_INSTITUIDOR_I, NU_CPF_I |
| Procurador (_P) | 18 | NM_PROCURADOR_P, NU_CPF_P |
| Representante | 12 | NM_REPRESENTANTE, NU_CPF_REPRES |
| Recebedor | 4 | NM_RECEBEDOR, NU_CPF_RECEBEDOR |
| Dependentes | 3 | QT_DEP_IR, QT_DEP_VAL_NB, QT_DEP_CADASTRO |
| Controle ETL | 4 | DT_ATUALIZACAO_ETL, NM_ARQUIVO, ANO_MES_REF |

---

## Identificação

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| NU_NB | varchar | 10 | Sim | — | Número do Benefício (NB), chave principal de identificação. Formato: 10 dígitos numéricos. Combinado com ANO_MES_REF forma a chave analítica do registro. |
| ID_OL_CONCESSAO | numeric | 5 | Sim | — | Identificador de On-Line da concessão original. Número interno do sistema INSS para o ato de concessão. |
| ID_OL_MANUTENCAO | numeric | 5 | Sim | — | Identificador de On-Line da manutenção vigente. Referencia a transação de atualização mais recente. |
| ID_OL_MANUTENCAO_ANT | numeric | 5 | Sim | — | Identificador de On-Line da manutenção anterior. Permite rastrear a transação precedente. Valor 0 indica primeira manutenção. |

---

## Valores financeiros

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| VL_MR_PAGA | numeric | 9 | Sim | — | Valor mensal pago na competência de referência (em R$). |
| VL_MR_ATU | numeric | 9 | Sim | — | Valor mensal atualizado do benefício (em R$). Reflete reajustes aplicados. |
| VL_RMI | numeric | 9 | Sim | — | Renda Mensal Inicial (RMI) — valor calculado no ato da concessão, antes de reajustes. |
| CS_PA | numeric | 5 | Sim | — | Código do percentual de ajuste (PA). Indica fator de acréscimo ou redução sobre a RMI. |
| VL_SB | numeric | 9 | Sim | — | Valor do Salário de Benefício (SB), base de cálculo da RMI. |

---

## Classificações

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| CS_TRATAMENTO | numeric | 5 | Sim | COD_TRATAMENTO | Código do tipo de tratamento/modalidade do benefício. |
| CS_ESPECIE | numeric | 5 | Sim | COD_ESPECIE | Código da espécie do benefício (ex: 31=Aposentadoria por Invalidez, 41=Aposentadoria por Tempo, 88=Amparo Social Idoso). 95 espécies disponíveis. |
| CS_RAMO_ATIVIDADE | numeric | 5 | Sim | COD_RAMO_ATIVIDADE | Código do ramo de atividade do empregador. 9 valores. |
| CS_FORMA_FILIACAO | numeric | 5 | Sim | COD_FORMA_FILIACAO | Código da forma de filiação ao RGPS (ex: 1=Empregado, 3=Autônomo). 10 valores. |
| CS_DOC_EMPREGADOR | numeric | 5 | Sim | COD_DOC_EMPREGADOR | Tipo do documento do empregador (ex: 1=CNPJ, 2=CEI). 5 valores. |
| CS_CLIENTELA | varchar | 1 | Sim | {U, R} | Clientela: U=Urbana, R=Rural. |
| CS_DESPACHO | numeric | 5 | Sim | COD_DESPACHO | Código do tipo de despacho da concessão. 43 valores. |
| CS_SITUACAO_BENEF | numeric | 5 | Sim | COD_SITUACAO | Código da situação do benefício (ex: 0=Ativo, 5=Suspenso, 35=Cessado). 25 valores. |
| CS_MEIO_PAGTO | numeric | 5 | Sim | COD_MEIO_PAGAMENTO | Código do meio de pagamento (ex: 1=Banco, 5=Cartão). 9 valores. |
| CS_DIAGNOSTICO | numeric | 5 | Sim | COD_CID (indireto) | Código CID do diagnóstico (formato numérico interno). Aplicável a benefícios por incapacidade. |

---

## Benefício anterior

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| NU_NB_ANT | varchar | 10 | Sim | — | NB do benefício predecessor. Valor `0000000000` (10 zeros) indica que não há predecessor. |
| D2_DIB_NB_ANT | nvarchar | 20 | Sim | — | Data de Início do Benefício anterior (DIB) no formato DDMMAAAA. |
| CS_ESPECIE_ANT | numeric | 5 | Sim | COD_ESPECIE | Código da espécie do benefício predecessor. |

---

## Datas (formato DDMMAAAA em nvarchar)

> Todas as datas D2_* são armazenadas como nvarchar(20) no formato **DDMMAAAA**. Valor `''` (vazio) indica data não preenchida.

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| D2_DER | nvarchar | 20 | Sim | Data de Entrada do Requerimento — quando o segurado protocolou o pedido. |
| D2_DIB | nvarchar | 20 | Sim | Data de Início do Benefício — data oficial de início do pagamento. |
| D2_DDB | nvarchar | 20 | Sim | Data de Despacho do Benefício — data da decisão/despacho administrativo. |
| D2_DCB | nvarchar | 20 | Sim | Data de Cessação do Benefício — preenchida quando o benefício é encerrado. |
| D2_DIP | nvarchar | 20 | Sim | Data de Início do Pagamento — primeira competência com pagamento efetivo. |
| D2_DRD | nvarchar | 20 | Sim | Data da Resolução do Despacho — formalização da decisão. |
| D2_OBITO_RECLUSAO | nvarchar | 20 | Sim | Data de óbito ou reclusão do titular (quando aplicável). |
| D2_HABILITACAO | nvarchar | 20 | Sim | Data de habilitação do benefício no sistema. |
| D2_FORMAT_CONC | nvarchar | 20 | Sim | Data de formalização da concessão. |
| D2_INI_INCAPAC | nvarchar | 20 | Sim | Data de início da incapacidade (específico para benefícios por invalidez/auxílio-doença). |
| D2_INICIO_DOENCA | nvarchar | 20 | Sim | Data de início da doença ou acidente causador da incapacidade. |
| D2_LIMITE | nvarchar | 20 | Sim | Data-limite de benefício temporário (ex: auxílio-doença). Após esta data, requer prorrogação. |

---

## Matrículas

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NU_MATR_CONCESSOR | varchar | 8 | Sim | Matrícula do servidor INSS que realizou a concessão. Valor `55555555` indica concessão automática/batch. |
| NU_MATR_HABILITADOR | varchar | 8 | Sim | Matrícula do habilitador que aprovou o benefício. |
| NU_MATR_FORM_CONC | varchar | 11 | Sim | Matrícula do formalizador da concessão. Valor `00000000000` indica ausência. |
| NU_MATR_MP1 | varchar | 7 | Sim | Matrícula do médico-perito 1 (benefícios por incapacidade). |
| NU_MATR_MP2 | varchar | 7 | Sim | Matrícula do médico-perito 2 (quando há segunda perícia). Valor `0000000` indica ausência. |

---

## Pagamento

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| DT_DIA_UTIL_PGTO | numeric | 5 | Sim | — | Dia útil de pagamento (1 a 31). Valor 0 indica não definido. |
| ID_BANCO | numeric | 5 | Sim | — | Código do banco pagador. |
| ID_ORGAO_PAGADOR | numeric | 5 | Sim | — | Identificador do órgão pagador. |
| CS_MEIO_PAGTO | numeric | 5 | Sim | COD_MEIO_PAGAMENTO | (ver Classificações) |
| NU_AGENCIA_PAG | numeric | 5 | Sim | COD_AGENCIA | Número da agência bancária pagadora. 5.845 agências disponíveis. |
| NU_CONTA_CORRENTE | varchar | 10 | Sim | — | Número da conta corrente do pagamento. Vazio quando o meio não requer conta. |

---

## Titular (_T)

Dados pessoais do **titular** do benefício.

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_TITULAR_BENEF_T | varchar | 40 | Sim | Nome completo do titular do benefício. |
| NM_MAE_T | varchar | 32 | Sim | Nome da mãe do titular. |
| NU_CPF_T | varchar | 11 | Sim | CPF do titular (11 dígitos). Valor `00000000000` indica CPF ausente. |
| ID_NIT_T | varchar | 11 | Sim | Número de Identificação do Trabalhador (NIT/PIS/PASEP) do titular. |
| DT_NASCIMENTO_T | nvarchar | 20 | Sim | Data de nascimento no formato DDMMAAAA. |
| CTPS_T | varchar | 7 | Sim | Número da Carteira de Trabalho e Previdência Social (CTPS). |
| CTPS_SERIE_T | varchar | 5 | Sim | Série da CTPS. |
| CTPS_UF_T | varchar | 2 | Sim | UF de emissão da CTPS. |
| NU_IDENTIDADE_T | varchar | 14 | Sim | Número do documento de identidade (RG). |
| IDENTIDADE_UF_T | varchar | 2 | Sim | UF de emissão do RG. |
| CS_EMISSOR_T | varchar | 2 | Sim | Código do órgão emissor do RG (ex: 01=SSP). |
| NU_TIT_ELEITOR_T | varchar | 11 | Sim | Número do título de eleitor. |
| NU_TIT_ELEITOR_DV_T | varchar | 2 | Sim | Dígitos verificadores do título de eleitor. |
| CS_RESP_VAL_CNIS_T | numeric | 5 | Sim | Código de responsabilidade pela validação no CNIS. |
| CS_SEXO_T | numeric | 5 | Sim | Sexo: 1=Masculino, 2=Feminino. |
| TE_ENDERECO_T | varchar | 40 | Sim | Logradouro e número do endereço. |
| NU_DDD_T | varchar | 4 | Sim | DDD do telefone. |
| NU_TELEFONE_T | varchar | 8 | Sim | Número do telefone. |
| DT_ULTIMA_ALTER_T | nvarchar | 20 | Sim | Data da última alteração cadastral do titular (DDMMAAAA). |
| NM_BAIRRO_T | varchar | 17 | Sim | Bairro do endereço. |
| NU_CEP_T | varchar | 8 | Sim | CEP do endereço (8 dígitos). |
| NM_MUNICIPIO_T | varchar | 24 | Sim | Município de residência. |
| NM_UF_MUNICIPIO_T | varchar | 2 | Sim | Sigla da UF do município. |
| ID_MUN_SINPAS_T | numeric | 5 | Sim | Código do município no sistema SINPAS. |
| ID_MUN_IBGE_T | numeric | 5 | Sim | Código do município no IBGE (6 dígitos). |
| D2_OBITO_T | nvarchar | 20 | Sim | Data de óbito do titular (DDMMAAAA). Vazio enquanto vivo. |

---

## Instituidor (_I)

Dados do **instituidor** — pessoa que originou o benefício derivado (ex: pensão por morte).

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_INSTITUIDOR_I | varchar | 40 | Sim | Nome do instituidor. Vazio quando o benefício não é derivado. |
| NM_MAE_I | varchar | 32 | Sim | Nome da mãe do instituidor. |
| NU_CPF_I | varchar | 11 | Sim | CPF do instituidor. `00000000000` quando ausente. |
| ID_NIT_I | varchar | 11 | Sim | NIT/PIS/PASEP do instituidor. |
| DT_NASCIMENTO_I | nvarchar | 20 | Sim | Data de nascimento do instituidor (DDMMAAAA). |
| CTPS_I | varchar | 7 | Sim | CTPS do instituidor. |
| CTPS_SERIE_I | varchar | 5 | Sim | Série da CTPS do instituidor. |
| CTPS_UF_I | varchar | 2 | Sim | UF da CTPS do instituidor. |
| NU_IDENTIDADE_I | varchar | 14 | Sim | RG do instituidor. |
| IDENTIDADE_UF_I | varchar | 2 | Sim | UF do RG do instituidor. |
| CS_EMISSOR_I | varchar | 2 | Sim | Órgão emissor do RG do instituidor. |
| NU_TIT_ELEITOR_I | varchar | 11 | Sim | Título de eleitor do instituidor. |
| NU_TIT_ELEITOR_DV_I | varchar | 2 | Sim | DV do título de eleitor do instituidor. |
| CS_RESP_VAL_CNIS_I | numeric | 5 | Sim | Validação CNIS do instituidor. |
| CS_SEXO_I | numeric | 5 | Sim | Sexo do instituidor: 1=M, 2=F. 0 quando não aplicável. |
| D2_OBITO_I | nvarchar | 20 | Sim | Data de óbito do instituidor (DDMMAAAA). |

---

## Procurador (_P)

Dados do **procurador** — representante legal designado via procuração.

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_PROCURADOR_P | varchar | 70 | Sim | Nome completo do procurador. |
| NM_MAE_P | varchar | 70 | Sim | Nome da mãe do procurador. |
| NU_CPF_P | varchar | 11 | Sim | CPF do procurador. `00000000000` quando ausente. |
| ID_NIT_P | varchar | 12 | Sim | NIT do procurador. |
| DT_NASCIMENTO_P | nvarchar | 20 | Sim | Data de nascimento do procurador (DDMMAAAA). |
| CTPS_P | varchar | 7 | Sim | CTPS do procurador. |
| CTPS_SERIE_P | varchar | 5 | Sim | Série da CTPS do procurador. |
| CTPS_UF_P | varchar | 2 | Sim | UF da CTPS do procurador. |
| NU_IDENTIDADE_P | varchar | 14 | Sim | RG do procurador. |
| IDENTIDADE_UF_P | varchar | 2 | Sim | UF do RG do procurador. |
| CS_EMISSOR_P | numeric | 5 | Sim | Órgão emissor do RG do procurador. |
| CS_SEXO_P | numeric | 5 | Sim | Sexo do procurador: 1=M, 2=F. |
| NM_BAIRRO_P | varchar | 17 | Sim | Bairro do endereço do procurador. |
| NU_CEP_P | varchar | 8 | Sim | CEP do procurador. |
| TE_ENDERECO_P | varchar | 40 | Sim | Endereço do procurador. |
| NM_MUNICIPIO_P | varchar | 40 | Sim | Município do procurador. |
| NM_UF_MUNICIPIO_P | varchar | 2 | Sim | UF do procurador. |
| MUNICIP_NASC_P | numeric | 5 | Sim | Código SINPAS do município de nascimento do procurador. |

---

## Representante

Dados do **representante legal** (ex: tutor, curador, responsável por incapaz).

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| CS_REPRESENTANTE | numeric | 5 | Sim | Código do tipo de representante. 0 quando não há representante. |
| NM_REPRESENTANTE | varchar | 40 | Sim | Nome do representante. `000...0` (40 zeros) quando ausente. |
| NM_MAE_REPRES | varchar | 32 | Sim | Nome da mãe do representante. |
| NU_CPF_REPRES | varchar | 11 | Sim | CPF do representante. `00000000000` quando ausente. |
| ID_NIT_REPRES | varchar | 11 | Sim | NIT do representante. |
| DT_NASC_REPRES | nvarchar | 20 | Sim | Data de nascimento do representante (DDMMAAAA). |
| NU_CTPS_REPRES | varchar | 7 | Sim | CTPS do representante. |
| NU_CTPS_UF_REPRES | varchar | 2 | Sim | UF da CTPS do representante. |
| NU_IDENT_REPRES | varchar | 14 | Sim | RG do representante. |
| NU_IDENT_UF_REPRES | varchar | 2 | Sim | UF do RG do representante. |
| CS_EMIS_IDENT_REPRES | varchar | 2 | Sim | Órgão emissor do RG do representante. |
| CS_SEXO_REPRES | numeric | 5 | Sim | Sexo do representante: 1=M, 2=F. |

---

## Recebedor

Pessoa que efetivamente recebe o pagamento (pode diferir do titular).

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| NM_RECEBEDOR | varchar | 28 | Sim | Nome do recebedor do pagamento. |
| DT_NASC_RECEB | nvarchar | 20 | Sim | Data de nascimento do recebedor (DDMMAAAA). |
| NU_CPF_RECEBEDOR | varchar | 11 | Sim | CPF do recebedor. |
| CS_SEXO_RECEBEDOR | numeric | 5 | Sim | Sexo do recebedor: 1=M, 2=F. |

---

## Dependentes

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| QT_DEP_IR | numeric | 5 | Sim | Quantidade de dependentes para Imposto de Renda. |
| QT_DEP_VAL_NB | numeric | 5 | Sim | Quantidade de dependentes que influenciam o valor do benefício. |
| QT_DEP_CADASTRO | numeric | 5 | Sim | Total de dependentes cadastrados no benefício. |

---

## Controle ETL

| Campo | Tipo | Tam | Nulável | Descrição |
|-------|------|-----|---------|-----------|
| DS_ERRO | varchar | 1024 | Sim | Descrição de erro de processamento ETL. Vazio em registros corretos. |
| DT_ATUALIZACAO_ETL | datetime2 | 8 | Sim | Timestamp da carga/atualização do registro no data warehouse. |
| NM_ARQUIVO | varchar | 256 | Sim | Nome do arquivo de origem. Padrão: `D.SUB.APE.000.CON1.AAAAMM.NN`. |
| ANO_MES_REF | decimal | 5 | Sim | Competência de referência no formato AAAAMM (ex: 201401 = janeiro/2014). |
