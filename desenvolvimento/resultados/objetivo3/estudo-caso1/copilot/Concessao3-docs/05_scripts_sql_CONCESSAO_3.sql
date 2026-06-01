-- =============================================================================
-- CONCESSAO_3 - Scripts SQL Utilitarios
-- Base: BD_BENEFICIOS_HIST.dbo.CONCESSAO_3
-- object_id = 805577908 | 128 campos | arquivo CON3
-- Schema identico a CONCESSAO_1 (CON1). Particao horizontal da entidade Concessao.
-- =============================================================================

-- =============================================================================
-- 1. PROFILING GERAL
-- =============================================================================

-- 1.1 Totais e periodo
SELECT
    COUNT(*)                        AS total_registros,
    COUNT(DISTINCT NU_NB)           AS nb_unicos,
    COUNT(DISTINCT ANO_MES_REF)     AS competencias,
    MIN(ANO_MES_REF)                AS competencia_min,
    MAX(ANO_MES_REF)                AS competencia_max
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3];

-- 1.2 Distribuicao por competencia
SELECT ANO_MES_REF, COUNT(*) AS qtd, ROUND(SUM(VL_MR_ATU),2) AS soma_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3]
GROUP BY ANO_MES_REF ORDER BY ANO_MES_REF;

-- 1.3 Comparativo CON1 vs CON3 por competencia
SELECT
    COALESCE(c1.ANO_MES_REF, c3.ANO_MES_REF)   AS competencia,
    ISNULL(c1.qtd_c1, 0)                        AS qtd_concessao_1,
    ISNULL(c3.qtd_c3, 0)                        AS qtd_concessao_3,
    ISNULL(c1.qtd_c1, 0) + ISNULL(c3.qtd_c3, 0) AS total_concessoes
FROM (
    SELECT ANO_MES_REF, COUNT(*) AS qtd_c1
    FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] GROUP BY ANO_MES_REF
) c1
FULL OUTER JOIN (
    SELECT ANO_MES_REF, COUNT(*) AS qtd_c3
    FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] GROUP BY ANO_MES_REF
) c3 ON c1.ANO_MES_REF=c3.ANO_MES_REF
ORDER BY competencia;

-- =============================================================================
-- 2. INTEGRIDADE REFERENCIAL (identica a CONCESSAO_1)
-- =============================================================================

-- 2.1 Sobrepositao com CONCESSAO_1 (nao deve existir)
SELECT c1.NU_NB, c1.ANO_MES_REF
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1
JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c3 ON c1.NU_NB=c3.NU_NB AND c1.ANO_MES_REF=c3.ANO_MES_REF;

-- 2.2 Espécies sem correspondencia
SELECT c.CS_ESPECIE, COUNT(*) AS cnt
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
WHERE ce.COD_ESPECIE IS NULL AND c.CS_ESPECIE IS NOT NULL
GROUP BY c.CS_ESPECIE;

-- 2.3 Consistencia DER <= DIB
SELECT COUNT(*) AS violacoes FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3]
WHERE LEN(D2_DER)=8 AND LEN(D2_DIB)=8 AND D2_DER<>'' AND D2_DIB<>''
  AND CONVERT(date,SUBSTRING(D2_DER,5,4)+SUBSTRING(D2_DER,3,2)+SUBSTRING(D2_DER,1,2))
    > CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));

-- =============================================================================
-- 3. ANALISE DE DOMINIOS
-- =============================================================================

-- 3.1 Distribuicao por especie
SELECT c.CS_ESPECIE, ce.DESCR_ESPECIE, COUNT(*) AS qtd, ROUND(AVG(c.VL_MR_ATU),2) AS media
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
GROUP BY c.CS_ESPECIE, ce.DESCR_ESPECIE ORDER BY qtd DESC;

-- 3.2 Distribuicao por UF
SELECT NM_UF_MUNICIPIO_T, COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3]
GROUP BY NM_UF_MUNICIPIO_T ORDER BY qtd DESC;

-- =============================================================================
-- 4. CONSULTAS REUTILIZAVEIS
-- =============================================================================

-- 4.1 Visao unificada CON1 + CON3 (base completa de concessoes)
SELECT 'CON1' AS origem, NU_NB, ANO_MES_REF, CS_ESPECIE, VL_MR_ATU, D2_DIB, NM_TITULAR_BENEF_T
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
UNION ALL
SELECT 'CON3' AS origem, NU_NB, ANO_MES_REF, CS_ESPECIE, VL_MR_ATU, D2_DIB, NM_TITULAR_BENEF_T
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3];

-- 4.2 Concessoes CON3 com cessacao em CONCESSAO_2
SELECT
    c3.NU_NB,
    c3.ANO_MES_REF        AS comp_concessao,
    c3.NM_TITULAR_BENEF_T,
    c3.D2_DIB,
    c2.D2_DCB,
    m.DESCR_MOTIVO
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c3
JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2 ON c3.NU_NB=c2.NU_NB
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MOTIVO_CONCESSAO2] m ON CAST(c2.CS_MOTIVO AS varchar)=m.COD_MOTIVO
WHERE c2.D2_DCB IS NOT NULL AND c2.D2_DCB<>'';

-- 4.3 JOIN padrao CON3 com dimensoes
SELECT
    c.NU_NB, c.ANO_MES_REF,
    ce.DESCR_ESPECIE, cs.DESCR_SITUACAO,
    c.CS_CLIENTELA, cm.DESCR_MEIO_PAGAMENTO,
    c.VL_MR_ATU, c.NM_TITULAR_BENEF_T, c.NM_UF_MUNICIPIO_T,
    CASE WHEN LEN(c.D2_DIB)=8 AND c.D2_DIB<>''
         THEN CONVERT(date,SUBSTRING(c.D2_DIB,5,4)+SUBSTRING(c.D2_DIB,3,2)+SUBSTRING(c.D2_DIB,1,2))
         ELSE NULL END AS data_dib
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE]        ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO]       cs ON CAST(c.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MEIO_PAGAMENTO] cm ON CAST(c.CS_MEIO_PAGTO AS varchar)=cm.COD_MEIO_PAGAMENTO;

-- 4.4 Historico de NB na visao unificada CON1+CON3
SELECT origem, NU_NB, ANO_MES_REF, CS_SITUACAO_BENEF, VL_MR_ATU, NM_ARQUIVO
FROM (
    SELECT 'CON1' AS origem, NU_NB, ANO_MES_REF, CS_SITUACAO_BENEF, VL_MR_ATU, NM_ARQUIVO
    FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
    UNION ALL
    SELECT 'CON3', NU_NB, ANO_MES_REF, CS_SITUACAO_BENEF, VL_MR_ATU, NM_ARQUIVO
    FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_3]
) u
WHERE NU_NB = '0000000001'   -- <- substituir pelo NB desejado
ORDER BY ANO_MES_REF;
