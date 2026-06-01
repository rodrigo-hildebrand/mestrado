# Dicionario de Dados - PESSOA
**Base:** BD_CAD_UNICO.dbo.PESSOA
**Total de campos:** 40

## Estrutura de campos
| Campo | Tipo | Tam | Nulavel | FK / Dominio | Descricao |
|---|---|---|---|---|---|
| NOME_ARQUIVO_CARGA | varchar | 258 | True | - | Nome do arquivo que originou a carga do registro. |
| COD_PREFEITURA | varchar | 13 | True | - | Identificador da prefeitura ou ente local responsavel pelo cadastro. |
| COD_FAMILIA | varchar | 11 | True | - | Identificador da familia no Cadastro Unico. |
| COD_PESSOA | varchar | 11 | True | - | Identificador da pessoa no Cadastro Unico. |
| DTA_CADASTRAMENTO_MEMB | date | 3 | True | - | Data em que a pessoa foi incluida no cadastro da familia. |
| DTA_ATUAL_MEMB | date | 3 | True | - | Data da ultima atualizacao cadastral da pessoa. |
| COD_EST_CADASTRAL_MEMB | varchar | 1 | True | COD_EST_CADASTRAL_MEMBRO | Codigo do estado cadastral da pessoa dentro do Cadastro Unico. |
| IND_TRABALHO_INFANTIL_PESSOA | decimal | 5 | True | COD_IND_TRAB_INFANTIL_PESSOA | Indica ocorrencia de trabalho infantil para a pessoa cadastrada. |
| NUM_ORDEM_PESSOA | varchar | 2 | True | - | Posicao ordinal da pessoa dentro da composicao familiar. |
| NOM_PESSOA | varchar | 70 | True | - | Nome completo da pessoa cadastrada. |
| NUM_NIS_PESSOA_ATUAL | varchar | 11 | True | - | Numero do NIS atualmente vinculado a pessoa. |
| NOM_APELIDO_PESSOA | varchar | 34 | True | - | Apelido ou nome social/apelido registrado para a pessoa. |
| COD_SEXO_PESSOA | varchar | 1 | True | COD_SEXO_PESSOA | Codigo do sexo da pessoa. |
| DTA_NASC_PESSOA | date | 3 | True | - | Data de nascimento da pessoa. |
| COD_PARENTESCO_RF_PESSOA | varchar | 2 | True | COD_PARENTESCO | Codigo do parentesco da pessoa em relacao ao responsavel familiar. |
| COD_RACA_COR_PESSOA | varchar | 1 | True | COD_RACA | Codigo de raca/cor declarado para a pessoa. |
| NOM_COMPLETO_MAE_PESSOA | varchar | 70 | True | - | Nome completo da mae da pessoa. |
| IND_NOM_COMPLETO_MAE_PESSOA | decimal | 5 | True | - | Indica se a informacao sobre o nome completo da mae foi declarada. |
| NOM_COMPLETO_PAI_PESSOA | varchar | 70 | True | - | Nome completo do pai da pessoa. |
| IND_NOM_COMPLETO_PAI_PESSOA | decimal | 5 | True | - | Indica se a informacao sobre o nome completo do pai foi declarada. |
| COD_LOCAL_NASCIMENTO_PESSOA | varchar | 1 | True | - | Codigo do tipo de local de nascimento da pessoa, no Brasil ou exterior. |
| SIG_UF_MUNIC_NASC_PESSOA | varchar | 2 | True | - | Sigla da UF do municipio de nascimento da pessoa. |
| IND_UF_MUNIC_NASC_PESSOA | decimal | 5 | True | - | Indica se a UF do municipio de nascimento foi informada. |
| NOM_IBGE_MUNIC_NASC_PESSOA | varchar | 35 | True | - | Nome do municipio de nascimento da pessoa segundo referencia IBGE. |
| COD_IBGE_MUNIC_NASC_PESSOA | varchar | 7 | True | - | Codigo IBGE do municipio de nascimento da pessoa. |
| IND_IBGE_MUNIC_NASC_PESSOA | decimal | 5 | True | - | Indica se o codigo IBGE do municipio de nascimento foi informado. |
| NOM_PAIS_ORIGEM_PESSOA | varchar | 40 | True | - | Nome do pais de origem da pessoa, quando aplicavel. |
| COD_PAIS_ORIGEM_PESSOA | varchar | 2 | True | - | Codigo do pais de origem da pessoa. |
| IND_PAIS_ORIGEM_PESSOA | decimal | 5 | True | - | Indica se o pais de origem foi informado. |
| COD_CERTIDAO_REGISTRADA_PESSOA | varchar | 1 | True | COD_CERTIDAO_CIVIL_PESSOA | Codigo do tipo de certidao civil registrada para a pessoa. |
| COD_ORIGEM_PREFEITURA_PESSOA | varchar | 13 | True | - | Identificador da prefeitura de origem da pessoa em casos de transferencia. |
| COD_ORIGEM_FAMILIA_PESSOA | varchar | 11 | True | - | Codigo da familia de origem da pessoa em casos de transferencia. |
| IND_TRANSFERENCIA_PESSOA | decimal | 5 | True | - | Indica se o registro da pessoa foi transferido de outro cadastro/localidade. |
| NOM_ORIGEM_ALTERACAO_PESSOA | varchar | 60 | True | - | Nome da origem ou sistema que motivou a alteracao do registro da pessoa. |
| CHV_NAT_PES_ATUAL | varchar | 13 | True | - | Chave natural atual da pessoa no sistema do Cadastro Unico. |
| CHV_NAT_PES_ORIGINAL | varchar | 13 | True | - | Chave natural original da pessoa antes de ajustes ou migracoes. |
| NU_NIS_ORIGINAL | varchar | 11 | True | - | Numero do NIS originalmente associado a pessoa. |
| ANO_MES_CARGA | varchar | 6 | True | - | Competencia da carga no formato AAAAMM. |
| DT_ATUALIZACAO_ETL | datetime | 8 | True | - | Timestamp de atualizacao do processo ETL. |
| DS_ERRO | varchar | 1024 | True | - | Descricao do erro ou alerta de qualidade identificado durante a carga. |

## Observacoes
- Campos de data estao em `date`/`datetime`, sem necessidade de parser DDMMAAAA neste dataset.
- O relacionamento principal esperado e `FAMILIA.COD_FAMILIA` -> `PESSOA.COD_FAMILIA`.
- `DS_ERRO` concentra diagnosticos de qualidade de carga quando presentes.
