# Regras de negócio e domínios — CONCESSAO_3
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_3

## Contexto
CONCESSAO_3 tem schema idêntico à CONCESSAO_1. As **regras de negócio são as mesmas** — consulte [04_regras_dominios_CONCESSAO_1.md](../Concessao1-docs/04_regras_dominios_CONCESSAO_1.md) para o conjunto completo de 18 regras.

As regras específicas adicionais documentadas aqui tratam da **relação entre as partições CON1 e CON3**.

---

## Regras adicionais de particionamento

### R19 — CONCESSAO_1 e CONCESSAO_3 não devem ter sobreposição de NU_NB na mesma competência
```sql
SELECT c1.NU_NB, c1.ANO_MES_REF
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1
JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c3
    ON c1.NU_NB=c3.NU_NB AND c1.ANO_MES_REF=c3.ANO_MES_REF;
```

### R20 — União CON1+CON3 forma a base completa de concessões
Para análises totais, usar UNION ALL:
```sql
SELECT * FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
UNION ALL
SELECT * FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3];
```

### R21 — Consistência NM_ARQUIVO: CON3 em CONCESSAO_3
```sql
SELECT NM_ARQUIVO, COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3]
WHERE NM_ARQUIVO NOT LIKE 'D.SUB.APE.000.CON3.______.__%'
GROUP BY NM_ARQUIVO ORDER BY COUNT(*) DESC;
```

---

## Domínios
Idênticos aos de CONCESSAO_1. Ver [04_regras_dominios_CONCESSAO_1.md](../Concessao1-docs/04_regras_dominios_CONCESSAO_1.md).

## Padrões de formato

| Campo | Formato | Exemplo |
|-------|---------|---------|
| NU_NB | 10 dígitos numéricos | `6041274902` |
| ANO_MES_REF | AAAAMM (decimal) | `201401` |
| D2_* datas | DDMMAAAA (nvarchar) | `15112013` |
| NM_ARQUIVO | D.SUB.APE.000.**CON3**.AAAAMM.NN | `D.SUB.APE.000.CON3.201401.002` |
