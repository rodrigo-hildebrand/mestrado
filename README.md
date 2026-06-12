# Resultados da Pesquisa

Esta pasta reúne os principais artefatos digitais produzidos no desenvolvimento da pesquisa de mestrado sobre o uso de inteligência artificial generativa em fiscalizações contínuas governamentais.

Os arquivos estão organizados por objetivo de pesquisa, de modo a facilitar a rastreabilidade entre método, evidência empírica, análise realizada e resultados apresentados na dissertação.

## Estrutura da pasta

```text
resultados/
├── objetivo1/
│   └── survey-wgbd.md
├── objetivo2/
│   └── Respostas 2026 03 15.xlsx
└── objetivo3/
    ├── estudo-caso1/
    │   ├── assistente/
    │   └── copilot/
    ├── estudo-caso2/
    │   ├── agenteCopilot/
    │   ├── agenteVS/ scripts/
    │   ├── assistente/
    │   └── analise-detalhada.md
    └── estudo-caso3/
        ├── README.md
        ├── configuracao-sistema.md
        ├── legibilidade_pt.py
        ├── quebra-gelos.md
        └── textos-legibilidade.md
```

## Objetivo 1

A pasta `objetivo1` contém materiais relacionados ao levantamento internacional ou documental utilizado para mapear o uso de dados, automação e inteligência artificial em auditorias e fiscalizações.

Arquivo identificado:

- `survey-wgbd.md`: documento em Markdown com registros, sínteses ou análise associada ao survey WGBD.

## Objetivo 2

A pasta `objetivo2` contém dados estruturados associados à coleta empírica da pesquisa, com ênfase em experiências do TCU, dos TCEs e TCMs.

Arquivo identificado:

- `Respostas 2026 03 15.xlsx`: planilha com respostas coletadas em 15 de março de 2026, gerada por IA, com uma linha para cada TCE/TCM investigado.

## Objetivo 3

A pasta `objetivo3` reúne estudos de caso, experimentos, scripts e documentação relacionados ao uso de assistentes, agentes e ferramentas de IA generativa.

### Estudo de caso 1

Contém duas abordagens comparáveis:

- `assistente/`
- `copilot/`

Estudo de caso de documentação de bases de dados, utilizando comparação entre o uso de assistente conversacional e o uso do GitHub Copilot.

### Estudo de caso 2

Contém materiais relacionados a agentes, assistentes e análise detalhada:

- `agenteCopilot/`
- `agenteVS/ scripts/`
- `assistente/`
- `analise-detalhada.md`

Estudo de caso focao em desenvolver um agente que analise uma política pública, apontando riscos, alertas e tipologias. Estrutura mais técnica, com agentes, scripts e avaliação analítica.

### Estudo de caso 3

Contém documentação e script associados ao ContasClaras-AI, assistente voltado à transformação de achados de fiscalizações contínuas em textos claros, acessíveis e adequados à comunicação pública, utilizando conceitos de Linguagem Simples.

Arquivos identificados:

- `README.md`
- `configuracao-sistema.md`
- `legibilidade_pt.py`
- `quebra-gelos.md`
- `textos-legibilidade.md`

## Tipos de artefatos

A pasta combina três tipos principais de artefatos:

| Tipo | Extensão ou pasta | Finalidade |
|---|---|---|
| Documento analítico | `.md` | Registrar análises, configurações, prompts, sínteses e documentação |
| Base estruturada | `.xlsx` | Armazenar respostas ou dados tabulares |
| Código ou experimento | `.py`, pastas de agentes e scripts | Apoiar testes, automação, avaliação de legibilidade e reprodutibilidade parcial |

## Recomendações de uso

1. Consulte primeiro a pasta correspondente ao objetivo de pesquisa.
2. Use os arquivos Markdown como documentação metodológica e analítica.
3. Trate a planilha do objetivo 2 como fonte de dados estruturados.
4. Verifique os scripts Python e subpastas de agentes como artefatos computacionais de apoio.
5. Registre qualquer alteração relevante por meio de commits claros e mensagens descritivas.

## Observação sobre reprodutibilidade

Os arquivos desta pasta devem ser compreendidos como artefatos de pesquisa. Alguns documentos registram análises e configurações; outros armazenam dados ou scripts. A reprodução integral dos resultados pode depender de contexto adicional, versões de ferramentas, parâmetros de execução e bases externas não necessariamente armazenadas no repositório.

## Referência sugerida

HILDEBRAND, Rodrigo O C. *Inteligência Artificial Generativa no Controle Externo: Aplicações em Fiscalizações Contínuas*. Mestrado Profissional em Controle da Administração Pública, Instituto Serzedello Corrêa (ISC). GitHub, 2026. Disponível em: <https://github.com/rodrigo-hildebrand/mestrado>. Acesso em: 12 jun. 2026.
