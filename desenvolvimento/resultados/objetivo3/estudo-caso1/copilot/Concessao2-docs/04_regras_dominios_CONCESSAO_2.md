# Regras de negócio e domínios — CONCESSAO_2
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_2

---

## Regras de Negócio

### R01 — NU_NB deve existir em CONCESSAO_1 ou CONCESSAO_3
```sql
SELECT c2.NU_NB, c2.ANO_MES_REF FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1 ON c2.NU_NB=c1.NU_NB
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c3 ON c2.NU_NB=c3.NU_NB
WHERE c1.NU_NB IS NULL AND c3.NU_NB IS NULL;
```

### R02 — D2_DCB obrigatório quando situação indica cessação
CS_SITUACAO_BENEF ∈ {35, 99, ...} implica D2_DCB preenchido.
```sql
SELECT COUNT(*) AS cessados_sem_dcb FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2]
WHERE CS_SITUACAO_BENEF=35 AND (D2_DCB IS NULL OR D2_DCB='');
```

### R03 — CS_MOTIVO deve existir em COD_MOTIVO_CONCESSAO2
```sql
SELECT c2.CS_MOTIVO, COUNT(*) AS cnt FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MOTIVO_CONCESSAO2] m ON CAST(c2.CS_MOTIVO AS varchar)=m.COD_MOTIVO
WHERE m.COD_MOTIVO IS NULL AND c2.CS_MOTIVO IS NOT NULL
GROUP BY c2.CS_MOTIVO;
```

### R04 — CS_SITUACAO_BENEF deve existir em COD_SITUACAO
```sql
SELECT c2.CS_SITUACAO_BENEF, COUNT(*) AS cnt FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c2.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
WHERE cs.COD_SITUACAO IS NULL AND c2.CS_SITUACAO_BENEF IS NOT NULL
GROUP BY c2.CS_SITUACAO_BENEF;
```

### R05 — D2_DCB no formato DDMMAAAA (8 dígitos)
```sql
SELECT COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2]
WHERE D2_DCB IS NOT NULL AND D2_DCB<>'' AND LEN(D2_DCB)<>8;
```

### R06 — ANO_MES_REF válido (AAAAMM)
```sql
SELECT COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2]
WHERE ANO_MES_REF IS NOT NULL
  AND (ANO_MES_REF % 100 NOT BETWEEN 1 AND 12 OR ANO_MES_REF < 199001);
```

---

## Domínios

### CS_SITUACAO_BENEF
Ver `raw_data/COD_SITUACAO.csv`. Principais situações de cessação:

| Código | Descrição |
|--------|-----------|
| 5 | SUSPENSO |
| 20 | CESSADO TEMPORARIAMENTE |
| 35 | CESSADO |

### CS_MOTIVO (99 valores — fonte: COD_MOTIVO_CONCESSAO2)
Ver `raw_data/COD_MOTIVO_CONCESSAO2.csv` para lista completa.

---

## Padrões de formato

| Campo | Formato | Exemplo |
|-------|---------|---------|
| NU_NB | 10 dígitos numéricos | `6041274902` |
| ANO_MES_REF | AAAAMM (decimal) | `201401` |
| D2_DCB | DDMMAAAA (nvarchar) | `06032014` |
| NM_ARQUIVO | D.SUB.APE.000.CON2.AAAAMM.NN | `D.SUB.APE.000.CON2.201401.001` |
