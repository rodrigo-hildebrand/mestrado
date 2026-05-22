# README — Agente de Fiscalização Contínua (Copilot Studio)

## 📋 Visão Geral

Este **agente de IA conversacional** (implementado em Copilot Studio com arquitetura ReWOO + RAG) foi desenvolvido para apoiar auditores, coordenadores e especialistas em dados na **Fiscalização Contínua** — auditoria baseada em dados com ênfase em conformidade, risco e detecção de fraude.

O agente **sugere**, **documenta** e **estrutura** investigações, mas **nunca decide** ou **homologa** achados. Toda saída é provisória e para revisão humana.

---

## Instruções

Você é um agente de apoio à Fiscalização Contínua (auditoria baseada em dados).

Limites obrigatórios:
- Você NÃO substitui julgamento profissional humano.
- Você NÃO homologa achados, NÃO emite decisões jurídicas e NÃO responsabiliza agentes.
- Você apenas sugere riscos, tipologias, alertas e testes, sempre para revisão humana.

Governança e rastreabilidade:
- Toda sugestão deve indicar fontes (normativos, jurisprudência, relatórios, dicionários de dados).
- Não invente normas, campos ou jurisprudência.
- Se faltar informação, sinalize a lacuna, sugira alternativa e classifique o impacto na confiança.
- Trate dados como sensíveis, priorizando agregação, anonimização e controle de acesso.

Forma de resposta:
- Sempre estruturar a saída em artefatos de auditoria (matriz de riscos, tipologias, testes).
- Sempre incluir seções “Fontes” e “Assunções”.

---

## Tópico 1 — Planejar Investigação (ReWOO / Plan)

kind: AdaptiveDialog
beginDialog:
  kind: OnRecognizedIntent
  id: main
  intent:
    triggerQueries:
      - planejar investigação
      - como planejar uma investigação
      - ajude a planejar uma investigação
      - quero iniciar um plano de investigação
      - preciso de um plano para investigar
      - planejamento de investigação ReWOO
      - criar plano investigativo ReWOO
      - elaborar estratégia de investigação
      - começar planejamento investigativo

  actions:
    - kind: SendActivity
      id: SendActivity_TCq0ME
      activity: |-
        ETAPA 1 — PLANO DE INVESTIGAÇÃO (ReWOO)

        Vou montar um plano em 4 blocos:
        A) Riscos candidatos (hipóteses) — alinhados ao tema
        B) Critérios normativos/jurisprudenciais a buscar (com filtros)
        C) Bases/dados necessários por risco (campos, chaves, qualidade)
        D) Testes potenciais (tipo: regra, anomalia, consistência, cobertura) e prioridade

        Saída desta etapa:
        - Lista priorizada de riscos + justificativa
        - Lista de consultas de busca documental (normativos/jurisprudência/relatórios)
        - Checklist de dados/campos a validar no dicionário
        - Pontos de lacuna e proxies possíveis (com impacto na confiança)

        Fontes: (a preencher após buscas)
        Assunções: (registrar explicitamente)

inputType: {}
outputType: {}

## Tópico 2 — Executar Recuperação (RAG/Busca) (ReWOO / Execute – ferramentas)

kind: AdaptiveDialog
beginDialog:
  kind: OnRecognizedIntent
  id: main
  intent:
    triggerQueries:
      - executar recuperação
      - iniciar busca RAG
      - usar ferramenta ReWOO
      - executar RAG
      - buscar com ReWOO
      - recuperação de informações
      - ferramentas de busca avançada
      - ativar recuperação de dados
      - executar busca com ferramentas

  actions:
    - kind: SendActivity
      id: SendActivity_1ryALM
      activity: |-
        Bem-vindo à ETAPA 2 — RECUPERAÇÃO DE EVIDÊNCIAS.

        Nesta etapa, você poderá:
        1) Buscar em normativos (retornar trechos citáveis + IDs)
        2) Buscar em jurisprudência (ementas/trechos + IDs)
        3) Recuperar relatórios prévios (trechos + IDs)
        4) Consultar ao dicionário/catálogo de dados (campos, tipos, chaves)

        Regras:
        - Não retornar dados pessoais brutos.
        - Se houver conflito entre fontes, registrar conflito e sugerir checagem humana.
        - Se faltar base/campo, propor proxy/amostragem/ofício e marcar impacto na confiança.

    - kind: Question
      id: Question_rCw4lB
      variable: Topic.Risco
      prompt: Qual risco você deseja investigar?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_5RQTSF
      variable: Topic.BuscaNormativos
      prompt: Deseja buscar em normativos? (Sim/Não)
      entity: BooleanPrebuiltEntity

    - kind: ConditionGroup
      id: ConditionGroup_aVSOvA
      conditions:
        - id: ConditionItem_97cpaR
          condition: =Topic.BuscaNormativos = true
          actions:
            - kind: Question
              id: Question_hVQppY
              variable: Topic.NormativoID
              prompt: Informe o ID do normativo ou palavra-chave para busca.
              entity: StringPrebuiltEntity

    - kind: Question
      id: Question_pYT3X8
      variable: Topic.BuscaJurisprudencia
      prompt: Deseja buscar em jurisprudência? (Sim/Não)
      entity: BooleanPrebuiltEntity

    - kind: ConditionGroup
      id: ConditionGroup_WLCZBO
      conditions:
        - id: ConditionItem_IrIDUi
          condition: =Topic.BuscaJurisprudencia = true
          actions:
            - kind: Question
              id: Question_6hmaWC
              variable: Topic.JurisprudenciaID
              prompt: Informe o ID da jurisprudência ou palavra-chave para busca.
              entity: StringPrebuiltEntity

    - kind: Question
      id: Question_uBmeeP
      variable: Topic.RecuperarRelatorios
      prompt: Deseja recuperar relatórios prévios? (Sim/Não)
      entity: BooleanPrebuiltEntity

    - kind: ConditionGroup
      id: ConditionGroup_wikZht
      conditions:
        - id: ConditionItem_vn8SsH
          condition: =Topic.RecuperarRelatorios = true
          actions:
            - kind: Question
              id: Question_tqgQo3
              variable: Topic.RelatorioID
              prompt: Informe o ID do relatório ou palavra-chave para busca.
              entity: StringPrebuiltEntity

    - kind: Question
      id: Question_IXAt2j
      variable: Topic.ConsultaCatalogo
      prompt: Deseja consultar ao dicionário/catálogo de dados? (Sim/Não)
      entity: BooleanPrebuiltEntity

    - kind: ConditionGroup
      id: ConditionGroup_g2CORr
      conditions:
        - id: ConditionItem_WbDWrq
          condition: =Topic.ConsultaCatalogo = true
          actions:
            - kind: Question
              id: Question_8PXFJV
              variable: Topic.CampoCatalogo
              prompt: Informe o campo, tipo ou chave para consulta.
              entity: StringPrebuiltEntity

    - kind: SendActivity
      id: SendActivity_kDc4nc
      activity: |-
        Ao final, você receberá:
        - Pacote de Evidências (IDs + trechos) por risco
        - Mapa Norma ↔ Risco com citações
        - Mapa Dado ↔ Risco com campos necessários

        Lembre-se: Se houver conflito entre fontes, será registrado e sugerida checagem humana. Se faltar base/campo, será proposto proxy/amostragem/ofício e marcado impacto na confiança.

inputType: {}
outputType: {}

## Tópico 3 — Gerar Matriz de Riscos + Tipologias/Alertas (ReWOO / Synthesize)

kind: AdaptiveDialog
beginDialog:
  kind: OnRecognizedIntent
  id: main
  intent:
    triggerQueries:
      - gerar matriz de riscos
      - criar matriz de riscos
      - matriz de riscos e tipologias
      - sintetizar alertas de risco
      - analisar tipologias ReWOO
      - synthesize risk matrix
      - alertas ReWOO e Synthesize
      - tipologias e alertas de risco
      - como gerar matriz de riscos com ReWOO
      - matriz de riscos com Synthesize

  actions:
    - kind: Question
      id: Question_YORyj6
      variable: Topic.RiskID
      prompt: Por favor, informe o ID do risco.
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_sL9Fl4
      variable: Topic.RiskDescription
      prompt: Descreva o risco.
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_gmmarq
      variable: Topic.CriticidadeProbabilidadeImpacto
      prompt: Qual a criticidade, probabilidade e impacto do risco? Justifique cada um.
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_TofOs4
      variable: Topic.CriterioNormativo
      prompt: "Informe o critério normativo (citação: ID + trecho)."
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_Q9Dq9F
      variable: Topic.Evidencias
      prompt: Quais são as evidências (IDs)?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_SvNjxH
      variable: Topic.BasesCamposNecessarios
      prompt: Quais bases e campos são necessários?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_CCynlz
      variable: Topic.Testabilidade
      prompt: O risco é testável? (sim/não) Justifique.
      entity: BooleanPrebuiltEntity

    - kind: Question
      id: Question_zL6qlR
      variable: Topic.TipoTeste
      prompt: Qual tipo de teste sugerido?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_EN9oZ9
      variable: Topic.ComplexidadeLimitacoes
      prompt: Informe a complexidade e limitações.
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_eJfWij
      variable: Topic.SugestaoAmostra
      prompt: Sugira uma amostra para verificação humana.
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_3BL3x0
      variable: Topic.Prioridade
      prompt: Qual a prioridade do risco?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_r6zfXp
      variable: Topic.Fontes
      prompt: Quais são as fontes utilizadas?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_1pCpZh
      variable: Topic.Assuncoes
      prompt: Quais são as assunções consideradas?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_8kYwmw
      variable: Topic.TipologiaNomeDefinicao
      prompt: Informe o nome e definição operacional da tipologia/alerta.
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_GnWOFo
      variable: Topic.RegraLogica
      prompt: Descreva a regra lógica (em linguagem clara).
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_lqeOuk
      variable: Topic.CamposThresholds
      prompt: Quais campos necessários e thresholds?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_o5XG9o
      variable: Topic.JustificativaNormativa
      prompt: Justificativa normativa (citações).
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_cj0Uwt
      variable: Topic.FalsoPositivoMitigacao
      prompt: Qual o falso-positivo esperado e como será mitigado?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_6zt8Y7
      variable: Topic.MonitoramentoIndicadores
      prompt: Como será feito o monitoramento e quais indicadores de qualidade de dados serão utilizados?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_LGYZxK
      variable: Topic.TipologiaFontes
      prompt: Quais são as fontes utilizadas para tipologias/alertas?
      entity: StringPrebuiltEntity

    - kind: Question
      id: Question_ed1K3r
      variable: Topic.TipologiaAssuncoes
      prompt: Quais são as assunções consideradas para tipologias/alertas?
      entity: StringPrebuiltEntity

    - kind: SendActivity
      id: SendActivity_Kn5cBe
      activity: |-
        Resumo dos artefatos:

        Matriz de Riscos:
        - ID: {Topic.RiskID}
        - Descrição: {Topic.RiskDescription}
        - Criticidade/Probabilidade/Impacto: {Topic.CriticidadeProbabilidadeImpacto}
        - Critério normativo: {Topic.CriterioNormativo}
        - Evidências: {Topic.Evidencias}
        - Bases e campos necessários: {Topic.BasesCamposNecessarios}
        - Testabilidade: {Topic.Testabilidade}
        - Tipo de teste sugerido: {Topic.TipoTeste}
        - Complexidade e limitações: {Topic.ComplexidadeLimitacoes}
        - Sugestão de amostra: {Topic.SugestaoAmostra}
        - Prioridade: {Topic.Prioridade}
        - Fontes: {Topic.Fontes}
        - Assunções: {Topic.Assuncoes}

        Tipologias e Alertas:
        - Nome e definição operacional: {Topic.TipologiaNomeDefinicao}
        - Regra lógica: {Topic.RegraLogica}
        - Campos necessários e thresholds: {Topic.CamposThresholds}
        - Justificativa normativa: {Topic.JustificativaNormativa}
        - Falso-positivo esperado e mitigação: {Topic.FalsoPositivoMitigacao}
        - Monitoramento e indicadores: {Topic.MonitoramentoIndicadores}
        - Fontes: {Topic.TipologiaFontes}
        - Assunções: {Topic.TipologiaAssuncoes}

inputType: {}
outputType: {}

## Tópico 4 — Especificação de Testes + SQL/Python (com safe execution)

kind: AdaptiveDialog
beginDialog:
  kind: OnRecognizedIntent
  id: main
  intent:
    triggerQueries:
      - especificação de testes
      - como testar com SQL e Python
      - executar código seguro em SQL ou Python
      - testes automatizados usando SQL/Python
      - exemplo de safe execution em Python
      - dicas para especificação de testes com SQL
      - testar scripts python com segurança
      - safe execution para consultas SQL
      - como garantir execução segura em testes

  actions:
    - kind: SendActivity
      id: SendActivity_v0wN4h
      activity: |-
        Bem-vindo à etapa 4 — Testes Executáveis.

        Para cada risco testável, você deverá fornecer:
        - Objetivo e hipótese
        - Critério normativo (citações)
        - Dados necessários (bases, campos, chaves)
        - Algoritmo/query propostos
        - Validação e interpretação
        - Riscos de viés e auditoria do teste
        - Limites de segurança (somente agregados; timeouts; filtros; parametrização; aprovação humana)

        Se a execução de SQL estiver habilitada:
        - Proponha a query
        - Sugira limites (ex.: TOP N, agregações, janelas)
        - Registre resultado agregado e ID do artefato (log)

inputType: {}
outputType: {}
