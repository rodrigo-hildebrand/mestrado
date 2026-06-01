# CadUnico-teste1 - Resultado com pesquisa na internet

## Objetivo
Avaliar se e possivel finalizar a analise estrutural de duas tabelas supostamente ligadas ao Cadastro Unico, `TB_FAMILIA` e `TB_PESSOA`, usando apenas informacoes publicas disponiveis na internet, sem introspeccao em banco e sem usar a skill criada no workspace.

## Fontes consultadas (web)
1. Pagina oficial de consulta do CadUnico:
   - https://www.gov.br/pt-br/servicos/consultar-dados-do-cadastro-unico-cadunico
2. Pagina oficial de solicitacao de base identificada do CadUnico:
   - https://www.gov.br/pt-br/servicos/solicitar-cessao-de-dados-identificados-do-cadastro-unico
3. Pagina oficial do programa Cadastro Unico no MDS:
   - https://www.gov.br/mds/pt-br/acoes-e-programas/cadastro-unico
4. Busca web por termos tecnicos:
   - https://www.bing.com/search?q=CadUnico+TB_FAMILIA+TB_PESSOA
   - https://www.bing.com/search?q=%22codigo+familiar%22+nis+cadunico
   - https://www.bing.com/search?q=manual+cadunico+familia+pessoa+pdf
5. Resultados publicos adicionais localizados nas buscas:
   - pagina de manuais do MDS para operacao do sistema de Cadastro Unico
   - manuais e formularios publicos em PDF que descrevem o modelo conceitual de familia e pessoa, mas nao o esquema SQL fisico

## Achados principais
1. A documentacao oficial aberta confirma que o CadUnico e organizado em dois niveis centrais de informacao:
   - **familia**
   - **membros/pessoas da familia**
2. A pagina de consulta oficial informa que o usuario pode visualizar:
   - **codigo familiar**
   - situacao cadastral
   - data da ultima atualizacao
   - data limite para nova atualizacao
   - dados de identificacao do responsavel pela unidade familiar
   - dados da familia e de seus membros
3. A pagina de solicitacao de base identificada informa que a base do CadUnico contem dados de **pessoas e familias**, incluindo:
   - nome
   - documentos pessoais
   - endereco
   - NIS
   - codigo da familia
   - filiacao
   - informacoes georreferenciadas do domicilio
4. A pagina institucional do Cadastro Unico no MDS confirma o escopo conceitual da base, citando que o governo registra:
   - endereco
   - caracteristicas do domicilio
   - quem faz parte da familia
   - identificacao de cada pessoa
   - escolaridade
   - situacao de trabalho e renda
   - deficiencia
5. **Nao foi encontrada na internet aberta uma documentacao publica do esquema fisico das tabelas `TB_FAMILIA` e `TB_PESSOA`** com lista oficial de colunas, tipos SQL, chaves primarias e chaves estrangeiras.
6. Tambem nao foi encontrada evidencia publica suficiente de que os nomes fisicos `TB_FAMILIA` e `TB_PESSOA` sejam exatamente os nomes das tabelas operacionais do banco do CadUnico; esses nomes sao plausiveis, mas nao puderam ser confirmados oficialmente neste teste.

## Estrutura de dados inferida (hipotese conceitual)

Conclusao parcial: a internet aberta permite inferir com boa confianca o **modelo conceitual familia-pessoa**, mas nao permite cravar o **modelo relacional fisico** das tabelas `TB_FAMILIA` e `TB_PESSOA`.

### Tabela hipotetica `TB_FAMILIA`
Observacao: estrutura abaixo e uma hipotese de trabalho baseada nas fontes publicas, nao o dicionario oficial do banco.

| campo_hipotetico | descricao_curta | tipo_sql_sugerido | fundamento |
|---|---|---|---|
| co_familia | codigo da familia | varchar(20) | pagina oficial cita explicitamente "codigo familiar" |
| co_pessoa_responsavel | identificador da pessoa responsavel | varchar(20) | pagina oficial cita "responsavel pela unidade familiar" |
| situacao_cadastral | situacao do cadastro da familia | varchar(30) | consulta oficial cita situacao cadastral |
| dt_ultima_atualizacao | data da ultima atualizacao cadastral | date | consulta oficial cita essa data |
| dt_limite_atualizacao | prazo para nova atualizacao | date | consulta oficial cita essa data |
| endereco_logradouro | logradouro da familia | varchar(200) | base oficial menciona endereco |
| endereco_numero | numero do domicilio | varchar(20) | inferencia natural do bloco endereco |
| endereco_bairro | bairro | varchar(100) | inferencia natural do bloco endereco |
| endereco_municipio | municipio de cadastro | varchar(100) | consulta oficial pede UF/municipio para localizar cadastro |
| endereco_uf | UF do cadastro | char(2) | consulta oficial pede UF |
| cep | CEP do domicilio | varchar(8) | inferencia natural do bloco endereco |
| geolocalizacao | informacao georreferenciada do domicilio | varchar(100) ou geometry | pagina de cessao menciona georreferenciamento |
| renda_familiar | renda total da familia | decimal(18,2) | pagina institucional menciona renda |
| qtd_membros | quantidade de pessoas da familia | int | inferencia do relacionamento familia-pessoa |
| tipo_domicilio | caracteristica do domicilio | varchar(100) | pagina institucional menciona caracteristicas do domicilio |

### Tabela hipotetica `TB_PESSOA`
Observacao: estrutura abaixo tambem e hipotetica.

| campo_hipotetico | descricao_curta | tipo_sql_sugerido | fundamento |
|---|---|---|---|
| co_pessoa | identificador da pessoa | varchar(20) | necessario para granularidade pessoa |
| co_familia | codigo da familia | varchar(20) | pagina oficial menciona familia e seus membros |
| nis | numero de identificacao social | varchar(20) | pagina oficial cita NIS |
| nome_pessoa | nome completo | varchar(200) | pagina de cessao cita nome |
| nome_mae | filiacao materna | varchar(200) | consulta oficial usa nome da mae para localizar cadastro |
| dt_nascimento | data de nascimento | date | consulta oficial usa data de nascimento |
| cpf | CPF/documento | varchar(14) | pagina de cessao cita documentos pessoais |
| parentesco_rf | parentesco com o responsavel familiar | varchar(50) | inferencia natural do bloco familiar |
| flag_responsavel_familiar | indica se e o responsavel da familia | bit | pagina oficial cita responsavel pela unidade familiar |
| escolaridade | nivel de escolaridade | varchar(100) | pagina institucional menciona escolaridade |
| situacao_trabalho | ocupacao/situacao de trabalho | varchar(100) | pagina institucional menciona situacao de trabalho |
| renda_pessoa | renda individual | decimal(18,2) | pagina institucional menciona renda |
| possui_deficiencia | indicador de deficiencia | bit | pagina institucional menciona deficiencia |
| sexo | sexo/genero cadastral | varchar(20) | inferencia padrao de cadastro de pessoa |
| municipio_nascimento | municipio de nascimento | varchar(100) | hipotese comum de cadastro individual |

## Chaves e relacionamentos (hipotese)
- PK de `TB_FAMILIA`: `co_familia`
- PK de `TB_PESSOA`: `co_pessoa` ou `nis`
- FK principal: `TB_PESSOA.co_familia -> TB_FAMILIA.co_familia`
- Cardinalidade esperada: uma familia para muitas pessoas
- Restricao de negocio esperada: exatamente uma pessoa marcada como responsavel familiar por familia

## O que da para afirmar com seguranca
1. O CadUnico possui ao menos duas entidades logicas centrais: **familia** e **pessoa/membro**.
2. Existe um identificador de familia (**codigo familiar**) e um identificador individual relevante (**NIS**).
3. A familia possui bloco de endereco e situacao cadastral.
4. A pessoa possui bloco de identificacao e atributos socioeconomicos.
5. A consulta oficial e orientada por dados da pessoa, mas retorna dados da familia e dos membros.

## O que nao foi possivel confirmar somente com internet aberta
1. Lista oficial de colunas de `TB_FAMILIA`.
2. Lista oficial de colunas de `TB_PESSOA`.
3. Tipos SQL reais.
4. Chaves primarias reais.
5. Chaves estrangeiras reais.
6. Nomes fisicos reais das tabelas no banco operacional.
7. Regras de nulabilidade, defaults e indices.
8. Tabelas de dominio relacionadas e seus codigos oficiais.

## Proposta de outputs (i-iv) possiveis nesta fase
Mesmo sem metadata do banco, e possivel produzir artefatos **hipoteticos** com marcacao explicita de nivel de confianca:

1. Dicionario de dados preliminar
- Conteudo: campos inferidos para familia e pessoa, com coluna `status = hipotese`.

2. Modelo ER preliminar
- Conteudo: entidade `TB_FAMILIA` ligada a `TB_PESSOA` por `co_familia`.

3. JSON Schema preliminar
- Conteudo: schema conceitual de familia e pessoa, sem pretensao de aderencia total ao banco real.

4. Regras e dominios preliminares
- Conteudo: regras de integridade esperadas, como uma pessoa responsavel por familia e relacionamento 1:N.

5. Scripts SQL genericos
- Conteudo: placeholders para profiling e integridade, dependentes dos nomes reais de colunas.

## Conclusao objetiva
**Nao e possivel finalizar com rigor tecnico a analise estrutural das tabelas `TB_FAMILIA` e `TB_PESSOA` usando somente a internet aberta.**

O que a pesquisa permite fechar:
- modelo conceitual familia-pessoa
- hipoteses razoaveis de campos principais
- relacionamento esperado entre as entidades
- blocos tematicos de dados (identificacao, domicilio, renda, escolaridade, trabalho, membros)

O que a pesquisa nao permite fechar:
- dicionario de dados real
- esquema SQL real
- PK/FK reais
- dominios codificados reais
- artefatos tecnicos com confianca suficiente para documentacao definitiva

## Recomendacao objetiva para a proxima fase
Para transformar as hipoteses em documentacao tecnica confiavel, sera necessario ao menos um destes caminhos:
1. acesso aos metadados reais do banco (`sys.columns`, `sys.types`, `sys.foreign_keys`);
2. acesso a manual operacional autenticado com lista de campos do sistema;
3. acesso a extracao anonima de amostra ou dicionario oficial do CadUnico.

Sem isso, os entregaveis possiveis nesta fase devem ser tratados como **prototipos conceituais**, nao como documentacao confirmada do banco.
