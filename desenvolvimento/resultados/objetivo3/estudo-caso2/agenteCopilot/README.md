# README — Agente de Fiscalização Contínua (Copilot Studio)

## 📋 Visão Geral

Este **agente de IA conversacional** (implementado em Copilot Studio com arquitetura ReWOO + RAG) foi desenvolvido para apoiar auditores, coordenadores e especialistas em dados na **Fiscalização Contínua** — auditoria baseada em dados com ênfase em conformidade, risco e detecção de fraude.

O agente **sugere**, **documenta** e **estrutura** investigações, mas **nunca decide** ou **homologa** achados. Toda saída é provisória e para revisão humana.

---

## 🎯 Propósito

Transformar um prompt em linguagem natural (pergunta do auditor) em um **plano de investigação estruturado, rastreável e executável**, passando por 4 etapas:

1. **Planejar** (Plan) — Hipóteses de risco, critérios normativos, dados necessários, testes propostos
2. **Executar/Recuperar** (Execute) — Busca documental (RAG), cruzamento de bases, validação de campos
3. **Sintetizar** (Synthesize) — Matriz de riscos, tipologias, alertas, com fontes e assunções explícitas
4. **Testar** (Execute - Testes) — Especificações SQL/Python com safe execution, limites de segurança

---

## 🚀 Como Usar

### Entrada (O que você fala ao agente)

Você pode usar linguagem natural e o agente reconhecerá automaticamente qual etapa iniciar:

#### **Etapa 1 — Planejar Investigação**

Diga coisas como:
- `"Planejar investigação sobre desvio de recursos"`
- `"Como planejar uma investigação?"`
- `"Ajude a planejar uma investigação sobre fraude em licitações"`
- `"Preciso de um plano para investigar problemas no Seguro-Defeso"`
- `"Planejamento de investigação ReWOO sobre política pública X"`

**O agente retorna:**
- Lista priorizada de riscos candidatos + justificativas
- Consultas de busca documental propostas (normativos/jurisprudência/relatórios)
- Checklist de dados/campos a validar
- Pontos de lacuna e proxies possíveis (com impacto na confiança)

---

#### **Etapa 2 — Executar Recuperação (Busca Documental)**

Diga coisas como:
- `"Executar recuperação de informações"`
- `"Iniciar busca RAG"`
- `"Usar ferramentas ReWOO"`
- `"Buscar com ReWOO sobre o risco R1"`
- `"Recuperação de informações sobre Lei 8.666"`

**O agente perguntará:**
- Qual risco você deseja investigar?
- Deseja buscar em normativos? (Sim/Não)
- Deseja buscar em jurisprudência? (Sim/Não)
- Deseja recuperar relatórios prévios? (Sim/Não)
- Deseja consultar ao dicionário/catálogo de dados? (Sim/Não)

**O agente retorna:**
- Pacote de evidências (IDs + trechos citáveis)
- Mapa Norma ↔ Risco com citações exatas
- Mapa Dado ↔ Risco com campos necessários
- Registro de conflitos entre fontes (se houver)
- Proposições de proxies/amostragem (se faltarem dados)

---

#### **Etapa 3 — Gerar Matriz de Riscos + Tipologias/Alertas**

Diga coisas como:
- `"Gerar matriz de riscos"`
- `"Criar matriz de riscos e tipologias"`
- `"Sintetizar alertas de risco"`
- `"Analisar tipologias ReWOO"`
- `"Como gerar matriz de riscos com ReWOO?"`

**O agente fará perguntas estruturadas sobre:**
- ID, descrição, criticidade, probabilidade, impacto do risco
- Critério normativo (citação: ID + trecho)
- Evidências (IDs)
- Bases e campos necessários
- Testabilidade (sim/não)
- Tipo de teste sugerido
- Complexidade e limitações
- Sugestão de amostra para verificação humana
- Prioridade
- Nome e definição operacional da tipologia/alerta
- Regra lógica
- Campos necessários e thresholds
- Justificativa normativa
- Falso-positivo esperado e mitigação
- Monitoramento e indicadores de qualidade de dados
- Fontes e assunções

**O agente retorna:**
- **Matriz de Riscos** estruturada (conforme modelo TCU)
- **Tipologias e Alertas** com regras lógicas executáveis
- **Seção Fontes** com todas as citações
- **Seção Assunções** explícitas

---

#### **Etapa 4 — Especificação de Testes (SQL/Python com Safe Execution)**

Diga coisas como:
- `"Especificação de testes"`
- `"Como testar com SQL e Python?"`
- `"Executar código seguro em SQL"`
- `"Testes automatizados usando SQL/Python"`
- `"Safe execution para consultas SQL"`

**O agente descreve:**
- Objetivo e hipótese de cada teste
- Critério normativo (citações)
- Dados necessários (bases, campos, chaves)
- Algoritmo/query propostos (com explicação)
- Validação e interpretação de resultados
- Riscos de viés e auditoria do teste
- **Limites de segurança:**
  - Apenas agregados (sem PII)
  - Timeouts (máx. X segundos)
  - Filtros parametrizados
  - Aprovação humana antes de executar

**O agente retorna:**
- Query SQL ou script Python com documentação
- Explicação do que cada parte faz
- Interpretação esperada de resultados
- Registro de auditoria (log de execução)

---

## 🛡️ Limites Obrigatórios (Governança)

### ❌ O agente NÃO:

1. **Substitui julgamento profissional humano**
   - Sempre indica: "Recomenda-se verificação", "Requer análise adicional"

2. **Homologa achados autonomamente**
   - Nunca valida resultados como "conclusão definitiva"
   - Sempre: "Sugestão para revisão", "Indicador potencial"

3. **Emite decisões jurídicas**
   - Nunca interpreta lei de forma conclusiva
   - Sempre cita fonte normativa e indica: "Consulte assessoria jurídica"

4. **Responsabiliza agentes ou gestores**
   - Não acusa nem culpabiliza
   - Usa linguagem neutra: "Achado indicou", "Teste apontou"

5. **Realiza auditoria final ou certificação**
   - Tudo que produz é sugestão prévia e provisória

### ✅ O agente SIM:

- ✓ Sugere hipóteses de risco e tipologias
- ✓ Propõe alertas automáticos e indicadores
- ✓ Desenha testes (SQL, Python) executáveis
- ✓ Localiza e cita normativos, jurisprudência e achados anteriores
- ✓ Identifica lacunas de dados e propõe alternativas
- ✓ Estrutura artefatos para análise humana
- ✓ Mantém rastreabilidade total
- ✓ Trata dados como sensíveis (agregação, anonimização)

---

## 📚 Rastreabilidade e Fontes

Toda sugestão do agente inclui seção **"Fontes"** contendo:

### Formato de citação obrigatório:

```
[Lei 8.666/1993, art. 3º] "Constitui objeto da licitação a contratação de bens ou serviços..."
[Acórdão nº 1.234/2022 — Plenário] "A dispensa de licitação carece de fundamentação adequada."
[Matriz de Riscos — FC 2023/Órgão X, risco_id=R042] "Achado anterior: divergência em valores."
[Base: SIAFI | Tabela: LiqEmpen | Campo: VL_EMPENHO (Numérico, 15.2)]
```

### Se informação não for encontrada:

O agente diz **explicitamente**:
- "Normativo não localizado na base de conhecimento"
- "Recomenda-se consultar [específico]"
- "Confiança reduzida (falta de 1 fonte)" ou "Crítica (normativo essencial não recuperado)"

---

## 🔐 Privacidade e Segurança

### Princípios obrigatórios:

1. **Nunca retorna PII (Informações Pessoalmente Identificáveis) em bruto**
   - Sem CPF, nome, matrícula, número de processo pessoal
   - Usa ID genérico: "Auditor_001", "Órgão_Zona_Sul"

2. **Prioriza agregação e anonimização**
   - "123 registros com divergência" (não lista individual)
   - "Por UF" ao invés de "por município específico"

3. **Recomenda controles de acesso**
   - "Relatório acesso restrito a auditores credenciados"
   - "Arquivo criptografado; logs de download"

4. **Registra conformidade**
   - "Processamento conforme LGPD, art. X"
   - "Dados mascarados em [data] por [motivo]"

---

## 📊 Estrutura de Resposta (Artefatos)

Toda resposta do agente segue padrão:

### 1. **Resumo** (1-2 parágrafos)
   - O que foi analisado
   - Conclusão provisória

### 2. **Artefato Principal** (Matriz/Tipologia/Teste)
   - Conforme template TCU
   - Campos obrigatórios preenchidos

### 3. **Seção "Fontes"**
   - Normativos com artigo/§
   - Jurisprudência com ID/data
   - Achados anteriores com ID
   - Dicionário de dados com tipo/definição
   - Metadados técnicos

### 4. **Seção "Assunções"**
   - O que foi assumido
   - Limitações
   - Impacto na confiança (Alta/Médio/Baixo)

### 5. **Próximos Passos**
   - Verificação humana
   - Complementação
   - Comunicação/escalação

---

## 🔧 Ferramentas Disponíveis (Tool Calling)

O agente usa as seguintes "ferramentas" de forma controlada:

| Ferramenta | Propósito | Limites |
|-----------|----------|---------|
| `search_normativos()` | Buscar Lei/Decreto/Resolução | Retorna trechos + ID; sem edição |
| `search_jurisprudencia()` | Buscar acórdãos/ementas do TCU | Retorna ementas + ID; sem acórdão integro |
| `retrieve_relatorios()` | Recuperar relatórios de FC anteriores | Retorna trechos + ID; sem dados brutos |
| `get_data_dictionary()` | Consultar dicionário de dados | Retorna: campo, tipo, descrição, chave |
| `sample_data()` | Obter amostra mascarada | Retorna N registros agregados/anonimizados |
| `run_sql()` | Executar query com limites | Timeout, TOP N, sem PII, aprovação humana |
| `generate_sql()` | Gerar query comentada | Retorna SQL + explicação; não executa |
| `generate_python_test()` | Gerar script Python | Retorna código + docstring; não executa |
| `log_artifact()` | Registrar artefato em log | ID de auditoria, timestamp, versão |

---

## 📋 Fluxo Típico de Uma Investigação

### Exemplo: Investigar possíveis desvios em programa de transferência de renda

```
Auditor: "Planejar investigação sobre desvio de recursos no Programa X"
         ↓
ETAPA 1 — PLANO
         ↓
Agente: "Encontrei 5 riscos candidatos:
         - R1: Beneficiários com empresa registrada
         - R2: Acumulação com outro benefício
         - R3: Beneficiário em município inelegível
         - R4: Concentração anômala por UF
         - R5: Documentação falsa
         Recomenda-se buscar normativos para validar critérios."
         ↓
Auditor: "Iniciar busca RAG sobre R1 e R2"
         ↓
ETAPA 2 — EXECUTAR/RECUPERAR
         ↓
Agente: "Buscando em normativos...
         [Lei 10.779/2003, art. 1º] 'Pescador que exerce atividade exclusiva...'
         [Acórdão 2.345/2023] 'Empresa como indicador de múltipla renda.'
         Encontrado: 1 normativo + 2 acórdãos + 3 achados anteriores (2023)
         Campo necessário: CPF (existe em SIAFI ✓), CNPJ_SOCIO (verificar integração)"
         ↓
Auditor: "Gerar matriz de riscos para R1"
         ↓
ETAPA 3 — SINTETIZAR
         ↓
Agente: "Montando matriz...
         R1 | Beneficiário com empresa | Lei 10.779/03, art. 1º | SIAFI/CPF + RFB/CNPJ
         Teste: SQL (cruzamento CPF-CNPJ) | Prioridade: ALTA
         Fontes: Lei 10.779/03, Acórdão 2.345/2023, FC 2023 (risco_id=R1_old)
         Assunção: Integração RFB-SIAFI disponível; se não, usar amostragem manual"
         ↓
Auditor: "Gerar especificação de teste SQL para R1"
         ↓
ETAPA 4 — TESTAR
         ↓
Agente: "Query proposta:
         SELECT b.cpf, b.nome, COUNT(DISTINCT r.cnpj) as qtd_empresas
         FROM beneficiarios b
         JOIN receita_federal r ON b.cpf = r.cpf_socio
         WHERE r.situacao = 'ATIVA'
         GROUP BY b.cpf, b.nome
         HAVING COUNT(*) > 0;
         
         Limites de segurança:
         - Sem PII: mascarar CPF/nome na saída
         - Timeout: 30 segundos
         - TOP 1000 registros por execução
         - Aprovação: 2 auditores antes de executar
         - Log: salvar ID de artefato + timestamp"
         ↓
Auditor: [Executa query com supervisão humana]
         ↓
Agente: "Resultado agregado: 1.234 beneficiários com empresa ativa.
         Impacto estimado: R$ 45 milhões (requer validação).
         Recomenda-se amostra de 100 registros para verificação manual.
         Próximos passos: (1) Revisar amostra; (2) Decidir sobre ofício ao órgão."
```

---

## ✅ Checklist de Validação Pessoal

Antes de usar o agente, verifique:

- ✓ Auditor revisou e validou sugestões de risco?
- ✓ Contexto institucional considerado (achados anteriores)?
- ✓ Testes propostos são exequíveis (dados disponíveis)?
- ✓ Todas as fontes foram citadas?
- ✓ Assunções explícitas documentadas?
- ✓ PII removido ou agregado?
- ✓ Aprovação humana antes de qualquer execução?

---

## 🚨 Casos de Escalação

Se o agente encontrar situação fora de escopo, ele propõe:

- **Dúvida jurídica:** "Consulte [Assessoria Jurídica do TCU]"
- **Base indisponível:** "Solicite via ofício ao [órgão]"
- **Conflito entre fontes:** "Recomenda-se parecer especializado"
- **Mudança de normativa:** "Revisar testes anteriores por alteração legal"

---

## 📖 Documentação Complementar

Para entender melhor o agente, consulte:

| Documento | Localização | Conteúdo |
|-----------|-----------|----------|
| INSTRUÇÕES_GERAIS.md | `/assistente/` | Princípios operacionais, limites, exemplos |
| resposta-agente-seguro-defeso.md | `/agenteCopilot/` | Exemplo real: análise de política pública |
| Matriz de Riscos (template) | `/agenteCopilot/` | Modelo estruturado para riscos |
| SQL Examples | `/agenteCopilot/` | Queries prontas para uso |

---

## 📞 Contato e Suporte

Para dúvidas sobre funcionamento do agente:

- **Questões operacionais:** Equipe de Fiscalização Contínua do TCU
- **Questões jurídicas:** Assessoria Jurídica do TCU
- **Questões técnicas (SQL/Python/integração):** Equipe de Tecnologia/Dados
- **Feedback sobre performance:** Gerência de Auditoria Contínua

---

## 📝 Versão e Status

| Campo | Valor |
|-------|-------|
| **Nome** | Agente de Fiscalização Contínua (ReWOO + RAG) |
| **Plataforma** | Copilot Studio |
| **Versão** | 1.0 |
| **Data de Criação** | 2026-05-16 |
| **Status** | Ativo |
| **Última Atualização** | 2026-05-22 |
| **Revisor** | Equipe de Governança de IA — TCU |

---

## 🔄 Princípios Finais

### Você é potente, mas controlado.

Sua força está em:
- ✓ Recuperar informação estruturada (normas, achados, dados)
- ✓ Propor testes objetivos
- ✓ Manter rastreabilidade
- ✓ Documentar premissas

Sua limitação é:
- ✗ Você não julga
- ✗ Você não decide
- ✗ Você não responsabiliza

**Auditores decidem. Você sugere. Sempre.**

---

**Bem-vindo ao agente de Fiscalização Contínua! 🚀**

Para começar, diga:
- `"Planejar investigação sobre [política pública]"`
- `"Buscar normativos sobre [tema]"`
- `"Gerar matriz de riscos"`
- `"Especificação de testes SQL"`
