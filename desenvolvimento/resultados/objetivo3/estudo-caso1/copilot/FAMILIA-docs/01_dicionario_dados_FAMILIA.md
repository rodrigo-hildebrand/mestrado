# Dicionario de Dados - FAMILIA
**Base:** BD_CAD_UNICO.dbo.FAMILIA
**Total de campos:** 45

## Estrutura de campos
| Campo | Tipo | Tam | Nulavel | FK / Dominio | Descricao |
|---|---|---|---|---|---|
| NOME_ARQUIVO_CARGA | varchar | 258 | True | - | Nome do arquivo que originou a carga do registro. |
| COD_PREFEITURA | varchar | 13 | True | - | Identificador da prefeitura ou ente local responsavel pelo cadastro. |
| COD_FAMILIA | varchar | 11 | True | - | Identificador da familia no Cadastro Unico. |
| DAT_CADASTRAMENTO_FAM | date | 3 | True | - | Data em que a familia foi cadastrada no Cadastro Unico. |
| DAT_ATUAL_FAM | date | 3 | True | - | Data da ultima atualizacao cadastral da familia. |
| COD_EST_CADASTRAL_FAM | varchar | 1 | True | COD_EST_CADASTRAL_FAM | Codigo do estado cadastral da familia, como cadastrada ou excluida. |
| IND_CADASTRO_VALIDO_FAM | varchar | 1 | True | COD_IND_CADASTRO_VALIDO_FAM | Indica se o cadastro da familia esta valido para uso pelos programas. |
| COD_CONDICAO_CADASTRO_FAM | varchar | 1 | True | COD_CONDICAO_CADASTRO_FAM | Codigo que informa se o cadastro da familia esta atualizado ou desatualizado. |
| VLR_RENDA_MEDIA_FAM | decimal | 5 | True | - | Valor da renda media familiar apurada no cadastro. |
| IND_TRABALHO_INFANTIL_FAM | varchar | 1 | True | COD_IND_TRAB_INFANTIL_PESSOA | Indica ocorrencia de trabalho infantil associada a integrantes da familia. |
| COD_MUNIC_IBGE_2_FAM | varchar | 2 | True | - | Codigo IBGE resumido do municipio associado ao cadastro da familia. |
| COD_MUNIC_IBGE_5_FAM | varchar | 5 | True | - | Codigo IBGE do municipio associado ao cadastro da familia. |
| COD_IBGE_DISTRITO_FAM | varchar | 2 | True | - | Codigo IBGE do distrito do domicilio da familia. |
| COD_IBGE_SUBDISTR_FAM | varchar | 2 | True | - | Codigo IBGE do subdistrito do domicilio da familia. |
| COD_IBGE_SETOR_CENSO_FAM | varchar | 4 | True | - | Codigo do setor censitario do domicilio da familia. |
| COD_MODALIDADE_FAM | varchar | 1 | True | - | Codigo da modalidade cadastral ou perfil territorial da familia. |
| COD_FORMA_COLETA_FAM | varchar | 1 | True | COD_FORMA_COLETA_FAM | Codigo da forma de coleta do cadastro da familia, com ou sem visita domiciliar. |
| IND_FORMULARIO_0_FAM | smallint | 2 | True | - | Indica utilizacao do formulario principal 0 no cadastro da familia. |
| IND_FORMULARIO_1_FAM | smallint | 2 | True | - | Indica utilizacao do formulario complementar 1 no cadastro da familia. |
| IND_FORMULARIO_2_FAM | smallint | 2 | True | - | Indica utilizacao do formulario complementar 2 no cadastro da familia. |
| IND_FORMULARIO_SUP1_FAM | smallint | 2 | True | - | Indica utilizacao do formulario suplementar 1 no cadastro da familia. |
| IND_FORMULARIO_SUP2_FAM | smallint | 2 | True | - | Indica utilizacao do formulario suplementar 2 no cadastro da familia. |
| DTA_ENTREVISTA_FAM | date | 3 | True | - | Data da entrevista de cadastramento ou atualizacao da familia. |
| NOM_LOCALIDADE_FAM | varchar | 76 | True | - | Nome da localidade informada para a familia. |
| NOM_TIP_LOGRADOURO_FAM | varchar | 38 | True | - | Tipo do logradouro do endereco da familia, como rua ou avenida. |
| NOM_TITULO_LOGRADOURO_FAM | varchar | 38 | True | - | Titulo do logradouro do endereco da familia, quando existente. |
| NOM_LOGRADOURO_FAM | varchar | 76 | True | - | Nome do logradouro do endereco da familia. |
| NUM_LOGRADOURO_FAM | varchar | 16 | True | - | Numero do logradouro do endereco da familia. |
| DES_COMPLEMENTO_FAM | varchar | 22 | True | - | Complemento principal do endereco da familia. |
| DES_COMPLEMENTO_ADIC_FAM | varchar | 75 | True | - | Informacao complementar adicional do endereco da familia. |
| NUM_CEP_LOGRADOURO_FAM | varchar | 8 | True | - | CEP do endereco da familia. |
| COD_UNIDADE_TERRITORIAL_FAM | varchar | 10 | True | - | Codigo da unidade territorial associada ao domicilio da familia. |
| NOM_UNIDADE_TERRITORIAL_FAM | varchar | 33 | True | - | Nome da unidade territorial associada ao domicilio da familia. |
| TXT_REFERENCIA_LOCAL_FAM | varchar | 256 | True | - | Ponto de referencia textual para localizacao do domicilio da familia. |
| NOM_ENTREVISTADOR_FAM | varchar | 70 | True | - | Nome do entrevistador responsavel pelo atendimento da familia. |
| NUM_CPF_ENTREVISTADOR_FAM | varchar | 11 | True | - | CPF do entrevistador responsavel pelo atendimento da familia. |
| TXT_OBS_ENTREVISTADOR_FAM | varchar | 256 | True | - | Observacoes registradas pelo entrevistador sobre o cadastro da familia. |
| COD_ORIGEM_PREFEITURA_FAM | varchar | 13 | True | - | Identificador da prefeitura de origem em casos de transferencia ou migracao do cadastro da familia. |
| COD_ORIGEM_FAMILIA_FAM | varchar | 11 | True | - | Codigo da familia no cadastro de origem, quando houver transferencia. |
| ANO_MES_CARGA | varchar | 6 | True | - | Competencia da carga no formato AAAAMM. |
| DT_ATUALIZACAO_ETL | datetime2 | 8 | True | - | Timestamp de atualizacao do processo ETL. |
| DT_CDSTR_ATUAL_FMLA | date | 3 | True | - | Data limite ou data prevista para nova atualizacao cadastral da familia. |
| FLAG_FAM_ALTERADA_V7 | varchar | 1 | True | - | Indica se a familia sofreu alteracao relevante na migracao para a versao 7 do sistema. |
| DS_ERRO | varchar | 1024 | True | - | Descricao do erro ou alerta de qualidade identificado durante a carga. |
| DT_ATUALIZACAO_FAM | date | 3 | True | - | Data efetiva de atualizacao mais recente do cadastro da familia. |

## Observacoes
- Campos de data estao em `date`/`datetime`, sem necessidade de parser DDMMAAAA neste dataset.
- O relacionamento principal esperado e `FAMILIA.COD_FAMILIA` -> `PESSOA.COD_FAMILIA`.
- `DS_ERRO` concentra diagnosticos de qualidade de carga quando presentes.
