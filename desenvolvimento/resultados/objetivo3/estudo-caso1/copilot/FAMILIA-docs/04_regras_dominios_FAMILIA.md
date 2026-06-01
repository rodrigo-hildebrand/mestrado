# Regras e Dominios - FAMILIA

## Regras de negocio

### R01 - Chave logica da familia
`COD_FAMILIA` deve identificar uma familia de forma univoca por carga (`ANO_MES_CARGA`).

### R02 - Consistencia temporal de atualizacao
`DAT_ATUAL_FAM` deve ser maior ou igual a `DAT_CADASTRAMENTO_FAM` quando ambas preenchidas.

### R03 - Condicao cadastral conhecida
`COD_CONDICAO_CADASTRO_FAM` deve existir em `COD_CONDICAO_CADASTRO_FAM`.

### R04 - Estado cadastral conhecido
`COD_EST_CADASTRAL_FAM` deve existir em `COD_EST_CADASTRAL_FAM`.

### R05 - Indicador de cadastro valido
`IND_CADASTRO_VALIDO_FAM` deve pertencer ao dominio de `COD_IND_CADASTRO_VALIDO_FAM`.

### R06 - Forma de coleta conhecida
`COD_FORMA_COLETA_FAM` deve existir em `COD_FORMA_COLETA_FAM`.

### R07 - Trabalho infantil
`IND_TRABALHO_INFANTIL_FAM` deve usar dominio de `COD_IND_TRAB_INFANTIL_PESSOA`.

### R08 - CEP
`NUM_CEP_LOGRADOURO_FAM` deve ter 8 digitos quando preenchido.

### R09 - CPF entrevistador
`NUM_CPF_ENTREVISTADOR_FAM` deve ter 11 digitos quando preenchido.

### R10 - Data de entrevista
`DTA_ENTREVISTA_FAM` nao deve ser posterior a data de atualizacao ETL em cenarios regulares de carga.

## Dominios observados

### COD_EST_CADASTRAL_FAM
- 1: Em cadastramento
- 2: Sem Registro Civil
- 3: Cadastrado
- 4: Excluido

### COD_CONDICAO_CADASTRO_FAM
- 1: Atualizado
- 2: Desatualizado

### COD_FORMA_COLETA_FAM
- 0: Informacao migrada como inexistente
- 1: Sem visita domiciliar
- 2: Com visita domiciliar

### COD_IND_CADASTRO_VALIDO_FAM
- 1: Sim
- 2: Nao

### COD_IND_TRAB_INFANTIL_PESSOA
- 1: Sim
- 2: Nao
