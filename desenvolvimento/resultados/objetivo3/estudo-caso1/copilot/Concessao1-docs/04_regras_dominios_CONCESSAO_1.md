# Regras de negócio e domínios — CONCESSAO_1
**Base:** BD_BENEFICIOS_HIST.dbo.CONCESSAO_1

---

## Regras de Negócio

### R01 — Unicidade do registro
Cada combinação (NU_NB, ANO_MES_REF) deve ocorrer no máximo uma vez.
```sql
SELECT NU_NB, ANO_MES_REF, COUNT(*) AS cnt
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
GROUP BY NU_NB, ANO_MES_REF HAVING COUNT(*) > 1;
```

### R02 — NB obrigatório e com 10 dígitos
NU_NB deve ser sempre preenchido com 10 dígitos numéricos.
```sql
SELECT COUNT(*) AS invalidos FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE NU_NB IS NULL OR LEN(NU_NB) <> 10 OR NU_NB NOT LIKE '[0-9]%';
```

### R03 — Consistência DIB ≤ DDB (despacho após início)
Quando ambas preenchidas, D2_DDB deve ser ≥ D2_DIB.
```sql
SELECT COUNT(*) AS violacoes FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE LEN(D2_DIB)=8 AND LEN(D2_DDB)=8 AND D2_DIB<>'' AND D2_DDB<>''
  AND CONVERT(date,SUBSTRING(D2_DDB,5,4)+SUBSTRING(D2_DDB,3,2)+SUBSTRING(D2_DDB,1,2))
    < CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));
```

### R04 — DER anterior ou igual à DIB
D2_DER (requerimento) deve preceder ou coincidir com D2_DIB (início do benefício).
```sql
SELECT COUNT(*) AS violacoes FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE LEN(D2_DER)=8 AND LEN(D2_DIB)=8 AND D2_DER<>'' AND D2_DIB<>''
  AND CONVERT(date,SUBSTRING(D2_DER,5,4)+SUBSTRING(D2_DER,3,2)+SUBSTRING(D2_DER,1,2))
    > CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));
```

### R05 — DCB posterior à DIB quando preenchida
Se D2_DCB preenchido, deve ser > D2_DIB.
```sql
SELECT COUNT(*) AS violacoes FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE LEN(D2_DCB)=8 AND D2_DCB<>'' AND LEN(D2_DIB)=8 AND D2_DIB<>''
  AND CONVERT(date,SUBSTRING(D2_DCB,5,4)+SUBSTRING(D2_DCB,3,2)+SUBSTRING(D2_DCB,1,2))
   <= CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));
```

### R06 — Integridade referencial CS_ESPECIE
CS_ESPECIE deve existir em COD_ESPECIE.
```sql
SELECT c.CS_ESPECIE, COUNT(*) AS cnt FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
WHERE ce.COD_ESPECIE IS NULL AND c.CS_ESPECIE IS NOT NULL
GROUP BY c.CS_ESPECIE;
```

### R07 — Integridade referencial CS_SITUACAO_BENEF
```sql
SELECT c.CS_SITUACAO_BENEF, COUNT(*) AS cnt FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
WHERE cs.COD_SITUACAO IS NULL AND c.CS_SITUACAO_BENEF IS NOT NULL
GROUP BY c.CS_SITUACAO_BENEF;
```

### R08 — CS_CLIENTELA restrito ao domínio {U, R}
```sql
SELECT CS_CLIENTELA, COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE CS_CLIENTELA NOT IN ('U','R') OR CS_CLIENTELA IS NULL
GROUP BY CS_CLIENTELA;
```

### R09 — CPF do titular com 11 dígitos ou sentinela
NU_CPF_T deve ter 11 dígitos numéricos, ou ser o valor sentinela '00000000000'.
```sql
SELECT COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE NU_CPF_T IS NOT NULL AND NU_CPF_T<>'00000000000'
  AND (LEN(NU_CPF_T)<>11 OR NU_CPF_T NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
```

### R10 — Valores financeiros não negativos
VL_MR_ATU, VL_RMI e VL_SB devem ser ≥ 0.
```sql
SELECT COUNT(*) AS negativos FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE VL_MR_ATU < 0 OR VL_RMI < 0 OR VL_SB < 0;
```

### R11 — NU_NB_ANT '0000000000' indica ausência
O valor '0000000000' (10 zeros) é o sentinela para "sem predecessor", não uma referência válida.

### R12 — Matrícula '55555555' indica concessão automática
NU_MATR_CONCESSOR = '55555555' identifica processos batch/automáticos.

### R13 — Sexo com valores 1=M, 2=F; 0=não preenchido
CS_SEXO_T, CS_SEXO_I, CS_SEXO_P, CS_SEXO_REPRES, CS_SEXO_RECEBEDOR devem ser 0, 1 ou 2.
```sql
SELECT CS_SEXO_T, COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE CS_SEXO_T NOT IN (0,1,2) AND CS_SEXO_T IS NOT NULL
GROUP BY CS_SEXO_T;
```

### R14 — VL_SB >= VL_RMI (RMI deriva de SB)
A Renda Mensal Inicial não pode superar o Salário de Benefício.
```sql
SELECT COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE VL_RMI > VL_SB AND VL_RMI IS NOT NULL AND VL_SB IS NOT NULL;
```

### R15 — ANO_MES_REF no formato AAAAMM válido
```sql
SELECT COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE ANO_MES_REF IS NOT NULL
  AND (ANO_MES_REF % 100 NOT BETWEEN 1 AND 12 OR ANO_MES_REF < 199001);
```

### R16 — D2_LIMITE somente para benefícios temporários
D2_LIMITE deve ser preenchido apenas para espécies temporárias (auxílio-doença, reabilitação).

### R17 — NM_ARQUIVO com padrão CON1 ou CON3
```sql
SELECT NM_ARQUIVO, COUNT(*) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE NM_ARQUIVO NOT LIKE 'D.SUB.APE.000.CON_.______.__%'
GROUP BY NM_ARQUIVO ORDER BY COUNT(*) DESC;
```

### R18 — Integridade com CONCESSAO_2 (cessação)
Todo NU_NB com D2_DCB preenchida em CONCESSAO_1 deve ter correspondente em CONCESSAO_2.
```sql
SELECT c1.NU_NB, c1.D2_DCB
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2 ON c1.NU_NB=c2.NU_NB
WHERE c1.D2_DCB IS NOT NULL AND c1.D2_DCB<>'' AND c2.NU_NB IS NULL;
```

---

## Domínios

### CS_CLIENTELA
| Código | Descrição |
|--------|-----------|
| U | Urbana |
| R | Rural |

### CS_SEXO (T, I, P, Repres, Recebedor)
| Código | Descrição |
|--------|-----------|
| 0 | Não preenchido / não aplicável |
| 1 | Masculino |
| 2 | Feminino |

### CS_SITUACAO_BENEF (25 valores — fonte: COD_SITUACAO)
Ver arquivo `raw_data/COD_SITUACAO.csv` para lista completa.
Principais:

| Código | Descrição |
|--------|-----------|
| 0 | ATIVO |
| 5 | SUSPENSO |
| 20 | CESSADO TEMPORARIAMENTE |
| 35 | CESSADO |

### CS_ESPECIE (95 espécies — fonte: COD_ESPECIE)
Ver arquivo `raw_data/COD_ESPECIE.csv` para lista completa.
Principais tipos:

| Tipo | Exemplos de código |
|------|--------------------|
| APOSENTADORIA | 41, 42, 46, 57, 82 |
| AUXILIO | 31, 91, 36 |
| PENSAO | 21, 32, 92 |
| AMPAROS BPC | 87, 88 |

### CS_MEIO_PAGTO (9 valores — fonte: COD_MEIO_PAGAMENTO)
Ver `raw_data/COD_MEIO_PAGAMENTO.csv`

### CS_DOC_EMPREGADOR (5 valores — fonte: COD_DOC_EMPREGADOR)
| Código | Descrição |
|--------|-----------|
| 1 | CNPJ |
| 2 | CEI |
| 3 | CPF |
| 4 | NIT |
| 5 | Outros |

### CS_FORMA_FILIACAO (10 valores — fonte: COD_FORMA_FILIACAO)
Ver `raw_data/COD_FORMA_FILIACAO.csv`

---

## Padrões de formato

| Campo | Formato | Exemplo |
|-------|---------|---------|
| NU_NB | 10 dígitos numéricos | `6041274902` |
| ANO_MES_REF | AAAAMM (decimal) | `201401` |
| D2_* datas | DDMMAAAA (nvarchar) | `15112013` |
| DT_NASCIMENTO_T | DDMMAAAA (nvarchar) | `04011982` |
| NU_CPF_T | 11 dígitos numéricos | `72790741204` |
| NM_ARQUIVO | D.SUB.APE.000.CON1.AAAAMM.NN | `D.SUB.APE.000.CON1.201401.004` |
| NU_CEP_T | 8 dígitos | `66075580` |
| NU_DOC_EMPREGADOR | até 14 chars (CNPJ=14, CEI=12) | `03765290000152` |
