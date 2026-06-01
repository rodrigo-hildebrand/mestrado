# Modelo ER — CONCESSAO_3
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_3

```mermaid
erDiagram
    CONCESSAO_3 {
        varchar   NU_NB               PK
        decimal   ANO_MES_REF         PK
        numeric   ID_OL_CONCESSAO
        numeric   ID_OL_MANUTENCAO
        numeric   VL_MR_PAGA
        numeric   VL_MR_ATU
        numeric   VL_RMI
        numeric   VL_SB
        numeric   CS_ESPECIE
        numeric   CS_TRATAMENTO
        numeric   CS_SITUACAO_BENEF
        numeric   CS_MEIO_PAGTO
        varchar   CS_CLIENTELA
        nvarchar  D2_DIB
        nvarchar  D2_DCB
        nvarchar  D2_DER
        varchar   NM_TITULAR_BENEF_T
        varchar   NU_CPF_T
        nvarchar  DT_NASCIMENTO_T
        varchar   NM_UF_MUNICIPIO_T
        varchar   NM_ARQUIVO
        datetime2 DT_ATUALIZACAO_ETL
    }

    CONCESSAO_1 {
        varchar NU_NB               PK
        decimal ANO_MES_REF         PK
        varchar NM_TITULAR_BENEF_T
    }

    COD_ESPECIE {
        varchar COD_ESPECIE         PK
        varchar DESCR_ESPECIE
    }

    COD_SITUACAO {
        varchar COD_SITUACAO        PK
        varchar DESCR_SITUACAO
    }

    COD_TRATAMENTO {
        varchar COD_TRATAMENTO      PK
        varchar DESCR_TRATAMENTO
    }

    COD_DESPACHO {
        varchar COD_DESPACHO        PK
        varchar DESCR_DESPACHO
    }

    COD_MEIO_PAGAMENTO {
        varchar COD_MEIO_PAGAMENTO  PK
        varchar DESCR_MEIO_PAGAMENTO
    }

    COD_RAMO_ATIVIDADE {
        varchar COD_RAMO_ATIVIDADE  PK
        varchar DESCR_RAMO
    }

    COD_FORMA_FILIACAO {
        varchar COD_FORMA_FILIACAO  PK
        varchar DESCR_FORMA
    }

    COD_AGENCIA {
        numeric COD_AGENCIA         PK
        varchar NM_AGENCIA
    }

    COD_UF {
        varchar COD_UF              PK
        varchar NM_UF
    }

    CONCESSAO_2 {
        varchar   NU_NB             PK
        decimal   ANO_MES_REF      PK
        nvarchar  D2_DCB
        numeric   CS_SITUACAO_BENEF
        numeric   CS_MOTIVO
    }

    CONCESSAO_3 }o--|| COD_ESPECIE        : "CS_ESPECIE = COD_ESPECIE"
    CONCESSAO_3 }o--|| COD_SITUACAO       : "CS_SITUACAO_BENEF = COD_SITUACAO"
    CONCESSAO_3 }o--|| COD_TRATAMENTO     : "CS_TRATAMENTO = COD_TRATAMENTO"
    CONCESSAO_3 }o--|| COD_DESPACHO       : "CS_DESPACHO = COD_DESPACHO"
    CONCESSAO_3 }o--|| COD_MEIO_PAGAMENTO : "CS_MEIO_PAGTO = COD_MEIO_PAGAMENTO"
    CONCESSAO_3 }o--|| COD_RAMO_ATIVIDADE : "CS_RAMO_ATIVIDADE = COD_RAMO_ATIVIDADE"
    CONCESSAO_3 }o--|| COD_FORMA_FILIACAO : "CS_FORMA_FILIACAO = COD_FORMA_FILIACAO"
    CONCESSAO_3 }o--|| COD_AGENCIA        : "NU_AGENCIA_PAG = COD_AGENCIA"
    CONCESSAO_3 }o--|| COD_UF             : "NM_UF_MUNICIPIO_T = COD_UF"
    CONCESSAO_3 ||--o{ CONCESSAO_2        : "NU_NB (cessacao/atualizacao)"
    CONCESSAO_1 ||--|| CONCESSAO_3        : "schema identico — particionamento horizontal"
```

## Notas
- CONCESSAO_3 é **logicamente equivalente** a CONCESSAO_1 — mesmo schema de 128 campos.
- O particionamento (CON1 / CON3) é físico/operacional, provavelmente por período ou por código de espécie.
- Para análises que requerem toda a base de concessões, deve-se fazer `UNION ALL` entre CONCESSAO_1 e CONCESSAO_3.
