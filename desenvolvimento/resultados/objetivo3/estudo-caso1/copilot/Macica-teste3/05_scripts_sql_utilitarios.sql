-- =============================================================================
-- MACICA - Scripts SQL Utilitários
-- Base: BD_BENEFICIOS_HIST.dbo.MACICA (também em BD_BENEFICIOS.dbo.MACICA)
-- =============================================================================

-- =============================================================================
-- 1. PROFILING GERAL
-- =============================================================================

-- 1.1 Contagem total e período coberto
SELECT
    COUNT(*)                                    AS total_registros,
    COUNT(DISTINCT NU_NB)                       AS total_nb_unicos,
    COUNT(DISTINCT ANO_MES_REF)                 AS total_competencias,
    MIN(ANO_MES_REF)                            AS competencia_min,
    MAX(ANO_MES_REF)                            AS competencia_max,
    MIN(DT_ATUALIZACAO_ETL)                     AS primeira_carga_etl,
    MAX(DT_ATUALIZACAO_ETL)                     AS ultima_carga_etl
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA];

-- 1.2 Distribuição por competência
SELECT
    ANO_MES_REF,
    COUNT(*)                                    AS total_registros,
    COUNT(DISTINCT NU_NB)                       AS nb_unicos,
    ROUND(SUM(VL_MR_ATU), 2)                    AS soma_vl_mr_atu,
    ROUND(AVG(VL_MR_ATU), 2)                    AS media_vl_mr_atu,
    ROUND(SUM(VL_LIQUIDO), 2)                   AS soma_vl_liquido
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
GROUP BY ANO_MES_REF
ORDER BY ANO_MES_REF;

-- 1.3 Nulos por campo principal
SELECT
    COUNT(*)                                    AS total,
    SUM(CASE WHEN NU_NB IS NULL OR NU_NB = '' THEN 1 ELSE 0 END)             AS nulos_NU_NB,
    SUM(CASE WHEN ANO_MES_REF IS NULL THEN 1 ELSE 0 END)                     AS nulos_ANO_MES_REF,
    SUM(CASE WHEN CS_ESPECIE IS NULL THEN 1 ELSE 0 END)                      AS nulos_CS_ESPECIE,
    SUM(CASE WHEN CS_SITUACAO_BENEF IS NULL THEN 1 ELSE 0 END)               AS nulos_CS_SITUACAO_BENEF,
    SUM(CASE WHEN VL_MR_ATU IS NULL THEN 1 ELSE 0 END)                       AS nulos_VL_MR_ATU,
    SUM(CASE WHEN VL_LIQUIDO IS NULL THEN 1 ELSE 0 END)                      AS nulos_VL_LIQUIDO,
    SUM(CASE WHEN D2_DIB IS NULL OR D2_DIB = '' THEN 1 ELSE 0 END)           AS nulos_D2_DIB,
    SUM(CASE WHEN NU_CPF_T IS NULL OR NU_CPF_T = '' THEN 1 ELSE 0 END)       AS nulos_NU_CPF_T,
    SUM(CASE WHEN NU_CPF IS NULL OR NU_CPF = '' THEN 1 ELSE 0 END)           AS nulos_NU_CPF
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA];

-- 1.4 Estatísticas de valores (última competência disponível)
SELECT
    COUNT(*)                                    AS registros,
    MIN(VL_MR_ATU)                              AS valor_min,
    MAX(VL_MR_ATU)                              AS valor_max,
    AVG(VL_MR_ATU)                              AS valor_medio,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY VL_MR_ATU) OVER () AS mediana_vl,
    STDEV(VL_MR_ATU)                            AS desvio_padrao
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
WHERE ANO_MES_REF = (SELECT MAX(ANO_MES_REF) FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]);

-- 1.5 Cardinalidade de campos categóricos
SELECT 'CS_ESPECIE'       AS campo, COUNT(DISTINCT CS_ESPECIE)       AS cardinalidade FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] UNION ALL
SELECT 'CS_SITUACAO_BENEF',        COUNT(DISTINCT CS_SITUACAO_BENEF)        FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] UNION ALL
SELECT 'CS_CLIENTELA',             COUNT(DISTINCT CS_CLIENTELA)             FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] UNION ALL
SELECT 'CS_MEIO_PAGTO',            COUNT(DISTINCT CS_MEIO_PAGTO)            FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] UNION ALL
SELECT 'CS_RAMO_ATIVIDADE',        COUNT(DISTINCT CS_RAMO_ATIVIDADE)        FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] UNION ALL
SELECT 'CS_FORMA_FILIACAO',        COUNT(DISTINCT CS_FORMA_FILIACAO)        FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] UNION ALL
SELECT 'NM_UF_MUNICIPIO_T',        COUNT(DISTINCT NM_UF_MUNICIPIO_T)        FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
ORDER BY cardinalidade DESC;

-- =============================================================================
-- 2. INTEGRIDADE REFERENCIAL
-- =============================================================================

-- 2.1 CS_ESPECIE sem correspondência em COD_ESPECIE
SELECT m.CS_ESPECIE, COUNT(*) AS ocorrencias
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce
    ON CAST(m.CS_ESPECIE AS varchar(2)) = ce.COD_ESPECIE
WHERE ce.COD_ESPECIE IS NULL
  AND m.CS_ESPECIE IS NOT NULL
GROUP BY m.CS_ESPECIE
ORDER BY ocorrencias DESC;

-- 2.2 CS_SITUACAO_BENEF sem correspondência
SELECT m.CS_SITUACAO_BENEF, COUNT(*) AS ocorrencias
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs
    ON CAST(m.CS_SITUACAO_BENEF AS varchar(2)) = cs.COD_SITUACAO
WHERE cs.COD_SITUACAO IS NULL
  AND m.CS_SITUACAO_BENEF IS NOT NULL
GROUP BY m.CS_SITUACAO_BENEF;

-- 2.3 Verificação de consistência temporal (D2_DDB >= D2_DIB)
SELECT COUNT(*) AS violacoes_ddb_anterior_dib
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
WHERE LEN(D2_DDB) = 8
  AND LEN(D2_DIB) = 8
  AND D2_DDB <> '00000000'
  AND D2_DIB  <> '00000000'
  AND CONVERT(date,
        SUBSTRING(D2_DDB,5,4)+SUBSTRING(D2_DDB,3,2)+SUBSTRING(D2_DDB,1,2)) <
      CONVERT(date,
        SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2));

-- 2.4 Verificação VL_LIQUIDO = VL_BRUTO - TOT_DESCONTOS (tolerância de 0.01)
SELECT COUNT(*) AS divergencias_valor_liquido
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
WHERE VL_LIQUIDO IS NOT NULL
  AND VL_BRUTO IS NOT NULL
  AND TOT_DESCONTOS IS NOT NULL
  AND ABS(VL_LIQUIDO - (VL_BRUTO - TOT_DESCONTOS)) > 0.01;

-- 2.5 CPF com formato inválido (diferente de 11 dígitos numéricos ou zerado)
SELECT COUNT(*) AS cpf_invalido
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
WHERE NU_CPF_T IS NOT NULL
  AND NU_CPF_T <> '00000000000'
  AND (LEN(NU_CPF_T) <> 11 OR NU_CPF_T NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

-- =============================================================================
-- 3. ANÁLISE DE DOMÍNIOS
-- =============================================================================

-- 3.1 Distribuição por espécie com descrição
SELECT
    m.CS_ESPECIE,
    ce.TIPO_ESPECIE,
    ce.DESCR_ESPECIE,
    COUNT(*)                        AS qtd_registros,
    ROUND(SUM(m.VL_MR_ATU), 2)      AS soma_valor,
    ROUND(AVG(m.VL_MR_ATU), 2)      AS media_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce
    ON CAST(m.CS_ESPECIE AS varchar(2)) = ce.COD_ESPECIE
GROUP BY m.CS_ESPECIE, ce.TIPO_ESPECIE, ce.DESCR_ESPECIE
ORDER BY qtd_registros DESC;

-- 3.2 Distribuição por situação
SELECT
    m.CS_SITUACAO_BENEF,
    cs.DESCR_SITUACAO,
    COUNT(*) AS qtd
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs
    ON CAST(m.CS_SITUACAO_BENEF AS varchar(2)) = cs.COD_SITUACAO
GROUP BY m.CS_SITUACAO_BENEF, cs.DESCR_SITUACAO
ORDER BY qtd DESC;

-- 3.3 Distribuição por clientela (Urbano x Rural)
SELECT
    CS_CLIENTELA,
    COUNT(*)                        AS qtd,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
GROUP BY CS_CLIENTELA;

-- 3.4 Distribuição por UF do titular
SELECT
    NM_UF_MUNICIPIO_T               AS uf,
    COUNT(*)                        AS qtd,
    ROUND(SUM(VL_MR_ATU), 2)        AS soma_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
GROUP BY NM_UF_MUNICIPIO_T
ORDER BY qtd DESC;

-- 3.5 Valores fora do domínio para CS_CLIENTELA
SELECT CS_CLIENTELA, COUNT(*) AS ocorrencias
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
WHERE CS_CLIENTELA NOT IN ('U','R') OR CS_CLIENTELA IS NULL
GROUP BY CS_CLIENTELA;

-- =============================================================================
-- 4. CONSULTAS REUTILIZÁVEIS
-- =============================================================================

-- 4.1 Join padrão: MACICA + dimensões de espécie, situação e meio de pagamento
SELECT
    m.NU_NB,
    m.ANO_MES_REF,
    m.CS_ESPECIE,
    ce.TIPO_ESPECIE,
    ce.DESCR_ESPECIE,
    m.CS_SITUACAO_BENEF,
    cs.DESCR_SITUACAO,
    m.CS_CLIENTELA,
    m.CS_MEIO_PAGTO,
    cp.DESCR_MEIO_PAGAMENTO,
    m.VL_MR_ATU,
    m.VL_RMI,
    m.VL_BRUTO,
    m.TOT_DESCONTOS,
    m.VL_LIQUIDO,
    m.NM_TITULAR_BENEF_T,
    m.NU_CPF_T,
    m.DT_NASCIMENTO_T,
    m.NM_MUNICIPIO_T,
    m.NM_UF_MUNICIPIO_T,
    -- Datas convertidas de DDMMAAAA para DATE
    CASE WHEN LEN(m.D2_DIB) = 8 AND m.D2_DIB <> '00000000'
         THEN CONVERT(date, SUBSTRING(m.D2_DIB,5,4)+SUBSTRING(m.D2_DIB,3,2)+SUBSTRING(m.D2_DIB,1,2))
         ELSE NULL END AS data_inicio_beneficio,
    CASE WHEN LEN(m.D2_DCB) = 8 AND m.D2_DCB <> ''
         THEN CONVERT(date, SUBSTRING(m.D2_DCB,5,4)+SUBSTRING(m.D2_DCB,3,2)+SUBSTRING(m.D2_DCB,1,2))
         ELSE NULL END AS data_cessacao
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE]         ce ON CAST(m.CS_ESPECIE AS varchar(2)) = ce.COD_ESPECIE
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO]        cs ON CAST(m.CS_SITUACAO_BENEF AS varchar(2)) = cs.COD_SITUACAO
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_MEIO_PAGAMENTO]  cp ON CAST(m.CS_MEIO_PAGTO AS varchar(2)) = cp.COD_MEIO_PAGAMENTO;

-- 4.2 Filtro: benefícios ativos de determinada competência (ex: 202401)
SELECT *
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA]
WHERE ANO_MES_REF    = 202401
  AND CS_SITUACAO_BENEF = 0;  -- 0 = ATIVO

-- 4.3 Filtro: benefícios BPC (Amparo Social — espécies 87 e 88)
SELECT
    m.NU_NB,
    m.ANO_MES_REF,
    ce.DESCR_ESPECIE,
    m.NM_TITULAR_BENEF_T,
    m.NM_UF_MUNICIPIO_T,
    m.VL_MR_ATU
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(m.CS_ESPECIE AS varchar(2)) = ce.COD_ESPECIE
WHERE m.CS_ESPECIE IN (87, 88);

-- 4.4 Agregação: total de benefícios e valor por grupo de espécie e competência
SELECT
    m.ANO_MES_REF,
    ce.TIPO_ESPECIE,
    COUNT(*)                        AS qtd_beneficios,
    ROUND(SUM(m.VL_MR_ATU), 2)      AS soma_valor_atual,
    ROUND(AVG(m.VL_MR_ATU), 2)      AS media_valor
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_ESPECIE] ce ON CAST(m.CS_ESPECIE AS varchar(2)) = ce.COD_ESPECIE
GROUP BY m.ANO_MES_REF, ce.TIPO_ESPECIE
ORDER BY m.ANO_MES_REF, qtd_beneficios DESC;

-- 4.5 Rubricas explodidas: listar rubricas com valores de cada benefício (até 10)
SELECT
    m.NU_NB,
    m.ANO_MES_REF,
    rubrica.nr          AS nr_rubrica,
    rubrica.codigo      AS cod_rubrica,
    rubrica.valor       AS vl_rubrica,
    cr.DESCR_RUBRICA
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
CROSS APPLY (
    VALUES
    (1,  m.CS_RUBRICA_1,  m.VL_RUBRICA_1),
    (2,  m.CS_RUBRICA_2,  m.VL_RUBRICA_2),
    (3,  m.CS_RUBRICA_3,  m.VL_RUBRICA_3),
    (4,  m.CS_RUBRICA_4,  m.VL_RUBRICA_4),
    (5,  m.CS_RUBRICA_5,  m.VL_RUBRICA_5),
    (6,  m.CS_RUBRICA_6,  m.VL_RUBRICA_6),
    (7,  m.CS_RUBRICA_7,  m.VL_RUBRICA_7),
    (8,  m.CS_RUBRICA_8,  m.VL_RUBRICA_8),
    (9,  m.CS_RUBRICA_9,  m.VL_RUBRICA_9),
    (10, m.CS_RUBRICA_10, m.VL_RUBRICA_10)
) rubrica(nr, codigo, valor)
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_RUBRICA] cr
    ON CAST(rubrica.codigo AS varchar(3)) = cr.COD_RUBRICA
WHERE rubrica.codigo IS NOT NULL AND rubrica.codigo <> 0
ORDER BY m.NU_NB, m.ANO_MES_REF, rubrica.nr;

-- 4.6 Conversão de datas DDMMAAAA -> DATE (função auxiliar inline)
-- Uso: colocar a expressão abaixo em qualquer SELECT que precise de data real
--   CONVERT(date, SUBSTRING(D2_DIB,5,4)+SUBSTRING(D2_DIB,3,2)+SUBSTRING(D2_DIB,1,2)) AS data_dib

-- 4.7 Histórico de um NB específico ao longo das competências
SELECT
    m.NU_NB,
    m.ANO_MES_REF,
    m.CS_SITUACAO_BENEF,
    cs.DESCR_SITUACAO,
    m.VL_MR_ATU,
    m.VL_LIQUIDO,
    m.D2_DIB,
    m.D2_DCB,
    m.NM_ARQUIVO
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_SITUACAO] cs ON CAST(m.CS_SITUACAO_BENEF AS varchar(2)) = cs.COD_SITUACAO
WHERE m.NU_NB = '0000000001'   -- <- substituir pelo NB desejado
ORDER BY m.ANO_MES_REF;

-- 4.8 Benefícios com diagnóstico CID: join com COD_CID
SELECT
    m.NU_NB,
    m.ANO_MES_REF,
    m.CS_ESPECIE,
    m.CS_DIAGNOSTICO_N,
    cid_n.DESCR_CID   AS descr_diagnostico_principal,
    m.CS_DIAGNOSTICO_1,
    cid_1.DESCR_CID   AS descr_diagnostico_complementar
FROM [BD_BENEFICIOS_HIST].[dbo].[MACICA] m
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_CID] cid_n ON m.CS_DIAGNOSTICO_N = cid_n.COD_CID
LEFT JOIN [BD_BENEFICIOS_HIST].[dbo].[COD_CID] cid_1 ON m.CS_DIAGNOSTICO_1 = cid_1.COD_CID
WHERE m.CS_ESPECIE IN (31, 91, 32, 92)  -- benefícios por incapacidade
  AND m.CS_DIAGNOSTICO_N IS NOT NULL AND m.CS_DIAGNOSTICO_N <> '';
