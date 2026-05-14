# Quebra-Gelos (Prompts Iniciais) - ContasClaras-AI

Esta documentação lista os prompts de exemplo que facilitam a interação inicial com o assistente.

---

## Quebra-Gelo 1: Avaliar Legibilidade

### Prompt
```
Avaliar a legibilidade de um texto...
```

### Descrição
Permite validar se um texto segue os padrões de simplicidade e acessibilidade.

### O que o Assistente Faz
1. Recebe o texto para análise
2. Executa 5 indicadores de legibilidade em Python
3. Apresenta faixas para cada indicador
4. Fornece classificação final (Baixa/Média/Alta)
5. Sugere melhorias se necessário

### Exemplo de Uso
```
Avaliar a legibilidade de um texto:

"A implementação de procedimentos administrativos otimizados 
consequencia em maximização de eficiência operacional através 
da integração sinérgica de recursos disponibilizados."
```

### Indicadores Gerados
- Flesch Reading Ease
- Índice de Gulpease (português)
- Índice Gunning Fog
- Índice Coleman-Liau
- Índice ARI

---

## Quebra-Gelo 2: Resumo Até 150 Palavras

### Prompt
```
Resumo de até 150 palavras sobre a fiscalização...
```

### Descrição
Gera síntese rápida e acessível de achados de fiscalização.

### O que o Assistente Faz
1. Extrai pontos-chave
2. Organiza em narrativa fluida
3. Limita a 150 palavras
4. Usa linguagem simples (frases ≤ 20 palavras)
5. Formata valores monetários (R$ 1 000,00)

### Exemplo de Uso
```
Resumo de até 150 palavras sobre a fiscalização:

Fiscalização na Prefeitura de São Paulo (2026)
- Período: Janeiro a Março 2026
- Achado: Despesa não licenciada de R$ 850 000,00 em obras
- Impacto: Falta de processo licitatório
- Recomendação: Implementar controle prévio de gastos
```

### Resultado Esperado
Texto com máximo 150 palavras, acessível, sem jargão.

---

## Quebra-Gelo 3: Converter para Nota de Jornal

### Prompt
```
Converter para nota de jornal o seguinte relatório...
```

### Descrição
Transforma relatório técnico em manchete + corpo de notícia.

### O que o Assistente Faz
1. Cria manchete com 55 caracteres
2. Desenvolve corpo com 120-150 palavras
3. Usa linguagem jornalística e acessível
4. Destaca achado principal
5. Inclui contexto e impacto

### Estrutura de Saída
```
MANCHETE (55 caracteres)
[Título chamativo e informativo]

CORPO (120-150 palavras)
[Parágrafo introdutório]
[Desenvolvimento]
[Conclusão/Impacto]
```

### Exemplo de Uso
```
Converter para nota de jornal o seguinte relatório:

[Relatório técnico TCU sobre irregularidades em programa 
de habitação - valores, instituições, impactos]
```

---

## Quebra-Gelo 4: Gerar Ficha-Síntese

### Prompt
```
Gerar ficha-síntese com base nos achados abaixo...
```

### Descrição
Cria documento oficial TCU estruturado com bloco de dados-chave.

### O que o Assistente Faz
1. Organiza em 4 blocos oficiais:
   - **Bloco 1:** Dados-chave (instituição, valor, período)
   - **Bloco 2:** Achados (o que foi encontrado)
   - **Bloco 3:** Recomendações (ações corretivas)
   - **Bloco 4:** Benefícios (resultados esperados)
2. Usa template oficial do TCU
3. Aplica linguagem simples
4. Formata conforme padrões institucionais

### Estrutura de Saída
```
╔════════════════════════════════════════╗
║  BLOCO 1 – DADOS-CHAVE                 ║
║  Instituição: ...                      ║
║  Valor afetado: R$ ... milhão          ║
║  Período: ...                          ║
╚════════════════════════════════════════╝

╔════════════════════════════════════════╗
║  BLOCO 2 – ACHADOS                     ║
║  [Descrição de irregularidades]        ║
╚════════════════════════════════════════╝

╔════════════════════════════════════════╗
║  BLOCO 3 – RECOMENDAÇÕES               ║
║  [Ações corretivas sugeridas]          ║
╚════════════════════════════════════════╝

╔════════════════════════════════════════╗
║  BLOCO 4 – BENEFÍCIOS                  ║
║  [Resultados esperados]                ║
╚════════════════════════════════════════╝
```

### Exemplo de Uso
```
Gerar ficha-síntese com base nos achados abaixo:

Instituição: Secretaria de Obras - RJ
Valor: R$ 5,2 milhões
Período: 2024-2026
Achados: Desvios em licitações, falta de comprovação de despesa...
```

---

## Quebra-Gelo 5: Criar Tweet

### Prompt
```
Criar tweet com base neste achado da auditoria...
```

### Descrição
Gera post para redes sociais com até 280 caracteres.

### O que o Assistente Faz
1. Reduz informação-chave para 280 caracteres
2. Inclui hashtag: **#ContasClaras**
3. Cria chamada para ação ou informação impactante
4. Usa linguagem clara e engajante
5. Pode incluir emojis apropriados

### Estrutura de Saída
```
[Informação-chave em linguagem simples]

Saiba mais: [link]
#ContasClaras
```

### Exemplo de Uso
```
Criar tweet com base neste achado da auditoria:

Achado: Prefeitura de SP gastou R$ 850 mil sem licitar
Orgão: Secretaria de Obras
Recomendação: Implementar controle prévio
```

### Resultado Esperado
```
A Prefeitura de SP gastou R$ 850 mil sem respeitar 
processo de licitação. O TCU recomenda controle 
prévio de despesas. Transparência com #ContasClaras
```

---

## Tabela Rápida de Quebra-Gelos

| Quebra-Gelo | Prompt Chave | Output | Limite |
|-------------|--------------|--------|--------|
| 1 | "Avaliar legibilidade" | 5 indicadores + classificação | N/A |
| 2 | "Resumo até 150 palavras" | Texto corrido | 150 palavras |
| 3 | "Converter para nota de jornal" | Manchete + corpo | 55 + 120-150 chars/palavras |
| 4 | "Gerar ficha-síntese" | 4 blocos estruturados | Template TCU |
| 5 | "Criar tweet" | Post com hashtag | 280 caracteres |

---

## Dicas de Uso

1. **Seja específico:** Forneça contexto claro (instituição, valores, período)
2. **Escolha o formato:** Defina qual quebra-gelo melhor atende sua necessidade
3. **Revise a saída:** O assistente revisa automaticamente, mas você pode pedir ajustes
4. **Use referências:** Forneça dados precisos para resultados mais fidedignos
5. **Combine quebra-gelos:** Um texto convertido em nota de jornal pode depois virar tweet

---

**Versão:** 1.0  
**Data:** 2026-05-14  
**Assistente:** ContasClaras-AI (TCU)
