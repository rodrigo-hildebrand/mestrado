# 🎣 Análise da Política Pública: Seguro-Defeso do Pescador Artesanal

## 1. 📋 Descrição da Política Pública

O **Seguro-Defeso** é um benefício de seguro-desemprego, no valor de um salário-mínimo mensal, concedido ao pescador artesanal que exerce sua atividade profissional ininterruptamente, de forma artesanal e individualmente ou em regime de economia familiar, durante o período de defeso de atividade pesqueira para a preservação da espécie.¹

### Marco legal principal

- **Lei nº 10.779/2003** (e alterações pelas Leis nº 13.134/2015, nº 14.973/2024, nº 15.265/2025 e nº 15.399/2026; MP nº 1.323/2025)

### Critérios básicos de elegibilidade (Lei nº 10.779/2003)

- Exercer a atividade pesqueira exclusiva e ininterruptamente, de forma artesanal.¹
- Não dispor de outra fonte de renda diversa da decorrente da atividade pesqueira.¹
- Não estar em gozo de nenhum benefício de prestação continuada da Previdência ou da Assistência Social, exceto auxílio-acidente e pensão por morte.¹
- O pescador não fará jus, no mesmo ano, a mais de um benefício de seguro-desemprego decorrente de defesos relativos a espécies distintas.¹
- Somente terá direito ao benefício o pescador que comprovar domicílio em município abrangido ou limítrofe à área definida no ato que instituiu o período de defeso.²

### Requisitos de controle recentes

Os órgãos federais deverão disponibilizar suas bases de dados para verificação dos requisitos do benefício, que serão cruzadas com cadastros oficiais. O requerente deverá apresentar registro biométrico e estar inscrito no CadÚnico.²

---

## 2. 📊 Dimensão Orçamentária e Operacional

A estimativa é que o dano ao Erário tenha chegado a **9 bilhões de reais entre 2013 e 2024**, segundo o Ipea, órgão do Ministério do Planejamento e Orçamento. 

O programa não chegou ao fim: passou por reformulação e viu seu orçamento subir para **R$ 7,9 bilhões de reais em 2026**, colocando o seguro-defeso entre os programas sociais mais caros do país, maior que Gás do Povo e Farmácia Popular e equiparável ao Pé-de-Meia.³

---

## 3. 🔴 Matriz de Riscos e Tipologias de Fraude

### 3.1 Mapa de Riscos

| # | Risco | Tipologia | Probabilidade | Impacto | Nível de Risco |
|---|-------|-----------|---------------|---------|-----------------|
| R1 | Beneficiários sem atividade pesqueira real | Fraude de identidade / uso de documentos falsos | Alta | Crítico | 🔴 Crítico |
| R2 | Beneficiários com outras fontes de renda | Acumulação indevida de benefícios | Alta | Alto | 🔴 Alto |
| R3 | Cadastro em municípios sem área de defeso | Incompatibilidade geográfica | Alta | Alto | 🔴 Alto |
| R4 | Intermediários ("atravessadores") induzindo fraude | Organização criminosa / estelionato majorado | Alta | Crítico | 🔴 Crítico |
| R5 | Colônias e associações de pesca como vetores de fraude | Corrupção de entidade intermediária | Média | Crítico | 🔴 Crítico |
| R6 | Acumulação com benefícios previdenciários/assistenciais | Acumulação indevida | Média | Alto | 🟠 Alto |
| R7 | Beneficiário com empresa registrada em seu nome | Incompatibilidade de perfil | Média | Médio | 🟠 Médio |
| R8 | Declaração de pesca em múltiplos estados no mesmo período | Inconsistência geográfica | Baixa | Alto | 🟠 Médio |
| R9 | Concentração anômala de beneficiários por município | Concessão massiva irregular | Alta | Crítico | 🔴 Crítico |
| R10 | Pagamento de benefícios retroativos sem comprovação | Risco normativo / brechas legislativas | Alta | Alto | 🔴 Alto |
| R11 | Falha biométrica / inconsistência no CadÚnico | Controle preventivo insuficiente | Média | Alto | 🟠 Alto |

### 3.2 Detalhamento das Tipologias Identificadas

#### 🔴 T1 — Pescadores fictícios / uso de documentos falsos

Supostos pescadores receberam indevidamente o benefício entre 2014 e 2025 por meio do uso de documentos falsificados. Os investigados possuíam empresas registradas em seus nomes, o que contraria os critérios legais para a concessão do benefício. Os crimes investigados incluem estelionato majorado em detrimento de entidade pública e uso de documento falso.⁴

#### 🔴 T2 — Atravessadores orientando fraude

Dois tipos de práticas foram constatados:
- Em um, atravessadores estariam coagindo pescadores artesanais legítimos a repassarem a eles parte de seus vencimentos.
- Em outro, os atravessadores, em troca de remuneração, estariam induzindo e orientando pessoas que não têm direito ao Seguro-Defeso a obter o benefício de forma irregular, por meio de fraude e declaração de informações falsas ao governo.⁵

#### 🔴 T3 — Concentração anômala por município

Em Mocajuba (PA), **96% dos 15.300 moradores adultos eram segurados em 2024** — pelos cálculos do Tribunal de Contas da União, a produção média de cada "pescador" não chegaria a 2 quilos naquele ano.³

#### 🔴 T4 — Perfil econômico incompatível

- Em Campo Belo (MG), um casal dono de uma loja de móveis planejados recebeu R$ 35.000 do governo entre 2014 e 2020.
- Em Cristais (MG), o benefício foi pago a donos de confecções de roupas e pessoas que tinham até três carros na garagem.³

#### 🔴 T5 — Inconsistência geográfica de pesca

Em 2020, um beneficiário recebeu R$ 25.000 após declarar que pescou em **cinco estados diferentes no mesmo ano**, o que é incompatível com a pesca artesanal.³

#### 🔴 T6 — Entidades pesqueiras como vetor de fraude

A inclusão de sindicatos, associações e federações pesqueiras como intermediários é vista como risco, uma vez que diversas entidades tiveram papel central em esquemas criminosos desmantelados pela Polícia Federal. 

Segundo o delegado João Carlos Girotto: *"em regra, essas fraudes nascem nas associações, que poderiam usar esse poder para requerer o seguro defeso em nome de supostos beneficiários até mesmo sem o seu conhecimento"*.³

---

## 4. 🧪 Especificação de Testes de Auditoria (SQL/Análise de Dados)

⚠️ **Nota importante:** Os testes abaixo são sugestões analíticas para revisão humana. Nenhum resultado deve ser interpretado como achado definitivo sem validação do auditor responsável.

### TESTE 1 — Beneficiários com atividade empresarial (CNPJ)

**Hipótese de risco:** R7 | **Tipologia:** T4

```sql
-- Cruzamento RGP x CNPJ da Receita Federal
SELECT b.cpf, 
       b.nome, 
       b.municipio_residencia, 
       b.valor_recebido, 
       e.cnpj, 
       e.situacao_empresa
FROM beneficiarios_seguro_defeso b
JOIN cadastro_empresas e ON b.cpf = e.cpf_socio
WHERE b.competencia BETWEEN '2014-01' AND '2026-12'
  AND e.situacao_empresa = 'ATIVA'
ORDER BY b.valor_recebido DESC;
```

---

### TESTE 2 — Acumulação indevida com outros benefícios INSS

**Hipótese de risco:** R6 | **Tipologia:** T1

```sql
-- Cruzamento benefícios INSS x Seguro-Defeso no mesmo período
SELECT sd.cpf, 
       sd.nome, 
       sd.periodo_defeso, 
       bi.descricao_beneficio, 
       bi.dt_inicio, 
       bi.dt_fim
FROM seguro_defeso sd
JOIN beneficios_inss bi ON sd.cpf = bi.cpf
WHERE bi.dt_inicio <= sd.data_fim_defeso
  AND (bi.dt_fim IS NULL OR bi.dt_fim >= sd.data_inicio_defeso)
  AND bi.descricao_beneficio NOT IN ('AUXILIO-ACIDENTE','PENSAO POR MORTE');
```

---

### TESTE 3 — Concentração anômala de beneficiários por município

**Hipótese de risco:** R9 | **Tipologia:** T3

```sql
-- Proporção de beneficiários por população adulta
SELECT m.nome_municipio, 
       m.uf, 
       COUNT(sd.cpf) AS qtd_beneficiarios,
       m.populacao_adulta,
       ROUND(COUNT(sd.cpf)*100.0/m.populacao_adulta, 2) AS perc_populacao
FROM seguro_defeso sd
JOIN municipios m ON sd.cod_municipio = m.cod_ibge
WHERE sd.ano = 2024
GROUP BY m.nome_municipio, m.uf, m.populacao_adulta
HAVING perc_populacao > 30  -- alerta acima de 30%
ORDER BY perc_populacao DESC;
```

---

### TESTE 4 — Inconsistência geográfica (pesca em múltiplos estados)

**Hipótese de risco:** R8 | **Tipologia:** T5

```sql
-- Beneficiários com registros em mais de 1 UF no mesmo ano
SELECT cpf, 
       nome, 
       COUNT(DISTINCT uf_pesca) AS qtd_ufs_declaradas
FROM registros_atividade_pesca
WHERE ano_exercicio = 2024
GROUP BY cpf, nome
HAVING qtd_ufs_declaradas > 1
ORDER BY qtd_ufs_declaradas DESC;
```

---

### TESTE 5 — Beneficiários sem cobertura geográfica do defeso

**Hipótese de risco:** R3 | **Tipologia:** T1

```sql
-- Beneficiários em município não abrangido por portaria de defeso
SELECT sd.cpf, 
       sd.nome, 
       sd.cod_municipio, 
       sd.municipio_residencia, 
       sd.uf, 
       d.portaria_defeso
FROM seguro_defeso sd
LEFT JOIN municipios_defeso d ON sd.cod_municipio = d.cod_municipio
  AND sd.especie_defeso = d.especie
WHERE d.cod_municipio IS NULL;
```

---

### TESTE 6 — Ausência de biometria / CadÚnico

**Hipótese de risco:** R11 | **Tipologia:** T1/T2

```sql
-- Beneficiários sem registro biométrico ou inscrição no CadUnico
SELECT sd.cpf, 
       sd.nome, 
       sd.ano, 
       b.flag_biometria, 
       c.num_nis
FROM seguro_defeso sd
LEFT JOIN biometria b ON sd.cpf = b.cpf AND b.situacao = 'CONFIRMADO'
LEFT JOIN cadunico c ON sd.cpf = c.cpf AND c.situacao = 'ATIVO'
WHERE (b.cpf IS NULL OR c.num_nis IS NULL)
  AND sd.ano >= 2025;
```

---

## 5. 🟡 Alertas Adicionais de Governança

### Brechas legislativas recentes

O texto aprovado no Congresso permite:
- **Pagamento de benefícios retroativos a 2021**, inclusive de pessoas que à época não conseguiram comprovar o cumprimento das exigências
- **Fim dos relatórios mensais obrigatórios de pesca**, substituído por declaração anual
- **Proibição de usar dados do Cadastro Único** como parâmetro para decidir se o benefício deve ou não ser concedido.³

### Cancelamentos

O volume de fraudes no programa levou ao **cancelamento de 828.000 registros de pescadores em três anos**.³

---

## 6. 📚 Fontes

| # | Fonte | Tipo |
|---|-------|------|
| 1 | Lei nº 10.779/2003 e alterações (Lei 13.134/2015, Lei 14.973/2024, Lei 15.265/2025, Lei 15.399/2026, MP 1.323/2025) | Normativo |
| 2 | Agência Gov / MPA-CGU (set/2025) — Pedido de investigação à PF sobre fraudes no Seguro-Defeso | Ato administrativo |
| 3 | Operação Tarrafa 2 — Polícia Federal / MG (jul/2025) | Investigação criminal |
| 4 | MPF/PA — 5ª denúncia Operação Tarrafa | Denúncia criminal |
| 5 | Revista VEJA — Edição 2991 (abr/2026) | Matéria jornalística / dados IPEA |
| 6 | Câmara dos Deputados — Aprovação MP 1.323/25 (abr/2026) | Processo legislativo |
| 7 | IPEA — Estimativa de dano ao erário 2013-2024 | Estudo técnico |

---

## 7. ⚙️ Assunções e Limitações

| # | Assunção / Lacuna | Impacto na Confiança |
|---|-------------------|----------------------|
| A1 | Os testes SQL pressupõem integração entre bases RGP, INSS, Receita Federal, CadÚnico e IBGE, que pode não estar disponível | 🔴 Alto |
| A2 | A estimativa de R$ 9 bilhões em danos (IPEA) é referenciada a fontes secundárias e não a acórdão do TCU disponível para consulta direta | 🟠 Médio |
| A3 | Critérios de alerta nos testes (ex.: >30% de população adulta) são sugestivos e devem ser calibrados pelos auditores com benchmarks locais | 🟠 Médio |
| A4 | A análise não substitui julgamento pericial sobre elegibilidade individual de beneficiários | 🔴 Alto |
| A5 | Não foram localizados acórdãos específicos do TCU sobre Seguro-Defeso nas bases consultadas; recomenda-se consulta direta ao portal TCU (pesquisa.apps.tcu.gov.br) | 🟠 Médio |

---

**Versão:** 1.0  
**Data:** 2026-05-16  
**Status:** Análise preliminar — Requer validação por auditor responsável
