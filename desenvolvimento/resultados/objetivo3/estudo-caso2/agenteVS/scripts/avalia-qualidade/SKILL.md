---
name: avalia-qualidade
description: Receba scripts SQL ou Python com descricoes de tipologias ou alertas e gere scripts SQL de avaliacao de qualidade de dados por campo (obrigatoriedade, completude, validade, consistencia e acuracia), com base nos metadados das bases selecionadas. Nao execute os scripts. Use esta skill quando o usuario pedir avaliacao de qualidade de campos, prontidao de dados para auditoria, geracao de scripts de medicao de preenchimento, verificacao de validade estrutural, consistencia entre atributos relacionados ou acuracia de CPF.
compatibility: Any
---

# Avalia Qualidade

Execute sem usar Python nas fases analiticas.
Nao use fallback heuristico para inferir obrigatoriedade, condicionalidade, regras de validacao ou correspondencias nao explicitas.
Nao invente tabelas, colunas, filtros ou regras de negocio nao presentes nas entradas.
Nao execute os scripts SQL contra as bases. Gere apenas o codigo SQL de cada dimensao; todos os valores numericos (valor_0_100, total_registros, preenchidos, etc.) devem ser null na saida.

## Objetivo

Gerar scripts SQL de avaliacao da qualidade tecnica dos campos referenciados em tipologias ou alertas, retornando por campo:

- classificacao de obrigatoriedade (obrigatorio, opcional_condicional, opcional_nao_condicional);
- script SQL de completude para campos avaliaveis (valor_0_100 = null);
- script SQL de validade para campos com regra explicita (valor_0_100 = null);
- script SQL de consistencia para pares/grupos com relacao explicita (valor_0_100 = null);
- script SQL de acuracia para CPF via `BD_RECEITA.dbo.CPF` (valor_0_100 = null).

Os valores numericos nunca sao calculados nesta skill; ficam null para preenchimento apos execucao manual dos scripts.

## Dependencias obrigatorias

Esta skill depende de:

1. Scripts (SQL ou Python) com descricao de tipologia/alerta e referencia de campos, organizados em arvore por politica publica.
2. Inventario de bases, tabelas e colunas (saida da skill `busca-bd-labcontas`).

Se qualquer dependencia faltar, interrompa e sinalize ao agente orquestrador.

## Entradas

Aceite qualquer combinacao destes campos:

```json
{
  "politica_publica": "Seguro defeso",
  "tipologias_ou_alertas_por_politica": [
    {
      "politica_publica": "Seguro defeso",
      "politica_slug": "seguro-defeso",
      "tipologias_ou_alertas": [
        {
          "id": "TIP-01",
          "tipo": "tipologia",
          "descricao": "Pagamento apos obito",
          "linguagem_script": "sql",
          "script": "SELECT ...",
          "campos_referenciados": [
            {
              "database": "BD_SEGURO_DEFESO",
              "schema": "dbo",
              "tabela": "REQUERIMENTO",
              "campo": "CPF_REQUERENTE",
              "papel": "identificacao"
            }
          ],
          "regras_condicionais": [
            {
              "campo": "COD_DOENCA",
              "condicao": "CS_ESPECIE in (especies incapacidade)"
            }
          ]
        }
      ]
    }
  ],
  "bases_selecionadas": [
    {
      "database": "BD_SEGURO_DEFESO",
      "tabelas": [
        {
          "schema": "dbo",
          "nome": "REQUERIMENTO",
          "colunas": ["CPF_REQUERENTE", "NOME_REQUERENTE", "COD_DOENCA"]
        }
      ]
    }
  ],
  "max_registros_amostra": 0,
  "considerar_string_vazia_como_nulo": true
}
```

Campos aceitos:

- `politica_publica` (obrigatorio)
- `tipologias_ou_alertas_por_politica` (obrigatorio; estrutura em arvore)
- `bases_selecionadas` (obrigatorio)
- `max_registros_amostra` (opcional; `0` significa tabela completa)
- `considerar_string_vazia_como_nulo` (opcional, padrao: `true`)

Regra estrutural obrigatoria:

- As tipologias/alertas devem estar sob um no de politica publica em `tipologias_ou_alertas_por_politica`.
- A skill deve selecionar o no cuja `politica_publica` ou `politica_slug` corresponde a entrada solicitada.

## Regras de interrupcao por dependencia

Se faltar qualquer entrada obrigatoria, retorne:

```json
{
  "status": "dependencia_pendente",
  "dependencias": ["busca-bd-labcontas"],
  "acao_orquestrador": "Execute as skills faltantes e reenvie as saidas para avalia-qualidade.",
  "lacunas": ["motivo detalhado"]
}
```

Mapeamento de falhas:

- Sem `tipologias_ou_alertas_por_politica` ou lista vazia: dependencia de producao de tipologias/alertas.
- Sem no correspondente da politica solicitada: dependencia de producao de tipologias/alertas para a politica.
- Sem `bases_selecionadas` ou lista vazia: dependencia `busca-bd-labcontas`.

## Dimensoes de avaliacao por campo

### 1) Obrigatoriedade do campo

Para cada campo referenciado:

- `obrigatorio`: campo exigido para identificacao minima ou processamento basico no proprio script/alerta.
- `opcional_condicional`: campo exigido apenas quando condicao explicita estiver presente nas entradas.
  - Exemplo aceito quando vier explicitamente na entrada: `COD_DOENCA` apenas para beneficios de incapacidade.
  - Exemplo aceito quando vier explicitamente na entrada: `NOME_INSTITUIDOR` apenas para pensao/auxilio-reclusao.
- `opcional_nao_condicional`: campo nao critico e sem condicao explicita.

Regra anti-heuristica:

- Nao inferir condicoes por conhecimento externo; somente usar `regras_condicionais` e filtros explicitamente fornecidos.

### 2) Completude (0 a 100)

Para campos com completude avaliavel:

- `completude = 100 * (registros_preenchidos / registros_totais_avaliados)`
- `registros_preenchidos` considera `IS NOT NULL` e, se configurado, `LTRIM(RTRIM(campo)) <> ''` para texto.

Tratamento por tipo:

- `obrigatorio`: calcular completude normal.
- `opcional_condicional`: calcular:
  - `filtro_condicional_sugerido` (com base na condicao explicita de entrada);
  - `completude_relativa` no subconjunto filtrado.
- `opcional_nao_condicional`: retornar `nao_aplicavel` para completude.

### 3) Validade (0 a 100)

Aplicar somente para campos com completude avaliavel.

- `validade = 100 * (registros_validos / registros_preenchidos)`

Regras de validade devem vir explicitas nas entradas (ou do proprio script). Exemplos permitidos:

- Campo string representando data: validar formato conversivel e data plausivel.
- Campo de nome: detectar presenca de algarismos quando regra explicita proibir.
- CPF: validar tamanho e padrao numerico basico.

Se nao houver regra explicita de validade para o campo, retornar `validade_nao_avaliada` e registrar lacuna.

### 4) Consistencia (0 a 100)

Avaliar pares/grupos relacionados na mesma tabela quando o relacionamento estiver explicito na entrada.
Exemplos de pares relacionais aceitos quando explicitados:

- municipio e UF
- CEP e endereco
- nome_mae e indicador_possui_mae

Formula:

- `consistencia = 100 * (registros_consistentes / registros_avaliados_relacao)`

Sem relacao explicita, retornar `consistencia_nao_avaliada`.

### 5) Acuracia (0 a 100) para CPF

Quando o campo for CPF (nome do campo contendo `CPF`):

- verificar correspondencia em `BD_RECEITA.dbo.CPF.NUM_CPF`
- `acuracia = 100 * (cpf_encontrado_receita / cpf_preenchido)`

Se `BD_RECEITA.dbo.CPF` nao estiver acessivel no conjunto de bases, registrar lacuna e retornar `acuracia_nao_avaliada`.

## Fluxo de execucao

### Etapa 1 - Normalizar entradas

- Ler `tipologias_ou_alertas_por_politica`, selecionar o no da politica e expandir lista de campos referenciados.
- Validar existencia de cada campo no inventario de `bases_selecionadas`.
- Campos inexistentes devem ir para `erros_mapeamento_campo`.

### Etapa 2 - Classificar obrigatoriedade

- Classificar cada campo com base no papel declarado e nas regras condicionais explicitas.
- Nao classificar por similaridade de nome, sem evidencia explicita.

### Etapa 3 - Gerar SQL de medicao

Para cada campo/relacao avaliavel, gerar SQL objetivo de contagem:

- totais
- preenchidos
- validos
- consistentes
- acurados (CPF)

Exemplo base de completude:

```sql
SELECT
  COUNT(*) AS total_registros,
  SUM(CASE WHEN [CAMPO] IS NOT NULL THEN 1 ELSE 0 END) AS preenchidos
FROM [DATABASE].[SCHEMA].[TABELA];
```

### Etapa 4 - Consolidar saida

Gerar um JSON em arvore com resultado por politica publica, tipologia/alerta e campo.

## Formato de saida

Gerar `references/generated/<politica-slug>/avaliacao_qualidade.json`:

```json
{
  "status": "ok",
  "politica_publica": "<tema>",
  "avaliacao_timestamp": "2026-05-14T12:00:00Z",
  "total_politicas_avaliadas": 1,
  "total_tipologias_ou_alertas": 0,
  "total_campos_avaliados": 0,
  "resultados_por_politica": [
    {
      "politica_publica": "<tema>",
      "politica_slug": "<tema-slug>",
      "resultados": [
        {
          "id": "TIP-01",
          "tipo": "tipologia",
          "descricao": "...",
          "campos": [
            {
              "database": "BD_X",
              "schema": "dbo",
              "tabela": "TABELA_X",
              "campo": "CPF",
              "obrigatoriedade": "obrigatorio",
              "condicionalidade": {
                "tipo": "nao_condicional",
                "filtro_condicional_sugerido": null
              },
              "completude": {
                "aplicavel": true,
                "valor_0_100": null,
                "total_registros": null,
                "preenchidos": null,
                "nulos_ou_vazios": null,
                "completude_relativa": null
              },
              "validade": {
                "aplicavel": true,
                "valor_0_100": null,
                "registros_preenchidos": null,
                "registros_validos": null,
                "regra_validade": "cpf_numerico_tamanho_11"
              },
              "consistencia": {
                "aplicavel": false,
                "valor_0_100": null,
                "relacao": null
              },
              "acuracia": {
                "aplicavel": true,
                "valor_0_100": null,
                "fonte_referencia": "BD_RECEITA.dbo.CPF.NUM_CPF"
              },
              "sql_testes": {
                "completude": "SELECT ...",
                "validade": "SELECT ...",
                "consistencia": null,
                "acuracia": "SELECT ..."
              }
            }
          ]
        }
      ]
    }
  ],
  "lacunas": [],
  "erros_mapeamento_campo": [],
  "referencias": {
    "generated": "references/generated/<politica-slug>/avaliacao_qualidade.json"
  }
}
```

Status possiveis:

- `dependencia_pendente`
- `ok`
- `ok_com_lacunas`

## Regras de qualidade

- Nao usar Python nas fases analiticas.
- Nao usar fallback heuristico para completar regra ausente.
- Nao inventar condicoes de obrigatoriedade/consistencia/validade.
- Nao executar os scripts SQL; apenas gera-los.
- Todos os valores numericos (valor_0_100, total_registros, preenchidos, nulos_ou_vazios, registros_validos, registros_preenchidos) devem ser null.
- Completude e validade so devem ser geradas (sql_testes populado) para campos avaliaveis.
- Para `opcional_nao_condicional`, marcar completude como `aplicavel: false` e sql_testes.completude como null.
- Todo campo avaliado deve retornar SQL de teste correspondente (ou justificativa de nao aplicacao).
