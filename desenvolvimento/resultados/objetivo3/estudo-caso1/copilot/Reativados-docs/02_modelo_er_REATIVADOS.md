# Modelo ER — REATIVADOS
**Base:** BD_BENEFICIOS_HIST.dbo.REATIVADOS

```mermaid
erDiagram
    REATIVADOS {
        varchar  NU_NB PK
        decimal  ANO_MES_REF PK
        varchar  ID_OL_CONCESSAO
        varchar  ID_OL_MANUTENCAO
        decimal  VL_MR_ATU
        decimal  VL_RMI
        decimal  CS_ESPECIE
        decimal  CS_SITUACAO_BENEF
        decimal  CS_SIT_BENEF_ANT
        decimal  CS_TRATAMENTO
        decimal  CS_MEIO_PAGTO
        varchar  D2_DER
        varchar  D2_DIB
        varchar  D2_DDB
        varchar  D2_ACAO
        varchar  D2_EFETIVACAO
        decimal  CS_MOTIVO_ACAO
        decimal  NU_MATR_EMISSOR
        varchar  NM_TITULAR_BENEF_T
        varchar  NU_CPF_T
        varchar  NM_RECEBEDOR
        varchar  NM_REPRESENTANTE_R
        varchar  NU_CPF_R
        decimal  CS_TIPO_R
        datetime DT_ATUALIZACAO_ETL
        varchar  NM_ARQUIVO
    }

    COD_ESPECIE {
        varchar COD_ESPECIE PK
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

    COD_DESPACHO {
        varchar COD_DESPACHO PK
        varchar DESCR_DESPACHO
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

    COD_TIPO {
        varchar COD_TIPO PK
        varchar DESCR_TIPO
    }

    REATIVADOS }o--|| COD_ESPECIE : "CS_ESPECIE = COD_ESPECIE"
    REATIVADOS }o--|| COD_SITUACAO : "CS_SITUACAO_BENEF = COD_SITUACAO"
    REATIVADOS }o--|| COD_SITUACAO : "CS_SIT_BENEF_ANT = COD_SITUACAO"
    REATIVADOS }o--|| COD_TRATAMENTO : "CS_TRATAMENTO = COD_TRATAMENTO"
    REATIVADOS }o--|| COD_MEIO_PAGAMENTO : "CS_MEIO_PAGTO = COD_MEIO_PAGAMENTO"
    REATIVADOS }o--|| COD_DESPACHO : "CS_DESPACHO = COD_DESPACHO"
    REATIVADOS }o--|| COD_RAMO_ATIVIDADE : "CS_RAMO_ATIVIDADE = COD_RAMO_ATIVIDADE"
    REATIVADOS }o--|| COD_FORMA_FILIACAO : "CS_FORMA_FILIACAO = COD_FORMA_FILIACAO"
    REATIVADOS }o--|| COD_DOC_EMPREGADOR : "CS_DOC_EMPREGADOR = COD_DOC_EMPREGADOR"
    REATIVADOS }o--o| COD_TIPO : "CS_TIPO_R = COD_TIPO"
```

## Notas
- O bloco `D2_EFETIVACAO`, `D2_ACAO`, `NU_MATR_EMISSOR`, `CS_MOTIVO_ACAO` e `CS_SIT_BENEF_ANT` caracteriza o evento de reativação.
- `CS_TIPO_R` sugere relacionamento com `COD_TIPO`, que possui dois valores e se ajusta ao papel do representante.
- `D2_EFETIVACAO` apareceu na amostra com 6 posições (`MMYYYY`), diferente das demais datas `D2_*` em `DDMMAAAA`.
