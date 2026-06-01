# Modelo ER — CONCESSAO_2
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_2

```mermaid
erDiagram
    CONCESSAO_2 {
        varchar   NU_NB               PK
        decimal   ANO_MES_REF         PK
        nvarchar  D2_DCB
        numeric   CS_SITUACAO_BENEF
        numeric   CS_MOTIVO
        numeric   ID_OL_MANUTENCAO
        varchar   DS_ERRO
        datetime2 DT_ATUALIZACAO_ETL
        varchar   NM_ARQUIVO
    }

    CONCESSAO_1 {
        varchar NU_NB               PK
        decimal ANO_MES_REF         PK
        varchar NM_TITULAR_BENEF_T
        numeric CS_ESPECIE
        nvarchar D2_DIB
    }

    CONCESSAO_3 {
        varchar NU_NB               PK
        decimal ANO_MES_REF         PK
        varchar NM_TITULAR_BENEF_T
        numeric CS_ESPECIE
        nvarchar D2_DIB
    }

    COD_SITUACAO {
        varchar COD_SITUACAO        PK
        varchar DESCR_SITUACAO
    }

    COD_MOTIVO_CONCESSAO2 {
        varchar COD_MOTIVO          PK
        varchar DESCR_MOTIVO
    }

    CONCESSAO_2 }o--|| CONCESSAO_1           : "NU_NB (cessacao do beneficio)"
    CONCESSAO_2 }o--|| CONCESSAO_3           : "NU_NB (cessacao do beneficio)"
    CONCESSAO_2 }o--|| COD_SITUACAO          : "CS_SITUACAO_BENEF = COD_SITUACAO"
    CONCESSAO_2 }o--|| COD_MOTIVO_CONCESSAO2 : "CS_MOTIVO = COD_MOTIVO"
```

## Notas
- CONCESSAO_2 é a **tabela de eventos de cessação**. Um NU_NB pode ter múltiplos registros em diferentes competências caso seja cessado, reativado e cessado novamente.
- O campo CS_MOTIVO referencia COD_MOTIVO_CONCESSAO2 — tabela exclusiva desta funcionalidade com 99 códigos de motivo de encerramento/alteração.
- A relação com CONCESSAO_1 e CONCESSAO_3 é pelo NU_NB — não há chave estrangeira física no banco.
