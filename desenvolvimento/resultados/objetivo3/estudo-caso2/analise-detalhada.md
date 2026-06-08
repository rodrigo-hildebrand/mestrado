### 2.3.3.2.3 Testes realizados pelos agentes

Nesta seção compararemos três grupos de testes realizados: assistentes de IA (criados à semelhança das soluções dos Estudos de caso 1 e 3); agente de IA com baixa customização (desenvolvido via Copilot Studio); e agente de IA com alta customização (desenvolvido via VS Code com GitHub e Copilot).

A análise dos resultados produzidos nos três casos passará por algumas questões:

1. A política pública está bem descrita pela IA, no que se refere aos normativos aplicáveis e aos órgãos envolvidos no processo de operacionalização da política?
2. Os riscos apontados pela IA são razoáveis, em comparação com os riscos apontados por auditores em fiscalizações tradicionais?
3. Há riscos importantes que não foram apontados pela IA?
4. A matriz desenvolvida pela IA trouxe uma ponderação do risco (probabilidade e impacto) razoável?
5. O nível de detalhes da resposta da IA é equivalente aos insumos trazidos por alguém de conhecimento básico, intermediário ou avançado?
6. Há sinais de alucinação ou erro no material produzido?
Sobre a matriz a ser entregue, ela deve ser desenvolvida conforme o Diagrama de Verificação de Riscos, técnica sugerida pela Portaria-Segecex 31, de 9/12/2010 ou pelo Manual de Gestão de Riscos do TCU (2020), ilustrada na Figura 7.

**Figura 7 – exemplo de Diagrama de Verificação de Riscos**
<img width="802" height="586" alt="image" src="https://github.com/user-attachments/assets/699502f6-5d5e-4ae0-954c-fcf14a923ad7" />

*Fonte: Portaria-Segecex 31, de 9/12/2010*

Para comparabilidade, algumas políticas públicas foram escolhidas para serem testadas: Seguro Defeso, Aposentadoria por Idade e BPC Idoso foram as principais, por trazerem diferentes funções de Governo, níveis de complexidade e maturidade de fiscalização pelo TCU (existência de tipologias já desenvolvidas e testadas).

O primeiro tema escolhido como exemplo é o Seguro-defeso, política pública vinculada ao Seguro-desemprego, operacionalizada pelo INSS, com finalidade de prover pagamentos a pescadores durante o período de defeso, em que a pesca é proibida para a preservação e reprodução de espécies de pescados.

Atualmente, o Seguro-defeso não está previsto expressamente no texto constitucional – apesar da proteção genérica dos arts. 7º, inciso II, e 201, inciso III –, encontrando sua maior definição na Lei 10.779/2003, normativo em que se definem condições de elegibilidade (art. 1º), incompatibilidades de acumulação (art. 1º, § 5º e art. 2º, § 1º), documentação exigida (art. 2º, § 2º), cancelamento do benefício (art. 4º), entre outros quesitos para a conformidade da concessão e pagamento do benefício.

A lei do Seguro-defeso é regulamentada pelo Decreto 8.424/2015, que além de definir pontos mais abstratos da lei, como “atividade ininterrupta” e “regime de economia familiar”, traz as competências dos ministérios e autarquias envolvidos na cadeira decisória da política, bem como define regras mais pontuais para o benefício, como a do § 12 do art. 1º, que define não será devido o benefício quando houver disponibilidade de alternativas de pesca nos municípios alcançados pelos períodos de defeso.

Além do INSS, sob a supervisão do Ministério da Previdência Social (MPS), o Instituto Brasileiro do Meio Ambiente e dos Recursos Naturais Renováveis (Ibama), Instituto Chico Mendes de Conservação da Biodiversidade (ICMBio) e os ministérios do Trabalho e Emprego (MTE), da Pesca e Aquicultura (MPA) e do Meio Ambiente e Mudança do Clima (MMA) também têm atuação na política pública.

Para as análises do Seguro defeso são utilizadas as siglas da base de dados “Registro Geral da Atividade Pesqueira” (RGP) e “Relatório de Exercício da Atividade Pesqueira” (REAP).

O segundo tema escolhido foi a Aposentadoria por idade, principal benefício previdenciário do Brasil, com 15% das concessões totais e 58% dos pagamentos realizados pelo INSS (Brasil, 2025).

Uma questão preliminar sobre a análise dessa política é que há diferentes espécies de benefícios que podem ser consideradas como Aposentadoria por idade, além da divisão por clientela (rural e urbana) e por sexo. O Boletim Estatístico da Previdência Social traz seis diferentes espécies, incluindo espécies em extinção (Brasil, 2025). Consideraremos como sucesso a identificação do assistente pela espécie mais genérica e vigente, a Aposentadoria por idade, espécie 41.

A base normativa da Aposentadoria por idade engloba a Constituição Federal, de 1988, art. 201, as Leis 8.212/91 e 8.213/91 e a Instrução Normativa INSS/PRES 128/2022. Há normativos diversos para casos pontuais, mas a menção a esses já é suficiente para uma análise completa para fins desse estudo de caso.

A Lei 8.212/91 traz uma subseção específica (arts. 48 a 51) para tratar da Aposentadoria por idade, com os parâmetros de idade para homens e mulheres (65 e 60 anos), bem como as exceções para trabalhadores rurais (cinco anos a menos). Já a IN 128/2022 detalha as condições em que se aplicam essas exceções, além de regras de transição, como a aplicação do fator previdenciário para os filiados até 13/11/2019 (art. 229), por exemplo.

O terceiro tema analisado foi o Benefício de Prestação Continuada ao Idoso (BPC Idoso), política federal assistencial, operacionalizada pelo INSS. Ele possui apenas dois requisitos, a idade (acima de 65 anos) e a renda (familiar per capita inferior a ¼ do salário-mínimo), o que o torna um bom candidato para ser avaliado pelo assistente.

A base normativa do BPC Idoso parte do art. 203, inciso V, da Constituição Federal, de 1988, passando pela Lei Orgânica da Assistência Social (Loas, Lei 8.742/93), pelo Regulamento do Benefício de Prestação Continuada (Decreto 6.214/2007) e pela IN INSS/PRES 128/2022, uma vez que os benefícios de prestação continuada ao idoso e à pessoa com deficiência são operacionalizados pelo INSS.

Na Loas há definições mais precisas sobre a composição familiar (art. 20, § 1º), renda (art. 20, § 3º-A), acumulações (art. 20, § 4º), entre outros temas. O Regulamento do BPC, por sua vez, reforça essas questões, operacionalizando detalhes da habilitação, da concessão, da manutenção, da representação e do indeferimento do benefício. Destaca-se que a IN INSS/PRES 128/2022 deve ser usada subsidiariamente em relação a requerimentos de BPC (art. 670), mesmo tratando-se de um normativo voltado ao Direito Previdenciário.

#### 2.3.3.2.3.1 Assistente de IA

Uma das principais diferenças entre assistentes e agentes de IA é a capacidade de organização de tarefas e de utilização de ferramentas, com o agente se destacando por sua postura mais proativa na persecução dos objetivos trazidos pelos usuários (IBM, 2026).

Destacam-se algumas restrições adicionais do uso de assistente de IA para solucionar esse estudo de caso: 1) o ambiente em que o GPT foi criado é uma conta particular – não há proteção ou sigilo contratual em relação às conversas trazidas, limitando, por exemplo, o conteúdo que pode ser encaminhado ao assistente como exemplos; 2) as ferramentas disponibilizadas são limitadas a consultas à internet, lousa (para edição de textos integrados) e análise de dados, não havendo integração com as bases de dados (LabContas) e conhecimento internalizado da estrutura do TCU (ChatTCU).

Dessa forma, para avaliar o problema do estudo de caso 2, utilizaremos em um prompt único sua capacidade de lidar com problemas complexos. Como a janela de contexto do assistente escolhido (GPT do ChatGPT) era limitada, decidiu-se por desenvolver uma breve lista de instruções neste contexto, com indicação para que seguisse as instruções detalhadas disponibilizadas em sua base de conhecimento. Uma descrição do assistente, as instruções detalhadas e os resultados dos testes avaliados  podem ser consultadas em repositório público do GitHub. O assistente pode ser acessado por meio de link .

Para a política de Seguro-defeso, o assistente trouxe uma resposta estruturada em sete seções – Enquadramento da política, Síntese avaliativa neutra, Matriz de riscos de auditoria, Tipologias e alertas automáticos, Testes executáveis, Lacunas de informação e impacto na confiança, e Encaminhamentos de Fiscalização Contínua –, destacando a atuação em três eixos: focalização dos benefícios; qualidade do RGP/REAP e coerência entre proteção social e gestão ambiental do defeso.

Na primeira seção, “Enquadramento da política”, o assistente trouxe uma definição simples e direta da política pública, apontando para canais oficiais da implementação do Seguro-defeso . Do ponto de vista normativo, não apontou explicitamente a Lei 10.779/2003, mas trouxe o Decreto 8.424/2015 e a Lei 15.399/2026 (que altera a Lei 10.779/2003), além de outras fontes importantes como relatório de Auditoria operacional do TCU (Acórdão 1.638/2021-Plenário TCU) e auditorias da CGU de 2017  e 2025 . Quanto aos órgãos e entes públicos, foram trazidos o INSS, o MTE

Consideramos, portanto, a questão 1) como parcialmente respondida, uma vez que não se citaram a Lei 10.779/2003, ou os entes relacionados ao defeso (MPA, MMA, Ibama e ICMBio).

A matriz de riscos criada pelo assistente trouxe oito riscos relevantes, conforme ilustrado no Quadro 10. Dentre os riscos apontados, há riscos de natureza de conformidade (inclusão de pessoas indevidamente no programa), como o risco de pagamento a pessoa com outra fonte de renda ou vínculo incompatível ou com comprovação insuficiente de atividade pesqueira; e de natureza operacional, como exclusão indevida por barreiras indevidas de acesso para pescadores legítimos (risco de exclusão) ou de inefetividade ambiental do defeso associado ao benefício.

As bases de dados apontadas para os riscos se mostraram razoáveis, como o uso do Cnis, do eSocial, da Rais ou do Cadastro Único como bases importantes para identificação de renda ou vínculos formais de trabalho.

Dessa forma, considera-se a questão 2) como respondida. Contudo, a questão 3 deve ser apontada como parcialmente respondida, uma vez que riscos “transversais”, como pagamento de benefício pós-óbito do titular, a beneficiário com CPF cancelado ou nulo, ou beneficiários sem tempo de carência ou sem vínculo na condição de Segurado Especial, por exemplo.

A matriz apresentada pelo assistente trouxe as prioridades de cada risco (alta/média/baixa), não a probabilidade e impacto, conforme sugerido pela Figura 7. Apesar dessa divergência formal, a priorização entre os riscos altos e médios se mostrou razoável, o que traz a questão 4) como respondida.

A segunda seção da resposta do assistente, Síntese avaliativa neutra, trouxe algumas dimensões a serem analisadas pelo auditor: relevância social, focalização, governança de dados, integridade e controles, materialidade e transparência. Trouxe impressões de relatórios do TCU e da CGU, assim como mudanças recentes na legislação (Lei 15.399/2026), que trouxe a obrigação de registro biométrico (com validação com as bases do Tribunal Superior Eleitoral e da Carteira Nacional de Habilitação) e inscrição no Cadastro único – mudança sugerida como ponto a ser fiscalizado.

Ademais, na seção Tipologias e alertas automáticos, o assistente traz testes realizáveis e coerentes com a política: “T1 – Beneficiário com renda/vínculo incompatível”, “T2 – RGP irregular no momento do requerimento”; “T3 – REAP/documentação de atividade ausente”; e “T4 – Concentração territorial/cadastral anômala”.

Na seção de testes executáveis, em que o assistente trouxe scripts para serem implementados em bases de dados reais (não acessíveis diretamente pelo assistente), ele detalhou em SQL e python teste de vínculo ou benefício incompatível, RGP inválido ou recente demais e municípios com crescimento atípico de requerimentos, testes razoáveis e compatíveis com a execução de uma Fiscalização Contínua.

Por fim, na seção de Lacunas de informação e impacto na confiança, são apontadas cinco lacunas com impacto de médio a alto na confiança do trabalho: Acesso ao histórico completo do RGP e logs administrativos; Dados ambientais sobre estoque pesqueiro e eficácia do defeso; Dados de indeferimentos e recursos; Comprovação de atividade em contextos de informalidade; e Dicionário real de dados. Para cada um sugere uma ação, como requisitar informações faltantes ou realizar amostragem, entrevistas e geolocalização como procedimentos adicionais.

Pelo exposto, consideramos para a questão 5) que o assistente trouxe informações mais aprofundadas em todos os quesitos relevantes, mas apresentou algumas falhas, em especial no aprofundamento técnico dos riscos. Por isso ele teve uma performance intermediária.

O texto produzido pelo assistente foi criativo em alguns pontos para os quais não tinha informações completas, como na criação dos scripts das tipologias, contudo, foi capaz de trazer a ressalva de que tais informações deveriam ser confrontadas com o dicionário de dados real: “os nomes de tabelas e campos nos testes são ilustrativos; dependem do dicionário real das bases”. Não se detectou, portanto, nível significativo de alucinação, respondendo à questão 6).

O teste gerado pelo assistente para a política pública de Aposentadoria por idade trouxe oito seções: Caracterização da política, Avaliação por dimensões, Matriz de riscos para fiscalização contínua, Tipologias e alertas sugeridos, Testes automatizáveis propostos, Indicadores de acompanhamento, Lacunas de dados e impactos na confiança e Síntese avaliativa. Nota-se que não houve padronização entre as seções dos testes realizados, característica comum de respostas de modelos LLM, que geram respostas aleatórias (sem padrão ou previsibilidade) a cada chamada.

A primeira definição trazida pelo assistente foi de que ele considerou como Aposentadoria por idade os benefícios do Regime Geral de Previdência Social (RGPS), “abrangendo aposentadoria por idade urbana, aposentadoria por idade rural, aposentadoria híbrida e aposentadoria programada após a EC nº 103/2019. Fora do escopo: RPPS, BPC/LOAS e aposentadorias especiais”, trazendo corretamente o escopo solicitado, que exclui aposentadorias de servidores públicos (Regimes próprios) e militares e previdência complementar.

Um primeiro problema identificado na resposta do assistente foi a busca por fontes secundárias de informação. Ao invés de utilizar a Constituição Federal, de 1988, e leis específicas, ele buscou como fonte as informações constantes nos endereços oficiais do INSS, do TCU e do Governo Federal. Apesar de, com isso, conseguir identificar as regras de negócio e possíveis riscos, consideramos que a questão 1) não foi respondida.

Pelo fato de o assistente ser construído na forma de chat, ao apontar-lhe essa falta de marco jurídico, ele foi capaz de contornar a falha, trazendo os artigos aplicáveis da Constituição Federal, a Emenda Constitucional 103/2009, as Leis 8.212/91 e 8.213/91, além da Lei 9.784/99 (Processo Administrativo Federal), da Lei 13.846/2019 – que instituiu o programa especial de análise de benefícios – e Lei Complementar 142/2013, que regula aposentadorias da pessoa com deficiência no RGPS. Nos demais normativos, trouxe o Regulamento da Previdência Social (Decreto 3.048/99) e a Instrução Normativa PRES/INSS 128/2022, entre outros. Essa nova resposta sugere que mudanças nas instruções do assistente ou o uso em caso real poderiam permitir que ele trouxesse a base normativa correta, alterando a resposta à questão 1).

A Matriz de riscos para fiscalização contínua criada apontou para sete riscos, trazendo para cada risco um critério de auditoria, os dados necessários para o teste, uma avaliação de “testabilidade” (baixa/média/alta) e uma avaliação de prioridade técnica (baixa/média/alta). Nota-se que nesse caso, assim como no do Seguro-defeso, não se utilizou o modelo oferecido pelo TCU para o Diagrama de Verificação de Riscos.

Destaca-se que, após a questão trazida ao assistente sobre marco jurídico, a nova resposta dele revisou a matriz e testes de auditoria, apontando para uma nova tabela com o tema auditável, a norma-base e o teste sugerido, conforme Quadro 13, que traz uma nova visão das informações trazidas na primeira rodada (Quadro 11).

Analisando as duas matrizes criadas, verifica-se que os riscos apontados são razoáveis, mesmo que não estejam disponibilizados no formato desejado. A questão 2) pode ser considerada como respondida. Sobre a não identificação de riscos relevantes, consideramos que a questão 3) também está respondida, já que os principais riscos foram detectados na resposta do assistente.

Sobre a avaliação de probabilidade e impacto dos riscos, a matriz inicial traz testabilidade e prioridade técnica, mas não os traduz diretamente com os conceitos de uma fiscalização, razão pela qual a questão 4) deve ser considerada não respondida.

Considerando os dois textos produzidos pelo assistente, houve bom aprofundamento da análise da política pública. Utilizaram-se termos especializados da política, considerando datas de entrada de requerimento (DER) e de início de benefício (DIB), número de benefício (NB) e ressalvas importantes, como observar decisões judiciais ou direito adquirido. Os indicadores de acompanhamento sugeridos também demonstraram alta relevância e pertinência com a política pública real. Não traremos aqui as sugestões de tipologias, alertas e scripts produzidos, mas eles seguiram o nível de profundidade apresentado para a política do Seguro-defeso. Pelo exposto, considera-se a questão 5) respondida com o perfil intermediário/avançado.

Assim como com o teste do Seguro-defeso, o texto produzido pelo assistente foi criativo em alguns pontos para os quais não tinha informações completas, como na criação dos scripts das tipologias, contudo, foi capaz de trazer a ressalva de que tais informações deveriam ser confrontadas com o dicionário de dados real: “os nomes de tabelas e campos dos testes são ilustrativos; devem ser substituídos pelo dicionário oficial”. Não se detectou, portanto, nível significativo de alucinação, respondendo à questão 6).

Para o BPC Idoso, o assistente trouxe cinco seções: Síntese avaliativa, Matriz de riscos, Tipologias e alertas automáticos, Especificação de testes e Questões de avaliação, além de fontes, assunções e lacunas, trazidas como seções seis e sete. Nota-se, novamente, que não houve padronização entre as seções dos testes realizados.

Novamente, a resposta do assistente realizou busca por fontes secundárias de informação. Ao invés de utilizar a Constituição Federal, de 1988, e leis específicas, ele buscou como fonte as informações constantes nos endereços oficiais do INSS, do Ministério do Desenvolvimento Social e Combate à Fome (MDS), do TCU e do Governo Federal. Citou, contudo, o Decreto 12.534/2025, que alterou o Regulamento do BPC e do Cadastro Único. Apesar de ter conseguido identificar as regras de negócio e possíveis riscos, consideramos que a questão 1) não foi respondida.

Como no teste com a Aposentadoria por idade, solicitou-se ao assistente que trouxesse a base normativa utilizada. Em nova busca pela internet, ele trouxe o artigo correto da Constituição Federal, a Loas, o Regulamento do BPC e outras leis, trazendo corpo normativo mais completo que o definido como parâmetro de sucesso do assistente.

A matriz de riscos criada pelo assistente trouxe seis riscos relevantes, conforme ilustrado no Quadro 12. Destaca-se que além dos riscos relacionados à política, o assistente trouxe nessa matriz informações sobre o teste a ser realizado e possíveis limitações, pontos trazidos na análise do Seguro-defeso (Quadro 10), mas não na Aposentadoria por idade (Quadro 11). Contudo, à semelhança das análises anteriores, houve uma conclusão por “criticidade” do risco, não trazendo a decomposição do risco por seu impacto e probabilidade.

Analisando-se os riscos apontados pelo assistente, verifica-se que os riscos mais relevantes foram identificados, como erros na composição familiar, na renda familiar, acumulações indevidas e problemas cadastrais graves (como pagamento após o óbito do titular do benefício ou a CPF cancelado ou nulo). As bases de dados informadas possuem as informações necessárias aos testes e as limitações propostas são relevantes.

Dessa forma, considera-se que as questões 2) e 3) devem ser consideradas como respondidas. Mesmo riscos transversais foram apontados pelo assistente, não se limitando aos riscos específicos da política pública. Apesar da divergência formal na priorização dos riscos, considera-se a questão 4) como respondida. Neste ponto, cabe uma ressalva de que um dos riscos médios – Inclusão/exclusão indevida por erro na composição familiar – poderia ter sido considerado como risco alto, dada auditoria recente do TCU, que apontou “15% de famílias com indícios de inconsistência na composição familiar, em contraposição ao disposto nos arts. 15 e 35-A do Anexo ao Decreto 6.214/2007” . Não consideramos, contudo, que essa divergência seja suficiente para considerar a questão como não respondida ou parcialmente respondida.

Considerando os dois textos produzidos pelo assistente, houve bom aprofundamento da análise da política pública. Utilizaram-se termos especializados da política e ressalvas importantes, como observar decisões judiciais ou direito adquirido. Os principais temas trazidos pelo assistente estão em consonância com as discussões realizadas no Controle Externo, Judiciário e Academia: focalização de benefícios; composição da renda e exceções ao cálculo; atualização do Cadastro Único e qualidade cadastral; transparência; e conformidade de pagamentos. Não traremos aqui as sugestões de tipologias, alertas e scripts produzidos, mas eles seguiram o nível de profundidade apresentado para a política do Seguro-defeso. Pelo exposto, considera-se a questão 5) respondida com o perfil intermediário/avançado.

Assim como com o teste do Seguro-defeso e da Aposentadoria por idade, o texto produzido pelo assistente foi criativo em alguns pontos para os quais não tinha informações completas, como na criação dos scripts das tipologias, contudo, foi capaz de trazer a ressalva de que tais informações deveriam ser confrontadas com o dicionário de dados real: “-- Exemplo conceitual: não executar sem adaptar ao dicionário real das bases”. Não se detectou, portanto, nível significativo de alucinação, respondendo à questão 6).

Os três testes realizados com o assistente estão consolidados no Quadro 3.

**Quadro 3 – avaliação Assistente de IA – quadro resumo**

| Questão | Seguro-defeso | Aposentadoria por idade | BPC Idoso |
| --- | --- | --- | --- |
| 1) A política pública está bem descrita pela IA, no que se refere aos normativos aplicáveis e aos órgãos envolvidos no processo de operacionalização da política? | Sim (parcial) | Não | Não |
| 2) Os riscos apontados pela IA são razoáveis, em comparação com os riscos apontados por auditores em fiscalizações tradicionais? | Sim | Sim | Sim |
| 3) Há riscos importantes que não foram apontados pela IA? | Não (parcial) | Sim | Sim |
| 4) A matriz desenvolvida pela IA trouxe uma ponderação do risco (probabilidade e impacto) razoável? | Sim | Não | Sim |
| 5) O nível de detalhes da resposta da IA é equivalente aos insumos trazidos por alguém de conhecimento básico, intermediário ou avançado? | Intermediário | Intermediário /avançado | Intermediário /avançado |
| 6) Há sinais de alucinação ou erro no material produzido? | Não | Não | Não |

*Fonte: elaboração própria*

#### 2.3.3.2.3.2 Agente de IA Copilot Studio

Uma segunda solução testada foi a criação de um agente de IA por meio da ferramenta Microsoft Copilot Studio . Essa plataforma permite a criação de agentes corporativos personalizados, com maior poder de integração a ferramentas corporativas do que os assistentes utilizados no primeiro conjunto de testes.

Uma observação que deve ser trazida é o alto custo de customizar um agente neste ambiente. A criação de um agente simples é tão intuitiva quanto a de um assistente GPT, por exemplo, mas ajustar um agente para se adequar a uma arquitetura pré-determinada, como aquela apresentada nas Figura 5 e Figura 6, se mostrou uma atividade de alto custo e complexidade.

O agente criado foi o “Agente de Fiscalização Contínua – Riscos”, criado com os mesmos parâmetros discutidos nas seções anteriores. Para construir um agente nesta plataforma, alguns campos estão disponíveis para desenvolvimento: instruções, conhecimento, ferramentas, agentes, tópicos e solicitações sugeridas. Apesar de não ser possível a publicação do agente em links públicos, os códigos utilizados e respostas produzidas podem ser consultados em repositório público do GitHub .

Os parâmetros anteriores foram traduzidos em um pequeno texto de Instruções e quatro Tópicos detalhados: Planejar Investigação (ReWOO / Plan); Executar Recuperação (RAG / Busca) (ReWOO / Execute – ferramentas); Gerar Matriz de Riscos + Tipologias / Alertas (ReWOO / Synthesize); e Especificação de Testes + SQL / Python (com safe execution). Cada uma delas foi construída com o uso de interface de IAGen, que traduzia instruções em linguagem natural para o formato de fluxo de atividades, como ilustrado na Figura 8.

**Figura 8 – exemplo de Tópico desenvolvido no Copilot Studio**

<img width="369" height="578" alt="image" src="https://github.com/user-attachments/assets/2e88b76e-187e-432a-8f4a-66c81347e36c" />


*Fonte: elaboração própria*

No primeiro teste, para a política pública do Seguro-defeso, utilizou-se um prompt direto e simples, como o utilizado no Assistente detalhado em 2.3.3.2.3.1. Com essa solicitação, o agente acionou seis vezes a sua ação “Pesquisar fontes”, trazendo contextos diferentes para suas buscas, como “Política pública Seguro-defeso, legislação, normativos e regulamentação” e “Seguro-defeso riscos, irregularidades, fraudes e achados de auditoria TCU”, por exemplo.

A análise estruturada produzida apresentou sete seções: Descrição da Política Pública; Dimensão Orçamentária e Operacional; Matriz de Riscos e Tipologias de Fraude (subdividida em Mapa de Riscos e Detalhamento das Tipologias Identificadas); Especificação de Testes de Auditoria; Alertas Adicionais de Governança; Fontes e Assunções e Limitações.

A descrição da política pública trouxe detalhamento do marco legal principal, dando ênfase aos critérios básicos de eligibilidade (Lei 10.779/2003). Foram incluídos, inclusive, critérios recentes de alterações legislativas, como a Lei 15.265/2025, que determina que “os órgãos federais deverão disponibilizar suas bases de dados para verificação dos requisitos do benefício, que serão cruzadas com cadastros oficiais. O requerente deverá apresentar registro biométrico e estar inscrito no CadÚnico”. Um ponto fraco na análise realizada pelo agente foi a “dimensão orçamentária e operacional”, que apenas apontou para os montantes do programa, sem trazer informações relevantes adicionais. Considera-se, portanto, a questão 1) como respondida.

Na seção de Matriz de Riscos e Tipologias de Fraude, o agente criou a matriz apresentada no Quadro 14. Ela trouxe riscos associados a possíveis tipologias, com respectivas probabilidade, impacto e risco. No entanto, não se informaram os critérios dos riscos e possíveis dados necessários.

Importante também notar que os riscos transversais apontados derivam diretamente da base normativa (falha biométrica ou inconsistência no Cadastro Único): riscos indiretos, como pagamentos pós-óbito do titular ou documentação fraudada (CPF nulo, por exemplo), não foram considerados.

Outra questão dos riscos e tipologias sugeridos foi que as tipologias estão criadas em um formato pontual, não genérico, como:

> T3 — Concentração anômala por município. Em Mocajuba (PA), 96% dos 15.300 moradores adultos eram segurados em 2024 — pelos cálculos do Tribunal de Contas da União, a produção média de cada "pescador" não chegaria a 2 quilos naquele ano.
> T5 — Inconsistência geográfica de pesca. Em 2020, um beneficiário recebeu R$ 25.000 após declarar que pescou em cinco estados diferentes no mesmo ano, o que é incompatível com a pesca artesanal.
Mesmo com tais falhas, considera-se que os riscos são razoáveis – questão 2) respondida – e que poucos riscos relevantes não foram detectados – questão 3) respondida parcialmente.

Sobre a forma de apresentar os riscos, a Matriz de Riscos criada trouxe os três indicadores: probabilidade, impacto e risco, além de vincular riscos a possíveis tipologias, o que permite à questão 4) ser considerada como respondida.

A descrição da política pública, o marco legal trazido, os riscos apontados, as tipologias esboçadas e as ressalvas trazidas pelo agente são equivalentes a impressões de analistas avançados da política pública.

O texto produzido pelo assistente foi criativo em alguns pontos para os quais não tinha informações completas, como na criação dos scripts das tipologias, contudo, foi capaz de trazer a ressalva de que tais informações deveriam ser confrontadas com o dicionário de dados real: “os testes abaixo são sugestões analíticas para revisão humana.”. Não se detectou, portanto, nível significativo de alucinação, respondendo à questão 6).

Para a Aposentadoria por idade, o agente trouxe – após acionar “Pesquisar fontes” em cinco contextos diferentes – a especificação da política, destacando que seriam analisados os benefícios do Regime Geral de Previdência Social (RGPS), em suas quatro submodalidades: Aposentadoria por Idade Urbana (pré-EC 103/2019); Aposentadoria por Idade Rural; Aposentadoria Programada (pós-EC 103/2019); e Aposentadoria por Idade PCD (LC 142/2013).

A resposta do assiste se estruturou em sete seções: Descrição da Política Pública; Matriz de Riscos; Tipologias e Alertas; Especificação de Testes Analíticos; Lacunas e Confiança da Análise; Fontes e Assunções. Nota-se que permanece a não padronização no formato utilizado, como nos testes via assistente.

Apesar de descrever bem os tipos de aposentadoria por idade, com suas fórmulas de cálculo em número de contribuições e em valor de benefícios, com a divisa por sexo e clientela (rural e urbana); o marco legal e o detalhamento trazidos forma superficiais. Somente se mencionou a Emenda Constitucional 103, de 2019, e a Lei 8.213/91. As demais fontes utilizadas foram sítios oficiais do INSS, jurisprudência do TCU e pesquisas acadêmicas. Por essa ressalva, considera-se a questão 1) como respondida parcialmente.

Na seção de Matriz de Riscos, foram apontados 10 riscos, com tipologia sugerida, probabilidade, impacto e risco, conforme ilustrado no Quadro 15.

Um destaque entre as tipologias sugeridas foi a “Tipologia 4 — Irregularidades em RPPS Municipais”, que apontou para benefício que foi definido pelo próprio agente como fora de escopo. Ele se refere a aposentadorias do Regime Próprio de Previdência Social (RPPS), regime referente aos servidores públicos federais, estaduais, distritais ou municipais.

Outra tipologia de destaque é a “Tipologia 5 — Fraudes em Aposentadoria Rural” (cujo teste sugerido foi o “Teste T5 — Inconsistência Rural × Endereço Urbano”). Ela demonstra que, apesar de não ter sido mencionado nenhum risco específico de aposentadorias rurais, elas estavam no escopo do agente, fato corroborado pela lacuna apontada de “Quantificação atualizada de benefícios rurais irregulares”.

Dadas essas ressalvas, os demais riscos e tipologias desenhados são consistentes com as últimas fiscalizações realizadas pela CGU e TCU nos benefícios do RGPS, respondendo à questão 2). Por outro lado, a não identificação na matriz de riscos específicos para aposentadorias rurais aponta para uma resposta parcial da questão 3).

A avaliação do agente para alguns riscos pode não estar bem ajustada, como a probabilidade de pagamento continuado a beneficiário falecido (alta) ou de descontos irregulares (alta), ou a probabilidade (alta) e o impacto do atraso da verificação de indícios (alto). Contudo, apesar de os dados poderem apontar para outros patamares, como “impressão”, a avaliação pode ser mantida. Com essa ressalva, a questão 4) pode ser considerada respondida.

A descrição da política pública, o marco legal trazido (com menos detalhes que o desejado), os riscos apontados (com a ressalva para benefícios rurais), as tipologias esboçadas e as ressalvas trazidas pelo agente são equivalentes a impressões de analistas intermediário da política pública.

Em termos de criatividade e alucinação, não se detectou nível significativo de alucinação, salvo a menção a benefícios do Regime Próprio de Previdência Social (RPPS), que está fora do escopo desejado. Manteve-se a questão 6) com resposta satisfatória, com observação (“não, parcial”).

O terceiro teste do agente, para a política pública do BPC Idoso, trouxe uma dinâmica diferente dos primeiros testes. Ao receber o mesmo tipo de insumo dos testes anteriores – qual seja um prompt simples e direto pedindo a análise da política –, ao invés de utilizar apenas as ferramentas e “Pesquisar fontes”, ele decidiu mesclar essas ferramentas com o uso dos Tópicos 1 a 3, conforme ilustrado na Figura 9.

**Figura 9 – resposta de agente com interação com usuário**

<img width="945" height="594" alt="image" src="https://github.com/user-attachments/assets/f1895610-3755-4b82-88cc-d1b42cc9581d" />

*Fonte: elaboração própria*

No fluxo realizado, após uma primeira pesquisa de fontes, realizou-se a execução do Tópico 1, que apontou para novas pesquisas de fontes e, e em seguida, a chamadas dos Tópicos 2 e 3. Nesse ponto, o agente interrompe seu fluxo interno e pede ao usuário que ele aponte qual o risco a investigar, apontando uma falha no desenho de seu funcionamento.

Em rodada subsequentes, com o mesmo comando, o agente trouxe variações desse erro. Acionava os Tópicos (ora o 2, ora o 3) e pedia para que o usuário retornasse as informações para análise de risco, como “qual o risco deseja investigar?” ou “qual o ID do risco?”. Ao desabilitar os Tópicos, a resposta trazida pelo agente voltou ao formato dos testes anteriores.

A resposta estruturada apresentou oito seções: Contextualização da Política; Base Normativa e Jurisprudência; Matriz de Riscos; Tipologias de Irregulares Identificadas (TCU – Acórdão 451/2025); Testes de Auditoria Sugeridos; Deliberações já emitidas pelo TCU; Assunções e Fontes.

As duas primeiras seções da resposta trouxeram descrição (com os principais critérios, como a idade, a renda, a revisão periódica, a inscrição no Cadastro Único, entre outros pontos) e marco legal completo – incluindo a Constituição Federal, a Loas e o Regulamento do BPC –, além de trazer pontos da jurisprudência, como o RE 567.985/MT do STF  (que declarou a inconstitucionalidade parcial do critério de ¼ de salário-mínimo do BPC) e o REsp 1.962.868-SP / Informativo 770, de 18/4/2023 (que reafirma que o BPC deve ser concedido conforme a lei, sem requisitos adicionais além dos legais). Dado o exposto, a questão 1) foi respondida.

A Matriz de Riscos produzida trouxe cada um dos oito riscos com uma possível causa-raiz, seguidos de impacto (em alguns casos com quantificações trazidas de auditorias do TCU), probabilidade e nível, como observado no Quadro 16. Apesar de poucos riscos, eles trazem as principais fragilidades do programa, tanto erros de inclusão (por renda incompatível, composição familiar inadequada ou acumulação indevida) quanto falhas no desenho da política (crescimento orçamentário), passando por falhas mais transversais, como nos cadastros, no pagamento pós-óbito do titular ou na judicialização.

Consideram-se as questões 2) e 3) como respondidas. O formato da Matriz, além dos campos de impacto, probabilidade e nível, ainda trouxe possíveis causas-raiz do risco.

Nas tipologias sugeridas, os testes apontam, inclusive, bases de dados a serem verificadas, como o Sirc e a base de CPF da Receita Federal do Brasil no caso de pagamentos a titulares falecidos e Caged, eSocial e Rais para verificar incompatibilidades de renda.

Dentre os riscos sugeridos, apenas as probabilidades de “Inconsistências cadastrais (endereço, família)” e “Concessões judiciais sem cumprimento pleno de requisitos” pareceram sobrestimados (alto). Dessa forma, a questão 4) pode ser considerada respondida.

A descrição da política pública, o marco legal trazido, os riscos apontados, as tipologias esboçadas e as ressalvas trazidas pelo agente são equivalentes a impressões de analistas avançados da política pública.

Em termos de criatividade e alucinação, não se detectou nível significativo de alucinação. Houve, porém, um erro argumentativo. Ao avaliar as concessões judiciais de BPCs, o agente se confundiu ao misturar os dois tipos de benefícios: aos idosos e às pessoas com deficiência. Talvez essa confusão (ou alucinação) tenha afetado a atribuição de risco à probabilidade de “alto”. Destaca-se, por outro lado, que nenhum dos riscos incluíram questões de perícias médicas, CID ou outros temas afetos ao BPC a pessoas com deficiência, apesar de uma das tipologias sugeridas ser: “Mapear concessões judiciais sem CID registrado e verificar cumprimento dos demais critérios (renda, CadÚnico)”.

Sobre as concessões judiciais:

As decisões judiciais representam 25% do total das concessões, e a maioria delas sem qualquer indicação de CID (identificação da doença ou deficiência). Até setembro de 2024, foram quase 3 milhões de novas concessões de BPC a pessoas com deficiência, das quais 711 mil foram por determinação judicial, e a maior parte não possuía indicação de CID. (grifo no original, texto criado por IA)

Pelo exposto, considera-se a questão 6) como parcialmente respondida.

Os três testes realizados com o agente Copilot Studio estão consolidados no Quadro 4.

**Quadro 4 – avaliação Agente Copilot – quadro resumo**

| Questão | Seguro-defeso | Aposentadoria por idade | BPC Idoso |
| --- | --- | --- | --- |
| 1) A política pública está bem descrita pela IA, no que se refere aos normativos aplicáveis e aos órgãos envolvidos no processo de operacionalização da política? | Sim | Sim, parcial | Sim |
| 2) Os riscos apontados pela IA são razoáveis, em comparação com os riscos apontados por auditores em fiscalizações tradicionais? | Sim | Sim | Sim |
| 3) Há riscos importantes que não foram apontados pela IA? | Não, parcial | Não, parcial | Não |
| 4) A matriz desenvolvida pela IA trouxe uma ponderação do risco (probabilidade e impacto) razoável? | Sim | Sim | Sim |
| 5) O nível de detalhes da resposta da IA é equivalente aos insumos trazidos por alguém de conhecimento básico, intermediário ou avançado? | Avançado | Intermediário | Avançado |
| 6) Há sinais de alucinação ou erro no material produzido? | Não | Não, parcial | Não, parcial |

*Fonte: elaboração própria*

#### 2.3.3.2.3.3 Agente de IA VS Code

Os testes realizados no agente desenvolvido via VS Code com uso do GitHub e Copilot foram os que mais se aproximaram às definições e arquitetura do agente proposto para o estudo de caso 2, dada a alta customização disponível e integração com a estrutura de dados do LabContas.

O código do orquestrador desenhado, das skills criadas e respostas produzidas podem ser consultadas em repositório público do GitHub .

Resgatando a arquitetura funcional descrita na Figura 5, temos que após a entrada do usuário – trazendo o tema da fiscalização – o agente acionaria um orquestrador, que teria, por sua vez, a responsabilidade de acionar as diferentes skills analíticas, para ao final, produzir uma saída ao usuário.

Para efeito de comparabilidade, foram usadas de exemplo as mesmas três políticas públicas analisadas pelo assistente de IA e pelo agente desenvolvido no Copilot Studio: Seguro-defeso, Aposentadoria por idade e BPC Idoso.

Um primeiro destaque da comparação entre as respostas do “agente VS Code” e as dos demais é que suas respostas são mais estruturadas, uma vez que cada skill possui entradas e saídas sugeridas (geralmente em formato JSON).

Dadas essas observações preliminares, a análise dos três testes se iniciou pelo Seguro-defeso.

Ao iniciar a análise da política pública, o orquestrador acionou a skill “busca-legislacao”, identificando a Constituição Federal, de 1988, as Leis 7.998/90, 8.212/91, 8.213/91, 10.779/2003 e 11.959/2009, e o Decreto 8.424/2015. Destaca-se que cada diploma legal foi trazido na íntegra para o contexto do agente, de forma a ser analisado por outras skills. se necessário.

O arquivo final, gerado no formato de relatório formatado (.docx), trouxe uma breve descrição da política pública. Maior detalhamento foi utilizado nas fases intermediárias, o que aponta para possível melhoria na skill de preparação de relatórios, que se mostrou excessivamente contida. Considera-se, pelo conjunto das peças produzidas, a questão 1) como respondida.

A análise de risco realizada gerou um arquivo JSON que apresenta uma análise de riscos com cinco riscos gerais: RG-01 — Falhas de Elegibilidade e Habilitação (risco de concessão do benefício sem atendimento integral dos requisitos legais); RG-02 — Fragilidade de Comprovação Documental e Cadastral (risco relacionado a: RGP; biometria; documentos fiscais; contribuições previdenciárias; consistência cadastral); RG-03 — Pagamentos e Manutenção Indevida (risco de continuidade de pagamentos sem base legal válida); RG-04 — Fraude e Integridade Cadastral (risco de: fraude documental; declarações falsas; inconsistências cadastrais); e RG-05 — Governança, Monitoramento e Controle Financeiro (risco de insuficiência de: controles financeiros; monitoramento; governança do FAT; supervisão institucional).

Cada um desses riscos gerais foi avaliado em aspectos de probabilidade, impacto e “quadrante DVR”, além de ter sido decomposto em ao menos um risco específico (em um total de nove), como por exemplo:

```json
"id_risco_especifico": "RE-03",
"id_risco_geral": "RG-01",
"titulo": "Risco de beneficio concedido sem verificacao da ausencia de outra fonte de renda ou vinculo de trabalho",
"descricao": "Ocorre quando a administracao nao confirma adequadamente a inexistencia de renda diversa da pesca ou de vinculo laboral incompatível.",
"causa": "Cruzamentos cadastrais incompletos e dependencia excessiva de autodeclaracao do requerente.",
"efeito": "Pagamento indevido a beneficiarios fora do publico elegivel.",
"normativos_base": ["Lei 10.779/2003", "Decreto 8.424/2015"],
"dispositivos": ["Lei 10.779/2003, art. 1o, para. 4o e art. 2o, para. 1o", "Decreto 8.424/2015, art. 2o, IV e V; art. 3o, para. 3o"],
"evidencia_normativa": "A lei e o decreto exigem ausencia de outra fonte de renda e autorizam confirmacao em bases governamentais, inclusive junto a Receita Federal.",
"tipo": "especifico"
```

Esse risco foi considerado como o quarto em prioridade, com o controle esperado “Consulta obrigatória a bases tributarias, trabalhistas e previdenciárias antes do deferimento e em revisões periódicas” e o teste de auditoria sugerido “Cruzar amostra de beneficiários com bases de vínculo laboral, renda e benefícios continuados para confirmar ausência de fonte de renda incompatível”.

Cabe uma breve observação sobre a skill de avaliar a qualidade das bases de dados. Ela está apenas sugerindo scripts a serem rodados. Em sua primeira versão ela realizou diretamente as consultas, mas seu tempo de processamento foi muito alto, o que impossibilitou seu uso em produção (mas sinalizou para a possibilidade).

Dada a quantidade de informações distintas trazidas pelo agente, não foi possível a criação de apenas um quadro com cada risco. O Quadro 17 traz os riscos específicos gerados, com causa, efeito e possível teste de auditoria a se aplicar.

Os riscos apontados são razoáveis, bem fundamentados e incluem questões transversais (mesmo que mencionados nessa etapa de forma mais genérica, como “fraude documental”, ou “risco de manutenção indevida após ocorrência de causa legal de cessação”, englobando pagamentos pós-óbito). Dessa forma, as questões 2) e 3) foram respondidas satisfatoriamente.

A avaliação de probabilidade, impacto e quadrante trazem a justificativa utilizada, e foram compatíveis com os graus sugeridos (alto/médio/baixo). A questão 4) foi respondida.

Utilizando como base as saídas das skills de análise de risco, análise SWOT/FOFA  e desenvolvimento de tipologias, considera-se que o nível alcançado pelo agente foi avançado. Cabe destacar que, como há etapa específica de busca no LabContas pelas estruturas de dados, a criação de scripts sugeridos utiliza dados mais próximos aos reais.

O texto produzido pelo agente foi criativo na sugestão de riscos, tipologias e testes de qualidade. Não se detectou, contudo, nível significativo de alucinação, respondendo à questão 6).

A segunda política testada foi a Aposentadoria por idade. A skill de busca por legislação aplicável apontou para a Lei Complementar 142/2013 (que trata de aposentadorias de pessoas com deficiência), para as Leis 8.212/91 e 8.213/91, para o Decreto 3.048/99 (Regulamento da Previdência Social) e para a Instrução Normativa INSS/PRES 128/2022, itens considerados como o rol de sucesso para o teste.

Destaca-se que a Constituição Federal, de 1988, é sempre considerada insumo para as análises do agente. Neste caso, a Emenda Constitucional 103/2019 trouxe regras que podem influenciar diretamente nos riscos e tipologias a serem aplicados. Mesmo não tendo sido explicitada nesse momento, a EC 103/2019 foi um dos normativos utilizados para a análise, ponto trazido no relatório final produzido.

O arquivo final, gerado no formato de relatório formatado (.docx), trouxe uma breve descrição da política pública. Maior detalhamento foi utilizado nas fases intermediárias, o que aponta para possível melhoria na skill de preparação de relatórios, que se mostrou excessivamente contida. Considera-se, pelo conjunto das peças produzidas, a questão 1) como respondida.

Como no primeiro teste, a análise de riscos gerou um arquivo JSON com detalhamento de seis riscos gerais (Falhas na verificação de requisitos de elegibilidade; Fragilidade do Cnis e na prova documental; Erros na instrução e motivação do processo administrativo; Riscos específicos da aposentadoria rural e da pessoa com deficiência; Erros financeiros e de data de início de benefício; e Riscos transversais de integridade cadastral e manutenção) e doze riscos específicos, ilustrado no Quadro 18. Os mesmos campos com base normativa resumida, avaliação dos riscos por probabilidade e impacto, prioridade (quadrante DVR) e justificativas constam deste arquivo.

Os riscos apontados são razoáveis, bem fundamentados e incluem questões transversais com exemplos específicos, como CPF nulo ou pagamento pós-óbito. Dessa forma, as questões 2) e 3) foram respondidas satisfatoriamente.

A avaliação de probabilidade, impacto e quadrante trazem a justificativa utilizada, e foram compatíveis com os graus sugeridos (alto/médio/baixo). A questão 4) foi respondida.

Utilizando como base as saídas das skills de análise de risco, análise SWOT/FOFA e desenvolvimento de tipologias, considera-se que o nível alcançado pelo agente foi avançado.

O texto produzido pelo agente foi criativo na sugestão de riscos, tipologias e testes de qualidade. Não se detectou, contudo, nível significativo de alucinação, respondendo à questão 6).

Por fim, o terceiro teste realizado foi na política BPC Idoso. A legislação apontada inclui a Lei 8.742/93 (Loas), 10.741/2003 (Estatuto da Pessoa Idosa) e 14.176/2021, além do Decreto 6.214/2007 (Regulamento do BPC).

O relatório gerado ao final do processo trouxe muito poucas informações do programa em sua introdução, mas trouxe uma análise SWOT/FOFA muito detalhada. Nos três relatórios gerados houve a consolidação das diferentes skills acionadas, mas em todos o nível de detalhamento ficou aquém do necessário em um caso real. Ou seja, as informações de interesse foram coletadas ou processadas, mas não chegaram ao relatório final.

Sobre o processo completo, contudo, permanece a percepção de que a política foi bem descrita e analisada, em especial quanto aos normativos e entes envolvidos com a política pública. Uma ressalva importante foi não explicitar nos riscos ou nas análises a qualidade do Cadastro Único, apesar de serem apontados os riscos geral de “Fragilidade cadastral e documental” e específico de “concessão indevida por validação insuficiente da renda familiar per capita”, que teria como causa falha no confronto de dados do cadastro (pressupondo-se “Cadastro Único”) com bases oficiais.

Por essa falha, consideramos a questão 1) como respondida parcialmente.

Como nos demais testes, a análise de riscos gerou um arquivo JSON com detalhamento de cinco riscos gerais (Falhas de elegibilidade e habilitação; Fragilidade cadastral e documental; Manutenção e pagamento indevido; Conformidade normativa e motivação decisória; e Governança, monitoramento e controle) e oito riscos específicos, ilustrados no Quadro 19. Os mesmos campos com base normativa resumida, avaliação dos riscos por probabilidade e impacto, prioridade (quadrante DVR) e justificativas constam deste arquivo.

Os riscos apontados são razoáveis, bem fundamentados e incluem questões transversais. Apesar de não mencionar diretamente o Cadastro Único, suas maiores fragilidades foram apontadas, como problemas de identificação de pessoas ou de renda e atualização do cadastro. Dessa forma, as questões 2) e 3) foram respondidas satisfatoriamente.

A avaliação de probabilidade, impacto e quadrante trazem a justificativa utilizada, e foram compatíveis com os graus sugeridos (alto/médio/baixo). A questão 4) foi respondida.

Utilizando como base as saídas das skills de análise de risco, análise SWOT/FOFA e desenvolvimento de tipologias, considera-se que o nível alcançado pelo agente foi avançado.

O texto produzido pelo agente foi criativo na sugestão de riscos, tipologias e testes de qualidade. Não se detectou, contudo, nível significativo de alucinação, respondendo à questão 6).

Os três testes realizados com o assistente estão consolidados no Quadro 5

**Quadro 5 – avaliação Agente VS Code – quadro resumo**

| Questão | Seguro-defeso | Aposentadoria por idade | BPC Idoso |
| --- | --- | --- | --- |
| 1) A política pública está bem descrita pela IA, no que se refere aos normativos aplicáveis e aos órgãos envolvidos no processo de operacionalização da política? | Sim | Sim | Sim, parcial |
| 2) Os riscos apontados pela IA são razoáveis, em comparação com os riscos apontados por auditores em fiscalizações tradicionais? | Sim | Sim | Sim |
| 3) Há riscos importantes que não foram apontados pela IA? | Não | Não | Não |
| 4) A matriz desenvolvida pela IA trouxe uma ponderação do risco (probabilidade e impacto) razoável? | Sim | Sim | Sim |
| 5) O nível de detalhes da resposta da IA é equivalente aos insumos trazidos por alguém de conhecimento básico, intermediário ou avançado? | Avançado | Avançado | Avançado |
| 6) Há sinais de alucinação ou erro no material produzido? | Não | Não | Não |

*Fonte: elaboração própria*
