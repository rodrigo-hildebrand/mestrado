# Modelo ER — PAB
**Base:** BD_BENEFICIOS_HIST.dbo.PAB

```mermaid
erDiagram
    PAB {
        varchar  NU_NB PK
        decimal  ANO_MES_REF PK
        varchar  ID_OL_CONCESSAO
        varchar  ID_OL_MANUTENCAO
        decimal  VL_RMI
        decimal  VL_SB
        decimal  CS_ESPECIE
        decimal  CS_TRATAMENTO
        decimal  CS_SITUACAO_BENEF
        decimal  CS_MEIO_PAGTO
        varchar  CS_DIAGNOSTICO
        varchar  D2_DER
        varchar  D2_DIB
        varchar  D2_DDB
        varchar  D2_DCB
        varchar  D2_SOLIC_CREDITO
        varchar  D2_VALIDACAO_CRED
        varchar  D2_INI_PERIODO
        varchar  D2_FIM_PERIODO
        decimal  CS_MOTIVO_SOLIC
        decimal  CS_ORIGEM_CREDITO
        decimal  VL_LIQUIDO_CRED
        varchar  NM_TITULAR_BENEF_T
        varchar  NU_CPF_T
        varchar  NM_RECEBEDOR_PAB
        datetime DT_ATUALIZACAO_ETL
        varchar  NM_ARQUIVO
    }

    COD_ESPECIE {
        varchar COD_ESPECIE PK
        varchar TIPO_ESPECIE
        varchar DESCR_ESPECIE
    }

    COD_SITUACAO {
        varchar COD_SITUACAO PK
        varchar DESCR_SITUACAO
    }

    COD_TRATAMENTO {
        varchar COD_TRATAMENTO PK
        varchar DESCR_TRATAMENTO
    }

    COD_MEIO_PAGAMENTO {
        varchar COD_MEIO_PAGAMENTO PK
        varchar DESCR_MEIO_PAGAMENTO
    }

    COD_RAMO_ATIVIDADE {
        varchar COD_RAMO_ATIVIDADE PK
        varchar DESCR_RAMO_ATIVIDADE
    }

    COD_FORMA_FILIACAO {
        varchar COD_FORMA_FILIACAO PK
        varchar DESCR_FORMA_FILIACAO
    }

    COD_DOC_EMPREGADOR {
        varchar COD_DOC_EMPREGADOR PK
        varchar DESCR_DOC_EMPREGADOR
    }

    COD_DESPACHO {
        varchar COD_DESPACHO PK
        varchar DESCR_DESPACHO
    }

    COD_CID {
        varchar COD_CID PK
        varchar DESCR_CID
    }

    PAB }o--|| COD_ESPECIE : "CS_ESPECIE = COD_ESPECIE"
    PAB }o--|| COD_SITUACAO : "CS_SITUACAO_BENEF = COD_SITUACAO"
    PAB }o--|| COD_TRATAMENTO : "CS_TRATAMENTO = COD_TRATAMENTO"
    PAB }o--|| COD_MEIO_PAGAMENTO : "CS_MEIO_PAGTO = COD_MEIO_PAGAMENTO"
    PAB }o--|| COD_RAMO_ATIVIDADE : "CS_RAMO_ATIVIDADE = COD_RAMO_ATIVIDADE"
    PAB }o--|| COD_FORMA_FILIACAO : "CS_FORMA_FILIACAO = COD_FORMA_FILIACAO"
    PAB }o--|| COD_DOC_EMPREGADOR : "CS_DOC_EMPREGADOR = COD_DOC_EMPREGADOR"
    PAB }o--|| COD_DESPACHO : "CS_DESPACHO = COD_DESPACHO"
    PAB }o--o| COD_CID : "CS_DIAGNOSTICO = COD_CID"
```

## Notas
- O bloco `D2_SOLIC_CREDITO`, `NU_SEQ_SOLIC_CRED`, `D2_VALIDACAO_CRED`, `D2_INI_PERIODO`, `D2_FIM_PERIODO`, `CS_MOTIVO_SOLIC`, `CS_ORIGEM_CREDITO` e `VL_LIQUIDO_CRED` caracteriza o evento financeiro específico do PAB.
- O restante do layout preserva os dados cadastrais do benefício, semelhantes às tabelas de concessão, para contextualizar o crédito.
- Datas `D2_*` seguem o padrão `DDMMAAAA` em `varchar(8)`.
