# Modelo ER — CONCESSAO_1
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_1

```mermaid
erDiagram
    CONCESSAO_1 {
        varchar   NU_NB               PK
        decimal   ANO_MES_REF         PK
        numeric   ID_OL_CONCESSAO
        numeric   ID_OL_MANUTENCAO
        numeric   ID_OL_MANUTENCAO_ANT
        numeric   VL_MR_PAGA
        numeric   VL_MR_ATU
        numeric   VL_RMI
        numeric   VL_SB
        numeric   CS_PA
        numeric   CS_ESPECIE
        numeric   CS_TRATAMENTO
        numeric   CS_RAMO_ATIVIDADE
        numeric   CS_FORMA_FILIACAO
        numeric   CS_DOC_EMPREGADOR
        varchar   CS_CLIENTELA
        numeric   CS_DESPACHO
        numeric   CS_SITUACAO_BENEF
        numeric   CS_DIAGNOSTICO
        numeric   CS_MEIO_PAGTO
        varchar   NU_NB_ANT
        numeric   CS_ESPECIE_ANT
        nvarchar  D2_DER
        nvarchar  D2_DIB
        nvarchar  D2_DDB
        nvarchar  D2_DCB
        nvarchar  D2_DIP
        nvarchar  D2_LIMITE
        varchar   NM_TITULAR_BENEF_T
        varchar   NU_CPF_T
        nvarchar  DT_NASCIMENTO_T
        varchar   NM_UF_MUNICIPIO_T
        numeric   ID_BANCO
        numeric   NU_AGENCIA_PAG
        varchar   NU_CPF_I
        varchar   NU_CPF_P
        varchar   NU_CPF_REPRES
        varchar   NU_CPF_RECEBEDOR
        numeric   QT_DEP_CADASTRO
        decimal   ANO_MES_REF
        varchar   NM_ARQUIVO
        datetime2 DT_ATUALIZACAO_ETL
    }

    COD_ESPECIE {
        varchar COD_ESPECIE       PK
        varchar TIPO_ESPECIE
        varchar DESCR_ESPECIE
    }

    COD_SITUACAO {
        varchar COD_SITUACAO      PK
        varchar DESCR_SITUACAO
    }

    COD_TRATAMENTO {
        varchar COD_TRATAMENTO    PK
        varchar DESCR_TRATAMENTO
    }

    COD_DESPACHO {
        varchar COD_DESPACHO      PK
        varchar DESCR_DESPACHO
    }

    COD_MEIO_PAGAMENTO {
        varchar COD_MEIO_PAGAMENTO PK
        varchar DESCR_MEIO_PAGAMENTO
    }

    COD_RAMO_ATIVIDADE {
        varchar COD_RAMO_ATIVIDADE PK
        varchar DESCR_RAMO
    }

    COD_FORMA_FILIACAO {
        varchar COD_FORMA_FILIACAO PK
        varchar DESCR_FORMA
    }

    COD_DOC_EMPREGADOR {
        varchar COD_DOC_EMPREGADOR PK
        varchar DESCR_DOC
    }

    COD_AGENCIA {
        numeric COD_AGENCIA        PK
        varchar NM_AGENCIA
        varchar NM_BANCO
    }

    COD_UF {
        varchar COD_UF             PK
        varchar NM_UF
    }

    COD_MOTIVO_CONCESSAO2 {
        varchar COD_MOTIVO         PK
        varchar DESCR_MOTIVO
    }

    CONCESSAO_2 {
        varchar   NU_NB             PK
        decimal   ANO_MES_REF      PK
        nvarchar  D2_DCB
        numeric   CS_SITUACAO_BENEF
        numeric   CS_MOTIVO
        datetime2 DT_ATUALIZACAO_ETL
    }

    CONCESSAO_1 }o--|| COD_ESPECIE          : "CS_ESPECIE = COD_ESPECIE"
    CONCESSAO_1 }o--|| COD_SITUACAO         : "CS_SITUACAO_BENEF = COD_SITUACAO"
    CONCESSAO_1 }o--|| COD_TRATAMENTO       : "CS_TRATAMENTO = COD_TRATAMENTO"
    CONCESSAO_1 }o--|| COD_DESPACHO         : "CS_DESPACHO = COD_DESPACHO"
    CONCESSAO_1 }o--|| COD_MEIO_PAGAMENTO   : "CS_MEIO_PAGTO = COD_MEIO_PAGAMENTO"
    CONCESSAO_1 }o--|| COD_RAMO_ATIVIDADE   : "CS_RAMO_ATIVIDADE = COD_RAMO_ATIVIDADE"
    CONCESSAO_1 }o--|| COD_FORMA_FILIACAO   : "CS_FORMA_FILIACAO = COD_FORMA_FILIACAO"
    CONCESSAO_1 }o--|| COD_DOC_EMPREGADOR   : "CS_DOC_EMPREGADOR = COD_DOC_EMPREGADOR"
    CONCESSAO_1 }o--|| COD_AGENCIA          : "NU_AGENCIA_PAG = COD_AGENCIA"
    CONCESSAO_1 }o--|| COD_UF               : "NM_UF_MUNICIPIO_T = COD_UF"
    CONCESSAO_1 ||--o{ CONCESSAO_2          : "NU_NB (cessacao/atualizacao)"
    CONCESSAO_1 }o--o| COD_ESPECIE          : "CS_ESPECIE_ANT = COD_ESPECIE (anterior)"
```

## Notas
- **CONCESSAO_1 ↔ CONCESSAO_3**: Mesmo schema (128 campos). CON1 e CON3 são partições horizontais do mesmo layout — provavelmente cargas de períodos distintos.
- **CONCESSAO_1 ↔ CONCESSAO_2**: CONCESSAO_2 é tabela complementar de cessação/atualização, ligada por NU_NB. Registra D2_DCB, CS_MOTIVO e nova CS_SITUACAO_BENEF quando o benefício é encerrado ou alterado.
- Datas D2_* em nvarchar(20) no formato **DDMMAAAA** — exigem SUBSTRING para conversão.
