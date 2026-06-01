# Dicionário de Dados — BD_BENEFICIOS_HIST.dbo.MACICA

**Base:** BD_BENEFICIOS / BD_BENEFICIOS_HIST (LabContas)
**Objeto:** Tabela MACICA (object_id 821577965)
**Total de campos:** 149
**Fonte dos metadados:** sys.all_columns + dados reais via ODBC + tabelas COD_* do próprio banco

---

## Grupos de campos

| Grupo | Prefixo / sufixo | Descrição |
|-------|-----------------|-----------|
| Identificação do benefício | NU_NB, ID_OL_* | Chaves e vínculos de processamento |
| Valores financeiros | VL_*, TOT_* | Valores monetários do benefício |
| Classificações de benefício | CS_PA, CS_ESPECIE, CS_TRATAMENTO, CS_RAMO_*, CS_FORMA_*, CS_DOC_*, CS_DESPACHO, CS_SITUACAO_BENEF | Códigos de categorização |
| Datas | D2_*, DT_*, DN_* | Datas previdenciárias e cadastrais |
| Pagamento | ID_BANCO, ID_ORGAO_PAGADOR, CS_MEIO_PAGTO, NU_AGENCIA_PAG, NU_CONTA_CORRENTE | Informações de pagamento |
| Titular do benefício (sufixo _T) | NM_*, NU_*, DT_*, CTPS_*, IDENTIDADE_*, CS_*, TE_*, NM_BAIRRO_*, NU_CEP_*, NU_DDD_*, NU_TELEFONE_*, ID_MUN_* | Dados cadastrais do titular |
| Instituidor (sufixo _I) | NM_*, NU_*, DT_*, CTPS_*, IDENTIDADE_*, CS_*, D2_OBITO_I | Dados do segurado instituidor (para pensão por morte) |
| Procurador (sufixo _P) | NM_*, NU_*, DT_*, CTPS_*, IDENTIDADE_*, CS_*, TE_*, NM_*, NU_CEP_*, NM_MUNICIPIO_* | Dados do procurador legal |
| Representante legal (sufixo _R) | NM_*, ID_NIT_*, DT_*, CTPS_*, IDENTIDADE_*, CS_*, NU_CPF_R, CS_SEXO_R | Dados do representante legal |
| Diagnóstico CID | CS_DIAGNOSTICO_N, CS_DIAGNOSTICO_1 | Código CID-10 |
| Dependentes | QT_DEP_IR, QT_DEP_VAL_NB, QT_DEP_CADASTRO | Quantidades de dependentes |
| Rubricas | CS_RUBRICA_1..10, VL_RUBRICA_1..10 | Rubricas de descontos/créditos |
| Controle ETL | DT_ATUALIZACAO_ETL, NM_ARQUIVO, DS_ERRO, ANO_MES_REF | Metadados de carga |
| Outros | NU_MATR_CONCESSOR, NU_MATR_HABILITADOR, NU_MATR_MP1, NU_MATR_MP2, NU_TIT_ELEITOR, CS_VAL_CNIS, CS_LC_142_2013 | Matrícula de servidores e validações |

---

## Tabela detalhada de campos

| col_id | campo | tipo_sql | tamanho | nulável | fk / tabela de domínio | descrição |
|--------|-------|----------|---------|---------|------------------------|-----------|
| 1 | NU_NB | varchar(10) | 10 | Sim | — | Número do Benefício (NB): identificador único do benefício no INSS. Candidato a PK analítica. |
| 2 | ID_OL_CONCESSAO | varchar(8) | 8 | Sim | — | Identificador do Órgão Local de Concessão do benefício (código da APS/GEX). |
| 3 | ID_OL_MANUTENCAO | varchar(8) | 8 | Sim | — | Identificador do Órgão Local responsável pela manutenção atual do benefício. |
| 4 | ID_OL_MANUT_ANT | varchar(8) | 8 | Sim | — | Órgão Local de manutenção anterior (histórico de transferência). |
| 5 | CS_PA | decimal(1,0) | — | Sim | — | Código de "Parte Autora" — identifica se há ação judicial associada ao benefício. |
| 6 | VL_MR_ATU | decimal(14,2) | — | Sim | — | Valor da Mensalidade/Renda Atual (RMA): valor bruto mensal efetivamente pago na competência. |
| 7 | VL_RMI | decimal(14,2) | — | Sim | — | Valor da Renda Mensal Inicial (RMI): valor do benefício na data de início, antes de reajustes. |
| 8 | CS_TRATAMENTO | decimal(2,0) | — | Sim | COD_TRATAMENTO | Código de tratamento do benefício (previdenciário, estatutário, misto etc.). |
| 9 | CS_ESPECIE | decimal(2,0) | — | Sim | COD_ESPECIE | Código de espécie do benefício (ex: 41=Aposent. por Idade, 88=Amparo Social Idoso). 2 dígitos. |
| 10 | CS_RAMO_ATIVIDADE | decimal(1,0) | — | Sim | COD_RAMO_ATIVIDADE | Ramo de atividade do segurado (01=Bancário, 02=Comerciário, 08=Rural, 09=Irrelevante etc.). |
| 11 | CS_FORMA_FILIACAO | decimal(1,0) | — | Sim | COD_FORMA_FILIACAO | Forma de filiação ao RGPS (1=Empregado, 7=Segurado Especial, 8=Contribuinte Individual etc.). |
| 12 | CS_DOC_EMPREGADOR | decimal(1,0) | — | Sim | COD_DOC_EMPREGADOR | Tipo de documento do empregador (1=CNPJ/CGC, 2=CEI, 3=CPF, 7=NIT). |
| 13 | NU_DOC_EMPREGADOR | varchar(14) | 14 | Sim | — | Número do documento do empregador (CNPJ, CEI ou CPF, conforme CS_DOC_EMPREGADOR). |
| 14 | NU_NB_ANT | varchar(10) | 10 | Sim | — | Número do benefício anterior (origem/conversão). '0000000000' quando não há. |
| 15 | D2_DER | varchar(8) | 8 | Sim | — | Data de Entrada do Requerimento (DER): data em que o segurado protocolou o pedido. Formato DDMMAAAA. |
| 16 | D2_DIB | varchar(8) | 8 | Sim | — | Data de Início do Benefício (DIB): data a partir da qual o benefício é devido. Formato DDMMAAAA. |
| 17 | D2_DDB | varchar(8) | 8 | Sim | — | Data de Despacho do Benefício (DDB): data em que o benefício foi aprovado/despachado. Formato DDMMAAAA. |
| 18 | D2_DCB | varchar(8) | 8 | Sim | — | Data de Cessação do Benefício (DCB): data em que o benefício foi encerrado. Vazio se ativo. Formato DDMMAAAA. |
| 19 | D2_DIP | varchar(8) | 8 | Sim | — | Data de Início do Pagamento (DIP): data do primeiro crédito ao beneficiário. Formato DDMMAAAA. |
| 20 | D2_INI_INCAPAC | varchar(8) | 8 | Sim | — | Data de Início da Incapacidade: data em que a incapacidade laboral teve início (para benefícios por incapacidade). Formato DDMMAAAA. |
| 21 | D2_INICIO_DOENCA | varchar(8) | 8 | Sim | — | Data de Início da Doença: data do diagnóstico ou início da enfermidade. Formato DDMMAAAA. |
| 22 | D2_DRD | varchar(8) | 8 | Sim | — | Data de Realização do Despacho (DRD): data de emissão do despacho definitivo. Formato DDMMAAAA. |
| 23 | D2_OBITO_RECLUSAO | varchar(8) | 8 | Sim | — | Data de óbito do segurado ou data de reclusão (para auxílio-reclusão). Formato DDMMAAAA. |
| 24 | CS_CLIENTELA | varchar(1) | 1 | Sim | — | Clientela do benefício: U=Urbano, R=Rural. Indica o regime previdenciário de origem. |
| 25 | NU_MATR_CONCESSOR | varchar(8) | 8 | Sim | — | Matrícula do servidor responsável pela concessão do benefício. |
| 26 | NU_MATR_HABILITADOR | varchar(8) | 8 | Sim | — | Matrícula do servidor habilitador (responsável pela habilitação do pagamento). |
| 27 | CS_SITUACAO_BENEF | decimal(2,0) | — | Sim | COD_SITUACAO | Situação atual do benefício (00=Ativo, 02=Cessado, 03=Suspenso etc.). |
| 28 | ID_BANCO | varchar(3) | 3 | Sim | — | Código do banco pagador (código FEBRABAN, ex: 341=Itaú, 033=Santander). |
| 29 | ID_ORGAO_PAGADOR | varchar(6) | 6 | Sim | — | Código da agência/órgão pagador (PAB ou agência bancária). |
| 30 | CS_MEIO_PAGTO | decimal(2,0) | — | Sim | COD_MEIO_PAGAMENTO | Código do meio de pagamento (01=Cartão Magnético, 02=Conta Corrente Fita Magnética etc.). |
| 31 | NU_AGENCIA_PAG | varchar(6) | 6 | Sim | — | Número da agência bancária pagadora. |
| 32 | NU_CONTA_CORRENTE | varchar(10) | 10 | Sim | — | Número da conta corrente bancária do beneficiário. |
| 33 | CS_DIAGNOSTICO_N | varchar(6) | 6 | Sim | COD_CID | Código CID da doença principal (novo). Referência à tabela COD_CID (CID-10). |
| 34 | CS_DIAGNOSTICO_1 | varchar(6) | 6 | Sim | COD_CID | Código CID anterior/complementar. Referência à tabela COD_CID (CID-10). |
| 35 | NU_MATR_MP1 | varchar(7) | 7 | Sim | — | Matrícula do médico perito 1 responsável pela perícia. |
| 36 | NU_MATR_MP2 | varchar(7) | 7 | Sim | — | Matrícula do médico perito 2 (quando houver dupla perícia). |
| 37 | D2_FORMAT_CONC | varchar(8) | 8 | Sim | — | Data de formalização da concessão. Formato DDMMAAAA. |
| 38 | CS_DESPACHO | decimal(2,0) | — | Sim | COD_DESPACHO | Código de despacho do benefício (tipo da decisão de concessão). |
| 39 | DT_DIA_UTIL_PAGTO | varchar(2) | 2 | Sim | — | Dia útil de pagamento (calendário de crédito bancário). |
| 40 | NM_RECEBEDOR | varchar(28) | 28 | Sim | — | Nome do recebedor do pagamento (pode ser o próprio beneficiário, procurador ou representante). |
| 41 | DN_RECEBEDOR | varchar(8) | 8 | Sim | — | Data de nascimento do recebedor. Formato DDMMAAAA. |
| 42 | NU_CPF_R | varchar(11) | 11 | Sim | — | CPF do representante legal (sufixo _R). 11 dígitos sem pontuação. |
| 43 | CS_SEXO_R | decimal(1,0) | — | Sim | — | Sexo do representante legal (1=Masculino, 2=Feminino). |
| 44 | NM_TITULAR_BENEF_T | varchar(40) | 40 | Sim | — | Nome completo do titular do benefício (sufixo _T). |
| 45 | NM_MAE_T | varchar(32) | 32 | Sim | — | Nome da mãe do titular. |
| 46 | NU_CPF_T | varchar(11) | 11 | Sim | — | CPF do titular do benefício. 11 dígitos sem pontuação. |
| 47 | ID_NIT_T | varchar(11) | 11 | Sim | — | NIT (Número de Identificação do Trabalhador) do titular. Equivalente ao PIS/PASEP. |
| 48 | DT_NASCIMENTO_T | varchar(8) | 8 | Sim | — | Data de nascimento do titular. Formato DDMMAAAA. |
| 49 | CTPS_T | varchar(7) | 7 | Sim | — | Número da Carteira de Trabalho e Previdência Social (CTPS) do titular. |
| 50 | CTPS_SERIE_T | varchar(5) | 5 | Sim | — | Série da CTPS do titular. |
| 51 | CTPS_UF_T | varchar(2) | 2 | Sim | COD_UF | UF de emissão da CTPS do titular. |
| 52 | NU_IDENTIDADE_T | varchar(14) | 14 | Sim | — | Número do documento de identidade (RG) do titular. |
| 53 | IDENTIDADE_UF_T | varchar(2) | 2 | Sim | COD_UF | UF emissora do RG do titular. |
| 54 | CS_EMISSOR_T | varchar(2) | 2 | Sim | COD_EMISSOR | Código do órgão emissor do RG do titular (ex: SSP, IFP, PC). |
| 55 | NU_TIT_ELEITOR | varchar(13) | 13 | Sim | — | Número do título de eleitor do titular. |
| 56 | CS_VAL_CNIS | decimal(2,0) | — | Sim | — | Código de validação do CNIS (Cadastro Nacional de Informações Sociais) do titular. |
| 57 | CS_SEXO_T | decimal(1,0) | — | Sim | — | Sexo do titular (1=Masculino, 2=Feminino). |
| 58 | TE_ENDERECO_T | varchar(40) | 40 | Sim | — | Logradouro/endereço do titular. |
| 59 | NM_BAIRRO_T | varchar(17) | 17 | Sim | — | Bairro do titular. |
| 60 | NU_CEP_T | varchar(8) | 8 | Sim | — | CEP do titular (8 dígitos sem hífen). |
| 61 | NU_DDD_T | varchar(4) | 4 | Sim | — | DDD do telefone do titular. |
| 62 | NU_TELEFONE_T | varchar(8) | 8 | Sim | — | Número de telefone do titular (sem DDD). |
| 63 | ID_MUN_SINPAS_T | varchar(5) | 5 | Sim | — | Código SINPAS do município de residência do titular (código legado). |
| 64 | ID_MUN_IBGE_T | varchar(6) | 6 | Sim | — | Código IBGE do município de residência do titular (6 dígitos). |
| 65 | NM_MUNICIPIO_T | varchar(24) | 24 | Sim | — | Nome do município de residência do titular. |
| 66 | NM_UF_MUNICIPIO_T | varchar(2) | 2 | Sim | COD_UF | UF de residência do titular. |
| 67 | D2_OBITO_T | varchar(8) | 8 | Sim | — | Data de óbito do titular. Preenchido quando houver registro de falecimento. Formato DDMMAAAA. |
| 68 | NM_INSTITUIDOR_I | varchar(40) | 40 | Sim | — | Nome do segurado instituidor da pensão por morte (sufixo _I). |
| 69 | NM_MAE_I | varchar(32) | 32 | Sim | — | Nome da mãe do instituidor. |
| 70 | NU_CPF_I | varchar(11) | 11 | Sim | — | CPF do instituidor. |
| 71 | ID_NIT_I | varchar(11) | 11 | Sim | — | NIT do instituidor. |
| 72 | DT_NASCIMENTO_I | varchar(8) | 8 | Sim | — | Data de nascimento do instituidor. Formato DDMMAAAA. |
| 73 | CTPS_I | varchar(7) | 7 | Sim | — | Número da CTPS do instituidor. |
| 74 | CTPS_SERIE_I | varchar(5) | 5 | Sim | — | Série da CTPS do instituidor. |
| 75 | CTPS_UF_I | varchar(2) | 2 | Sim | COD_UF | UF de emissão da CTPS do instituidor. |
| 76 | NU_IDENTIDADE_I | varchar(14) | 14 | Sim | — | RG do instituidor. |
| 77 | IDENTIDADE_UF_I | varchar(2) | 2 | Sim | COD_UF | UF emissora do RG do instituidor. |
| 78 | CS_EMISSOR_I | varchar(2) | 2 | Sim | COD_EMISSOR | Órgão emissor do RG do instituidor. |
| 79 | NU_TIT_ELEITOR_I | varchar(13) | 13 | Sim | — | Título de eleitor do instituidor. |
| 80 | CS_VAL_CNIS_I | decimal(2,0) | — | Sim | — | Validação CNIS do instituidor. |
| 81 | CS_SEXO_I | decimal(1,0) | — | Sim | — | Sexo do instituidor (1=Masculino, 2=Feminino). |
| 82 | D2_OBITO_I | varchar(8) | 8 | Sim | — | Data de óbito do instituidor. Formato DDMMAAAA. |
| 83 | NM_PROCURADOR_P | varchar(70) | 70 | Sim | — | Nome do procurador legal (sufixo _P). |
| 84 | NM_MAE_P | varchar(70) | 70 | Sim | — | Nome da mãe do procurador. |
| 85 | NU_CPF_P | varchar(11) | 11 | Sim | — | CPF do procurador. |
| 86 | ID_NIT_P | varchar(11) | 11 | Sim | — | NIT do procurador. |
| 87 | DT_NASCIMENTO_P | varchar(8) | 8 | Sim | — | Data de nascimento do procurador. Formato DDMMAAAA. |
| 88 | CTPS_P | varchar(7) | 7 | Sim | — | CTPS do procurador. |
| 89 | CTPS_SERIE_P | varchar(5) | 5 | Sim | — | Série da CTPS do procurador. |
| 90 | CTPS_UF_P | varchar(2) | 2 | Sim | COD_UF | UF da CTPS do procurador. |
| 91 | NU_IDENTIDADE_P | varchar(14) | 14 | Sim | — | RG do procurador. |
| 92 | IDENTIDADE_UF_P | varchar(2) | 2 | Sim | COD_UF | UF emissora do RG do procurador. |
| 93 | CS_EMISSOR_P | varchar(2) | 2 | Sim | COD_EMISSOR | Órgão emissor do RG do procurador. |
| 94 | CS_SEXO_P | decimal(1,0) | — | Sim | — | Sexo do procurador (1=Masculino, 2=Feminino). |
| 95 | NM_BAIRRO_P | varchar(17) | 17 | Sim | — | Bairro do procurador. |
| 96 | NU_CEP_P | varchar(8) | 8 | Sim | — | CEP do procurador. |
| 97 | TE_ENDERECO_P | varchar(40) | 40 | Sim | — | Logradouro do procurador. |
| 98 | NM_MUNICIPIO_P | varchar(40) | 40 | Sim | — | Município do procurador. |
| 99 | NM_UF_MUNICIPIO_P | varchar(2) | 2 | Sim | COD_UF | UF do procurador. |
| 100 | MUNICIP_NASC_P | decimal(6,0) | — | Sim | — | Código do município de nascimento do procurador. |
| 101 | NM_REPRESENTANTE_R | varchar(40) | 40 | Sim | — | Nome do representante legal (sufixo _R, diferente de procurador). |
| 102 | NM_MAE_R | varchar(32) | 32 | Sim | — | Nome da mãe do representante legal. |
| 103 | ID_NIT_R | varchar(11) | 11 | Sim | — | NIT do representante legal. |
| 104 | DT_NASCIMENTO_R | varchar(8) | 8 | Sim | — | Data de nascimento do representante legal. Formato DDMMAAAA. |
| 105 | CTPS_R | varchar(7) | 7 | Sim | — | CTPS do representante legal. |
| 106 | CTPS_SERIE_R | varchar(5) | 5 | Sim | — | Série da CTPS do representante legal. |
| 107 | CTPS_UF_R | varchar(2) | 2 | Sim | COD_UF | UF da CTPS do representante legal. |
| 108 | NU_IDENTIDADE_R | varchar(14) | 14 | Sim | — | RG do representante legal. |
| 109 | IDENTIDADE_UF_R | varchar(2) | 2 | Sim | COD_UF | UF emissora do RG do representante legal. |
| 110 | CS_EMISSOR_R | varchar(2) | 2 | Sim | COD_EMISSOR | Órgão emissor do RG do representante legal. |
| 111 | CS_TIPO_R | decimal(1,0) | — | Sim | COD_TIPO | Tipo do representante legal (01=Recursos, 02=Ações Originárias). |
| 112 | QT_DEP_IR | decimal(2,0) | — | Sim | — | Quantidade de dependentes para fins de Imposto de Renda. |
| 113 | QT_DEP_VAL_NB | decimal(2,0) | — | Sim | — | Quantidade de dependentes que influenciam o valor do NB (ex: salário-família). |
| 114 | QT_DEP_CADASTRO | decimal(2,0) | — | Sim | — | Quantidade total de dependentes cadastrados. |
| 115 | QT_RUBRICA_REG | decimal(3,0) | — | Sim | — | Quantidade de rubricas registradas para este benefício (máximo 10). |
| 116..125 | CS_RUBRICA_1..10 | decimal(3,0) | — | Sim | COD_RUBRICA | Código de cada rubrica (desconto ou crédito) registrada. Até 10 rubricas por benefício. |
| 126..135 | VL_RUBRICA_1..10 | decimal(14,2) | — | Sim | — | Valor monetário de cada rubrica correspondente (CS_RUBRICA_N e VL_RUBRICA_N são pares). |
| 136 | VL_BRUTO | decimal(14,2) | — | Sim | — | Valor bruto do benefício antes de descontos (soma das rubricas de crédito). |
| 137 | TOT_DESCONTOS | decimal(14,2) | — | Sim | — | Total de descontos aplicados (soma das rubricas de desconto). |
| 138 | VL_LIQUIDO | decimal(14,2) | — | Sim | — | Valor líquido do benefício = VL_BRUTO - TOT_DESCONTOS. |
| 139 | NU_CPF | varchar(11) | 11 | Sim | — | CPF do beneficiário (campo consolidado, sem sufixo de papel). |
| 140 | CS_SEXO | decimal(1,0) | — | Sim | — | Sexo do beneficiário (campo consolidado; 1=Masculino, 2=Feminino). |
| 141 | DT_ULTIMA_ALTER | varchar(8) | 8 | Sim | — | Data da última alteração cadastral no benefício. Formato DDMMAAAA. |
| 142 | D2_LIMITE | varchar(8) | 8 | Sim | — | Data limite do benefício (prazo máximo de duração, se houver). Formato DDMMAAAA. |
| 143 | DS_ERRO | varchar(1024) | 1024 | Sim | — | Descrição de erros ou inconsistências detectados no processamento/ETL. |
| 144 | DT_ATUALIZACAO_ETL | datetime | — | Sim | — | Data e hora da carga/atualização pelo processo ETL no LabContas. |
| 145 | NM_ARQUIVO | varchar(256) | 256 | Sim | — | Nome do arquivo de carga ETL de origem (ex: D.SUB.APE.000.MAC.AAAAMM.NN). |
| 146 | ANO_MES_REF | decimal(6,0) | — | Sim | — | Ano e mês de referência da folha (competência, formato AAAAMM, ex: 201401). |
| 147 | DT_ULTIMA_PERICIA | varchar(8) | 8 | Sim | — | Data da última perícia médica realizada. Formato DDMMAAAA. |
| 148 | FASE_ULTIMA_PERICIA | varchar(2) | 2 | Sim | — | Código da fase/resultado da última perícia médica. |
| 149 | CS_LC_142_2013 | numeric(1,0) | — | Sim | — | Indicador de enquadramento na Lei Complementar 142/2013 (aposentadoria da pessoa com deficiência). |

---

## Tabelas complementares relacionadas

| tabela | campo MACICA relacionado | descrição |
|--------|--------------------------|-----------|
| COD_ESPECIE | CS_ESPECIE | 99 espécies de benefício (previdenciários, assistenciais, acidentários) |
| COD_SITUACAO | CS_SITUACAO_BENEF | 24 situações possíveis (Ativo, Cessado, Suspenso e variantes) |
| COD_MEIO_PAGAMENTO | CS_MEIO_PAGTO | 9 meios de pagamento (cartão, conta corrente, OPB etc.) |
| COD_TRATAMENTO | CS_TRATAMENTO | 64 tipos de tratamento do benefício |
| COD_DESPACHO | CS_DESPACHO | 43 tipos de despacho de concessão |
| COD_RAMO_ATIVIDADE | CS_RAMO_ATIVIDADE | 9 ramos de atividade do segurado |
| COD_FORMA_FILIACAO | CS_FORMA_FILIACAO | 10 formas de filiação ao RGPS |
| COD_DOC_EMPREGADOR | CS_DOC_EMPREGADOR | 5 tipos de documento do empregador |
| COD_EMISSOR | CS_EMISSOR_T, CS_EMISSOR_I, CS_EMISSOR_P, CS_EMISSOR_R | 38 órgãos emissores de RG |
| COD_RUBRICA | CS_RUBRICA_1..10 | 285 tipos de rubrica (descontos e créditos) |
| COD_TIPO | CS_TIPO_R | 2 tipos de representante legal |
| COD_UF | campos _UF_* | 27 UFs + DF |
| COD_CID | CS_DIAGNOSTICO_N, CS_DIAGNOSTICO_1 | 14.233 códigos CID-10 |
| COD_GEX | ID_OL_* | 100 Gerências Executivas do INSS |
| COD_MOTIVO_CONCESSAO2 | — | 99 motivos de concessão/cessação |

---

## Notas sobre dados e padrões observados na amostra

1. **Datas** armazenadas como varchar(8) no formato DDMMAAAA (não ISO). Atenção ao converter.
2. **NU_NB** com 10 dígitos — o NB real tem 10 posições incluindo DV.
3. **ANO_MES_REF** é a chave de competência no formato AAAAMM (ex: 201401 = jan/2014).
4. **NM_ARQUIVO** segue padrão `D.SUB.APE.000.MAC.AAAAMM.NN` — permite rastrear a competência de carga.
5. **CS_ESPECIE 88** = Amparo Social ao Idoso (BPC/LOAS), **87** = Amparo Social Pessoa com Deficiência.
6. **Rubricas** funcionam como pares paralelos: CS_RUBRICA_N + VL_RUBRICA_N. QT_RUBRICA_REG indica quantas estão preenchidas.
7. **Campos de papel** (_T = Titular, _I = Instituidor, _P = Procurador, _R = Representante) podem estar vazios dependendo da espécie.
