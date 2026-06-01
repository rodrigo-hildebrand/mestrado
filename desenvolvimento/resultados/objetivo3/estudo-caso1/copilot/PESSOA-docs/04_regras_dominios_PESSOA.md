# Regras e Dominios - PESSOA

## Regras de negocio

### R01 - Chave logica da pessoa
`COD_PESSOA` deve identificar unicamente a pessoa no contexto da familia/carga.

### R02 - Vinculo familiar obrigatorio
`COD_FAMILIA` deve existir na tabela `FAMILIA`.

### R03 - Ordem no nucleo familiar
`NUM_ORDEM_PESSOA` deve representar a ordem da pessoa dentro da familia.

### R04 - Estado cadastral de membro
`COD_EST_CADASTRAL_MEMB` deve existir em `COD_EST_CADASTRAL_MEMBRO`.

### R05 - Sexo codificado
`COD_SEXO_PESSOA` deve existir em `COD_SEXO_PESSOA`.

### R06 - Parentesco codificado
`COD_PARENTESCO_RF_PESSOA` deve existir em `COD_PARENTESCO`.

### R07 - Raca/cor codificada
`COD_RACA_COR_PESSOA` deve existir em `COD_RACA`.

### R08 - Certidao civil codificada
`COD_CERTIDAO_REGISTRADA_PESSOA` deve existir em `COD_CERTIDAO_CIVIL_PESSOA`.

### R09 - Integridade de NIS
`NUM_NIS_PESSOA_ATUAL` e `NU_NIS_ORIGINAL` devem ter 11 digitos quando preenchidos.

### R10 - Datas da pessoa
`DTA_ATUAL_MEMB` deve ser maior ou igual a `DTA_CADASTRAMENTO_MEMB` quando ambas preenchidas.

### R11 - Integridade de origem
Quando `IND_TRANSFERENCIA_PESSOA = 1`, espera-se origem preenchida (`NOM_ORIGEM_ALTERACAO_PESSOA`).

## Dominios observados

### COD_SEXO_PESSOA
- 1: Masculino
- 2: Feminino

### COD_PARENTESCO
- 01: Responsavel pela familia (RF)
- 02: Conjuge/companheiro(a)
- 03: Filho(a)
- 04: Enteado(a)
- 05: Neto(a) ou Bisneto(a)
- 06: Pai, Mae, Padrasto/Madrasta do RF
- 07: Sogro(a), Padrasto/Madrasta do conjuge
- 08: Irmao ou Irma
- 09: Genro ou Nora
- 10: Outro parente
- 11: Nao parente

### COD_RACA
- 1: Branca
- 2: Negra
- 3: Amarela
- 4: Parda
- 5: Indigena

### COD_EST_CADASTRAL_MEMBRO
- 1: Em cadastramento
- 2: Sem Registro Civil
- 3: Cadastrado
- 4: Excluido
- 5: Aguardando atribuicao NIS
- 6: Aguardando alteracao de caracterizacao

### COD_CERTIDAO_CIVIL_PESSOA
- 1: Nascimento
- 2: Casamento
- 3: RANI (Certidao Indigena)

### COD_IND_TRAB_INFANTIL_PESSOA
- 1: Sim
- 2: Nao
