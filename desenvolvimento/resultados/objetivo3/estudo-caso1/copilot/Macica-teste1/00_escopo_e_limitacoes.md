# Macica-teste1 - Escopo e Limitacoes (Fase 1)

## Contexto
Objeto da fase: view `BD_BENEFICIOS.dbo.MACICA`.

## Resposta solicitada (somente base de conhecimento)
Com base apenas no meu conhecimento interno, nao possuo um catalogo oficial e confiavel com a estrutura completa da view `BD_BENEFICIOS.dbo.MACICA` (campos, tipos, PK/FK) da base Macica/folha do INSS.

Por esse motivo, nao posso afirmar com seguranca:
- lista exata de colunas
- tipos de dados exatos de cada coluna
- chaves primarias e estrangeiras reais

## Limitação encontrada
A estrutura fisica/logica dessa view e um dado local do seu ambiente (metadados no SQL Server). Sem consulta ao catalogo do banco (`INFORMATION_SCHEMA`, `sys.columns`, `sys.types`, `sys.foreign_keys`, etc.), qualquer lista de campos seria especulativa.

## Proposta de outputs desta fase
Abaixo esta um plano objetivo para os outputs i-iv, com modelos prontos para preenchimento assim que os metadados forem extraidos.

### (i) Dicionario de dados
Arquivo sugerido: `01_dicionario_dados_macica.md`

Estrutura recomendada (tabela):
- coluna
- descricao_curta
- tipo_sql
- tamanho/precisao
- nulabilidade
- origem (base/tabela/view)
- observacao_regra

### (ii) Esquemas (ER/JSON)
Arquivos sugeridos:
- `02_modelo_er_macica.mmd` (Mermaid ER)
- `03_schema_macica.json` (JSON Schema ou estrutura tipada)

Conteudo esperado:
- entidade principal: MACICA
- entidades relacionadas (a identificar por joins e FKs reais)
- cardinalidades
- campos-chave
- no JSON: propriedades, tipo, required, descricao

### (iii) Tabelas explicativas de regras e dominios
Arquivo sugerido: `04_regras_dominios_macica.md`

Estruturas recomendadas:
1. Regras de negocio
- id_regra
- campo(s)
- descricao
- tipo (validacao, derivacao, consistencia)
- severidade

2. Dominios
- campo
- conjunto_valores
- significado
- regra de valores invalidos

### (iv) Scripts SQL utilitarios
Pasta sugerida: `sql/`

Arquivos sugeridos:
- `sql/01_profiling_macica.sql`
- `sql/02_integridade_referencial_macica.sql`
- `sql/03_dominios_macica.sql`
- `sql/04_consultas_reusaveis_macica.sql`

Modelos de conteudo:

1) Profiling
- contagem total
- nulos por coluna
- cardinalidade por coluna
- estatisticas basicas em campos numericos
- outliers por regra simples

2) Integridade referencial
- identificacao de campos candidatos a FK
- verificacao de orfaos em joins tipicos
- contagem de chaves sem correspondencia

3) Dominios
- distribuicao de valores por campo categorico
- deteccao de valores fora do dominio
- padroes invalidos (comprimento, caracteres)

4) Consultas reusaveis
- joins tipicos com dimensoes de apoio
- filtros frequentes (competencia, especie, situacao)
- agregacoes (por competencia, UF, especie, situacao)

## Proximo passo recomendado
Se voce autorizar introspecao no banco, eu gero automaticamente os outputs completos da Fase 1 com base em metadados reais da view, sem inferencia especulativa.
