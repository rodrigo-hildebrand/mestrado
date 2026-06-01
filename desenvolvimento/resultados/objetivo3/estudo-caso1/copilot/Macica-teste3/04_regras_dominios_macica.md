# Regras de Negócio e Domínios — MACICA

**Base:** BD_BENEFICIOS_HIST.dbo.MACICA
**Fonte:** sys.all_columns + tabelas COD_* (dados reais) + AEPS 2023 (gov.br)

---

## 1. Regras de negócio

| id | campo(s) | descrição | tipo | severidade |
|----|----------|-----------|------|-----------|
| R01 | NU_NB + ANO_MES_REF | Chave analítica composta: um NB pode aparecer em múltiplas competências; a combinação identifica univocamente um registro na folha. | UNICIDADE | Alta |
| R02 | D2_DIB, D2_DDB, D2_DCB | Consistência temporal: D2_DDB >= D2_DIB; D2_DCB (quando preenchido) >= D2_DDB. | VALIDAÇÃO | Alta |
| R03 | D2_DER, D2_DIB | DER deve ser <= DIB; o pedido não pode ser posterior ao início do benefício. | VALIDAÇÃO | Alta |
| R04 | D2_DIP | D2_DIP deve ser >= D2_DDB e próxima ao início da competência de pagamento. | VALIDAÇÃO | Alta |
| R05 | VL_LIQUIDO | VL_LIQUIDO = VL_BRUTO - TOT_DESCONTOS. Divergência indica inconsistência de rubrica. | DERIVAÇÃO | Alta |
| R06 | QT_RUBRICA_REG, CS_RUBRICA_N, VL_RUBRICA_N | QT_RUBRICA_REG deve igual ao número de pares CS_RUBRICA_N não nulos (N=1..10). | CONSISTÊNCIA | Média |
| R07 | CS_ESPECIE, CS_SITUACAO_BENEF | Para espécies por incapacidade temporária (31, 91), situação ativa (00) implica D2_LIMITE preenchido. | REGRA DE NEGÓCIO | Média |
| R08 | CS_ESPECIE, D2_OBITO_I | Para pensões por morte (21, 23, 29, 84, 93), D2_OBITO_I deve estar preenchido. | INTEGRIDADE | Alta |
| R09 | CS_ESPECIE, NM_INSTITUIDOR_I | Para espécies de pensão por morte, NM_INSTITUIDOR_I não deve ser vazio. | COMPLETUDE | Alta |
| R10 | CS_CLIENTELA | Deve ser 'U' ou 'R'. Outros valores indicam erro de carga. | DOMÍNIO | Alta |
| R11 | NU_CPF_T | CPF do titular deve ter 11 dígitos numéricos. Valores zerados ('00000000000') indicam ausência. | FORMATO | Média |
| R12 | ID_NIT_T | NIT/PIS do titular: 11 dígitos. Valores zerados indicam ausência; deve coexistir com CPF ou ser o identificador principal. | CONSISTÊNCIA | Média |
| R13 | CS_DOC_EMPREGADOR, NU_DOC_EMPREGADOR | Quando CS_DOC_EMPREGADOR=1, NU_DOC_EMPREGADOR deve ter 14 dígitos (CNPJ); quando =3, deve ter 11 (CPF). | VALIDAÇÃO | Média |
| R14 | CS_SEXO_T, CS_SEXO | CS_SEXO (campo consolidado) deve ser igual a CS_SEXO_T. Divergência indica registro inconsistente. | CONSISTÊNCIA | Baixa |
| R15 | ANO_MES_REF | Deve ser um AAAAMM válido (ano razoável 1990-2030, mês 01-12). | FORMATO | Média |
| R16 | Datas D2_* e DT_* (varchar8) | Todas as datas são armazenadas como varchar(8) no formato DDMMAAAA; conversão requer tratamento especial (não ISO). | FORMATO | Alta |
| R17 | CS_ESPECIE 87, 88 | BPC/LOAS (87 e 88) não têm caráter contributivo. Valor deve ser igual a 1 salário-mínimo vigente. | VALIDAÇÃO | Média |
| R18 | NU_NB_ANT | '0000000000' indica benefício original (sem antecessor). Valor diferente indica transformação/conversão de espécie. | SEMÂNTICA | Baixa |

---

## 2. Domínios dos principais campos codificados

### CS_CLIENTELA
| valor | significado |
|-------|-------------|
| U | Urbano |
| R | Rural |

### CS_SEXO / CS_SEXO_T / CS_SEXO_I / CS_SEXO_P / CS_SEXO_R
| valor | significado |
|-------|-------------|
| 1 | Masculino |
| 2 | Feminino |

### CS_ESPECIE (resumo por grupo)
| código(s) | tipo | espécies ativas (concessão) |
|-----------|------|-----------------------------|
| 41 | Aposentadoria por Idade | Sim |
| 42 | Aposentadoria por Tempo de Contribuição | Sim (regras de transição pós-EC 103/2019) |
| 46 | Aposentadoria Especial | Sim |
| 32 | Aposentadoria por Invalidez/Incapacidade Permanente | Sim |
| 92 | Aposentadoria por Invalidez Acidentária | Sim |
| 21 | Pensão por Morte Previdenciária | Sim |
| 23 | Pensão por Morte Ex-Combatente | Sim |
| 29 | Pensão por Morte Ex-Combatente Marítimo | Sim |
| 84 | Pensão por Morte Ex-SASSE | Sim |
| 31 | Auxílio-Doença Previdenciário | Sim |
| 91 | Auxílio-Doença Acidentário | Sim |
| 36 | Auxílio-Acidente Previdenciário | Sim |
| 25 | Auxílio-Reclusão | Sim |
| 87 | Amparo Social Pessoa com Deficiência (BPC/LOAS) | Sim |
| 88 | Amparo Social ao Idoso (BPC/LOAS) | Sim |
| demais | Espécies extintas ou históricas | Não |

### CS_SITUACAO_BENEF
| código | descrição |
|--------|-----------|
| 00 | ATIVO |
| 01 | EXCLUIDO |
| 02 | CESSADO |
| 03 | SUSPENSO |
| 04 | SUSPENSO POR MARCA DE ERRO |
| 05 | CESSADO POR CESS DO ORIGEM |
| 06 | SUSPENSO P/ SUSP DO ORIGEM |
| 07 | SUSPENSO PELO CONPAG |
| 08 | CESSADO PELO SISOBI |
| 09 | ESTAT TRANSF. ORGAO ORIGEM |
| 10 | RECEBENDO MENSALID DE RECUPER 6 MESES |
| 11 | RECEBENDO MENSALID DE RECUPER 18 MESES |
| 12 | SUSPENSO REVISAO RUR/URB |
| 13..24 | Demais suspensões/cessações especializadas |

### CS_MEIO_PAGTO
| código | descrição |
|--------|-----------|
| 01 | CMG — Cartão Magnético |
| 02 | CCF — Conta Corrente Fita Magnética |
| 03 | CCL — Conta Corrente Listagem |
| 04 | PAB — Pagamento Alternativo de Benefício |
| 05 | APB — Autorização de Pagamento de Benefício |
| 06 | CPB — Cheque de Pagamento de Benefício |
| 07 | OPB — Ordem de Pagamento de Benefício |
| 08 | RPB — Relação de Pagamento de Benefício |
| 09 | AP  — Autorização de Pagamento |

### CS_RAMO_ATIVIDADE
| código | descrição |
|--------|-----------|
| 01 | Bancário |
| 02 | Comerciário |
| 03 | Transportes e Carga |
| 04 | Ferroviário |
| 05 | Industriário |
| 06 | Marítimo |
| 07 | Servidor Público |
| 08 | Rural |
| 09 | Irrelevante |

### CS_FORMA_FILIACAO
| código | descrição |
|--------|-----------|
| 0 | Desempregado |
| 1 | Empregado |
| 2 | Avulso |
| 3 | Empresário |
| 4 | Doméstico |
| 5 | Facultativo |
| 6 | Rural Equiparado |
| 7 | Segurado Especial |
| 8 | Contribuinte Individual |
| 9 | Optante |

### CS_DOC_EMPREGADOR
| código | descrição |
|--------|-----------|
| 1 | CNPJ/CGC |
| 2 | CEI |
| 3 | CPF |
| 7 | NIT |
| 9 | Outro |

### CS_TIPO_R (representante legal)
| código | descrição |
|--------|-----------|
| 01 | Recursos |
| 02 | Ações Originárias |

---

## 3. Padrões de formato

| campo | formato | observação |
|-------|---------|------------|
| Todos campos D2_* e DT_* | DDMMAAAA (varchar 8) | NÃO é formato ISO; converter com SUBSTRING para SQL |
| NU_CPF, NU_CPF_T/I/P | 11 dígitos sem pontuação | '00000000000' = ausente |
| ID_NIT_T/I/P/R | 11 dígitos | Equivale ao PIS/PASEP/NIT |
| NU_NB | 10 dígitos | Inclui dígito verificador na última posição |
| ANO_MES_REF | AAAAMM (decimal 6) | Ex: 201401 = janeiro de 2014 |
| NM_ARQUIVO | D.SUB.APE.000.MAC.AAAAMM.NN | Permite inferir competência da carga |
| NU_NB_ANT = '0000000000' | Benefício original | Sem predecessores |
| CS_DIAGNOSTICO_N/1 | Código CID-10 | Pode ter ponto ou não; verificar conformidade com COD_CID |
