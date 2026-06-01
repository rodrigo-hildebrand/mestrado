# Dicionário de Dados — CONCESSAO_2
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_2  
**Extração:** sys.all_columns (object_id=789577851)  
**Total de campos:** 9  
**NM_ARQUIVO padrão:** `D.SUB.APE.000.CON2.AAAAMM.NN`

## Contexto
Tabela **complementar de cessação e atualização de situação** dos benefícios. Cada registro representa uma alteração de situação de um benefício (NU_NB) em uma competência (ANO_MES_REF): cessação, suspensão ou reativação. Relaciona-se com CONCESSAO_1 (e CONCESSAO_3) pelo campo NU_NB.

---

## Campos

| Campo | Tipo | Tam | Nulável | FK / Domínio | Descrição |
|-------|------|-----|---------|--------------|-----------|
| NU_NB | varchar | 10 | Sim | CONCESSAO_1.NU_NB | Número do Benefício. 10 dígitos numéricos. Chave de ligação com CONCESSAO_1/3. |
| D2_DCB | nvarchar | 20 | Sim | — | Data de Cessação do Benefício no formato **DDMMAAAA**. Registra a data efetiva da cessação ou suspensão. |
| CS_SITUACAO_BENEF | numeric | 5 | Sim | COD_SITUACAO | Código da nova situação após a alteração (ex: 5=Suspenso, 35=Cessado). 25 valores disponíveis. |
| CS_MOTIVO | numeric | 5 | Sim | COD_MOTIVO_CONCESSAO2 | Código do motivo da cessação ou alteração de situação. FK: COD_MOTIVO_CONCESSAO2 (99 valores). |
| ID_OL_MANUTENCAO | numeric | 5 | Sim | — | Identificador On-Line da transação de manutenção que originou a alteração. |
| DS_ERRO | varchar | 1024 | Sim | — | Descrição de erro de processamento ETL. Vazio em registros corretos. |
| DT_ATUALIZACAO_ETL | datetime2 | 8 | Sim | — | Timestamp da carga/atualização do registro no data warehouse. |
| NM_ARQUIVO | varchar | 256 | Sim | — | Nome do arquivo de origem. Padrão: `D.SUB.APE.000.CON2.AAAAMM.NN`. |
| ANO_MES_REF | decimal | 5 | Sim | — | Competência de referência no formato AAAAMM (ex: 201401). |
