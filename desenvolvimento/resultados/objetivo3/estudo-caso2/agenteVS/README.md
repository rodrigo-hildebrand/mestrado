# Audit Agent — Orquestrador de Fiscalizações Contínuas

Agente orientado a *skills* para apoio a **auditorias governamentais, fiscalizações contínuas e avaliações de políticas públicas** com base em dados. O projeto combina um **agente orquestrador** (definição em linguagem natural) com um **motor de execução em Python** que planeja, executa e rastreia um fluxo completo de trabalho auditável, fundamentado e reprodutível.

> **Contexto acadêmico.** Este repositório integra a dissertação de Mestrado Profissional Controle das Políticas Públicas (ISC/TCU), como parte do **Objetivo 3 — Estudo de Caso 2 (`GitHub Copilot`)**. Constitui um artefato de pesquisa aplicada (*design science*): um agente de IA para apoio ao controle externo. Destina-se a fins acadêmicos e de demonstração — não é um produto de produção.

> **Como navegar.** Este README é o ponto de entrada. A definição do agente está em `orquestrador-fiscalizacao.agent.md`; as skils podem ser verificadas nas respectivas pastas dentro de `scripts`.

---

## Sumário

- [1. Visão geral](#1-visão-geral)
- [2. Arquitetura](#2-arquitetura)
- [3. O agente orquestrador](#3-o-agente-orquestrador)
- [4. Catálogo de skills](#4-catálogo-de-skills)
- [5. Fluxo operacional (ReWOO)](#5-fluxo-operacional-rewoo)
- [6. Estrutura de diretórios](#6-estrutura-de-diretórios)
- [7. Instalação e execução](#7-instalação-e-execução)
- [8. Modos de execução e interação com o usuário](#8-modos-de-execução-e-interação-com-o-usuário)
- [9. Artefatos, rastreabilidade e persistência](#9-artefatos-rastreabilidade-e-persistência)
- [10. Governança, ética e limitações](#10-governança-ética-e-limitações)
- [11. Glossário](#11-glossário)
- [12. Reprodutibilidade, licença e citação](#12-reprodutibilidade-licença-e-citação)

---

## 1. Visão geral

O **Audit Agent** automatiza as etapas iniciais e intermediárias de um ciclo de auditoria de política pública. Em vez de produzir uma resposta imediata, o agente primeiro **estrutura a demanda**, aciona um **planejador** e conduz o trabalho por meio de *skills* especializadas até gerar um **produto auditável e rastreável**.

O sistema foi projetado para o contexto de controle externo (Tribunal de Contas), respeitando princípios de:

- **Fundamentação normativa** — nenhuma conclusão sem base legal identificada;
- **Rastreabilidade** — cada etapa persiste seu artefato de entrada, saída e estado;
- **Segregação de funções** — planejamento, execução e validação de governança são etapas distintas;
- **Validação humana** — tipologias geram *alertas*, nunca conclusões automáticas de fraude.

### Principais capacidades

| Capacidade | Descrição |
|---|---|
| Planejamento estruturado | Decompõe a demanda em passos com dependências, no padrão ReWOO |
| Levantamento normativo | Base legal organizada pela pirâmide de Kelsen |
| Análise de risco | Riscos gerais e específicos, DVR e matriz de risco no padrão TCU |
| Análise estratégica | Matrizes SWOT priorizadas |
| Mapeamento de dados | Bases, tabelas e chaves de cruzamento (ambiente LabContas) |
| Tipologias de auditoria | Scripts SQL/Python orientados a risco |
| Qualidade de dados | Avaliação de completude, validade, consistência e acurácia |
| Relatório consolidado | Produto executivo em `.docx` |
| Governança | Verificação final do produto com níveis de adequação |

---

## 2. Arquitetura

O projeto tem **duas camadas complementares**:

1. **Camada de definição do agente** (`orquestrador-fiscalizacao.agent.md`) — descreve, em linguagem natural, o comportamento do orquestrador, os critérios de acionamento de cada *skill* e as regras de qualidade. É consumida por um agente de IA (por exemplo, no VS Code).
2. **Camada de execução em Python** (`app/`) — um *scaffold* que planeja, executa, encadeia e persiste os passos de forma determinística, servindo tanto como motor operacional quanto como referência de contrato entre *skills*.

---

## 3. O agente orquestrador

A definição do agente está em [orquestrador-fiscalizacao.agent.md](orquestrador-fiscalizacao.agent.md). Sua **regra central**:

> A primeira capacidade a ser utilizada deve ser sempre a *skill* `planejador`, salvo quando o usuário pedir explicitamente apenas a criação, revisão ou ajuste de uma *skill*.

O `planejador` produz: entendimento da demanda, produto esperado, informações mínimas necessárias, plano de ação, *skills* necessárias, ordem de execução e pontos de consulta a fontes externas/internas.

### Regras de qualidade do agente

- Não inventar legislação, bases, campos, tabelas, decisões ou achados.
- Distinguir explicitamente: **fato conhecido**, **inferência**, **premissa**, **hipótese de auditoria**, **alerta analítico** e **achado confirmado**.
- Incluir comentários em SQL/Python suficientes para revisão por auditor humano.
- Ao lidar com dados sensíveis, indicar cuidados de acesso, minimização, finalidade, segregação e rastreabilidade.
- Diante de sobreposição entre *skills*, escolher a mais específica.

---

## 4. Catálogo de skills

As *skills* residem em `.orquestrador-fiscalizacao.agent.md/skills/<nome>/SKILL.md`, cada uma com *frontmatter* (`name`, `description`, `compatibility`), critérios de acionamento, entradas e saídas esperadas. Algumas possuem `main.py` (executável), pastas `references/` (insumos e artefatos gerados) e `evals/` (testes de acionamento).

| Skill | Função | Entrada principal | Saída |
|---|---|---|---|
| `planejador` | Plano ReWOO de execução em JSON | `context` | `plan` (passos com `tool`, `input`, `depends_on`) |
| `busca-legislacao` | Base normativa (pirâmide de Kelsen), fontes oficiais | `politica_publica` | Normativos organizados por hierarquia |
| `analise-swot2` | SWOT inicial priorizada (sem depender de riscos) | política pública | Matriz SWOT priorizada |
| `analise-risco` | Riscos gerais e específicos, DVR e matriz TCU | política + legislação | Matriz de risco priorizada |
| `analise-swot` | SWOT complementar baseada nos riscos | política + riscos | Matriz SWOT refinada |
| `busca-bd-labcontas` | Mapeamento interativo de bases (SQL Server / LabContas) | `bases_prioritarias` | Estrutura de bases, tabelas e chaves |
| `desenvolve-tipologia` | Tipologias/testes orientados a risco (SQL/Python) | riscos + estrutura de bases | Tipologias priorizadas e executáveis |
| `avalia-qualidade` | Scripts SQL de qualidade de dados por campo | tipologias + metadados | Indicadores de obrigatoriedade, validade, consistência, acurácia |
| `prepara-relatorio` | Consolidação em relatório executivo `.docx` | resultados do ciclo | Relatório + metadados JSON |
| `governanca` | Verificação final do produto com níveis de adequação | relatório final | Parecer com etapas candidatas a reprocessamento |
| `skill-creator` | Criação, revisão e melhoria de *skills* | pedido do usuário | *Skill* nova ou revisada |

### Notas de acionamento

- **`analise-swot2` vs. `analise-swot`**: use `analise-swot2` **antes** de conhecer os riscos (prioriza o que investigar); use `analise-swot` **depois** da `analise-risco` (refina com base nos riscos específicos).
- **`busca-bd-labcontas`** é interativa por natureza: conduz um ciclo de validação com o usuário até o aceite do conjunto de bases. Não pressupõe acesso a bases sensíveis.
- **`desenvolve-tipologia`** nunca conclui fraude: produz **alertas** que exigem validação humana e explicita risco de falso positivo.

---

## 5. Fluxo operacional (ReWOO)

O agente segue o padrão **ReWOO** (*Reasoning WithOut Observation*): o planejador gera um plano completo e o executor o percorre, permitindo **paralelismo** entre passos sem dependência e **referências** entre etapas (`#E1`, `#E2`, `#E3.campo`).

### Ordem preferencial para avaliação completa de política pública

1. `planejador`
2. `busca-legislacao`
3. `analise-swot2`
4. `analise-risco`
5. `analise-swot`
6. `busca-bd-labcontas` *(se houver componente de dados)*
7. `desenvolve-tipologia` *(se houver testes/alertas)*
8. `avalia-qualidade` *(se houver bases)*
9. `prepara-relatorio` *(produto textual final)*
10. `governanca` *(riscos de acesso, IA, dados, LGPD, rastreabilidade)*

### Exemplo de passo do plano (JSON)

```json
{
  "id": "E3",
  "objective": "Executar analise de risco",
  "tool": "analise-risco",
  "input": { "context": "...", "legislacao": "#E1" },
  "depends_on": ["E1"],
  "expected_output": "Riscos gerais e especificos",
  "mode": "sequential"
}
```

O executor resolve `#E1` para a saída da etapa `E1` antes de invocar a *skill*.

---

## 6. Estrutura de diretórios

```
audit-agent/
├─ Claude.md                     # orquestrador-fiscalizacao.agent.md
├─ main.py                       # Atalho para app.agent:main
├─ requirements.txt
├─ app/                          # Motor de execução (scaffold)
│  ├─ agent.py                   # CLI / entry point
│  ├─ orchestrator.py            # Ciclo de orquestração
│  ├─ plan_executor.py           # Execução de passos e resolução de refs
│  ├─ skill_registry.py          # Registro de skills e contratos
│  ├─ adapters.py                # Execução real/dry-run e persistência
│  ├─ planner_client.py          # Parser do plano + fallback
│  ├─ run_state.py               # Estado da execução
│  ├─ models.py                  # Modelos de dados
│  └─ interaction.py             # Autorizações/confirmações
├─ .claude/skills/               # Skills especializadas
│  └─ <skill>/
│     ├─ SKILL.md                # Definição e critérios de acionamento
│     ├─ main.py                 # (opcional) runner executável
│     ├─ references/             # Insumos e artefatos gerados
│     └─ evals/                  # Testes de acionamento
└─ runs/                         # Saídas de cada execução, por objeto
   └─ <objeto-slug>/
      ├─ run_state.json          # Estado consolidado da execução
      └─ <skill>/resultado.json  # Artefato por etapa
```

---

## 7. Instalação e execução

### Pré-requisitos

- Python 3.10+ (uso de `dataclass(slots=True)` e *type hints* modernos)
- PowerShell (Windows) ou terminal equivalente

### Preparação do ambiente

```powershell
# a partir da raiz do projeto
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

> `requirements.txt` está vazio no *scaffold* atual; *skills* específicas (ex.: `prepara-relatorio`, que gera `.docx`) podem exigir dependências adicionais declaradas em seus próprios diretórios.

### Execução básica

```powershell
python main.py "Avaliacao inicial da politica publica Bolsa Familia"
```

### Saída completa em JSON

```powershell
python main.py "Avaliar politica de aposentadoria por incapacidade permanente" --json
```

### Argumentos da CLI

| Argumento | Descrição | Padrão |
|---|---|---|
| `context` (posicional) | Objetivo principal / demanda | `"Executar fluxo completo de auditoria."` |
| `--json` | Imprime o resultado completo em JSON | desativado |
| `--execution-mode {real,dry-run}` | `real` gera artefatos locais; `dry-run` apenas simula | `real` |
| `--answers-json <arquivo>` | Respostas por `step_id` para retomar execução pausada | `""` |
| `--no-mirror-generated` | Não espelha resultados em `skills/<skill>/references/generated/` | desativado |

---

## 8. Modos de execução e interação com o usuário

### Modos de execução

- **`real`** — executa as *skills* (via *runner* ou carregando artefatos previamente gerados) e persiste todos os resultados em `runs/`.
- **`dry-run`** — simula a execução, ecoando o *payload*; útil para validar a estrutura do plano sem efeitos colaterais.

### Pausa e retomada

Quando uma *skill* precisa de dados que ainda não existem, ela retorna o *status* `needs_user_input` e a execução é **pausada**, registrando as perguntas pendentes. Para retomar, forneça um arquivo de respostas mapeando `step_id → { campo: valor }`:

```json
{
  "E5": {
    "bases_prioritarias": "CNIS, SIAPE, Óbitos",
    "periodo_analise": "2022-2025"
  }
}
```

```powershell
python main.py "..." --answers-json .\respostas.json
```

---

## 9. Artefatos, rastreabilidade e persistência

Cada execução gera um **diretório por objeto** em `runs/<objeto-slug>/`, com:

- `run_state.json` — estado consolidado: plano, saídas por etapa, avisos, pausas e resultados;
- `<skill>/resultado.json` — artefato de sucesso de cada *skill*;
- `<skill>/estado.json` — artefato de estado quando a *skill* não conclui (ex.: `needs_user_input`).

O nome do objeto é **inferido** a partir da demanda e normalizado em *slug* por [planner_client.py](app/planner_client.py) (ex.: *"Bolsa Família"* → `bolsa-familia`).

### Protocolo de status das skills

| Status | Significado |
|---|---|
| `ok` | Execução concluída com sucesso |
| `needs_user_input` | Faltam entradas obrigatórias; execução pausa e coleta perguntas |
| `error` | Falha de execução; interrompe o fluxo com diagnóstico |

Cada artefato registra `skill`, `status`, `output`, `questions`, `error` e `executed_at`, garantindo rastreabilidade completa da cadeia de decisão.

---

## 10. Governança, ética e limitações

O agente foi desenhado para operar sob restrições institucionais de controle externo:

- **Não conclui fraude automaticamente.** Tipologias produzem *alertas* que exigem análise e validação humana.
- **Base normativa obrigatória.** Achados devem ancorar-se em legislação identificada; normas sujeitas à atualização devem ser confirmadas em fonte oficial.
- **Dados sensíveis.** O uso de bases (ex.: LabContas) pressupõe autorização, perfil de acesso, finalidade e minimização; a *skill* correspondente conduz validação com o usuário.
- **LGPD e explicabilidade.** A *skill* `governanca` verifica o produto final e sinaliza etapas candidatas a reprocessamento, com níveis de adequação (`adequado`, `parcialmente_adequado`, `inadequado`, `incerto`).
- **Segregação de funções.** Planejamento, execução e validação são etapas distintas e auditáveis.

### Limitações conhecidas

- O *scaffold* Python utiliza um **plano *fallback*** determinístico quando o planejador não está disponível; em produção, o plano deve provir da *skill* `planejador` acionada pelo agente de IA.
- As *skills* que dependem de execução (ex.: qualidade de dados, tipologias) **geram scripts**, mas **não os executam** contra bases reais sem autorização e ambiente adequados.
- O carregamento de artefatos por *skill* depende de arquivos JSON previamente gerados em `references/generated/<objeto>/` ou de caminho explícito via `artifact_path`.

---

## 11. Glossário

| Termo | Definição |
|---|---|
| **ReWOO** | *Reasoning WithOut Observation*: separa planejamento e execução; passos referenciam resultados anteriores |
| **DVR** | Diagrama de Verificação de Risco, usado na matriz de risco no padrão TCU |
| **SWOT** | Análise estratégica de forças, fraquezas, oportunidades e ameaças |
| **Tipologia** | Regra analítica (SQL/Python) que testa a concretização de um risco e gera alertas |
| **LabContas** | Ambiente de dados (SQL Server) utilizado como fonte para cruzamentos e verificações |
| **Slug** | Identificador normalizado do objeto de análise (ex.: `bolsa-familia`) |
| **Artefato** | Arquivo JSON que registra entrada, saída, estado e metadados de uma etapa |

---

## 12. Reprodutibilidade e citação

### Reprodutibilidade

Os exemplos em `runs/` (ex.: `aposentadoria-incapacidade-permanente/`, `bolsa-familia/`) são execuções de demonstração e podem ser inspecionados sem executar o código. Para reproduzir do zero, siga a [Seção 7](#7-instalação-e-execução) e utilize o modo `dry-run` quando não houver artefatos de *skills* previamente gerados.

### Escopo e isenção de responsabilidade

Este artefato tem finalidade **acadêmica e demonstrativa**. As saídas geradas (riscos, tipologias, alertas) **não constituem achados de auditoria** e exigem validação por auditor humano. Nenhum dado sensível ou base restrita é distribuído neste repositório.

### Como citar

```bibtex
@mastersthesis{hildebrand_agentevs,
  author = {Hildebrand, Rodrigo O. C.},
  title  = {Inteligência Artificial Generativa no Controle Externo: Aplicações em Fiscalizações Contínuas},
  school = {Instituto Serzedello Corrêa (ISC/TCU)},
  note   = {Estudo de Caso 2, Objetivo 3. Disponível em: https://github.com/rodrigo-hildebrand/mestrado/tree/main/desenvolvimento/resultados/objetivo3/estudo-caso2/agenteVS}
}
```

---

### Referências internas

- Definição do agente: [Claude.md](Claude.md)
- *Entry point*: [main.py](main.py)
- Motor de orquestração: [app/orchestrator.py](app/orchestrator.py)
- Registro de skills: [app/skill_registry.py](app/skill_registry.py)
- Skills: [.claude/skills/](.claude/skills/) (cada `<nome>/SKILL.md`)
