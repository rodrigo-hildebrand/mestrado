---
name: desenvolve-tipologia
description: Receba riscos específicos ranqueados (matriz de risco) e o conjunto de bases/tabelas/consultas disponíveis, e gere tipologias de auditoria com scripts executáveis para testar concretização de riscos, priorizando SQL e usando Python apenas quando SQL não for tecnicamente aplicável. Use esta skill quando o usuário pedir desenvolvimento de tipologias, testes de auditoria orientados a risco, scripts de verificação de risco, ou desenho de consultas para validação de achados.
compatibility: Any
---

# Desenvolve Tipologia

Execute sem usar Python nas fases analíticas.
Não use fallback heurístico para inventar mapeamentos risco-dado.
Não invente tabelas, colunas, consultas, joins, chaves ou regras de negócio que não estejam explicitamente presentes nas entradas.

## Objetivo

Transformar riscos específicos priorizados e estrutura real de dados em tipologias auditáveis, cada uma contendo:

- referência ao risco específico e ao risco geral relacionado;
- bases, tabelas e consultas necessárias;
- script detalhado para testar se o risco está concretizado.

## Dependências obrigatórias

Esta skill depende de duas entradas anteriores:

1. Resultado da análise de risco (ex.: saída da skill `analise-risco`), contendo riscos específicos ranqueados.
2. Resultado da descoberta de dados (ex.: saída da skill `busca-bd-labcontas`), contendo bases, tabelas, colunas e consultas disponíveis.

Se qualquer dependência faltar, interrompa imediatamente e devolva status de dependência ao agente orquestrador.

## Entradas

Aceite qualquer combinação destes campos:

```json
{
  "politica_publica": "Seguro defeso",
  "riscos_especificos_ranqueados": [
    {
      "id": "RE-01",
      "risco_geral_id": "RG-01",
      "titulo": "Concessão indevida",
      "prioridade": 1,
      "descricao": "Risco de concessão sem elegibilidade",
      "controles_esperados": ["validação de elegibilidade"],
      "evidencias_textuais": ["CPF", "NIS", "data_concessao"]
    }
  ],
  "bases_selecionadas": [
    {
      "database": "BD_BENEFICIOS",
      "tabelas": [
        {
          "schema": "dbo",
          "nome": "BENEFICIO",
          "colunas": ["CPF", "NIS", "DT_CONCESSAO", "STATUS"]
        }
      ],
      "consultas_disponiveis": ["sp_validacao_beneficio"]
    }
  ],
  "max_riscos": 10,
  "prefer_sql": true,
  "incluir_python_quando_sql_inviavel": true
}
```

Campos aceitos:

- `politica_publica` (obrigatório)
- `riscos_especificos_ranqueados` (obrigatório; lista ordenada por prioridade)
- `bases_selecionadas` (obrigatório; databases, tabelas, colunas, consultas)
- `max_riscos` (opcional, padrão: 10)
- `prefer_sql` (opcional, padrão: `true`)
- `incluir_python_quando_sql_inviavel` (opcional, padrão: `true`)

## Regras de interrupção por dependência

Se faltar qualquer entrada obrigatória, retorne:

```json
{
  "status": "dependencia_pendente",
  "dependencias": [
    "analise-risco",
    "busca-bd-labcontas"
  ],
  "acao_orquestrador": "Execute as skills faltantes e reenvie as saídas para desenvolve-tipologia.",
  "lacunas": ["motivo detalhado"]
}
```

Mapeamento de falhas:

- Sem `riscos_especificos_ranqueados`: dependência `analise-risco`.
- Sem `bases_selecionadas`: dependência `busca-bd-labcontas`.
- Com listas vazias: dependência correspondente também deve ser sinalizada.

## Método sem heurística

### Etapa 1 - Selecionar riscos prioritários

- Use os riscos na ordem informada em `riscos_especificos_ranqueados`.
- Considere no máximo `max_riscos`.
- Não reordene por critério próprio.

### Etapa 2 - Mapeamento risco para dados

Para cada risco selecionado:

- Use apenas referências explícitas presentes em:
  - `evidencias_textuais` do risco;
  - nomes reais de databases/tabelas/colunas/consultas fornecidos em `bases_selecionadas`.
- O mapeamento permitido é por correspondência literal de termos (case-insensitive).
- Não usar sinônimos, embeddings, similaridade semântica, ontologias ou enriquecimento externo.
- Se não houver correspondência literal suficiente, não invente mapeamento; registre em `lacunas`.

### Etapa 3 - Definir linguagem do script

Regra obrigatória de preferência:

1. Gerar script SQL sempre que possível com os objetos disponíveis.
2. Usar Python apenas quando SQL não for tecnicamente aplicável e `incluir_python_quando_sql_inviavel=true`.
3. Se SQL for inviável e Python estiver desabilitado, registrar lacuna.

### Etapa 4 - Gerar tipologia por risco

Para cada risco com mapeamento válido, gerar 1 tipologia com:

- `tipologia_id`
- `risco_especifico_id`
- `risco_especifico_titulo`
- `risco_geral_id`
- `prioridade_risco`
- `bases_necessarias` (database + tabela + colunas)
- `consultas_necessarias`
- `objetivo_teste`
- `criterio_concretizacao_risco`
- `linguagem_script` (`sql` ou `python`)
- `script_detalhado`
- `parametros_execucao`
- `observacoes`

## Formato de saída

Retorne JSON no arquivo `references/generated/<politica-slug>/tipologias_auditoria.json`:

```json
{
  "status": "ok",
  "politica_publica": "<tema>",
  "total_riscos_recebidos": 0,
  "total_riscos_processados": 0,
  "total_tipologias": 0,
  "tipologias": [
    {
      "tipologia_id": "TIP-001",
      "risco_especifico_id": "RE-01",
      "risco_especifico_titulo": "Concessão indevida",
      "risco_geral_id": "RG-01",
      "prioridade_risco": 1,
      "bases_necessarias": [
        {
          "database": "BD_BENEFICIOS",
          "schema": "dbo",
          "tabela": "BENEFICIO",
          "colunas": ["CPF", "NIS", "DT_CONCESSAO"]
        }
      ],
      "consultas_necessarias": ["sp_validacao_beneficio"],
      "objetivo_teste": "Verificar concessões sem evidência de elegibilidade",
      "criterio_concretizacao_risco": "Existe registro que viola a regra de controle definida",
      "linguagem_script": "sql",
      "script_detalhado": "SELECT TOP (100) ...",
      "parametros_execucao": {
        "periodo_inicio": "<yyyy-mm-dd>",
        "periodo_fim": "<yyyy-mm-dd>"
      },
      "observacoes": []
    }
  ],
  "lacunas": [],
  "referencias": {
    "generated": "references/generated/<politica-slug>/tipologias_auditoria.json"
  }
}
```

Status possíveis:

- `dependencia_pendente`: faltam entradas obrigatórias.
- `ok`: tipologias geradas.
- `ok_com_lacunas`: geração concluída, mas com riscos sem mapeamento literal suficiente.

## Regras de qualidade

- Não usar Python nas fases analíticas da skill.
- Não usar fallback heurístico para completar lacunas de dados.
- Não inventar objetos de banco não presentes em `bases_selecionadas`.
- Cada tipologia deve referenciar ao menos 1 risco específico e 1 risco geral relacionado.
- Cada tipologia deve explicitar as bases (com tabelas/colunas) e consultas necessárias.
- Priorizar SQL sempre; Python apenas na exceção prevista.
- Em caso de falta de correspondência literal, registrar lacuna em vez de forçar tipologia.

## Exemplo 1 - Óbito

```sql
DROP TABLE IF EXISTS #TPL_21_001;

SELECT *
INTO #TPL_21_001
FROM dbo.P_MACICA_COMPARACAO_CPF_TE AS t1
WHERE t1.TIPO_PESSOA = 'I'
  AND t1.CRIT_CERTEZA IN (0, 1, 2, 4)
  AND t1.SITUACAO_CPF <> '3'
  AND t1.ANO_MES_CARGA_MACICA = CAST(@ano_mes_macica AS varchar(6))
  AND t1.CS_ESPECIE IN (
    1, 2, 3, 20, 21, 22, 23, 26, 27, 28, 29,
    55, 59, 84, 86, 93, 97
  );

DELETE t1
FROM #TPL_21_001 AS t1
INNER JOIN dbo.DQ_sisobi AS s
  ON t1.CPF_MACICA = s.CPF_SISOBI
WHERE s.AVALIACAO_CPF = 'igual';

DELETE t1
FROM #TPL_21_001 AS t1
INNER JOIN dbo.DQ_OBITO_SISOBI AS s
  ON t1.CPF_MACICA = s.CPF_SISOBI
WHERE s.AVALIACAO_CPF = 'igual';

DELETE t1
FROM #TPL_21_001 AS t1
INNER JOIN [BD_SIRC].[dbo].[CERTIDOES_OBITO] AS s
  ON t1.CPF_MACICA = s.NU_CPF
WHERE s.CRITERIO_SIMILARIDADE_RECEITA IN (1, 2, 3, 4, 5);

SELECT a.*
FROM [BDU_SECEXPREVI].[FCB_2024].[FCB2024_AMOSTRA_TPL_BP_E21_001] AS a
INNER JOIN #TPL_21_001 AS b
  ON a.NU_NB = b.NU_NB;
```

## Exemplo 2 - Teto Previdenciário

```sql
DROP TABLE IF EXISTS #REGRAS_TETO_STF;

CREATE TABLE #REGRAS_TETO_STF (
  CS_ESPECIE decimal(2, 0) NOT NULL,
  CS_TRATAMENTO decimal(2, 0) NOT NULL,
  PRIMARY KEY (CS_ESPECIE, CS_TRATAMENTO)
);

INSERT INTO #REGRAS_TETO_STF (CS_ESPECIE, CS_TRATAMENTO)
VALUES
  (20, 70), (20, 72),
  (21, 03), (21, 59), (21, 60), (21, 65),
  (22, 07), (22, 09), (22, 71), (22, 72), (22, 75),
  (23, 11), (23, 60), (23, 65),
  (26, 03), (26, 59), (26, 60),
  (27, 03), (27, 60),
  (29, 42), (29, 43), (29, 44), (29, 48), (29, 49), (29, 50),
  (32, 16), (32, 54), (32, 64),
  (33, 17),
  (34, 30), (34, 32),
  (37, 73),
  (38, 73),
  (41, 16), (41, 54), (41, 64),
  (42, 16), (42, 54), (42, 64),
  (43, 24), (43, 54), (43, 64),
  (44, 17),
  (46, 54), (46, 64),
  (56, 52),
  (57, 54),
  (58, 58),
  (59, 58),
  (72, 30), (72, 32),
  (78, 32),
  (92, 54), (92, 64),
  (93, 60), (93, 65);

INSERT INTO dbo.P_MACICA_TPL_BP_E00_001 (
  ANO_MES_REF,
  NU_NB,
  VL_MR_ATU,
  VL_RMI,
  CS_TRATAMENTO,
  CS_ESPECIE,
  CS_DESPACHO,
  D2_DDB,
  NU_CPF_T,
  IDADE_DDB,
  TETO_INSS,
  TETO_STF,
  TETO,
  SITUACAO_E00_001
)
SELECT
  t1.ANO_MES_REF,
  t1.NU_NB,
  t1.VL_MR_ATU,
  t1.VL_RMI,
  t1.CS_TRATAMENTO,
  t1.CS_ESPECIE,
  t1.CS_DESPACHO,
  t1.D2_DDB,
  t1.NU_CPF_T,

  CAST(
    FLOOR(
      (
        ((@ano_mes_macica * 100) + 1)
        - TRY_CONVERT(
          int,
          CONCAT(
            SUBSTRING(t1.D2_DDB, 5, 4),
            SUBSTRING(t1.D2_DDB, 3, 2),
            SUBSTRING(t1.D2_DDB, 1, 2)
          )
        )
      ) / 10000.0
    ) AS int
  ) AS IDADE_DDB,

  CAST(@teto_inss AS varchar(7)) AS TETO_INSS,
  CAST(@teto_stf AS varchar(8)) AS TETO_STF,

  CASE
    WHEN r.CS_ESPECIE IS NOT NULL
     AND t1.VL_MR_ATU > @teto_stf
    THEN 'STF'
    ELSE 'INSS'
  END AS TETO,

  'IRREGULAR' AS SITUACAO_E00_001

FROM BD_BENEFICIOS_HIST.dbo.MACICA AS t1
LEFT JOIN #REGRAS_TETO_STF AS r
  ON r.CS_ESPECIE = t1.CS_ESPECIE
   AND r.CS_TRATAMENTO = t1.CS_TRATAMENTO
WHERE t1.CS_PA <> 3
  AND t1.CS_SITUACAO_BENEF = 0
  AND t1.VL_MR_ATU > @teto_inss
  AND t1.ANO_MES_REF = @ano_mes_macica

  -- Remove os casos que podem estar acima do teto INSS,
  -- mas ainda dentro do teto STF.
  AND NOT (
    r.CS_ESPECIE IS NOT NULL
    AND t1.VL_MR_ATU <= @teto_stf
  );
```
