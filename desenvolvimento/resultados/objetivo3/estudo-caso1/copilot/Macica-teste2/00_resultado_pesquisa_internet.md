# Macica-teste2 - Resultado com pesquisa na internet

## Objetivo
Repetir o exercicio da fase 1 para a view BD_BENEFICIOS.dbo.MACICA, desta vez usando pesquisa na internet.

## Fontes consultadas (web)
1. Busca web por termos tecnicos da view:
   - https://www.bing.com/search?q=%22BD_BENEFICIOS%22+%22MACICA%22+dbo
2. Busca web por contexto de folha/maciça:
   - https://www.bing.com/search?q=MACICA+INSS+folha+de+pagamento
3. Busca web por campos de beneficios (NB, DIB, DCB, especie):
   - https://www.bing.com/search?q=INSS+beneficios+concedidos+campos+NB+DIB+DCB+especie
4. Fonte oficial de referencia conceitual (Ministerio da Previdencia, AEPS 2023, Secao de Beneficios):
   - https://www.gov.br/previdencia/pt-br/assuntos/previdencia-social/arquivos/aeps-2023/secao-i-beneficios/apresentacao-beneficios

## Achados principais
1. Nao foi encontrada documentacao publica com o esquema tecnico da view BD_BENEFICIOS.dbo.MACICA (lista de colunas, tipos SQL, PK/FK).
2. A maior parte dos resultados indexados para "macica INSS" trata de calendario/explicacao operacional e nao de dicionario de dados de banco.
3. A fonte oficial encontrada (AEPS) confirma conceitos de negocio relevantes e siglas como DDB e DIB, alem de classificacao por especie/grupo de especie, mas nao publica o DDL da view MACICA.

## Estrutura de dados da MACICA (estado atual)
Conclusao: com base na internet aberta, nao ha evidencia suficiente para afirmar a estrutura exata da view BD_BENEFICIOS.dbo.MACICA.

### Campos possiveis (hipotese para prototipo)
Observacao: tabela abaixo e um rascunho de trabalho, nao o esquema oficial da view.

| campo_hipotetico | descricao_curta | tipo_sql_sugerido | observacao |
|---|---|---|---|
| nb | numero do beneficio | varchar(20) | candidato a identificador de beneficio |
| especie | codigo da especie do beneficio | varchar(2) | conceito oficial de especie aparece na fonte AEPS |
| grupo_especie | grupo da especie | varchar(100) | pode ser derivado de tabela de dominio |
| ddb | data de despacho do beneficio | date | citada explicitamente na fonte AEPS |
| dib | data de inicio do beneficio | date | citada explicitamente na fonte AEPS |
| dcb | data de cessacao do beneficio | date | comum em contexto previdenciario, validar no banco |
| situacao_beneficio | ativo/suspenso/cessado | varchar(30) | relacionado aos processos concessao/manutencao/cessacao |
| competencia | competencia de referencia | char(6) | usual para emissao/folha mensal |
| valor_beneficio | valor monetario do beneficio | decimal(18,2) | validar nome e precisao reais |
| uf | unidade federativa | char(2) | campo geografico comum em analises |
| municipio | codigo ou nome do municipio | varchar(100) | validar padrao real |

### Chaves e relacionamentos (hipotese)
- PK: nao identificada publicamente.
- Candidato de chave analitica: nb + competencia (hipotese).
- FKs: nao identificadas publicamente.
- Possiveis dimensoes relacionadas: dominio de especie, calendario/competencia, localidade, situacao.

## Proposta de outputs (i-iv) para Macica-teste2
Mesmo sem DDL publico, os entregaveis podem ser preparados com status de preenchimento:

1. Dicionario de dados
- Arquivo: 01_dicionario_dados_macica.md
- Conteudo: colunas confirmadas vs colunas hipoteticas, com nivel de confianca.

2. Esquemas (ER/JSON)
- Arquivos:
  - 02_modelo_er_macica.mmd
  - 03_schema_macica.json
- Conteudo: modelo minimo com entidade MACICA e campos com tag "confirmed=false" quando for hipotese.

3. Tabelas explicativas de regras e dominios
- Arquivo: 04_regras_dominios_macica.md
- Conteudo: regras documentadas (ex.: coerencia temporal entre DDB/DIB/DCB) e dominios de especie/grupo.

4. Scripts SQL utilitarios
- Pasta: sql/
- Arquivos:
  - 01_profiling_macica.sql
  - 02_integridade_referencial_macica.sql
  - 03_dominios_macica.sql
  - 04_consultas_reusaveis_macica.sql
- Conteudo: scripts genericos prontos para ajustar aos nomes reais de colunas.

## Limitacoes encontradas
1. Nao foi localizada na internet aberta a definicao oficial da view BD_BENEFICIOS.dbo.MACICA.
2. O portal de dados abertos da Dataprev esteve indisponivel por timeout a partir deste ambiente durante o teste.
3. Sem metadata do SQL Server local (sys.columns, sys.types, sys.foreign_keys), nao e possivel confirmar campos, tipos, PK e FK com rigor tecnico.

## Recomendacao objetiva para fechar a fase
Executar introspecao controlada da view no LabContas para transformar as hipoteses em esquema confirmado.
Consultas minimas recomendadas:
- sys.columns + sys.types para colunas/tipos
- INFORMATION_SCHEMA.VIEW_COLUMN_USAGE para origem de colunas
- sys.sql_expression_dependencies para dependencias
- (se aplicavel) relacoes em tabelas base para mapear FKs reais
