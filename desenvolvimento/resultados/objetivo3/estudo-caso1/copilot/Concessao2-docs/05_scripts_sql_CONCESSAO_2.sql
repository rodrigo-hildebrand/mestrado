-- =============================================================================
-- CONCESSAO_2 - Scripts SQL Utilitarios
-- Base: BD_BENEFICIOS_HIST.dbo.CONCESSAO_2
-- object_id = 789577851 | 9 campos | arquivo CON2
-- Tabela complementar de cessacao/atualizacao de CONCESSAO_1 e CONCESSAO_3
-- =============================================================================

-- 1. PROFILING GERAL
SELECT
    COUNT(*)                        AS total_registros,
    COUNT(DISTINCT NU_NB)           AS nb_unicos,
    COUNT(DISTINCT ANO_MES_REF)     AS competencias,
    MIN(ANO_MES_REF)                AS competencia_min,
    MAX(ANO_MES_REF)                AS competencia_max
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2];

-- 2. Distribuicao por competencia
SELECT ANO_MES_REF, COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2]
GROUP BY ANO_MES_REF ORDER BY ANO_MES_REF;

-- 3. Distribuicao por situacao com descricao
SELECT
    c2.CS_SITUACAO_BENEF,
    cs.DESCR_SITUACAO,
    COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c2.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
GROUP BY c2.CS_SITUACAO_BENEF, cs.DESCR_SITUACAO ORDER BY qtd DESC;

-- 4. Distribuicao por motivo com descricao
SELECT
    c2.CS_MOTIVO,
    m.DESCR_MOTIVO,
    COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MOTIVO_CONCESSAO2] m ON CAST(c2.CS_MOTIVO AS varchar)=m.COD_MOTIVO
GROUP BY c2.CS_MOTIVO, m.DESCR_MOTIVO ORDER BY qtd DESC;

-- 5. Integridade: NB sem correspondencia em CONCESSAO_1 ou CONCESSAO_3
SELECT c2.NU_NB, c2.ANO_MES_REF
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1 ON c2.NU_NB=c1.NU_NB
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c3 ON c2.NU_NB=c3.NU_NB
WHERE c1.NU_NB IS NULL AND c3.NU_NB IS NULL;

-- 6. JOIN completo: CONCESSAO_2 + CONCESSAO_1 + dimensoes
SELECT
    c2.NU_NB,
    c2.ANO_MES_REF,
    c2.D2_DCB,
    CASE WHEN LEN(c2.D2_DCB)=8 AND c2.D2_DCB<>''
         THEN CONVERT(date,SUBSTRING(c2.D2_DCB,5,4)+SUBSTRING(c2.D2_DCB,3,2)+SUBSTRING(c2.D2_DCB,1,2))
         ELSE NULL END AS data_cessacao,
    cs.DESCR_SITUACAO,
    m.DESCR_MOTIVO,
    c1.NM_TITULAR_BENEF_T,
    c1.CS_ESPECIE,
    ce.DESCR_ESPECIE,
    c1.D2_DIB              AS dib_original
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]          c1 ON c2.NU_NB=c1.NU_NB
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO]         cs ON CAST(c2.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MOTIVO_CONCESSAO2] m ON CAST(c2.CS_MOTIVO AS varchar)=m.COD_MOTIVO
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE]          ce ON CAST(c1.CS_ESPECIE AS varchar)=ce.COD_ESPECIE;

-- 7. Tempo de vigencia: dias entre DIB e DCB
SELECT
    c2.NU_NB,
    c1.D2_DIB,
    c2.D2_DCB,
    DATEDIFF(day,
        CONVERT(date,SUBSTRING(c1.D2_DIB,5,4)+SUBSTRING(c1.D2_DIB,3,2)+SUBSTRING(c1.D2_DIB,1,2)),
        CONVERT(date,SUBSTRING(c2.D2_DCB,5,4)+SUBSTRING(c2.D2_DCB,3,2)+SUBSTRING(c2.D2_DCB,1,2))
    ) AS dias_vigencia
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2
JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1 ON c2.NU_NB=c1.NU_NB
WHERE LEN(c1.D2_DIB)=8 AND c1.D2_DIB<>''
  AND LEN(c2.D2_DCB)=8 AND c2.D2_DCB<>'';
