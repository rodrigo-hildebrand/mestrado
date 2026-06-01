-- =============================================================================
-- CONCESSAO_1 - Scripts SQL Utilitarios
-- Base: BD_BENEFICIOS_HIST.dbo.CONCESSAO_1
-- object_id = 773577794 | 128 campos | arquivo CON1
-- =============================================================================

-- =============================================================================
-- 1. PROFILING GERAL
-- =============================================================================

-- 1.1 Contagem total e periodo coberto
SELECT
    COUNT(*)                        AS total_registros,
    COUNT(DISTINCT NU_NB)           AS nb_unicos,
    COUNT(DISTINCT ANO_MES_REF)     AS competencias,
    MIN(ANO_MES_REF)                AS competencia_min,
    MAX(ANO_MES_REF)                AS competencia_max,
    MIN(DT_ATUALIZACAO_ETL)         AS primeira_carga,
    MAX(DT_ATUALIZACAO_ETL)         AS ultima_carga
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1];

-- 1.2 Distribuicao por competencia
SELECT
    ANO_MES_REF,
    COUNT(*)                        AS total,
    COUNT(DISTINCT NU_NB)           AS nb_unicos,
    ROUND(AVG(VL_MR_ATU),2)         AS media_valor,
    ROUND(SUM(VL_MR_ATU),2)         AS soma_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
GROUP BY ANO_MES_REF
ORDER BY ANO_MES_REF;

-- 1.3 Percentual de nulos nos campos principais
SELECT
    COUNT(*)                                                    AS total,
    100.0*SUM(CASE WHEN NU_CPF_T='00000000000' OR NU_CPF_T IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS pct_sem_cpf,
    100.0*SUM(CASE WHEN NU_CPF_I='00000000000' OR NU_CPF_I IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS pct_sem_cpf_inst,
    100.0*SUM(CASE WHEN NU_CPF_P='00000000000' OR NU_CPF_P IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS pct_sem_procurador,
    100.0*SUM(CASE WHEN CS_REPRESENTANTE=0 OR CS_REPRESENTANTE IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS pct_sem_representante,
    100.0*SUM(CASE WHEN D2_DCB IS NULL OR D2_DCB='' THEN 1 ELSE 0 END)/COUNT(*)              AS pct_sem_cessacao,
    100.0*SUM(CASE WHEN NU_NB_ANT='0000000000' OR NU_NB_ANT IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS pct_sem_nb_anterior
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1];

-- 1.4 Estatisticas de valores (ultima competencia)
SELECT
    COUNT(*)                        AS registros,
    MIN(VL_MR_ATU)                  AS val_min,
    MAX(VL_MR_ATU)                  AS val_max,
    ROUND(AVG(VL_MR_ATU),2)         AS val_medio,
    MIN(VL_RMI)                     AS rmi_min,
    MAX(VL_RMI)                     AS rmi_max,
    ROUND(AVG(VL_RMI),2)            AS rmi_media
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE ANO_MES_REF = (SELECT MAX(ANO_MES_REF) FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]);

-- 1.5 Cardinalidade de campos categoricos
SELECT 'CS_ESPECIE'         AS campo, COUNT(DISTINCT CS_ESPECIE)         AS cardinalidade FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] UNION ALL
SELECT 'CS_SITUACAO_BENEF',          COUNT(DISTINCT CS_SITUACAO_BENEF)          FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] UNION ALL
SELECT 'CS_CLIENTELA',               COUNT(DISTINCT CS_CLIENTELA)               FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] UNION ALL
SELECT 'CS_MEIO_PAGTO',              COUNT(DISTINCT CS_MEIO_PAGTO)              FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] UNION ALL
SELECT 'CS_RAMO_ATIVIDADE',          COUNT(DISTINCT CS_RAMO_ATIVIDADE)          FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] UNION ALL
SELECT 'CS_FORMA_FILIACAO',          COUNT(DISTINCT CS_FORMA_FILIACAO)          FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] UNION ALL
SELECT 'NM_UF_MUNICIPIO_T',          COUNT(DISTINCT NM_UF_MUNICIPIO_T)          FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
ORDER BY cardinalidade DESC;

-- =============================================================================
-- 2. INTEGRIDADE REFERENCIAL
-- =============================================================================

-- 2.1 Espécies sem correspondencia em COD_ESPECIE
SELECT c.CS_ESPECIE, COUNT(*) AS cnt
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
WHERE ce.COD_ESPECIE IS NULL AND c.CS_ESPECIE IS NOT NULL
GROUP BY c.CS_ESPECIE ORDER BY cnt DESC;

-- 2.2 Situacoes sem correspondencia em COD_SITUACAO
SELECT c.CS_SITUACAO_BENEF, COUNT(*) AS cnt
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
WHERE cs.COD_SITUACAO IS NULL AND c.CS_SITUACAO_BENEF IS NOT NULL
GROUP BY c.CS_SITUACAO_BENEF;

-- 2.3 Consistencia DER <= DIB
SELECT COUNT(*) AS violacoes_der_apos_dib
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE LEN(D2_DER)=8 AND LEN(D2_DIB)=8 AND D2_DER<>'' AND D2_DIB<>''
  AND CONVERT(date,SUBSTRING(D2_DER,5,4)+SUBSTRING(D2_DER,3,2)+SUBSTRING(D2_DER,1,2))
    > CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));

-- 2.4 Consistencia DDB >= DIB
SELECT COUNT(*) AS violacoes_ddb_antes_dib
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE LEN(D2_DDB)=8 AND LEN(D2_DIB)=8 AND D2_DDB<>'' AND D2_DIB<>''
  AND CONVERT(date,SUBSTRING(D2_DDB,5,4)+SUBSTRING(D2_DDB,3,2)+SUBSTRING(D2_DDB,1,2))
    < CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));

-- 2.5 CPF titular invalido
SELECT COUNT(*) AS cpf_invalido
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE NU_CPF_T IS NOT NULL AND NU_CPF_T<>'00000000000'
  AND (LEN(NU_CPF_T)<>11
    OR NU_CPF_T NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

-- 2.6 Valores negativos
SELECT COUNT(*) AS valores_negativos
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE VL_MR_ATU < 0 OR VL_RMI < 0 OR VL_SB < 0;

-- =============================================================================
-- 3. ANALISE DE DOMINIOS
-- =============================================================================

-- 3.1 Distribuicao por especie
SELECT
    c.CS_ESPECIE,
    ce.TIPO_ESPECIE,
    ce.DESCR_ESPECIE,
    COUNT(*)                    AS qtd,
    ROUND(SUM(c.VL_MR_ATU),2)  AS soma_valor,
    ROUND(AVG(c.VL_MR_ATU),2)  AS media_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
GROUP BY c.CS_ESPECIE, ce.TIPO_ESPECIE, ce.DESCR_ESPECIE
ORDER BY qtd DESC;

-- 3.2 Distribuicao por situacao
SELECT
    c.CS_SITUACAO_BENEF,
    cs.DESCR_SITUACAO,
    COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
GROUP BY c.CS_SITUACAO_BENEF, cs.DESCR_SITUACAO ORDER BY qtd DESC;

-- 3.3 Distribuicao por clientela
SELECT
    CS_CLIENTELA,
    COUNT(*) AS qtd,
    ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),2) AS pct
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
GROUP BY CS_CLIENTELA;

-- 3.4 Distribuicao por UF do titular
SELECT
    NM_UF_MUNICIPIO_T,
    COUNT(*) AS qtd,
    ROUND(SUM(VL_MR_ATU),2) AS soma_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
GROUP BY NM_UF_MUNICIPIO_T ORDER BY qtd DESC;

-- 3.5 Proporcao de beneficios com procurador
SELECT
    CASE WHEN NU_CPF_P<>'00000000000' AND NU_CPF_P IS NOT NULL
         THEN 'Com procurador' ELSE 'Sem procurador' END AS tipo,
    COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
GROUP BY CASE WHEN NU_CPF_P<>'00000000000' AND NU_CPF_P IS NOT NULL
              THEN 'Com procurador' ELSE 'Sem procurador' END;

-- =============================================================================
-- 4. CONSULTAS REUTILIZAVEIS
-- =============================================================================

-- 4.1 JOIN padrao: CONCESSAO_1 com dimensoes principais
SELECT
    c.NU_NB,
    c.ANO_MES_REF,
    c.CS_ESPECIE,
    ce.DESCR_ESPECIE,
    c.CS_SITUACAO_BENEF,
    cs.DESCR_SITUACAO,
    c.CS_CLIENTELA,
    cm.DESCR_MEIO_PAGAMENTO,
    c.VL_MR_ATU,
    c.VL_RMI,
    c.NM_TITULAR_BENEF_T,
    c.NU_CPF_T,
    c.DT_NASCIMENTO_T,
    c.NM_MUNICIPIO_T,
    c.NM_UF_MUNICIPIO_T,
    -- Datas convertidas
    CASE WHEN LEN(c.D2_DIB)=8 AND c.D2_DIB<>''
         THEN CONVERT(date,SUBSTRING(c.D2_DIB,5,4)+SUBSTRING(c.D2_DIB,3,2)+SUBSTRING(c.D2_DIB,1,2))
         ELSE NULL END AS data_dib,
    CASE WHEN LEN(c.D2_DCB)=8 AND c.D2_DCB<>''
         THEN CONVERT(date,SUBSTRING(c.D2_DCB,5,4)+SUBSTRING(c.D2_DCB,3,2)+SUBSTRING(c.D2_DCB,1,2))
         ELSE NULL END AS data_cessacao,
    CASE WHEN LEN(c.D2_DER)=8 AND c.D2_DER<>''
         THEN CONVERT(date,SUBSTRING(c.D2_DER,5,4)+SUBSTRING(c.D2_DER,3,2)+SUBSTRING(c.D2_DER,1,2))
         ELSE NULL END AS data_requerimento
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE]        ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO]       cs ON CAST(c.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MEIO_PAGAMENTO] cm ON CAST(c.CS_MEIO_PAGTO AS varchar)=cm.COD_MEIO_PAGAMENTO;

-- 4.2 Historico de um NB especifico
SELECT
    c.NU_NB,
    c.ANO_MES_REF,
    cs.DESCR_SITUACAO,
    c.VL_MR_ATU,
    c.D2_DIB,
    c.D2_DCB,
    c.NM_ARQUIVO
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
WHERE c.NU_NB = '0000000001'    -- <- substituir pelo NB desejado
ORDER BY c.ANO_MES_REF;

-- 4.3 Concessoes com cessacao: CONCESSAO_1 + CONCESSAO_2
SELECT
    c1.NU_NB,
    c1.ANO_MES_REF       AS comp_concessao,
    c1.CS_ESPECIE,
    c1.D2_DIB            AS dib,
    c2.D2_DCB            AS dcb,
    c2.CS_MOTIVO,
    c2.CS_SITUACAO_BENEF AS sit_final,
    cs.DESCR_SITUACAO
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c1
JOIN [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_2] c2 ON c1.NU_NB=c2.NU_NB
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(c2.CS_SITUACAO_BENEF AS varchar)=cs.COD_SITUACAO
WHERE c2.D2_DCB IS NOT NULL AND c2.D2_DCB<>'';

-- 4.4 Agregacao por especie e competencia
SELECT
    c.ANO_MES_REF,
    ce.TIPO_ESPECIE,
    COUNT(*)                    AS qtd,
    ROUND(SUM(c.VL_MR_ATU),2)  AS soma_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(c.CS_ESPECIE AS varchar)=ce.COD_ESPECIE
GROUP BY c.ANO_MES_REF, ce.TIPO_ESPECIE
ORDER BY c.ANO_MES_REF, qtd DESC;

-- 4.5 Beneficios com representante legal
SELECT
    c.NU_NB,
    c.NM_TITULAR_BENEF_T,
    c.NM_REPRESENTANTE,
    c.NU_CPF_REPRES,
    c.CS_REPRESENTANTE,
    c.ANO_MES_REF
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1] c
WHERE c.CS_REPRESENTANTE<>0 AND c.CS_REPRESENTANTE IS NOT NULL;

-- 4.6 Calculo da idade do titular na DIB
SELECT
    NU_NB,
    NM_TITULAR_BENEF_T,
    DT_NASCIMENTO_T,
    D2_DIB,
    DATEDIFF(year,
        CONVERT(date,SUBSTRING(DT_NASCIMENTO_T,5,4)+SUBSTRING(DT_NASCIMENTO_T,3,2)+SUBSTRING(DT_NASCIMENTO_T,1,2)),
        CONVERT(date,SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2))
    ) AS idade_na_dib
FROM [BD_BENEFICIOS_HIST].[dbo].[CONCESSAO_1]
WHERE LEN(DT_NASCIMENTO_T)=8 AND DT_NASCIMENTO_T<>''
  AND LEN(D2_DIB)=8 AND D2_DIB<>'';
