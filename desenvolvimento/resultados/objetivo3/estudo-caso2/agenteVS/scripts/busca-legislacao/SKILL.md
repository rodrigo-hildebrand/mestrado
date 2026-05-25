---
name: busca-legislacao
description: Pesquise normativos na web para uma politica publica, priorizando fontes oficiais como planalto.gov.br, camara.leg.br, senado.leg.br e gov.br. Use esta skill sempre que o usuario pedir base legal, marco normativo, hierarquia normativa, ou legislacao aplicavel para politica publica, programa governamental, regulacao setorial ou tema juridico-administrativo.
compatibility: Any
---

# Busca Legislacao

Interprete o pedido do usuario e levante a base normativa aplicavel sem usar scripts Python.
Use somente leitura/escrita de arquivos e busca web com prioridade em fontes oficiais.

## Objetivo

Montar uma base legal organizada na ordem da Piramide de Kelsen:

1. Constituicao Federal (CF/88)
2. Lei Complementar (LC)
3. Lei Ordinaria (LO)
4. Decreto
5. Normativos sublegais (portaria, instrucao normativa, resolucao e similares)

Cada norma encontrada deve ser salva em arquivo texto separado, com metadados minimos, link oficial e texto integral da norma.

## Entradas

Aceite um objeto JSON com qualquer um destes campos:

```json
{
  "politica_publica": "Previdencia Social",
  "max_results": 12
}
```

Campos aceitos:

- `politica_publica` (preferencial)
- `query` (alias)
- `max_results` (opcional, padrao: 12, minimo: 5, maximo: 30)

Se a entrada vier em linguagem natural, converta para o objeto acima internamente.

## Saida esperada

Retorne um JSON com:

- `consulta`
- `status`
- `resumo`
- `itens` (lista ordenada pela hierarquia normativa)
- `arquivos_gerados` (lista de caminhos `.txt`)
- `cf88_comum` (caminho para o arquivo comum da CF)

## Fluxo de execucao

### 1) Interpretar pedido

- Identifique o tema central (politica publica, setor ou problema juridico).
- Expanda em termos de busca sinonimos e termos institucionais.
- Se o pedido estiver vago, assuma o eixo principal informado e siga a busca.

### 2) Buscar em fontes oficiais

Priorize nesta ordem:

1. `planalto.gov.br`
2. `camara.leg.br` e `www2.camara.leg.br`
3. `senado.leg.br`
4. `lexml.gov.br`
5. dominios oficiais `gov.br`

Monte consultas por nivel normativo, por exemplo:

- `site:planalto.gov.br lei complementar <tema>`
- `site:planalto.gov.br lei <tema>`
- `site:planalto.gov.br decreto <tema>`
- `site:gov.br portaria <tema>`
- `site:gov.br "instrucao normativa" <tema>`

### 3) Classificar e validar

Para cada resultado:

- Identifique `tipo_norma` e `numero/ano`.
- Valide se o dominio e oficial.
- Extraia ementa curta (ou resumo do caput quando possivel).
- Evite duplicados por URL canonica ou mesmo numero/ano.

### 4) Garantir a CF/88 sempre acessivel

- Sempre inclua o arquivo comum em `references/common/cf/cf88.txt`.
- Sempre devolva este caminho em `cf88_comum`.
- Verifique se ha mencao a emendas constitucionais recentes no contexto do tema.
- Se houver novidade relevante, acrescente nota no proprio `cf88.txt` em `Atualizacoes de contexto`.

### 5) Salvar arquivos texto

Grave os artefatos em:

- `references/generated/<slug-da-politica>/`

Um arquivo por norma, no formato:

- `<ordem-kelsen>_<tipo>_<numero-ano>.txt`

Exemplos:

- `02_lc_142-2013.txt`
- `03_lo_8212-1991.txt`
- `04_decreto_3048-1999.txt`
- `05_portaria_1510-2009.txt`

Conteudo minimo de cada arquivo:

```text
Titulo:
Tipo:
Numero/Ano:
Nivel Kelsen:
Tema:
Fonte oficial:
Data de consulta:
Resumo:
Palavras-chave:
Observacoes:

Texto integral:
<transcricao completa da norma em texto simples>
```

Regras para o campo `Texto integral`:

- Salve o texto normativo completo em texto simples, sem resumir por secoes.
- Nao substitua o corpo da norma por ementa curta.
- Remova tags HTML, scripts e elementos de navegacao, preservando o conteudo juridico.
- Mantenha metadados no topo e o texto integral logo abaixo.
- Preserve a estruturacao original em linhas e paragrafos (cabecalhos, artigos, incisos e paragrafos em linhas separadas).
- Nao colapse todo o corpo normativo em uma unica linha.
- Se a pagina oficial estiver indisponivel, mantenha o arquivo com `pendente_validacao` e registre a tentativa.

### 6) Consolidar retorno

- Ordene os itens por nivel Kelsen e, em seguida, por ano decrescente.
- Informe lacunas (ex.: "nao foi localizada LC especifica para o tema").
- Nao invente norma. Se nao confirmar em fonte oficial, marque como `pendente_validacao`.

### 7) Limpar artefatos temporarios

- Se forem criados scripts auxiliares para executar a coleta (por exemplo, `.ps1`, `.bat`, `.sh`), remova-os ao final da execucao.
- Mantenha no repositorio apenas os artefatos finais da skill: arquivos `.txt` da base legal e `resultado-execucao.json`.
- Remova tambem arquivos temporarios de download e processamento (`.tmp`, `.html` intermediario e logs ad hoc), preservando somente a saida final.

## Regras de qualidade

- Nao usar Python para interpretar, buscar ou gerar os arquivos da skill.
- Priorizar completude com rastreabilidade (sempre incluir URL oficial).
- Evitar dominio privado, blog, noticia opinativa ou agregador sem fonte primaria.
- Quando houver conflito entre fontes, prevalece a fonte oficial de publicacao normativa.

## Estrutura de arquivos desta skill

- Instrucao principal: `SKILL.md`
- Referencia comum CF/88: `references/common/cf/cf88.txt`
- Referencias geradas: `references/generated/<slug-da-politica>/`
- Guia de referencias: `references/README.md`
- Casos de teste: `evals/evals.json`
