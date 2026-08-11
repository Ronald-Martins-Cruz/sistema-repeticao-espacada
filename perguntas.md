# Banco de perguntas discursivas — ATI Desenvolvimento de Software

Conceitos: `conceitos.md`. Calibração: as 70 questões de
`docs/provas/prova-texto.md` (DATAPREV/FGV, 17/11/2024) e o
`docs/provas/gabarito-prova.md`.

Formato lido pelo importador: `# PARTE`, `## <n.n> Título`, `**Qn.**`.
Tags de metadado (removidas do enunciado antes de gravar):
`[prova Qxx]`, `[distrator]`, `[caso]`, `[prof: Dn]`.

## Escala de profundidade D0–D5

Cada nível é definido pela **família de distrator da FGV que a resposta
derruba**. É esse o teste que torna a etiqueta verificável: se a pergunta não
elimina o distrator daquele nível, ela não é daquele nível.

| Nível | Exige | Distrator que derruba | Exemplo na prova |
|---|---|---|---|
| **D0** | ligar nome a uma característica única | o nome trocado dentro de uma lista de nomes | Q48 (Flutter/Dart), Q58 |
| **D1** | enunciar o que o conceito é | a definição inventada ou deslocada de finalidade | Q59 (objetivo do ETL), Q70 |
| **D2** | separar o conceito do vizinho | **a troca de lugar entre dois conceitos irmãos** | Q41, Q44, Q50, Q65, Q67 |
| **D3** | pertinência a conjunto fechado, número, prazo | o item plausível que não pertence ao rol; o número alterado | Q63, Q64, Q56, Q38 |
| **D4** | decidir a partir de cenário ou código | a decisão correta na teoria, errada naquele caso | Q45, Q49, Q54, Q68, Q69 |
| **D5** | explicar o mecanismo, derivar a consequência | (a prova não usou — nível de reserva) | ausente |

## Perfil medido da prova (questões 36–70)

D0 11% · D1 9% · **D2 34%** · **D3 26%** · D4 20% · D5 0%.
Mediana D2/D3. Centro de gravidade em fronteira e rol exato.

## Âncora híbrida

Toda pergunta é comparada contra alguma referência:

- **Conceito que caiu na prova** → contra a questão específica, marcada com
  `[prova Qxx]`. A etiqueta diz se ela está no nível daquela questão, abaixo
  ou acima.
- **Conceito que não caiu** → contra o perfil global acima. O alvo é a mediana
  D2/D3, com escada até D4.

## Escada por conceito

Cada seção sobe **D1 → D4**, sempre cobrindo o nível que a prova usou naquele
conceito e passando um degrau além. Seções em que a FGV chegou ao D4 recebem
também uma pergunta **D5**: 1.2, 2.4, 2.5, 2.7, 2.13 e 2.14.

Perguntas `[distrator]` nasceram de alternativas erradas da prova real.

---

# PARTE I Legislação Acerca de Segurança da Informação e Proteção de Dados

## 1.1 Lei de Acesso à Informação — Lei nº 12.527/2011 (LAI)

**Q1.** Segundo a LAI, o que é classificar uma informação quanto ao sigilo, e
qual é a regra geral do ordenamento que essa classificação excepciona?
`[prof: D1]`

**Q2.** Liste os três graus de sigilo previstos na LAI e informe, em anos, o
prazo máximo de restrição de acesso de cada um deles. `[prof: D3]`
`[prova Q36]`

**Q3.** Distinga desclassificação, reavaliação e redução do prazo de sigilo.
Diga, para cada uma, quem tem competência para realizá-la e o que a provoca.
`[prof: D2]` `[distrator]` `[prova Q36]`

**Q4.** Findo o prazo de classificação, ou ocorrido o evento que constitui seu
termo final, a informação se torna pública automaticamente ou é preciso
procedimento próprio e decisão específica? Justifique. `[prof: D3]`
`[distrator]` `[prova Q36]`

**Q5.** Indique quais autoridades têm competência para classificar informação
em cada um dos três graus de sigilo. `[prof: D3]`

**Q6.** A decisão que classifica uma informação é pública e acessível a
qualquer interessado? Explique em que grau de sigilo essa decisão é mantida e
o que dela deve constar. `[prof: D2]` `[distrator]` `[prova Q36]`

**Q7.** Existe hipótese em que a LAI proíbe qualquer restrição de acesso,
independentemente do grau de sigilo cabível? Qual é ela e qual a razão da
vedação. `[prof: D3]` `[prova Q36]`

**Q8.** Um órgão federal classifica como ultrassecreto, por 25 anos, o
relatório de uma operação em que agentes públicos são apontados como autores
de tortura. Um jornalista pede acesso e o órgão nega, invocando o prazo de
classificação ainda em curso. Avalie a legalidade da negativa e diga o que a
lei determina nesse caso. `[prof: D4]` `[caso]` `[prova Q36]`

---

## 1.2 Lei de Crimes Cibernéticos — Lei nº 12.737/2012 (art. 154-A do CP)

**Q9.** Descreva a conduta típica do art. 154-A do Código Penal e as
finalidades que o tipo penal exige do agente. `[prof: D1]`

**Q10.** A conexão do dispositivo invadido a uma rede de computadores é
elementar do crime de invasão de dispositivo informático? Fundamente com a
redação vigente do tipo. `[prof: D2]` `[distrator]` `[prova Q37]`

**Q11.** A "violação indevida de mecanismo de segurança" continua sendo
elementar do art. 154-A? Explique o que mudou na redação do tipo e qual o
efeito prático dessa mudança sobre a configuração do crime. `[prof: D2]`
`[distrator]` `[prova Q37]`

**Q12.** Enumere as causas de aumento de pena do art. 154-A, indicando a fração
de aumento de cada uma e, no caso do sujeito passivo qualificado, o rol de
autoridades protegidas. `[prof: D3]` `[prova Q37]`

**Q13.** Qual é a natureza da ação penal no crime de invasão de dispositivo
informático? Indique a regra e a exceção, e diga se a queixa-crime é via
adequada para deflagrá-la. `[prof: D2]` `[distrator]` `[prova Q37]`

**Q14.** O crime do art. 154-A se consuma com a mera invasão ou exige a efetiva
obtenção, adulteração ou destruição dos dados? Classifique o crime quanto ao
resultado e explique como fica a tentativa. `[prof: D2]` `[distrator]`
`[prova Q37]`

**Q15.** Descreva a figura qualificada do § 3º do art. 154-A: que resultado a
caracteriza e qual a pena cominada. `[prof: D3]`

**Q16.** Um atacante obtém previamente a senha de acesso e, com ela, entra no
tablet do vice-Presidente da Câmara dos Deputados, adulterando informações e
causando prejuízo político à Casa. Analise: houve crime do art. 154-A mesmo
sem violação de mecanismo de segurança? Qual fração de aumento incide? Quem é
legitimado a promover a ação penal? `[prof: D4]` `[caso]` `[prova Q37]`

**Q17.** Explique por que o legislador escolheu a representação da vítima como
condição da ação penal na regra geral do art. 154-A, e por que essa condição
cai quando o crime é praticado contra a administração pública. `[prof: D5]`

---

## 1.3 Marco Civil da Internet — Lei nº 12.965/2014

**Q18.** Qual é o objeto do Marco Civil da Internet e o que, especificamente,
os dispositivos sobre proteção a registros, dados pessoais e comunicações
privadas exigem dos provedores? `[prof: D1]`

**Q19.** Liste as sanções previstas no Marco Civil da Internet para o
descumprimento das normas de proteção a registros e dados pessoais.
`[prof: D3]` `[prova Q38]`

**Q20.** As sanções do Marco Civil podem ser aplicadas cumulativamente ou
apenas de forma isolada? Reproduza a regra legal. `[prof: D2]` `[distrator]`
`[prova Q38]`

**Q21.** Descreva com precisão o cálculo da multa prevista no Marco Civil:
percentual, se é teto ou valor fixo, sobre qual base incide, referente a qual
período e com quais exclusões. `[prof: D3]` `[distrator]` `[prova Q38]`

**Q22.** A advertência prevista no Marco Civil tem apenas caráter repressivo?
Explique o que a lei exige que a advertência contenha e o efeito disso.
`[prof: D2]` `[distrator]` `[prova Q38]`

**Q23.** O Marco Civil deixa as empresas estrangeiras fora do seu regramento
sancionatório? Explique como a lei alcança a atuação delas no Brasil.
`[prof: D3]` `[distrator]` `[prova Q38]`

**Q24.** Quanto à guarda de registros no Marco Civil, informe: quem guarda
registro de conexão e por quanto tempo; quem guarda registro de acesso a
aplicações e por quanto tempo; e quais requisitos o provedor de aplicações
precisa cumprir para estar sujeito a essa obrigação. `[prof: D3]`

**Q25.** Um provedor de aplicações com sede no exterior, mas com filial no
Brasil, coleta dados pessoais de usuários brasileiros sem consentimento e
descumpre ordem de regularização anterior. Indique quais sanções do Marco
Civil podem ser aplicadas, se podem incidir ao mesmo tempo, e quem responde
pelo pagamento da multa. `[prof: D4]` `[caso]` `[prova Q38]`

---

## 1.4 Lei Geral de Proteção de Dados Pessoais — Lei nº 13.709/2018 (LGPD)

**Q26.** Que matéria o capítulo de fiscalização da LGPD disciplina e qual órgão
detém competência exclusiva para aplicar as sanções nele previstas?
`[prof: D1]`

**Q27.** Enumere as sanções administrativas previstas no art. 52 da LGPD.
`[prof: D3]` `[prova Q39]`

**Q28.** Informe os dois limites da multa simples da LGPD: o percentual, sobre
qual base ele incide, e o teto em reais por infração. `[prof: D3]`
`[prova Q39]`

**Q29.** É possível aplicar sanção da LGPD sem processo administrativo prévio
quando ficar comprovado que o agente de tratamento é violador contumaz?
Fundamente. `[prof: D2]` `[distrator]` `[prova Q39]`

**Q30.** Cite ao menos seis parâmetros que a LGPD manda considerar na dosimetria
da sanção e aponte um critério de aparência plausível que a lei **não** prevê.
`[prof: D3]` `[distrator]` `[prova Q39]`

**Q31.** Quais sanções da LGPD podem ser aplicadas a órgãos e entidades
públicas, e quais estão excluídas? Diga também o que a lei manda considerar
quando o infrator é ente público. `[prof: D3]` `[distrator]` `[prova Q39]`

**Q32.** Qual é a destinação do produto da arrecadação das multas aplicadas
pela ANPD, inscritas ou não em dívida ativa? `[prof: D3]` `[distrator]`
`[prova Q39]`

**Q33.** Defina controlador, operador, encarregado e titular na LGPD. Em
seguida, explique o critério que separa controlador de operador quando ambos
tratam os mesmos dados. `[prof: D2]`

**Q34.** Uma autarquia estadual sofre vazamento de dados de 200 mil cidadãos
por configuração indevida de um bucket público. Apurou-se que havia política
de boas práticas documentada, que a autarquia comunicou o incidente
espontaneamente em 48 horas e que é a primeira ocorrência. Indique quais
sanções são cabíveis, quais não são, e quais parâmetros de dosimetria pesam a
favor do infrator. `[prof: D4]` `[caso]` `[prova Q39]`

**Q35.** Compare os regimes sancionatórios do Marco Civil e da LGPD quanto ao
percentual da multa, à base de cálculo e à existência de teto absoluto.
`[prof: D2]`

---

## 1.5 Autoridade Nacional de Proteção de Dados (ANPD)

**Q36.** O que é a ANPD e quais são suas três grandes frentes de competência?
`[prof: D1]`

**Q37.** Qual é a natureza jurídica atual da ANPD e sua posição na
administração pública federal? Explique o que mudou em relação à natureza que
ela tinha na redação original da LGPD. `[prof: D2]` `[distrator]`
`[prova Q40]`

**Q38.** Descreva a composição do Conselho Diretor da ANPD: número de membros,
forma de nomeação, exigência de aprovação legislativa e duração do mandato.
`[prof: D3]` `[prova Q40]`

**Q39.** Além do Conselho Diretor, quais órgãos integram a estrutura da ANPD?
`[prof: D3]` `[prova Q40]`

**Q40.** Distinga ANPD e CNPD quanto à natureza, à composição e ao poder de
sancionar. Aponte qual dos dois edita normas e fiscaliza, e qual apenas propõe
e sugere. `[prof: D2]` `[distrator]` `[prova Q40]`

**Q41.** Uma empresa é multada pela ANPD e alega, em defesa, que o Conselho
Diretor não poderia decidir porque não conta com representantes do Senado e da
Câmara em sua composição. Avalie o argumento e explique onde está a confusão
institucional. `[prof: D4]` `[caso]` `[prova Q40]`

---

## 1.6 Conselho Nacional de Proteção de Dados Pessoais e da Privacidade (CNPD)

**Q42.** O que é o CNPD e qual é sua natureza no desenho institucional da
LGPD? `[prof: D1]`

**Q43.** Descreva a composição do CNPD: número total de representantes e quais
segmentos e instituições os indicam. `[prof: D3]` `[prova Q40]`

**Q44.** Enumere as atribuições do CNPD previstas na LGPD. `[prof: D3]`
`[prova Q40]`

**Q45.** O CNPD é órgão integrante da estrutura da ANPD ou entidade autônoma
externa a ela? Explique a relação institucional entre os dois e por que o
Conselho Diretor não se confunde com o CNPD. `[prof: D2]` `[distrator]`
`[prova Q40]`

**Q46.** Os membros do CNPD são remunerados pelo exercício da função? Explique
também como é a investidura e o que a lei prevê sobre a perda do cargo.
`[prof: D2]` `[distrator]` `[prova Q40]`

**Q47.** Uma associação de defesa do consumidor quer que o Estado brasileiro
edite norma obrigando anonimização em determinado setor. Indique a qual das
duas figuras — ANPD ou CNPD — ela deve dirigir a demanda para obter norma com
força vinculante, e qual seria o papel da outra nesse processo. `[prof: D4]`
`[caso]` `[prova Q40]`

---

# PARTE II Conhecimentos Específicos

## 2.1 Frameworks e Plataforma Java

**Q48.** O que é o Spring Framework e o que significam, nele, inversão de
controle e injeção de dependência? `[prof: D1]`

**Q49.** Distinga Spring Boot de Spring Cloud: qual dos dois resolve
autoconfiguração e inicialização da aplicação, e qual resolve os problemas de
sistemas distribuídos? `[prof: D2]` `[distrator]` `[prova Q41]`

**Q50.** Qual dos dois é framework de mapeamento objeto-relacional e qual é
framework de testes de unidade: Hibernate ou JUnit? Descreva o que cada um
faz. `[prof: D2]` `[distrator]` `[prova Q41]`

**Q51.** O Spring Boot elimina a configuração manual de dependências e
servidores, mas ainda exige que se use Tomcat ou JBoss em modo standalone?
Explique a diferença entre servidor embarcado e servidor standalone.
`[prof: D2]` `[distrator]` `[prova Q41]`

**Q52.** Explique o que é um *starter* do Spring Boot e o que exatamente a
autoconfiguração faz durante a inicialização da aplicação. `[prof: D3]`

**Q53.** Liste os problemas típicos de sistemas distribuídos que o Spring Cloud
se propõe a resolver, nomeando o recurso correspondente a cada um.
`[prof: D3]` `[prova Q41]`

**Q54.** O Spring é um framework voltado exclusivamente ao desenvolvimento de
aplicações monolíticas? Fundamente. `[prof: D2]` `[distrator]` `[prova Q41]`

**Q55.** Distinga Tomcat de JBoss/WildFly quanto ao que cada um implementa da
plataforma Java corporativa, e diga em que situação a escolha entre eles é
indiferente. `[prof: D3]`

**Q56.** Uma equipe vai construir cinco serviços independentes, com
configuração centralizada, descoberta de serviços e tolerância a falhas entre
eles, cada um empacotado como artefato executável único. Indique quais
projetos do ecossistema Spring atendem a cada exigência e justifique.
`[prof: D4]` `[caso]` `[prova Q41]`

---

## 2.2 Formatos e Tecnologias de Dados e Marcação

**Q57.** O que é XSLT, sobre que tipo de documento ele opera e em que formatos
de saída pode produzir resultado? `[prof: D1]` `[prova Q42]`

**Q58.** O XSLT é uma linguagem para transformar documentos JSON em outros
formatos? Explique. `[prof: D2]` `[distrator]` `[prova Q42]`

**Q59.** Compare XML e JSON quanto a verbosidade, legibilidade e compactação, e
diga qual dos dois predomina hoje em APIs web e por quê. `[prof: D2]`
`[distrator]` `[prova Q42]`

**Q60.** XML e JSON são estritamente equivalentes em expressividade? Cite
recursos do XML que não têm correspondente direto no JSON. `[prof: D2]`
`[distrator]` `[prova Q42]`

**Q61.** Enumere os recursos do ecossistema XML que sustentam contratos e
validação de documentos, indicando a função de cada um. `[prof: D3]`

**Q62.** Quais tipos de dados o JSON suporta nativamente? Aponte ao menos dois
tipos comuns em sistemas corporativos que ele **não** representa nativamente e
explique como se costuma contorná-los. `[prof: D3]`

**Q63.** Por que o JSON se tornou o formato dominante no transporte de dados
entre cliente e servidor em APIs? `[prof: D2]` `[prova Q42]`

**Q64.** Um sistema precisa trocar documentos fiscais com validação estrutural
obrigatória, assinatura digital sobre trechos do documento e contrato
verificável entre as partes. Outro precisa alimentar um front-end SPA com
listas paginadas em chamadas de baixa latência. Escolha o formato para cada
caso e justifique. `[prof: D4]` `[caso]` `[prova Q42]`

---

## 2.3 Design e Arquitetura de Software

**Q65.** O que é design de software e em que ele se distingue da atividade de
codificação? `[prof: D1]`

**Q66.** Qual é a principal diferença entre Arquitetura de Software e Design de
Software quanto ao alcance das decisões tomadas em cada um? `[prof: D2]`
`[distrator]` `[prova Q43]`

**Q67.** Qual dos dois — design de alto nível ou design de baixo nível — trata
da estrutura geral do sistema, com definição de módulos e suas interações? E
qual trata da implementação de funções e métodos específicos? `[prof: D2]`
`[distrator]` `[prova Q43]`

**Q68.** O design de software é o processo de codificar funcionalidades
seguindo diretamente os requisitos do usuário, sem envolver abstrações ou
estruturas maiores? Fundamente. `[prof: D2]` `[distrator]` `[prova Q43]`

**Q69.** A Arquitetura de Software é conceito aplicável apenas a projetos de
grande escala, sendo irrelevante em sistemas menores? Fundamente. `[prof: D2]`
`[distrator]` `[prova Q43]`

**Q70.** Defina módulo, componente e interface, e explique o que significa
dizer que a arquitetura define as **interações** entre eles. `[prof: D3]`

**Q71.** Explique o papel da abstração e da modularização como instrumentos de
decisão estrutural, e o que se perde quando um sistema é modularizado por
critério errado. `[prof: D3]`

**Q72.** Numa reunião, decide-se (i) que o sistema terá três camadas com
comunicação apenas por interface, (ii) que o repositório de clientes usará
cache em memória com expiração de 5 minutos e (iii) que o método de cálculo de
juros ficará em classe utilitária estática. Classifique cada decisão como
arquitetural, de design de alto nível ou de design de baixo nível, e
justifique. `[prof: D4]` `[caso]` `[prova Q43]`

---

## 2.4 Princípios SOLID

**Q73.** Enuncie os cinco princípios SOLID, dando o nome e a formulação de cada
um. `[prof: D1]`

**Q74.** Explique o Princípio da Responsabilidade Única e diga por que "uma
responsabilidade" não é o mesmo que "uma única função ou método".
`[prof: D2]`

**Q75.** Explique o Princípio Aberto/Fechado: aberto para o quê, fechado para o
quê, e por qual mecanismo da orientação a objetos isso se obtém na prática.
`[prof: D2]`

**Q76.** Uma subclasse que sobrescreve um método herdado e altera seu
comportamento viola, por esse fato, o Princípio da Substituição de Liskov?
Fundamente. `[prof: D2]` `[distrator]` `[prova Q49]`

**Q77.** Enumere as restrições que o Princípio da Substituição de Liskov impõe
a uma subclasse quanto a pré-condições, pós-condições, invariantes e exceções
lançadas. `[prof: D3]` `[prova Q49]`

**Q78.** Distinga o Princípio da Segregação de Interfaces do Princípio da
Responsabilidade Única: os dois falam de "fazer menos coisas", mas incidem
sobre alvos diferentes. Qual é cada alvo? `[prof: D2]`

**Q79.** Distinga o Princípio da Inversão de Dependência da técnica de injeção
de dependência. Um pode existir sem o outro? `[prof: D2]`

**Q80.** Considere uma classe `Retangulo` com `setLargura` e `setAltura`, e uma
subclasse `Quadrado` que sobrescreve ambos para manter os lados iguais. Um
cliente escrito contra `Retangulo` define largura 5, altura 4 e espera área 20.
Indique se há violação de LSP, qual restrição foi quebrada, e por que o
compilador não acusa nada. `[prof: D4]` `[caso]` `[prova Q49]`

**Q81.** Explique por que a violação de LSP quase sempre nasce de uma relação
de herança modelada como "é um" no vocabulário do domínio, mas não no
comportamento observável. `[prof: D5]` `[prova Q49]`

---

## 2.5 Orientação a Objetos

**Q82.** Defina herança, sobrescrita e polimorfismo, e explique como os três se
articulam numa chamada de método em tempo de execução. `[prof: D1]`

**Q83.** O propósito da sobrescrita é justamente especializar o comportamento
herdado. Sendo assim, quando é que especializar comportamento passa a ser
defeito? `[prof: D2]` `[distrator]` `[prova Q49]`

**Q84.** Distinga sobrecarga de sobrescrita quanto à assinatura, ao momento da
resolução e ao efeito sobre o polimorfismo. `[prof: D2]`

**Q85.** O que compõe o contrato de uma classe além das assinaturas dos
métodos, e por que essa parte do contrato não é verificada pelo compilador?
`[prof: D3]`

**Q86.** O princípio da substituição exige que o método sobrescrito seja
exatamente igual ao da classe base? E exige que ele lance exceção quando
chamado? Responda às duas e explique de onde vêm esses dois equívocos.
`[prof: D2]` `[distrator]` `[prova Q49]`

**Q87.** Dado o código em que `Cachorro extends Animal` sobrescreve
`emitirSom()` para imprimir "Latido" no lugar de "Som genérico", diga se o
código respeita a Substituição de Liskov e justifique em termos de corretude do
programa cliente. `[prof: D4]` `[caso]` `[prova Q49]`

**Q88.** O que significa, com precisão, dizer que a corretude do programa é
preservada ao substituir a classe base pela derivada? Corretude aferida por
quem, e observada de onde? `[prof: D5]` `[prova Q49]`

---

## 2.6 Redes Corporativas e Ambiente Web

**Q89.** Defina Internet, intranet e extranet quanto ao alcance e ao público
autorizado de cada uma. `[prof: D1]`

**Q90.** Qual das três — Internet, intranet ou extranet — usa tecnologias da
Internet para dar acesso controlado a parceiros externos autorizados, além dos
usuários internos? `[prof: D2]` `[distrator]` `[prova Q44]`

**Q91.** Um portal corporativo interno é uma página acessada publicamente, que
centraliza informações e serviços para clientes e fornecedores? Corrija a
afirmação e defina o que um portal corporativo interno de fato é. `[prof: D2]`
`[distrator]` `[prova Q44]`

**Q92.** Distinga servidor web de servidor de aplicações quanto à função
principal, ao tipo de conteúdo entregue e à relação com a lógica de negócios e
os bancos de dados. `[prof: D2]` `[distrator]` `[prova Q50]`

**Q93.** O servidor web é responsável exclusivamente por conteúdo estático?
Explique como ele participa da entrega de conteúdo dinâmico. `[prof: D2]`
`[distrator]` `[prova Q50]`

**Q94.** O balanceamento de carga é atribuição do servidor de aplicações?
Explique onde o balanceamento costuma ficar na arquitetura web e qual seu
objetivo. `[prof: D2]` `[distrator]` `[prova Q50]`

**Q95.** Cite produtos típicos de cada categoria — servidor web e servidor de
aplicações — e explique por que alguns produtos aparecem nas duas listas.
`[prof: D3]`

**Q96.** Uma multinacional precisa: publicar o catálogo público de produtos;
dar aos funcionários acesso a holerite e circulares internas; e permitir que
distribuidores homologados consultem estoque e emitam pedidos. Indique que
tipo de rede atende a cada necessidade e que tipo de servidor sustenta cada
uma. `[prof: D4]` `[caso]` `[prova Q44]`

---

## 2.7 Integração de Sistemas, SOA e Web Services

**Q97.** O que é Arquitetura Orientada a Serviços e quais são seus dois
objetivos declarados quanto a acoplamento e interoperabilidade? `[prof: D1]`

**Q98.** Compare Web Services RESTful e SOAP quanto ao contrato, ao formato das
mensagens, ao acoplamento resultante e à independência de plataforma.
`[prof: D2]` `[prova Q45]`

**Q99.** Enumere as restrições arquiteturais do estilo REST e explique o que
cada uma exige. `[prof: D3]`

**Q100.** Implementar serviços SOAP **sem** definição de contratos formais
aumenta a flexibilidade da comunicação? Fundamente. `[prof: D2]` `[distrator]`
`[prova Q45]`

**Q101.** O que é WSDL, a que tecnologia ele se associa e o que exatamente ele
descreve? `[prof: D3]` `[distrator]` `[prova Q45]`

**Q102.** Uma integração em que a mudança em um serviço se reflete diretamente
no outro caracteriza baixo ou alto acoplamento? Defina os dois termos e diga
qual deles a SOA busca. `[prof: D2]` `[distrator]` `[prova Q45]`

**Q103.** Adotar arquitetura monolítica, com todos os provedores de pagamento
integrados diretamente ao sistema, elimina a necessidade de web services e
melhora o desempenho? Avalie o ganho e o custo dessa escolha. `[prof: D2]`
`[distrator]` `[prova Q45]`

**Q104.** Uma empresa de comércio eletrônico vai integrar quatro provedores de
pagamento externos, cada um com evolução independente e stack tecnológico
próprio. Indique a tecnologia de integração adequada para garantir baixo
acoplamento e alta interoperabilidade, e explique por que RPC com contrato
rígido seria escolha pior. `[prof: D4]` `[caso]` `[prova Q45]`

**Q105.** Explique por que a ausência de estado no servidor (statelessness)
reduz acoplamento e habilita escalabilidade horizontal, e qual custo ela
transfere ao cliente. `[prof: D5]` `[prova Q45]`

---

## 2.8 Segurança em Comunicações Web

**Q106.** O que o HTTPS acrescenta ao HTTP, e quais garantias de segurança
resultam disso? `[prof: D1]`

**Q107.** Qual é a relação entre SSL e TLS? Indique qual sucedeu qual e o que
motivou a substituição. `[prof: D2]` `[distrator]` `[prova Q46]`

**Q108.** SSL e TLS são usados conjuntamente, cabendo ao SSL a autenticação e
ao TLS a criptografia dos dados? Corrija a afirmação. `[prof: D2]`
`[distrator]` `[prova Q46]`

**Q109.** SSL e TLS são intercambiáveis, oferecendo o mesmo nível de segurança
e diferindo apenas na compatibilidade com navegadores? Fundamente.
`[prof: D2]` `[distrator]` `[prova Q46]`

**Q110.** Descreva as etapas do handshake TLS, indicando em que momento ocorre
a autenticação do servidor e em que momento passa a valer a criptografia
simétrica. `[prof: D3]`

**Q111.** O que um certificado digital de servidor contém, quem o assina e o
que exatamente o navegador verifica ao recebê-lo. `[prof: D3]`

**Q112.** Informe quais versões de SSL e de TLS estão hoje depreciadas e quais
seguem em uso recomendado. `[prof: D3]`

**Q113.** Um site exibe cadeado no navegador. Um gestor conclui que o site é
confiável e que os dados armazenados no servidor estão protegidos. Aponte o que
o HTTPS efetivamente garante e o que essa conclusão extrapola. `[prof: D4]`
`[caso]` `[prova Q46]`

---

## 2.9 Métricas, Estimativas e Mensuração de Software

**Q114.** O que a Análise de Pontos de Função mede e a partir de que insumo ela
é calculada? `[prof: D1]`

**Q115.** Qual das duas técnicas oferece mensuração objetiva e independente do
time de desenvolvimento: Ponto de Função ou Story Points? Fundamente.
`[prof: D2]` `[distrator]` `[prova Q47]`

**Q116.** Story Points permitem melhor padronização de estimativas entre
projetos e times diferentes? Explique por que a comparabilidade entre equipes é
justamente o ponto fraco deles. `[prof: D2]` `[distrator]` `[prova Q47]`

**Q117.** Qual das duas técnicas é adequada a contratos formais com escopo
fechado e orçamento rígido, e por quê a outra não é? `[prof: D2]`
`[distrator]` `[prova Q47]`

**Q118.** O Ponto de Função é mais flexível por levar em conta o contexto
subjetivo do time ao estimar o esforço? Corrija a afirmação, separando o que é
objetivo do que é subjetivo em cada técnica. `[prof: D2]` `[distrator]`
`[prova Q47]`

**Q119.** Distinga estimativa de **tamanho** de estimativa de **esforço**, e
explique como se converte uma na outra. `[prof: D2]` `[prova Q47]`

**Q120.** Enumere os tipos de função contados na APF, separando os de dados dos
de transação. `[prof: D3]`

**Q121.** Um órgão público vai contratar fábrica de software por escopo
fechado, com medição de entrega auditável por terceiro, e internamente a equipe
quer planejar sprints de duas semanas. Indique qual técnica serve a cada
finalidade e por que usar a mesma para as duas seria erro. `[prof: D4]`
`[caso]` `[prova Q47]`

---

## 2.10 Desenvolvimento Mobile

**Q122.** Qual framework de desenvolvimento multiplataforma para Android e iOS
utiliza a linguagem Dart? `[prof: D0]` `[prova Q48]`

**Q123.** Distinga desenvolvimento nativo de desenvolvimento multiplataforma
quanto a esforço de codificação, desempenho e acesso a recursos do dispositivo.
`[prof: D1]` `[prova Q48]`

**Q124.** Associe cada framework à sua linguagem ou tecnologia de base: Flutter,
React Native, Xamarin, Ionic e SwiftUI. `[prof: D3]` `[distrator]`
`[prova Q48]`

**Q125.** O SwiftUI é um framework multiplataforma para Android e iOS? Explique
a que plataformas ele efetivamente se destina. `[prof: D2]` `[distrator]`
`[prova Q48]`

**Q126.** Distinga a abordagem do Ionic da abordagem do React Native quanto à
forma como a interface é renderizada no dispositivo. `[prof: D2]`

**Q127.** Explique como o Flutter renderiza sua interface e por que essa
escolha o diferencia dos frameworks que mapeiam componentes para widgets
nativos. `[prof: D3]`

**Q128.** Uma equipe pequena precisa lançar em Android e iOS em quatro meses,
com telas muito customizadas e uso intenso de câmera e sensores, e a empresa já
tem um time forte em TypeScript. Avalie as opções multiplataforma e o custo de
ir nativo, indicando a escolha e os riscos assumidos. `[prof: D4]` `[caso]`
`[prova Q48]`

---

## 2.11 Arquiteturas de Aplicações Front-end

**Q129.** O que caracteriza uma Single Page Application quanto ao carregamento
inicial e à navegação entre telas? `[prof: D1]`

**Q130.** Distinga SPA de PWA. Aponte qual das duas se define pela navegação
sem recarregar a página e qual se define pela possibilidade de instalação no
dispositivo com experiência próxima à de aplicativo nativo. `[prof: D2]`
`[distrator]` `[prova Q51]`

**Q131.** Uma SPA requer Service Workers para funcionar? Explique de qual das
duas arquiteturas o Service Worker é peça essencial. `[prof: D2]`
`[distrator]` `[prova Q51]`

**Q132.** O que um Service Worker permite fazer que a página comum não permite?
Enumere as capacidades. `[prof: D3]` `[prova Q51]`

**Q133.** SPA e PWA dependem exclusivamente de frameworks JavaScript, sendo
impossível implementá-las sem eles? Fundamente. `[prof: D2]` `[distrator]`
`[prova Q51]`

**Q134.** Enumere os requisitos técnicos mínimos para que uma aplicação web
seja considerada instalável como PWA. `[prof: D3]`

**Q135.** Uma SPA e uma PWA são mutuamente exclusivas? Explique a relação
possível entre as duas. `[prof: D2]` `[prova Q51]`

**Q136.** Uma seguradora quer que os peritos de campo consultem apólices e
registrem laudos em áreas sem cobertura de rede, com o ícone do sistema na tela
inicial do celular e sem publicar em loja de aplicativos. Indique a arquitetura
front-end adequada, os recursos que a viabilizam e o que ela ainda assim não
resolve. `[prof: D4]` `[caso]` `[prova Q51]`

---

## 2.12 Testes de Software

**Q137.** O que um teste unitário verifica e qual é a unidade típica sob teste?
`[prof: D1]` `[prova Q52]`

**Q138.** Distinga teste unitário de teste de integração quanto ao alvo da
verificação e ao que cada um consegue e não consegue detectar. `[prof: D2]`
`[distrator]` `[prova Q52]`

**Q139.** O que um teste de usabilidade avalia e por que ele não substitui nem é
substituído por testes automatizados. `[prof: D2]` `[prova Q52]`

**Q140.** No TDD, os testes são escritos antes ou depois do código funcional?
Explique qual efeito essa ordem produz sobre o desenho do código.
`[prof: D2]` `[distrator]` `[prova Q52]`

**Q141.** Descreva o ciclo do TDD, nomeando suas três etapas e o que se faz em
cada uma. `[prof: D3]` `[prova Q52]`

**Q142.** Descreva a pirâmide de testes: quais níveis a compõem, em que
proporção e qual o critério que justifica essa proporção. `[prof: D3]`

**Q143.** Todo teste automatizado é teste unitário? E todo teste unitário é
automatizado? Responda às duas e explique por que a confusão entre os dois
termos é comum. `[prof: D2]` `[distrator]` `[prova Q52]`

**Q144.** Uma equipe tem 900 testes verdes, todos exercitando classes isoladas
com todas as dependências substituídas por dublês, e mesmo assim a integração
com o gateway de pagamento quebra em produção a cada release. Diagnostique a
lacuna e indique que tipos de teste faltam. `[prof: D4]` `[caso]` `[prova Q52]`

---

## 2.13 Metodologias Ágeis e Gerenciamento de Projetos

**Q145.** Enuncie os quatro valores do Manifesto Ágil, na forma "X mais que Y",
e explique o que a expressão "mais que" não autoriza concluir. `[prof: D1]`

**Q146.** Distinga Scrum de Kanban quanto a ciclos de tempo, momento da entrega,
forma de limitar trabalho em andamento e prescrição de papéis e eventos.
`[prof: D2]` `[distrator]` `[prova Q53]`

**Q147.** Enumere os papéis do Scrum e a responsabilidade central de cada um.
`[prof: D3]` `[prova Q68]`

**Q148.** Enumere os eventos do Scrum, informando o propósito de cada um e a
quem cabe conduzi-lo. `[prof: D3]` `[prova Q69]`

**Q149.** Distinga Product Backlog, Sprint Backlog e Sprint Goal, indicando
quem é responsável por cada artefato. `[prof: D3]` `[prova Q69]`

**Q150.** Diante de um impedimento levantado no Daily Scrum, cabe ao Scrum
Master redistribuir as tarefas por conta própria, assumir a tarefa do
desenvolvedor, ou facilitar para que o time encontre a solução? Fundamente na
postura esperada do papel. `[prof: D2]` `[distrator]` `[prova Q68]`

**Q151.** O Product Owner deve decidir sozinho quais itens entram no Sprint?
Explique a divisão de decisão entre PO e time no Sprint Planning.
`[prof: D2]` `[distrator]` `[prova Q69]`

**Q152.** Explique o que é a capacidade do time e por que colocar no Sprint mais
itens do que ela comporta é prejudicial mesmo quando "sobra alguma coisa para o
próximo Sprint". `[prof: D2]` `[prova Q69]`

**Q153.** Caracterize XP, Lean, Waterfall e a abordagem Ágil Híbrida,
apontando o traço que distingue cada uma das demais. `[prof: D3]`
`[distrator]` `[prova Q70]`

**Q154.** Num projeto de alta complexidade, com requisitos que mudam com
frequência e necessidade de entregas rápidas em ciclos incrementais, com
priorização de valor ao cliente por feedback contínuo, qual metodologia ágil é
a mais adequada? Justifique e explique por que Kanban, XP e Lean, ainda que
ágeis, não são a melhor resposta a esse enunciado específico. `[prof: D4]`
`[caso]` `[prova Q53]`

**Q155.** Um desenvolvedor avisa no Daily que não concluirá sua tarefa até o
fim do Sprint. Descreva a sequência de ações correta do Scrum Master e do time,
e diga o que aconteceria com o Sprint Goal em cada alternativa errada
(assumir a tarefa, escalar ao PO, encerrar o Sprint mais cedo). `[prof: D4]`
`[caso]` `[prova Q68]`

**Q156.** Explique por que o Scrum atribui ao time, e não ao Scrum Master, a
decisão de reorganizar o trabalho dentro do Sprint. O que se perde,
concretamente, quando o Scrum Master decide sozinho? `[prof: D5]`
`[prova Q68]`

---

## 2.14 Engenharia de Requisitos

**Q157.** Distinga requisito funcional de requisito não funcional e dê um
exemplo de cada num sistema bancário. `[prof: D1]` `[prova Q54]`

**Q158.** A exigência de que o saldo da conta passe a ser apresentado em tempo
real é requisito funcional ou não funcional? Fundamente pelo critério que
separa as duas categorias. `[prof: D2]` `[distrator]` `[prova Q54]`

**Q159.** Enumere as técnicas de elicitação de requisitos e descreva
brevemente cada uma. `[prof: D3]` `[prova Q54]`

**Q160.** Uma entrevista com o gerente do projeto é exemplo de técnica de
prototipação? Distinga as duas técnicas quanto ao que produzem. `[prof: D2]`
`[distrator]` `[prova Q54]`

**Q161.** Uma sessão de brainstorming com a equipe de desenvolvimento é técnica
inadequada de elicitação, por não envolver usuários finais? Avalie a
afirmação. `[prof: D2]` `[distrator]` `[prova Q54]`

**Q162.** Em que ponto do ciclo de vida do software se posiciona a engenharia
de requisitos, e por que a ideia de que ela ocorre após a implementação é
equivocada? `[prof: D2]` `[distrator]` `[prova Q54]`

**Q163.** Distinga verificação de validação de requisitos, indicando a pergunta
que cada uma responde. `[prof: D2]`

**Q164.** Um cliente pede "um relatório de vendas que abra rápido". Decomponha
esse pedido nos requisitos funcionais e não funcionais implicados, tornando
cada um verificável, e indique que técnica de elicitação você usaria para
fechar cada lacuna. `[prof: D4]` `[caso]` `[prova Q54]`

**Q165.** Explique por que classificar um requisito não funcional como
funcional costuma sair caro, e em que momento do projeto o erro normalmente
aparece. `[prof: D5]` `[prova Q54]`

---

## 2.15 DevOps

**Q166.** O que é Integração Contínua e qual problema de desenvolvimento em
equipe ela ataca? `[prof: D1]` `[prova Q55]`

**Q167.** Qual conceito descreve, única e corretamente, a prática de fornecer
rapidamente uma nova versão ao ambiente de produção com o mínimo de
interrupção para os usuários? `[prof: D1]` `[prova Q55]`

**Q168.** Distinga Entrega Contínua de Implantação Contínua: onde exatamente
está a diferença entre as duas. `[prof: D2]` `[distrator]` `[prova Q55]`

**Q169.** Distinga Integração Contínua de Entrega Contínua quanto ao que cada
uma automatiza e ao artefato que cada uma produz. `[prof: D2]` `[distrator]`
`[prova Q55]`

**Q170.** Defina gerenciamento de configuração, monitoramento contínuo e
controle de versão, e explique por que nenhum dos três é a resposta para
"publicar nova versão em produção com mínima interrupção". `[prof: D3]`
`[distrator]` `[prova Q55]`

**Q171.** Enumere estratégias de publicação que reduzem a interrupção percebida
pelo usuário, explicando o mecanismo de cada uma. `[prof: D3]` `[prova Q55]`

**Q172.** DevOps é um conjunto de ferramentas ou uma cultura? Fundamente
apontando o que não se resolve comprando ferramenta. `[prof: D2]`

**Q173.** Uma equipe integra e testa a cada commit, gera artefato versionado e
o mantém sempre pronto para produção, mas a subida depende de aprovação manual
do gerente. Classifique a maturidade dessa esteira nos termos de CI, Entrega
Contínua e Implantação Contínua, e diga o que falta para o estágio seguinte.
`[prof: D4]` `[caso]` `[prova Q55]`

---

## 2.16 Blockchain

**Q174.** O que é um bloco em uma blockchain e o que significa dizer que os
blocos são encadeados? `[prof: D1]`

**Q175.** Enumere os elementos armazenados diretamente em um bloco de uma
blockchain pública como Bitcoin ou Ethereum. `[prof: D3]` `[prova Q56]`

**Q176.** O registro de saldo das carteiras participantes é armazenado
diretamente no bloco? Explique como o saldo é obtido no Bitcoin.
`[prof: D2]` `[distrator]` `[prova Q56]`

**Q177.** Distinga o modelo UTXO do modelo de contas, indicando qual blockchain
adota cada um e como cada modelo representa o saldo de um participante.
`[prof: D2]` `[prova Q56]`

**Q178.** Explique a função do hash do bloco anterior, do Merkle root e do
nonce dentro da estrutura do bloco. `[prof: D3]` `[prova Q56]`

**Q179.** Explique por que alterar uma transação antiga exigiria refazer todos
os blocos posteriores, e o que nessa cadeia torna a fraude economicamente
inviável. `[prof: D3]`

**Q180.** Distinga validação de transação de mecanismo de consenso, e compare
Proof of Work e Proof of Stake quanto ao recurso que cada um exige do
validador. `[prof: D3]`

**Q181.** Um auditor recebe o número de um bloco e quer provar que determinada
transação está incluída nele sem baixar o bloco inteiro. Explique qual elemento
do bloco viabiliza essa prova e como. `[prof: D4]` `[caso]` `[prova Q56]`

---

## 2.17 Arquiteturas de Aplicação

**Q182.** O que é a Arquitetura Hexagonal, por que também se chama Portas e
Adaptadores, e o que ela separa de quê? `[prof: D1]` `[prova Q57]`

**Q183.** Numa arquitetura hexagonal, distinga porta de adaptador e diga qual
dos dois pertence ao núcleo de negócio. `[prof: D3]` `[prova Q57]`

**Q184.** Microsserviços compartilham o mesmo banco de dados para garantir a
consistência dos dados? Corrija a afirmação e explique o padrão esperado quanto
à propriedade dos dados. `[prof: D2]` `[distrator]` `[prova Q57]`

**Q185.** O que é um monolito distribuído, por que ele é considerado o pior dos
dois mundos, e qual característica dos microsserviços ele deixa de entregar?
`[prof: D2]` `[distrator]` `[prova Q57]`

**Q186.** Uma arquitetura monolítica pode ser distribuída? Explique o que ainda
assim a diferencia de microsserviços quanto ao processo de implantação.
`[prof: D2]` `[distrator]` `[prova Q57]`

**Q187.** Defina acoplamento e coesão e explique por que microsserviços
perseguem alta coesão interna e baixo acoplamento entre serviços.
`[prof: D2]` `[prova Q57]`

**Q188.** Como se mantém a consistência de dados entre serviços que não
compartilham banco? Descreva a abordagem e o que ela troca em relação à
consistência forte. `[prof: D3]`

**Q189.** Uma empresa quebrou seu sistema em oito serviços, mas todos leem e
escrevem no mesmo esquema de banco e precisam subir juntos a cada release.
Classifique a arquitetura resultante, aponte os sintomas que a denunciam e
indique o primeiro passo de correção. `[prof: D4]` `[caso]` `[prova Q57]`

---

## 2.18 Inteligência Artificial

**Q190.** Qual conceito está mais diretamente relacionado ao desenvolvimento de
sistemas que aprendem com os dados e melhoram seu desempenho ao longo do
tempo? `[prof: D0]` `[prova Q58]`

**Q191.** Defina Inteligência Artificial e delimite seu escopo em relação à
automação convencional. `[prof: D1]` `[prova Q58]`

**Q192.** Qual é a relação entre Aprendizado de Máquina e Redes Neurais
Artificiais: são sinônimos, disjuntos, ou um contém o outro? Fundamente.
`[prof: D2]` `[distrator]` `[prova Q58]`

**Q193.** Explique o que são Algoritmos Genéticos, Busca Heurística, Lógica
Booleana e Programação Linear, e diga por que nenhum deles é a resposta para
"sistemas que aprendem com os dados". `[prof: D3]` `[distrator]` `[prova Q58]`

**Q194.** Enumere os tipos de aprendizado de máquina e descreva o que
caracteriza cada um quanto ao dado disponível para o treinamento.
`[prof: D3]`

**Q195.** Explique o aninhamento entre Inteligência Artificial, Aprendizado de
Máquina e Aprendizado Profundo. `[prof: D2]` `[prova Q58]`

**Q196.** Um sistema precisa alocar 40 equipes de manutenção em 300 chamados
minimizando o custo total de deslocamento, com restrições rígidas conhecidas.
Outro precisa prever quais chamados vão reincidir em 30 dias a partir do
histórico. Indique a técnica adequada a cada um e justifique. `[prof: D4]`
`[caso]` `[prova Q58]`

---

## 2.19 Data Warehouse, ETL e ELT

**Q197.** Qual é o principal objetivo do processo de ETL em uma solução de Data
Warehousing? `[prof: D1]` `[prova Q59]`

**Q198.** O objetivo do ETL é criar visualizações e dashboards interativos,
realizar análises estatísticas preditivas ou gerenciar o acesso e a segurança
dos dados armazenados? Corrija a afirmação e diga a que camada cada uma dessas
atividades pertence. `[prof: D2]` `[distrator]` `[prova Q59]`

**Q199.** Distinga ETL de ELT quanto ao momento e ao local em que a
transformação ocorre. `[prof: D2]` `[distrator]` `[prova Q67]`

**Q200.** O ELT é mais eficiente em cenários de volume pequeno, com
processamento feito fora do sistema de destino? Corrija a afirmação e indique
o cenário em que o ELT de fato vence. `[prof: D2]` `[distrator]` `[prova Q67]`

**Q201.** Em que situação o ETL pode ser mais lento que o ELT? Explique qual
característica do sistema de destino determina essa comparação. `[prof: D2]`
`[distrator]` `[prova Q67]`

**Q202.** O que é um Data Warehouse e o que o distingue de um banco
transacional quanto à finalidade, ao histórico e ao perfil de consulta?
`[prof: D1]`

**Q203.** Distinga Data Warehouse, Data Mart e Data Lake quanto a escopo,
estrutura do dado armazenado e momento em que o esquema é aplicado.
`[prof: D3]`

**Q204.** Uma empresa migra seu DW on-premises para uma plataforma analítica em
nuvem com processamento elástico e cobrança por consumo, e ingere 4 TB diários
de logs semiestruturados. Indique se ETL ou ELT é a escolha adequada, o que
muda no pipeline e qual risco de governança a mudança introduz. `[prof: D4]`
`[caso]` `[prova Q67]`

---

## 2.20 Business Intelligence (BI)

**Q205.** O que é Business Intelligence e qual é o papel do mapeamento de
fontes de dados dentro de um projeto de BI? `[prof: D1]`

**Q206.** Coletar dados de todas as fontes disponíveis, sem discriminação,
incluindo as que apresentam inconsistências ou baixa relevância, é prática
recomendada para maximizar a quantidade de dados no sistema? Fundamente.
`[prof: D2]` `[distrator]` `[prova Q61]`

**Q207.** Enumere as boas práticas de mapeamento de fontes de dados em um
projeto de BI. `[prof: D3]` `[prova Q61]`

**Q208.** Explique o que se avalia em uma fonte de dados sob os critérios de
qualidade, relevância e confiabilidade, e por que os três não se confundem.
`[prof: D2]` `[prova Q61]`

**Q209.** Qual o papel da documentação detalhada das fontes — características,
formatos e relacionamentos — na governança de dados e em auditorias futuras?
`[prof: D3]` `[prova Q61]`

**Q210.** Que técnicas de elicitação se aplicam ao levantamento de requisitos
de BI, e o que a análise de documentos e sistemas legados acrescenta ao que as
entrevistas revelam. `[prof: D2]` `[prova Q61]`

**Q211.** Um projeto de BI vai construir o indicador "ticket médio por região".
Três sistemas informam faturamento, com regras distintas de cancelamento e
sem documentação. Descreva como você conduziria o mapeamento das fontes, o que
documentaria e qual prática deve ser explicitamente evitada. `[prof: D4]`
`[caso]` `[prova Q61]`

---

## 2.21 Sistemas de Suporte à Decisão (SSD/DSS)

**Q212.** O que é um Sistema de Suporte à Decisão e a quem ele se destina?
`[prof: D1]`

**Q213.** Defina problema estruturado, semiestruturado e não estruturado, dando
um exemplo organizacional de cada. `[prof: D3]` `[prova Q60]`

**Q214.** Os SSDs são adequados apenas a problemas estruturados, ideais apenas
para não estruturados, ou mais eficazes apenas em semiestruturados? Responda
qual é a abrangência correta e por que as outras três formulações são
restritivas demais. `[prof: D2]` `[distrator]` `[prova Q60]`

**Q215.** Qual é o papel da intuição e do julgamento humano na operação de um
SSD, e por que "suporte" à decisão não é sinônimo de "decisão automatizada"?
`[prof: D2]` `[prova Q60]`

**Q216.** Os SSDs são limitados a problemas de uma única área funcional da
organização? Fundamente. `[prof: D2]` `[distrator]` `[prova Q60]`

**Q217.** Um diretor quer um sistema que recomende o preço de venda de cada
produto considerando custo, demanda histórica, ações da concorrência e
percepção de marca. Classifique o problema quanto à estruturação, indique o
que o SSD pode entregar e o que necessariamente fica com o decisor humano.
`[prof: D4]` `[caso]` `[prova Q60]`

---

## 2.22 Bancos de Dados

**Q218.** Distinga OLTP de OLAP quanto ao perfil de carga, ao volume por
consulta e ao objetivo de cada um. `[prof: D1]`

**Q219.** Qual abordagem é usada principalmente em sistemas transacionais e
qual em sistemas de apoio à decisão: relacional ou multidimensional?
Fundamente. `[prof: D2]` `[distrator]` `[prova Q65]`

**Q220.** Em qual das duas abordagens os dados são organizados em cubos?
Explique o que o cubo acrescenta em relação à organização em tabelas.
`[prof: D2]` `[distrator]` `[prova Q65]`

**Q221.** Defina dimensão, métrica e agregação no contexto multidimensional, e
explique por que a afirmação de que a abordagem multidimensional não suporta
somas e médias é o oposto de sua finalidade. `[prof: D3]` `[distrator]`
`[prova Q65]`

**Q222.** Bancos NoSQL seguem estritamente as propriedades ACID? Explique o que
a maioria deles adota no lugar. `[prof: D2]` `[distrator]` `[prova Q66]`

**Q223.** Enumere os tipos de bancos NoSQL e dê um caso de uso característico
de cada um. `[prof: D3]` `[prova Q66]`

**Q224.** Bancos NoSQL são a melhor escolha para sistemas como ERPs e CRMs?
Fundamente pelo perfil de dados e de transações desses sistemas.
`[prof: D2]` `[distrator]` `[prova Q66]`

**Q225.** Enuncie as propriedades ACID e as propriedades BASE, e explique o que
o teorema CAP obriga a escolher em um sistema distribuído sujeito a partição.
`[prof: D3]` `[prova Q66]`

**Q226.** Distinga escalabilidade horizontal de vertical e explique por que a
horizontal é apontada como ponto forte dos bancos NoSQL. `[prof: D2]`
`[prova Q66]`

**Q227.** Um marketplace precisa de: (i) registro de pedidos com garantia
transacional entre estoque e pagamento; (ii) catálogo com atributos variáveis
por categoria e leitura massiva; (iii) recomendação por relações entre usuários
e produtos. Indique o tipo de banco adequado a cada necessidade e justifique.
`[prof: D4]` `[caso]` `[prova Q66]`

---

## 2.23 Controle de Acesso

**Q228.** Qual política de controle de acesso baseia seu procedimento na
comparação de rótulos de segurança com autorizações que indicam quais entidades
têm direito de acessar determinados recursos? `[prof: D1]` `[prova Q62]`

**Q229.** Distinga controle de acesso discricionário de mandatório quanto a
quem define a permissão e à possibilidade de o proprietário do recurso repassar
acesso a terceiros. `[prof: D2]` `[distrator]` `[prova Q62]`

**Q230.** Descreva o controle de acesso baseado em papéis: sobre o que a
permissão é concedida e qual vantagem administrativa isso traz.
`[prof: D2]` `[distrator]` `[prova Q62]`

**Q231.** O princípio do privilégio mínimo é uma política de controle de
acesso, no mesmo plano de DAC, MAC e RBAC? Explique o que ele de fato é.
`[prof: D2]` `[distrator]` `[prova Q62]`

**Q232.** Distinga autenticação de autorização, indicando a pergunta que cada
uma responde e a ordem em que ocorrem. `[prof: D2]`

**Q233.** Descreva o controle de acesso baseado em atributos e diga o que ele
oferece que o RBAC não oferece. `[prof: D3]`

**Q234.** Um sistema militar exige que documentos rotulados como "secreto" só
sejam lidos por usuários com habilitação igual ou superior, sem que o autor do
documento possa liberar acesso a quem quiser. Indique a política adequada,
explique por que DAC não serve e como o RBAC se encaixaria ou não.
`[prof: D4]` `[caso]` `[prova Q62]`

---

## 2.24 Segurança de Aplicações — OWASP

**Q235.** O que é a OWASP e o que representa a lista OWASP Top 10?
`[prof: D1]` `[prova Q63]`

**Q236.** Enumere as dez categorias do OWASP Top 10:2021. `[prof: D3]`
`[prova Q63]`

**Q237.** O que é Server-Side Request Forgery, como o ataque acontece e por que
o servidor é o instrumento da exploração? `[prof: D2]` `[distrator]`
`[prova Q63]`

**Q238.** "Proteção da cadeia de suprimentos de software", "proteção do
ambiente de engenharia", "treinamento operacional" e "uso de recursos de
linguagens e frameworks" são categorias do OWASP Top 10:2021? Para as que não
são, indique a categoria real que mais se aproxima. `[prof: D3]` `[distrator]`
`[prova Q63]`

**Q239.** Distinga Broken Access Control de Identification and Authentication
Failures, indicando em que momento da requisição cada falha se manifesta.
`[prof: D2]` `[prova Q63]`

**Q240.** Distinga Insecure Design de Security Misconfiguration: qual das duas
não se corrige com ajuste de parâmetro e por quê. `[prof: D2]` `[prova Q63]`

**Q241.** Indique as categorias que entraram no Top 10 em 2021 e as que
mudaram de posição ou foram absorvidas em relação à edição de 2017.
`[prof: D3]`

**Q242.** Uma aplicação permite que o usuário informe uma URL para importar uma
imagem de perfil, e o servidor faz a requisição a essa URL. Um atacante informa
um endereço interno da rede da empresa e recebe de volta o conteúdo. Classifique
a vulnerabilidade na taxonomia do Top 10:2021 e indique duas mitigações.
`[prof: D4]` `[caso]` `[prova Q63]`
