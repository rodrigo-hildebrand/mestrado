# Dicionário de Dados — CONCESSAO_3
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_3  
**Extração:** sys.all_columns (object_id=805577908)  
**Total de campos:** 128  
**NM_ARQUIVO padrão:** `D.SUB.APE.000.CON3.AAAAMM.NN`

## Contexto
Tabela de histórico de concessões de benefícios do INSS — arquivo **CON3**. Possui **schema idêntico** à CONCESSAO_1 (128 campos, mesmos nomes e tipos). A diferença está no arquivo de origem (CON3 vs CON1), indicando que CONCESSAO_1 e CONCESSAO_3 são **partições horizontais** da mesma entidade lógica "Concessão", provavelmente correspondendo a períodos ou lotes de carga distintos.

> **Nota:** Para a documentação completa dos campos, consulte o [Dicionário de CONCESSAO_1](../Concessao1-docs/01_dicionario_dados_CONCESSAO_1.md) — todos os campos, tipos, descrições e domínios são idênticos.

## Diferenças em relação à CONCESSAO_1

| Atributo | CONCESSAO_1 | CONCESSAO_3 |
|----------|-------------|-------------|
| object_id | 773577794 | 805577908 |
| NM_ARQUIVO | `D.SUB.APE.000.CON1.AAAAMM.NN` | `D.SUB.APE.000.CON3.AAAAMM.NN` |
| Propósito | Concessões lote 1 | Concessões lote 3 |

## Sumário dos grupos (idêntico à CONCESSAO_1)

| Grupo | Qtd campos | Campos-chave |
|-------|-----------|--------------|
| Identificação | 4 | NU_NB, ID_OL_CONCESSAO, ID_OL_MANUTENCAO |
| Valores financeiros | 5 | VL_MR_PAGA, VL_MR_ATU, VL_RMI, VL_SB |
| Classificações | 10 | CS_ESPECIE, CS_TRATAMENTO, CS_CLIENTELA, CS_DESPACHO |
| Benefício anterior | 3 | NU_NB_ANT, CS_ESPECIE_ANT |
| Datas (DDMMAAAA) | 12 | D2_DIB, D2_DDB, D2_DCB, D2_DER |
| Matrículas | 5 | NU_MATR_CONCESSOR, NU_MATR_HABILITADOR |
| Pagamento | 6 | ID_BANCO, CS_MEIO_PAGTO, NU_AGENCIA_PAG |
| Titular (_T) | 26 | NM_TITULAR_BENEF_T, NU_CPF_T, DT_NASCIMENTO_T |
| Instituidor (_I) | 16 | NM_INSTITUIDOR_I, NU_CPF_I |
| Procurador (_P) | 18 | NM_PROCURADOR_P, NU_CPF_P |
| Representante | 12 | NM_REPRESENTANTE, NU_CPF_REPRES |
| Recebedor | 4 | NM_RECEBEDOR, NU_CPF_RECEBEDOR |
| Dependentes | 3 | QT_DEP_IR, QT_DEP_VAL_NB, QT_DEP_CADASTRO |
| Controle ETL | 4 | DT_ATUALIZACAO_ETL, NM_ARQUIVO, ANO_MES_REF |

Para a lista completa com tipos, tamanhos, nulabilidade e descrições de cada campo, ver [01_dicionario_dados_CONCESSAO_1.md](../Concessao1-docs/01_dicionario_dados_CONCESSAO_1.md).
