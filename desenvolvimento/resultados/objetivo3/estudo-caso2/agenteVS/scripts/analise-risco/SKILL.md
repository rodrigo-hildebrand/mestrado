---
name: analise-risco
description: Receba uma politica publica ou um comando que envolva uma politica publica, reutilize os normativos ja gerados pela skill busca-legislacao e produza analise inicial de riscos, avaliacao por DVR e matriz de risco no padrao do TCU. Use esta skill sempre que o usuario pedir analise de risco, matriz de risco, riscos gerais e especificos, riscos de auditoria, DVR, ou priorizacao de riscos de uma politica publica, beneficio, programa, processo de concessao, controle ou execucao governamental.
compatibility: Any
---

# Analise de Risco

Execute a analise sem usar Python nas fases analiticas.
Nao crie fallback heuristico para suprir ausencia de base normativa: se os textos da politica ainda nao existirem em `skills/busca-legislacao/references/generated/`, devolva pedido explicito para o agente orquestrador rodar primeiro a skill `busca-legislacao`.

## Objetivo

Produzir uma analise inicial de riscos de politica publica com foco em:

1. consolidacao da base normativa ja levantada pela `busca-legislacao`;
2. resumo dos dispositivos relevantes para elegibilidade, concessao, manutencao, pagamento, controles, monitoramento e sancoes;
3. identificacao de riscos gerais e riscos especificos;
4. avaliacao dos riscos pelo Diagrama de Verificacao de Risco (DVR), no padrao metodologico do TCU;
5. construcao de matriz de risco pronta para uso em auditoria.

## Entradas

Aceite um objeto JSON com qualquer combinacao destes campos:

```json
{
  "politica_publica": "Seguro defeso",
  "comando": "Analise os riscos da politica de seguro defeso",
  "max_results": 8
}
```

Campos aceitos:

- `politica_publica` (preferencial)
- `comando` (alias quando o pedido vier em linguagem natural)
- `query` (alias)
- `max_results` (opcional, padrao: 8, minimo: 3, maximo: 20)

Se a entrada vier apenas em linguagem natural, extraia dela a politica publica principal.

## Dependencia obrigatoria

Antes de analisar risco, procure os artefatos da skill `busca-legislacao` em:

- `skills/busca-legislacao/references/generated/<slug-da-politica>/resultado-execucao.json`
- `skills/busca-legislacao/references/generated/<slug-da-politica>/*.txt`
- `skills/busca-legislacao/references/common/cf/cf88.txt`

Se esses arquivos nao existirem para a politica pedida:

- interrompa a analise;
- nao invente normativos;
- devolva status `dependencia_busca_legislacao`;
- informe claramente que o agente orquestrador deve rodar a skill `busca-legislacao` para a politica solicitada.

## Saida esperada

Retorne um JSON com:

- `consulta`
- `status`
- `resumo_executivo`
- `normativos_utilizados`
- `resumos_normativos`
- `riscos_gerais`
- `riscos_especificos`
- `avaliacao_dvr`
- `matriz_risco`
- `referencias_metodologicas`
- `lacunas`

## Fluxo de execucao

### 1) Localizar a base normativa da politica

- Gere um `slug` simples da politica publica a partir do nome informado.
- Procure primeiro o diretoria exata em `skills/busca-legislacao/references/generated/<slug>/`.
- Se nao houver correspondencia exata, procure nomes proximos apenas dentro desse diretorio `generated/`.
- Use como conjunto base:
  - `resultado-execucao.json` da politica;
  - arquivos `.txt` gerados pela `busca-legislacao`;
  - `cf88.txt` como referencia constitucional comum.

### 2) Resumir os normativos

Para cada normativo utilizado:

- extraia apenas o que for relevante para a analise de risco da politica;
- destaque criterios de elegibilidade, documentos exigidos, responsabilidades, fluxos, validacoes, controles, vedacoes, sancoes, cruzamentos cadastrais, hipoteses de suspensao, cancelamento ou glosa;
- mantenha referencia rastreavel ao normativo e, quando possivel, ao artigo, paragrafo, inciso ou dispositivo.

Formato minimo por item em `resumos_normativos`:

```json
{
  "normativo": "Lei 10.779/2003",
  "dispositivos_relevantes": [
    "art. 1o: define o beneficio e o publico-alvo",
    "art. 2o, § 2o, II: exige comprovacao documental especifica"
  ],
  "implicacoes_de_risco": [
    "risco de concessao a beneficiario sem requisito documental",
    "risco de falha no controle de elegibilidade"
  ]
}
```

### 3) Levantar riscos gerais

Os riscos gerais devem funcionar como categorias de agregacao analitica, por exemplo:

- elegibilidade e habilitacao
- cadastramento e identificacao do beneficiario
- comprovacao documental
- integridade cadastral e cruzamentos
- processamento, concessao e manutencao
- pagamento e acumulacao indevida
- conformidade normativa
- controles internos e monitoramento
- fraude e abuso
- governanca, supervisao e transparência

Cada risco geral deve conter:

- `id_risco_geral`
- `titulo`
- `descricao`
- `categoria`
- `fundamento_resumido`

### 4) Levantar riscos especificos

Os riscos especificos sao a saida mais importante do processo.
Eles devem ser concretos, auditaveis e vinculados a normativos, processos e criterios da politica.

Regras obrigatorias:

- vincule cada risco especifico a um risco geral;
- cite o normativo principal associado;
- cite dispositivo quando disponivel;
- explicite a falha, o evento de risco e o efeito esperado;
- inclua obrigatoriamente uma camada transversal de riscos, mesmo quando o tema principal for setorial;
- prefira formulacoes no estilo:
  - `Risco de ... devido a ...`;
  - `Risco de concessao indevida por ...`;
  - `Risco de pagamento indevido por ...`;
  - `Risco de nao conformidade com ... por falha em ...`.

Priorize riscos especificos semelhantes a estes padroes quando forem aderentes ao tema:

- risco de pagamento indevido a titular falecido;
- risco de pagamento indevido por requisito de elegibilidade nao comprovado;
- risco de pagamento indevido por documentacao insuficiente ou inconsistente;
- risco de concessao sem validacao de criterio normativo expresso;
- risco de manutencao indevida de beneficio por ausencia de revisao periodica;
- risco de fraude documental;
- risco de falha em cruzamento cadastral ou biometrico;
- risco de acumulacao indevida de beneficios inacumulaveis;
- risco de inconformidade com dispositivo legal especifico.

Camada transversal obrigatoria (minimo):

- no minimo 3 riscos especificos transversais por analise, vinculados a controles cadastrais, documentais e de manutencao de pagamento;
- avaliar explicitamente, quando aplicavel ao caso e aos normativos disponiveis:
  - identificacao invalida do titular (ex.: CPF nulo, cancelado, suspenso, duplicado ou inconsistente entre bases);
  - pagamento ou manutencao de beneficio apos obito do titular;
  - documentacao de identidade, vinculo, contribuicao ou elegibilidade inconsistente, falsa ou insuficiente;
  - acumulacao indevida com beneficios inacumulaveis.

Se algum item transversal nao for aplicavel por ausencia de previsao normativa na base da politica:

- registre essa limitacao em `lacunas` com justificativa objetiva;
- nao invente dispositivo normativo.

Cada item de `riscos_especificos` deve conter:

```json
{
  "id_risco_especifico": "RE-01",
  "id_risco_geral": "RG-01",
  "titulo": "Risco de concessao indevida por ausencia de comprovacao documental minima",
  "descricao": "Ocorre quando o processo admite beneficio sem validacao dos documentos exigidos pelo normativo.",
  "causa": "Falha no fluxo de habilitacao e na verificacao documental.",
  "efeito": "Pagamento indevido, dano ao erario e descumprimento normativo.",
  "normativos_base": [
    "Lei 10.779/2003",
    "Decreto 8.424/2015"
  ],
  "dispositivos": [
    "Lei 10.779/2003, art. 2o, § 2o",
    "Decreto 8.424/2015, art. 2o"
  ],
  "evidencia_normativa": "Os normativos exigem validacoes e documentos especificos para habilitacao.",
  "tipo": "especifico"
}
```

### 5) Avaliar riscos no modelo DVR do TCU

Avalie cada risco especifico conforme probabilidade e impacto.
Use escala ordinal simples e explicita:

- `probabilidade`: baixa, media, alta
- `impacto`: baixo, medio, alto

Defina o `quadrante_dvr` a partir da combinacao de probabilidade e impacto.
Use a seguinte logica operacional:

- `baixo` quando probabilidade e impacto forem baixos;
- `moderado` quando houver combinacao baixa/media sem predominio critico;
- `alto` quando um dos fatores for alto e o outro ao menos medio;
- `critico` quando probabilidade e impacto forem altos.

Nao substitua a avaliacao por heuristica solta: justifique cada classificacao com base na sensibilidade do processo, impacto potencial e aderencia aos controles previstos nos normativos.

Cada item em `avaliacao_dvr` deve conter:

- `id_risco_especifico`
- `probabilidade`
- `impacto`
- `quadrante_dvr`
- `justificativa`

### 6) Construir a matriz de risco

Gere `matriz_risco` como lista ordenada por criticidade decrescente.

Cada linha da matriz deve conter:

- `ordem_prioridade`
- `id_risco_especifico`
- `risco`
- `categoria`
- `normativo_chave`
- `probabilidade`
- `impacto`
- `quadrante_dvr`
- `controle_esperado`
- `teste_de_auditoria_sugerido`

Regra adicional da matriz:

- assegure que os riscos transversais obrigatorios aparecam explicitamente na `matriz_risco`, com controle esperado e teste de auditoria correspondente.

O campo `teste_de_auditoria_sugerido` deve ser objetivo e acionavel, por exemplo:

- conferir aderencia documental em amostra de processos;
- cruzar CPF com base de obitos;
- verificar acumulacao com outros beneficios;
- reprocessar criterios de elegibilidade em base selecionada;
- confirmar correspondencia entre dispositivo legal e regra implementada.

### 7) Registrar lacunas e limites

- Se algum risco relevante depender de normativo nao localizado, registre em `lacunas`.
- Se a base normativa estiver incompleta, use `status: concluido_com_lacuna`.
- Se a dependencia `busca-legislacao` estiver ausente, use `status: dependencia_busca_legislacao`.
- Se a base estiver suficiente, use `status: concluido`.

## Regras de qualidade

- Nao usar Python nas fases analiticas.
- Nao inventar normativos, dispositivos ou controles.
- Nao criar fallback heuristico para esconder ausencia de base normativa.
- Pode usar heuristica apenas para organizar, agrupar e priorizar riscos a partir da base existente.
- Priorize riscos especificos sobre listas genericas.
- Sempre vincule risco especifico a fundamento normativo e a um risco geral.
- Use a metodologia do TCU como referencia principal de estruturacao analitica.

## Referencias metodologicas locais

Consulte, quando necessario:

- `references/metodologia/manual-auditoria-operacional-tcu.txt`
- `references/metodologia/swot-dvr-auditoria.txt`
- `references/README.md`

## Estrutura desta skill

- Instrucao principal: `SKILL.md`
- Referencias metodologicas: `references/metodologia/`
- Guia de referencias: `references/README.md`
- Casos de teste: `evals/evals.json`
