---
name: analise-swot2
description: Receba apenas uma politica publica e produza uma matriz SWOT priorizada, com ate 10 itens por quadrante, sem usar Python na analise e sem consumir dados de analise-risco. Use esta skill quando o usuario pedir uma versao mais objetiva e priorizada da SWOT para apoio a decisao ou auditoria.
compatibility: Any
---

# Analise SWOT 2

Execute a analise sem usar Python.
Nao devolva respostas genéricas ou inventadas.
Baseie a saida no entendimento direto da politica publica informada, sem consumir analise-risco ou outras entradas auxiliares.

## Propósito

Produzir uma matriz SWOT priorizada para uma politica publica, distinguindo:

- **Forcas** (Strengths): as características positivas internas que uma organização pode explorar para atingir as suas metas. Referem-se às habilidades, capacidades e competências básicas da organização que atuam em conjunto para ajudá-la a alcançar suas metas e objetivos. Ex.: equipe experiente e motivada, recursos tecnológicos adequados
- **Fraquezas** (Weaknesses): falhas, lacunas e vulnerabilidades internas identificadas nos riscos.  As características negativas internas que podem inibir ou restringir o desempenho da
organização. Referem-se à ausência de capacidades e/ou habilidades críticas. São, portanto, deficiências e características que devem ser superadas ou contornadas para que a organização possa alcançar o nível de desempenho desejado. Ex.: alta rotatividade de pessoal, sistemas de informação obsoletos, processos internos excessivamente burocratizados. 
- **Oportunidades** (Opportunities): Características do ambiente externo, não controláveis
pela organização, com potencial para ajudá-la a crescer e atingir ou exceder as metas planejadas. Ex.: diretrizes governamentais favoráveis ao fortalecimento institucional, novas fontes orçamentárias, parcerias com outras instituições.
.
- **Ameacas** (Threats): Características do ambiente externo, não controláveis pela organização, que podem impedi-la de atingir as metas planejadas e comprometer o crescimento
organizacional. Ex.: dispersão geográfica do públicoalvo, disparidades regionais, conflito de competência.

## Regra conceitual

- **Forcas** e **Fraquezas** pertencem ao ambiente interno.
- **Oportunidades** e **Ameacas** pertencem ao ambiente externo.
- O microambiente pode envolver beneficiarios, fornecedores, operadores, bases de dados e programas semelhantes.
- O macroambiente pode envolver fatores economicos, demograficos, politicos, culturais, tecnologicos, legais, ecologicos e sociais.
- Se a entrada nao trouxer evidencia suficiente para um item, nao invente o item.

## Entradas

Aceite os campos abaixo:

```json
{
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso"
}
```

Campos aceitos:

- `politica_publica` obrigatorio
- `politica_slug` recomendado

## Regras de construcao da matriz SWOT

Cada quadrante deve conter **ate 10 itens**, ordenados do mais relevante para o menos relevante.

### Criterios de relevancia

Priorize itens com maior evidência e maior impacto na decisao:

1. maior aderencia direta ao objetivo da politica
2. maior severidade do risco (critico, alto, moderado)
3. maior abrangencia ou recorrencia
4. maior efeito sobre elegibilidade, manutencao, pagamento, controle ou integridade
5. maior capacidade de orientar a acao de auditoria ou melhoria

Se houver empate, mantenha o item com maior rastreabilidade normativa ou maior explicitude na fonte.

## Fontes permitidas por quadrante

### Forcas

Exemplos de forcas aceitaveis:

- Corpo técnico altamente qualificado.
- Domínio dos processos de controle.
- Infraestrutura de TI moderna.

### Fraquezas

Exemplos de fraquezas aceitaveis:
- Sistemas legados defasados.
- Burocracia excessiva em fluxos de trabalho.
- Resistência cultural a mudanças.
- Falta de integração entre bases de dados.

### Oportunidades

Exemplos de oportunidades aceitaveis:
- Diretrizes governamentais favoráveis ao fortalecimento institucional.
- Avanço do governo eletrônico (Gov.br).
- Demanda social por maior transparência.
- Parcerias com instituições internacionais.

### Ameacas

Exemplos de ameacas aceitaveis:
- Dispersão geográfica do público-alvo.
- Disparidades regionais.
- Conflito de competência entre órgãos.
- Restrições orçamentárias severas.
- Rotatividade alta de pessoal qualificado.
- Mudanças frequentes na legislação.

## Regras de execução

### Etapa 1 – Montar as forcas

- Extrair os itens favoraveis mais relevantes.
- Ordenar por centralidade legal e utilidade para a governanca da politica.
- Limitar a 10 itens.

### Etapa 2 – Montar as fraquezas

- Extrair fragilidades internas mais importantes da própria política, do desenho de execução e dos seus fluxos típicos.
- Agrupar itens equivalentes e remover duplicidades.
- Limitar a 10 itens.

### Etapa 3 – Montar as oportunidades

- Extrair avenidas de melhoria e reforços institucionais coerentes com a política analisada.
- Priorizar os itens com maior potencial de melhoria e maior impacto preventivo.
- Limitar a 10 itens.

### Etapa 4 – Montar as ameacas

- Ordenar primeiro os criticos, depois os altos.
- Limitar a 10 itens.

### Etapa 5 – Consolidar e salvar

- Montar JSON final com os quatro quadrantes.
- Salvar em `references/generated/<politica-slug>/analise_swot2.json`.

## Formato de saida

```json
{
  "status": "ok",
  "politica_publica": "Seguro defeso",
  "politica_slug": "seguro-defeso",
  "analise_timestamp": "2026-05-15T14:00:00Z",
  "forcas": [
    {
      "rank": 1,
      "item": "Marco legal central consolidado pela Lei 10.779/2003."
    }
  ],
  "fraquezas": [
    {
      "rank": 1,
      "item": "Validacao insuficiente do relatorio anual de exercicio da atividade pesqueira."
    }
  ],
  "oportunidades": [
    {
      "rank": 1,
      "item": "Validacao automatizada do RGP ativo com bloqueio sistemico."
    }
  ],
  "ameacas": [
    {
      "rank": 1,
      "item": "Concessao indevida sem evidencia suficiente de exercicio ininterrupto da atividade pesqueira."
    }
  ],
  "lacunas": []
}
```

## Status possiveis

- `ok`: os quatro quadrantes foram preenchidos sem lacunas relevantes.
- `ok_com_lacunas`: ha dados para a analise, mas algum quadrante ficou com menos de 10 itens por falta de evidencias.

## Regras de qualidade

- Nao usar Python na analise.
- Nao devolver narrativas vagas ou genéricas.
- Nao criar itens sem aderencia clara a politica informada.
- Cada item deve ser autoexplicativo e coerente com o contexto da politica.
- Se houver menos de 10 itens em um quadrante, isso e aceitavel quando a fonte nao trouxer mais evidencias.
- Se um quadrante nao puder ser preenchido, registrar em `lacunas`.
- Salvar sempre o JSON final.
