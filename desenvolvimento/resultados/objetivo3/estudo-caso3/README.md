# ContasClaras-AI: Assistente TCU para Relatórios de Fiscalização

## Visão Geral

O **ContasClaras-AI** é um assistente especializado do Tribunal de Contas da União (TCU) que converte achados de fiscalizações contínuas em relatórios acessíveis e de fácil compreensão.

Sua função principal é garantir que informações de controle externo sejam comunicadas de forma clara, simples e inclusiva, seguindo padrões internacionais de linguagem acessível e auditoria pública.

---

## Características Principais

### 1. **Linguagem Simples e Acessível**
- Frases com máximo 20 palavras
- Voz ativa preferencialmente
- Explicação de termos técnicos quando necessário
- Conformidade com o Manual de Linguagem Simples (Lucena & Gama, 2024)
- Verificação contra Plain Writing Act Checklist (EUA)

### 2. **Explicabilidade em IA (XAI)**
- Detecção de achados usando conceitos de SHAP/LIME (sem jargão técnico)
- Explicação em linguagem natural de como os achados foram identificados
- Framework XAI em Auditoria baseado em Zhang, Cho & Vasarhelyi (2022)

### 3. **Formatos de Saída Flexíveis**

O assistente gera um dos seguintes formatos conforme necessário:

| Formato | Descrição | Uso |
|---------|-----------|-----|
| `resumo_150` | Texto corrido até 150 palavras | Sínteses rápidas |
| `ficha_sintese` | Bloco 1: Dados-chave / Bloco 2: Achados / Bloco 3: Recomendações / Bloco 4: Benefícios | Documentos oficiais do TCU |
| `nota_jornal` | Manchete (55 caracteres) + corpo (120-150 palavras) | Divulgação pública |
| `tweet` | Até 280 caracteres com #ContasClaras | Comunicação em rede social |

### 4. **Conformidade Normativa**
- **ISSAI 100** - Princípios de auditoria do setor público
- **PAFR-GFOA** - Diretrizes de relatórios financeiros populares
- **Vocabulário de Controle Externo do TCU**
- **Padrões monetários brasileiros** (R$ 1 000,00; milhões/bilhões quando aplicável)

### 5. **Avaliação de Legibilidade**

O assistente valida legibilidade de textos usando:
- **Flesch Reading Ease** (escala de 0-100)
- **Índice de Gulpease** (português)
- **Índice Gunning Fog** (anos de educação necessários)
- **Índice Coleman-Liau** (baseado em caracteres)
- **Índice ARI (Automated Readability Index)**

Resultado: classificação em "Baixa", "Média" ou "Alta legibilidade"

---

## Base de Conhecimento

O assistente integra:

1. **Manuais e Guias:**
   - Manual de Linguagem Simples (Lucena & Gama, 2024)
   - Plain Writing Act Checklist (padrão EUA)
   - Diretrizes PAFR-GFOA (Popular Annual Financial Report)
   - Template oficial de Ficha-Síntese do TCU

2. **Documentos Técnicos:**
   - ISSAI 100 - Princípios fundamentais de auditoria
   - XAI in Auditing - Framework de explicabilidade
   - Vocabulário de Controle Externo do TCU

3. **Recursos Computacionais:**
   - Busca na web
   - Lousa (whiteboard)
   - Geração de imagens
   - Intérprete de código Python
   - Análise de dados

---

## Instruções de Operação

### Passo 1: Definir Modo de Saída
Escolha o formato desejado através do parâmetro `output_mode`:
```
output_mode: "ficha_sintese" | "resumo_150" | "nota_jornal" | "tweet"
```

### Passo 2: Alimentar com Dados
Forneça ao assistente:
- Achados de fiscalização
- Valores monetários afetados
- Instituições envolvidas
- Período da fiscalização
- Contexto específico (opcional)

### Passo 3: Processamento
O assistente:
1. Simplifica linguagem técnica
2. Aplica XAI para explicar "Como detectamos"
3. Formata valores monetários (R$ 1 000,00; milhões)
4. Estrutura conforme modo de saída
5. Revisa contra Plain Writing Checklist
6. Gera resultado final

### Passo 4: Validação de Legibilidade (opcional)
Solicite avaliação de legibilidade para qualquer texto:
```
"Avalie a legibilidade deste texto..."
```
O assistente executará análise Python com 5 indicadores.

---

## Exemplos de Quebra-Gelos (Prompts Iniciais)

1. **"Avaliar a legibilidade de um texto..."**
   - Valida se texto segue padrões de simplicidade

2. **"Resumo de até 150 palavras sobre a fiscalização..."**
   - Gera síntese rápida de achados

3. **"Converter para nota de jornal o seguinte relatório..."**
   - Transforma relatório em manchete + corpo de notícia

4. **"Gerar ficha-síntese com base nos achados abaixo..."**
   - Cria documento oficial TCU estruturado

5. **"Criar tweet com base neste achado da auditoria..."**
   - Gera post para redes sociais com #ContasClaras

---

## Referências Normativas

- Lucena, S. A., & Gama, M. E. (2024). Manual de Linguagem Simples.
- Zhang, J., Cho, Y., & Vasarhelyi, M. A. (2022). Framework XAI em Auditoria.
- IFAC. (2019). ISSAI 100 – Princípios Fundamentais de Auditoria do Setor Público.
- GFOA. (2007). Popular Annual Financial Report – Guidelines & Template.
- TCU. (2023). Vocabulário de Controle Externo Externo.
- Plain Language Association & Network. (2011). Plain Writing Act Checklist.

---

## Notas de Desenvolvimento

- **Arquivo Python:** `legibilidade_pt.py` necessário para avaliações de legibilidade
- **Revisão:** O assistente revisa automaticamente todo texto final antes da publicação
- **Evita Repetições:** Remove referências às instruções no resultado final
- **Cultura TCU:** Mantém terminologia oficial e padrões institucionais

---

## Contato e Suporte

Para dúvidas sobre funcionamento do ContasClaras-AI, consulte:
- Documentação oficial do TCU
- Guias de linguagem simples inclusos na base de conhecimento
- Checklist Plain Writing para validações

---

**Versão:** 1.0  
**Data de Criação:** 2026-05-14  
**Status:** Ativo
