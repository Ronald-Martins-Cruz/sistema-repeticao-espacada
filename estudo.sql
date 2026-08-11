PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE secao (
  id         INTEGER PRIMARY KEY,
  parte      TEXT    NOT NULL,            -- 'I' | 'II'
  codigo     TEXT    NOT NULL UNIQUE,     -- '1.1', '2.22'
  titulo     TEXT    NOT NULL,
  ordem      INTEGER NOT NULL,
  -- derivado na importação: nº de tags [prova Qxx] distintas da seção.
  -- Mede quanto a banca cobrou daquele bloco na prova real.
  peso_prova INTEGER NOT NULL DEFAULT 0
) STRICT;
INSERT INTO secao VALUES(1,'I','1.1','Lei de Acesso à Informação — Lei nº 12.527/2011 (LAI)',1,1);
INSERT INTO secao VALUES(2,'I','1.2','Lei de Crimes Cibernéticos — Lei nº 12.737/2012 (art. 154-A do CP)',2,1);
INSERT INTO secao VALUES(3,'I','1.3','Marco Civil da Internet — Lei nº 12.965/2014',3,1);
INSERT INTO secao VALUES(4,'I','1.4','Lei Geral de Proteção de Dados Pessoais — Lei nº 13.709/2018 (LGPD)',4,1);
INSERT INTO secao VALUES(5,'I','1.5','Autoridade Nacional de Proteção de Dados (ANPD)',5,1);
INSERT INTO secao VALUES(6,'I','1.6','Conselho Nacional de Proteção de Dados Pessoais e da Privacidade (CNPD)',6,1);
INSERT INTO secao VALUES(7,'II','2.1','Frameworks e Plataforma Java',7,1);
INSERT INTO secao VALUES(8,'II','2.2','Formatos e Tecnologias de Dados e Marcação',8,1);
INSERT INTO secao VALUES(9,'II','2.3','Design e Arquitetura de Software',9,1);
INSERT INTO secao VALUES(10,'II','2.4','Princípios SOLID',10,1);
INSERT INTO secao VALUES(11,'II','2.5','Orientação a Objetos',11,1);
INSERT INTO secao VALUES(12,'II','2.6','Redes Corporativas e Ambiente Web',12,2);
INSERT INTO secao VALUES(13,'II','2.7','Integração de Sistemas, SOA e Web Services',13,1);
INSERT INTO secao VALUES(14,'II','2.8','Segurança em Comunicações Web',14,1);
INSERT INTO secao VALUES(15,'II','2.9','Métricas, Estimativas e Mensuração de Software',15,1);
INSERT INTO secao VALUES(16,'II','2.10','Desenvolvimento Mobile',16,1);
INSERT INTO secao VALUES(17,'II','2.11','Arquiteturas de Aplicações Front-end',17,1);
INSERT INTO secao VALUES(18,'II','2.12','Testes de Software',18,1);
INSERT INTO secao VALUES(19,'II','2.13','Metodologias Ágeis e Gerenciamento de Projetos',19,4);
INSERT INTO secao VALUES(20,'II','2.14','Engenharia de Requisitos',20,1);
INSERT INTO secao VALUES(21,'II','2.15','DevOps',21,1);
INSERT INTO secao VALUES(22,'II','2.16','Blockchain',22,1);
INSERT INTO secao VALUES(23,'II','2.17','Arquiteturas de Aplicação',23,1);
INSERT INTO secao VALUES(24,'II','2.18','Inteligência Artificial',24,1);
INSERT INTO secao VALUES(25,'II','2.19','Data Warehouse, ETL e ELT',25,2);
INSERT INTO secao VALUES(26,'II','2.20','Business Intelligence (BI)',26,1);
INSERT INTO secao VALUES(27,'II','2.21','Sistemas de Suporte à Decisão (SSD/DSS)',27,1);
INSERT INTO secao VALUES(28,'II','2.22','Bancos de Dados',28,2);
INSERT INTO secao VALUES(29,'II','2.23','Controle de Acesso',29,1);
INSERT INTO secao VALUES(30,'II','2.24','Segurança de Aplicações — OWASP',30,1);
CREATE TABLE ponto_chave (
  id          INTEGER PRIMARY KEY,
  pergunta_id INTEGER NOT NULL REFERENCES pergunta(id) ON DELETE CASCADE,
  ordem       INTEGER NOT NULL,
  descricao   TEXT    NOT NULL,           -- 'cita que o prazo do ultrassecreto é 25 anos'
  fonte       TEXT,                       -- 'LAI art. 24, §1º, I' — torna o feedback acionável
  peso        INTEGER NOT NULL DEFAULT 1 CHECK (peso > 0),
  essencial   INTEGER NOT NULL DEFAULT 0 CHECK (essencial IN (0,1)), -- se faltar, nota ≤ 2
  revisado    INTEGER NOT NULL DEFAULT 0 CHECK (revisado  IN (0,1)), -- 1 = você conferiu na fonte
  gerado_em   TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
  UNIQUE (pergunta_id, ordem)
) STRICT;
INSERT INTO ponto_chave VALUES(1,73,1,'enuncia o SRP (S): uma classe deve ter um unico motivo para mudar','Martin, SRP (Agile PPP, cap. 9)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(2,73,2,'enuncia o OCP (O): entidades de software devem ser abertas para extensao e fechadas para modificacao','Martin, OCP (C++ Report, jan/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(3,73,3,'enuncia o LSP (L): funcoes que usam ponteiro ou referencia a uma base devem poder usar objetos derivados sem saber disso','Martin, LSP (C++ Report, mar/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(4,73,4,'enuncia o ISP (I): clientes nao devem ser forcados a depender de interfaces que nao usam','Martin, ISP (C++ Report, 1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(5,73,5,'enuncia o DIP (D): alto e baixo nivel dependem de abstracoes; abstracoes nao dependem de detalhes, detalhes e que dependem de abstracoes','Martin, DIP (C++ Report, mai/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(6,74,1,'define responsabilidade como um motivo para mudar (a reason for change)','Martin, SRP (Agile PPP, cap. 9)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(7,74,2,'enuncia que a classe deve ter um unico motivo para mudar, nunca mais de um','Martin, SRP (Agile PPP, cap. 9)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(8,74,3,'explica que uma responsabilidade agrupa varias funcoes que mudam juntas pela mesma razao, logo nao equivale a um unico metodo','Martin, SRP (Agile PPP, cap. 9)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(9,74,4,'ilustra que contar metodos nao basta: a interface Modem (dial, hangup, send, recv) tem quatro metodos mas duas responsabilidades, gestao de conexao e comunicacao de dados','Martin, SRP (Agile PPP, cap. 9), Listing 9-1',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(10,74,5,'liga o conceito a coesao no nivel de classe (DeMarco 1979, Page-Jones 1988)','Martin, SRP (Agile PPP, cap. 9)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(11,75,1,'aberto para extensao: o comportamento do modulo pode ser estendido para atender novos requisitos','Martin, OCP (C++ Report, jan/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(12,75,2,'fechado para modificacao: o codigo-fonte existente permanece inviolado, nao se altera o que ja funciona','Martin, OCP (C++ Report, jan/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(13,75,3,'mecanismo: abstracao e polimorfismo, o modulo depende de uma classe base abstrata fixa e o novo comportamento entra como um novo derivado, sem tocar no modulo','Martin, OCP (C++ Report, jan/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(14,75,4,'atribui a formulacao a Bertrand Meyer (1988)','Martin, OCP (C++ Report, jan/1996)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(15,75,5,'reconhece que nenhum modulo e 100% fechado: o fechamento e estrategico, escolhido para as mudancas mais provaveis','Martin, OCP — Strategic Closure',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(16,76,1,'responde que nao: sobrescrever um metodo e alterar seu comportamento nao viola o LSP por esse fato isolado','Martin, LSP (C++ Report, mar/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(17,76,2,'situa o criterio no contrato esperado pelos clientes da base (pre-condicoes, pos-condicoes, invariantes), nao no mero ato de sobrescrever','Martin, LSP — Design by Contract',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(18,76,3,'observa que redefinir comportamento em derivados (polimorfismo) e justamente o mecanismo que sustenta o OCP, portanto o override e esperado, nao proibido','Martin, OCP (C++ Report, jan/1996)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(19,76,4,'distingue: so ha violacao quando o override fortalece pre-condicao, enfraquece pos-condicao ou quebra invariante ou expectativa do cliente','Martin, LSP — Design by Contract',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(20,77,1,'pre-condicoes: a subclasse nao pode fortalece-las, deve aceitar tudo que a base aceita (so pode iguala-las ou enfraquece-las)','Martin, LSP — regra de Meyer',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(21,77,2,'pos-condicoes: a subclasse nao pode enfraquece-las, deve garantir tudo que a base garante (so pode iguala-las ou fortalece-las)','Martin, LSP — regra de Meyer',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(22,77,3,'invariantes: as invariantes estabelecidas pela base devem ser preservadas pela subclasse','Martin, LSP (C++ Report, mar/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(23,77,4,'excecoes: a subclasse nao deve lancar excecoes que os clientes da base nao esperam (ex.: PersistentSet::Add lancando bad_cast quebra clientes de Set)','Martin, LSP — A Real Example',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(24,77,5,'cita a regra de Meyer: ao redefinir uma rotina, so se pode trocar a pre-condicao por uma mais fraca e a pos-condicao por uma mais forte','Martin, LSP — Design by Contract',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(25,78,1,'SRP incide sobre a classe ou modulo: cada classe com um unico motivo para mudar (uma responsabilidade)','Martin, SRP (Agile PPP, cap. 9)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(26,78,2,'ISP incide sobre a interface vista pelo cliente: nenhum cliente forcado a depender de metodos que nao usa','Martin, ISP (C++ Report, 1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(27,78,3,'SRP olha o eixo de mudanca do lado de quem mantem a classe; ISP olha o acoplamento do lado do cliente, pois interface gorda acopla clientes distintos entre si','Martin, ISP (C++ Report, 1996)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(28,78,4,'nota que o ISP admite um objeto com interface nao-coesa desde que cada cliente o acesse por uma interface segregada e coesa (delegacao ou heranca, padrao Adapter)','Martin, ISP — Class vs Object Interfaces',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(29,79,1,'DIP e um principio: modulos de alto e de baixo nivel dependem de abstracoes, e abstracoes nao dependem de detalhes','Martin, DIP (C++ Report, mai/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(30,79,2,'injecao de dependencia e uma tecnica: fornecer a dependencia a partir de fora (ex.: via construtor), em vez de o objeto cria-la internamente',NULL,1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(31,79,3,'conclui que um existe sem o outro: injetar uma dependencia concreta e DI sem inverter (ainda acopla ao detalhe), e da para obter DIP por outros meios (fabrica abstrata, stdio.h) sem injecao classica',NULL,1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(32,79,4,'usa o exemplo Button/ButtonClient: Button depende da abstracao (DIP) e recebe o cliente concreto por construtor (a injecao), mostrando que os dois sao ortogonais','Martin, DIP — A Simple Example (Button/Lamp)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(33,80,1,'afirma que ha violacao de LSP: Quadrado nao e substituivel por Retangulo do ponto de vista do cliente','Martin, LSP (C++ Report, mar/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(34,80,2,'identifica a restricao quebrada: a pos-condicao de setLargura da base (a altura permanece inalterada) e enfraquecida pelo Quadrado','Martin, LSP — The Real Problem',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(35,80,3,'explica que o cliente supos, de forma razoavel, que largura e altura variam de modo independente (comportamento publico da base), e o Quadrado quebra isso: a area da 16, nao 20','Martin, LSP — The Real Problem',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(36,80,4,'explica que o compilador nao acusa porque a relacao de tipos e valida (heranca publica, assinaturas compativeis); o LSP e restricao comportamental e semantica, fora do alcance do verificador de tipos','Martin, LSP (C++ Report, mar/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(37,80,5,'resume: no sistema de tipos Quadrado e-um Retangulo, mas comportamentalmente um objeto Quadrado nao e um objeto Retangulo','Martin, LSP — What Went Wrong',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(38,81,1,'explica que o e-um do vocabulario do dominio (um quadrado e um retangulo) tenta o modelador a herdar, mas a OO exige o e-um de comportamento, nao de vocabulario','Martin, LSP — What Went Wrong',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(39,81,2,'sustenta que o que importa em software e o comportamento publico extrinseco do qual os clientes dependem, nao a categoria intrinseca ou matematica','Martin, LSP (C++ Report, mar/1996)',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(40,81,3,'invoca que a validade nao e intrinseca: um modelo pode ser autoconsistente isolado e ainda invalido perante as suposicoes razoaveis dos clientes da base','Martin, LSP — Validity is not Intrinsic',1,1,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(41,81,4,'conclui que por isso um objeto Quadrado nao e um objeto Retangulo, embora um quadrado seja um retangulo','Martin, LSP — What Went Wrong',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(42,81,5,'aponta a consequencia: quebrar o LSP tambem quebra o OCP, pois os clientes passam a ter de checar o tipo do objeto','Martin, LSP (C++ Report, mar/1996)',1,0,0,'2026-07-23 17:07:57');
INSERT INTO ponto_chave VALUES(43,145,1,'lista os quatro valores na forma correta: individuos e interacoes mais que processos e ferramentas; software em funcionamento mais que documentacao abrangente; colaboracao com o cliente mais que negociacao de contratos; responder a mudancas mais que seguir um plano','Manifesto Agil (2001)',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(44,145,2,'explica que "mais que" nao abole o lado direito: ha valor nos itens a direita, mas valoriza-se mais os da esquerda; nao e "em vez de" nem descarta documentacao, contrato, processo ou plano','Manifesto Agil (2001)',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(45,145,3,'nao inverte os pares: o item de maior valor fica sempre a esquerda (ex.: nao e "processos mais que individuos")','Manifesto Agil (2001)',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(46,146,1,'ciclos de tempo: Scrum trabalha em iteracoes de duracao fixa (Sprints de um mes ou menos, timeboxed); Kanban e fluxo continuo, sem timeboxes/iteracoes prescritas','Scrum Guide 2020, A Sprint; Kanban Guide 2020',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(47,146,2,'limite de WIP: Kanban limita explicitamente o trabalho em andamento por estagio do fluxo (pull); Scrum limita indiretamente, pela capacidade do time refletida no Sprint Backlog selecionado para a Sprint','Kanban Guide 2020',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(48,146,3,'momento da entrega: Scrum entrega um Incremento pelo menos a cada Sprint (cadencia, apresentado na Sprint Review); Kanban entrega item a item, continuamente, conforme cada um fica pronto','Scrum Guide 2020; Kanban Guide 2020',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(49,146,4,'Scrum prescreve papeis e eventos; Kanban nao prescreve papeis nem eventos fixos (erro classico: dizer que Kanban tem sprints ou que Scrum nao tem timebox)','Kanban Guide 2020',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(50,147,1,'Product Owner: responsavel por maximizar o valor do produto e pelo gerenciamento do Product Backlog; e uma pessoa, nao um comite','Scrum Guide 2020, Product Owner',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(51,147,2,'Scrum Master: responsavel por estabelecer o Scrum e pela eficacia do time; e um lider servidor (true leader) que provoca a remocao de impedimentos, nao um chefe','Scrum Guide 2020, Scrum Master',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(52,147,3,'Developers: comprometidos em criar um Incremento utilizavel a cada Sprint; criam o Sprint Backlog, aderem a Definicao de Pronto e sao autogerenciados','Scrum Guide 2020, Developers',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(53,147,4,'as tres responsabilidades vivem num unico Scrum Team, sem sub-times nem hierarquia; time multifuncional, autogerenciado, normalmente 10 pessoas ou menos','Scrum Guide 2020, Scrum Team',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(54,148,1,'a Sprint e o conteiner de todos os demais eventos: duracao fixa de um mes ou menos, e uma nova comeca logo apos o fim da anterior','Scrum Guide 2020, A Sprint',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(55,148,2,'Sprint Planning: inicia a Sprint definindo o porque (Meta da Sprint), o que e o como (Sprint Backlog); trabalho colaborativo de todo o Scrum Team; timebox 8h para Sprint de um mes','Scrum Guide 2020, Sprint Planning',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(56,148,3,'Daily Scrum: inspecionar o progresso rumo a Meta da Sprint e adaptar o plano do dia; 15 min, diario, e dos Developers (PO e SM so participam como Developers se trabalham no Sprint Backlog)','Scrum Guide 2020, Daily Scrum',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(57,148,4,'Sprint Review: inspecionar o resultado da Sprint com os stakeholders e ajustar o Product Backlog; e sessao de trabalho, nao mera apresentacao; timebox 4h para Sprint de um mes','Scrum Guide 2020, Sprint Review',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(58,148,5,'Sprint Retrospective: planejar melhorias de qualidade e eficacia (pessoas, interacoes, processos, ferramentas, Definicao de Pronto); so o Scrum Team; encerra a Sprint; timebox 3h','Scrum Guide 2020, Sprint Retrospective',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(59,148,6,'no Guia 2020 os eventos pertencem ao Scrum Team: o SM garante que ocorram e respeitem o timebox, mas nao os "comanda"; nao ha mais a figura do SM que conduz cada reuniao','Scrum Guide 2020, Eventos Scrum',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(60,149,1,'Product Backlog: lista ordenada e emergente de tudo que o produto precisa; e a unica fonte de trabalho do time; responsavel = Product Owner (ordena e gerencia)','Scrum Guide 2020, Product Backlog',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(61,149,2,'Sprint Backlog: Meta da Sprint (porque) + itens selecionados (o que) + plano de entrega (como); e um plano feito por e para os Developers; responsavel = Developers','Scrum Guide 2020, Sprint Backlog',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(62,149,3,'Sprint Goal (Meta da Sprint): objetivo unico da Sprint; nao e um artefato a parte, e o compromisso do Sprint Backlog; criada por todo o Scrum Team na Planning e e compromisso dos Developers','Scrum Guide 2020, Meta da Sprint',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(63,149,4,'precisao: cada artefato tem um compromisso - Product Backlog/Meta do Produto, Sprint Backlog/Meta da Sprint, Incremento/Definicao de Pronto; a Meta da Sprint pertence ao Sprint Backlog','Scrum Guide 2020, Scrum Artifacts',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(64,150,1,'resposta correta: facilitar para que o time encontre a solucao e provocar a remocao do impedimento; nao redistribuir as tarefas por conta propria nem assumir a tarefa do desenvolvedor','Scrum Guide 2020, Scrum Master',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(65,150,2,'fundamento: o SM e lider servidor (nao comando e controle); ele treina o time no autogerenciamento e serve, em vez de decidir ou executar no lugar dele','Scrum Guide 2020, Scrum Master',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(66,150,3,'redistribuir tarefas por conta propria viola o autogerenciamento: sao os Developers que decidem quem faz o que, quando e como','Scrum Guide 2020, Scrum Team',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(67,150,4,'assumir a tarefa retira o SM do papel de remover impedimentos e nao resolve a causa do impedimento; as duas opcoes gerenciais que a FGV oferece sao distratores','Scrum Guide 2020, Scrum Master',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(68,151,1,'resposta: nao decide sozinho; quem seleciona os itens que entram na Sprint sao os Developers, por meio de discussao com o Product Owner','Scrum Guide 2020, Sprint Planning (Topico dois)',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(69,151,2,'divisao: o PO propoe o valor/porque e a ordem do Product Backlog (prioridade); os Developers definem o quanto cabe e o como realizar; a Meta da Sprint e definida por todo o Scrum Team','Scrum Guide 2020, Sprint Planning',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(70,151,3,'o "como" e criterio exclusivo dos Developers: ninguem mais lhes diz como transformar itens do Product Backlog em Incremento','Scrum Guide 2020, Sprint Planning (Topico tres)',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(71,152,1,'capacidade = quanto de trabalho os Developers conseguem concluir (com Definicao de Pronto) numa Sprint, previsto a partir do desempenho anterior; e base para uma previsao realista, nao meta a estourar','Scrum Guide 2020, Sprint Planning',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(72,152,2,'sobrecarregar quebra a previsibilidade e ameaca a Meta da Sprint: um Sprint Backlog inflado ja nasce como previsao falsa, e o compromisso perde sentido','Scrum Guide 2020, Sprint Backlog',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(73,152,3,'o problema nao e "sobrar item": itens comecados e nao concluidos nao viram Incremento (nao atendem a Definicao de Pronto), sao trabalho parcialmente feito - desperdicio, nao valor','Scrum Guide 2020, Incremento; Poppendieck, Lean Thinking (2002)',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(74,152,4,'WIP alto aumenta troca de contexto e derruba o foco; mais itens em paralelo nao aceleram a entrega e contrariam o ritmo sustentavel e a qualidade que nao deve diminuir na Sprint','Kanban Guide 2020; Scrum Guide 2020, A Sprint',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(75,153,1,'XP (Extreme Programming): metodo agil centrado em praticas de engenharia - programacao em par, TDD/testes automatizados, integracao continua, refatoracao, pequenas entregas; traco distintivo = excelencia tecnica no codigo','XP - Beck / Ron Jeffries; Agile Alliance',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(76,153,2,'Lean: origem no Sistema Toyota de Producao; principio central = eliminar desperdicio (tudo que nao agrega valor ao cliente); traco distintivo = otimizar o fluxo de valor, nao um processo de codigo','Poppendieck, Principles of Lean Thinking (2002)',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(77,153,3,'Waterfall (Cascata): modelo linear e sequencial em fases (requisitos, design/analise, codificacao, testes, operacao); traco distintivo = grande planejamento antecipado e fases sucessivas, dirigido a plano, nao agil','Royce (1970)',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(78,153,4,'Agil Hibrida: combina praticas ageis (entregas iterativas) com metodos tradicionais/dirigidos a plano (fases, documentacao); traco distintivo = mistura os dois mundos, nem puro agil nem pura cascata','Fowler, The New Methodology',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(79,153,5,'precisao/distrator: Royce nao defendeu a cascata pura; ele a descreveu e alertou que "o desenvolvimento e iterativo" e os passos nao sao meramente sucessivos - atribuir a cascata rigida a Royce como ideal e o erro comum','Royce (1970)',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(80,154,1,'resposta: Scrum - framework agil de entregas incrementais em Sprints com inspecao e adaptacao a cada ciclo, feito justamente para problemas complexos com requisitos que mudam','Scrum Guide 2020, Definicao do Scrum',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(81,154,2,'justificativa casada ao enunciado: ciclos incrementais fixos, revisao periodica com feedback dos stakeholders e valor priorizado sao exatamente Sprint, Sprint Review e Product Backlog ordenado pelo PO','Scrum Guide 2020',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(82,154,3,'Kanban nao e a melhor: e fluxo continuo, sem ciclos/timeboxes nem papeis/eventos prescritos; nao entrega a cadencia de ciclos incrementais com revisao periodica que o enunciado pede','Kanban Guide 2020',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(83,154,4,'XP nao e a melhor: foca praticas de engenharia (par, TDD, CI) e complementa o Scrum, mas nao e o framework de gestao das entregas e da priorizacao descrito no enunciado','XP - Ron Jeffries',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(84,154,5,'Lean nao e a melhor: e filosofia de eliminar desperdicio e otimizar fluxo; responde "como enxugar", nao "como organizar as entregas iterativas com papeis e eventos" que o caso pede','Poppendieck, Lean Thinking (2002)',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(85,155,1,'sequencia correta: o time inspeciona na Daily e se auto-organiza - replaneja o Sprint Backlog e renegocia o escopo com o PO mantendo a Meta da Sprint; o SM facilita e remove impedimentos, sem assumir nem mandar','Scrum Guide 2020, Daily Scrum / Sprint Backlog',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(86,155,2,'o foco e preservar a Meta da Sprint: renegocia-se o escopo dentro da Sprint sem afetar a Meta, em vez de salvar a tarefa individual','Scrum Guide 2020, Meta da Sprint',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(87,155,3,'errado assumir a tarefa: viola lider servidor e autogerenciamento; o SM deixa de servir, o time deixa de se auto-organizar e a causa do atraso permanece - a Meta fica dependente de um heroismo pontual','Scrum Guide 2020, Scrum Master',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(88,155,4,'errado escalar ao PO decidir a execucao: o PO cuida de valor e ordem, nao redistribui trabalho interno; o "como" e dos Developers, entao escalar joga a decisao no papel errado','Scrum Guide 2020, Product Owner / Sprint Planning',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(89,155,5,'errado encerrar o Sprint mais cedo: so o PO pode cancelar a Sprint e apenas se a Meta se tornar obsoleta; um item atrasado nao torna a Meta obsoleta, e encerrar joga fora o Incremento ainda possivel','Scrum Guide 2020, A Sprint',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(90,156,1,'fundamento: o Scrum Team e autogerenciado - decide internamente quem faz o que, quando e como; o Sprint Backlog e um plano feito por e para os Developers','Scrum Guide 2020, Scrum Team / Sprint Backlog',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(91,156,2,'o SM e lider servidor, nao gerente: seu papel e treinar o time no autogerenciamento e remover impedimentos, nao tomar a decisao no lugar dele','Scrum Guide 2020, Scrum Master',1,1,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(92,156,3,'o que se perde: quem conhece o trabalho tecnico sao os Developers, entao a decisao do SM sozinho tende a ser pior e reduz a transparencia e a adaptacao empirica do proprio time','Scrum Guide 2020, Adaptacao',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(93,156,4,'perde-se responsabilidade mutua e comprometimento: time que nao decide nao se responsabiliza pela Meta; volta-se ao comando e controle que o Scrum troca por empoderamento (adaptacao exige pessoas empoderadas)','Scrum Guide 2020, Adaptacao / Scrum Team',1,0,0,'2026-07-24 14:50:43');
INSERT INTO ponto_chave VALUES(94,218,1,'perfil de carga: OLTP sao muitas transacoes curtas e concorrentes, com escrita frequente (insert/update/delete) sobre o dado corrente; OLAP sao poucas consultas longas, predominantemente de leitura, sobre dado historico ja consolidado','Codd, Codd & Salley 1993, secao OLAP; Silberschatz 7ed cap. 11',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(95,218,2,'volume por consulta: OLTP toca poucos registros por operacao (um pedido, um cliente); OLAP varre e agrega grande volume por consulta, resumindo milhares ou milhoes de linhas em poucos numeros','Silberschatz 7ed cap. 11; MS Learn, Online Analytical Processing',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(96,218,3,'objetivo: OLTP executa e registra a operacao do negocio (controle operacional); OLAP apoia a decisao — analise historica, tendencia, cenarios "what-if" e "why"','Codd, Codd & Salley 1993, "OLAP is made up of numerous, speculative what-if and/or why data model scenarios"',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(97,218,4,'atualidade do dado e duracao: OLTP precisa de dado instantaneamente exato e sua transacao dura segundos ou minutos; OLAP trabalha com dado historico exato em um ponto no tempo e sua transacao analitica pode durar dias ou semanas','Codd, Codd & Salley 1993, Common Enterprise Data',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(98,218,5,'nao inverte os acronimos: o T de OLTP e transacional (transaction) e o A de OLAP e analitico (analytical) — inversao classica de distrator','Codd, Codd & Salley 1993 (cunhagem do termo OLAP)',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(99,219,1,'atribui na ordem certa: relacional em sistemas transacionais (OLTP) e multidimensional em sistemas de apoio a decisao (OLAP); a inversao — relacional para apoio a decisao e multidimensional para transacional — e falsa','Prova DATAPREV/FGV 2024, Q65-B (alternativa errada); gabarito Q65 = C',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(100,219,2,'fundamenta o lado relacional: modelo normalizado e orientado a registro, otimizado para escrita e integridade — insert/update/delete atomicos, redundancia baixa, bloqueio de poucas linhas, alta concorrencia','Silberschatz 7ed cap. 11; Elmasri & Navathe 7ed cap. 29',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(101,219,3,'fundamenta o lado multidimensional: organiza o dado por dimensoes e metricas ao longo de caminhos de consolidacao, o que torna barata a consulta que resume grande volume e a analise simultanea de varias dimensoes','Codd, Codd & Salley 1993, Multiple Data Dimensions/Consolidation Paths; Kimball, Dimensional Modeling Techniques',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(102,219,4,'ressalva de fronteira: o relacional nao esta excluido do apoio a decisao — o modelo dimensional tambem se implementa em RDBMS (esquema estrela, ROLAP), e Codd sustenta que o relacional segue sendo a tecnologia adequada, com OLAP como ferramenta complementar; a fronteira e de organizacao logica/fisica, nao de "um analisa e o outro nao"','Kimball, Star Schemas and OLAP Cubes; Codd, Codd & Salley 1993, A Complementary Approach',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(103,220,1,'o cubo pertence a abordagem multidimensional (OLAP), nao a relacional; dizer que "na abordagem relacional os dados sao organizados em cubos" e a inversao que a banca monta','Prova DATAPREV/FGV 2024, Q65-D (alternativa errada); Kimball, Star Schemas and OLAP Cubes',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(104,220,2,'define o cubo: estrutura dimensional implementada em banco multidimensional, contendo atributos de dimensao e fatos; pode ser equivalente em conteudo a um esquema estrela relacional ou, mais comumente, derivado dele','Kimball, Star Schemas and OLAP Cubes',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(105,220,3,'o que acrescenta em relacao a tabelas: cada celula e endereçada pela combinacao de valores das dimensoes e as consolidacoes ao longo dos eixos ja vem pre-agregadas, em vez de serem reconstruidas a cada consulta por join mais group by','Kimball, Aggregate Fact Tables or Cubes; Silberschatz 7ed cap. 11',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(106,220,4,'cita as operacoes que o cubo torna naturais: roll-up e drill-down (subir e descer no nivel de consolidacao), slice and dice e pivot/rotacao dos eixos de analise','Codd, Codd & Salley 1993, regra 1 — Multidimensional Conceptual View ("slice and dice, or pivot and rotate"); Silberschatz 7ed cap. 11',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(107,220,5,'o cubo e acessado por linguagem analitica (MDX/XMLA), mais expressiva que SQL para esse tipo de manipulacao','Kimball, Star Schemas and OLAP Cubes; MS Learn, Multidimensional Models (SSAS)',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(108,221,1,'dimensao: o eixo de analise, o contexto descritivo do evento — quem, o que, onde, quando, por que e como; a tabela de dimensao guarda os atributos usados para filtrar e agrupar os fatos (em Codd, e o nivel mais alto de um caminho de consolidacao)','Kimball, Dimensions for Descriptive Context; Codd, Codd & Salley 1993',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(109,221,2,'metrica (fato ou medida): o valor numerico medido que resulta do evento do processo de negocio — quantidade vendida, valor, saldo; vive na tabela fato, e cada linha de fato corresponde a um evento de medicao no grao declarado','Kimball, Facts for Measurements; Kimball, Fact Table Structure',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(110,221,3,'agregacao: consolidar as metricas ao longo de uma ou mais dimensoes (soma, media, contagem, minimo, maximo), subindo ou descendo no nivel do caminho de consolidacao — roll-up e drill-down','Kimball, Aggregate Fact Tables or Cubes; Kimball, Drilling Down',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(111,221,4,'explica por que a negativa inverte a finalidade: agregar e o proposito da abordagem — a tabela fato e o alvo primario dos computos e agregacoes dinamicas das consultas, e tabelas agregadas e cubos existem justamente para pre-calcular somas; dizer que o multidimensional nao suporta soma e media nega aquilo para que ele foi construido','Kimball, Fact Table Structure ("primary target of computations and dynamic aggregations"); prova DATAPREV/FGV 2024, Q65-E',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(112,221,5,'precisao que separa a limitacao real da falsa: nem todo fato soma em qualquer dimensao — fatos aditivos somam em todas; semiaditivos somam em algumas e nao em todas (saldo nao soma no tempo); nao aditivos, como razoes e percentuais, recalculam-se a partir dos componentes aditivos. A restricao e do tipo de fato, nunca da abordagem','Kimball, Additive, Semi-Additive, and Non-Additive Facts',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(113,222,1,'responde que nao como regra: afirmar que bancos NoSQL seguem estritamente ACID e falso — para rodar em cluster a maioria deles tem capacidade transacional limitada','Prova DATAPREV/FGV 2024, Q66-A (alternativa errada); Fowler & Sadalage 2012, "most NoSQL databases have limited transactional capability"',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(114,222,2,'nomeia o que a maioria adota no lugar: BASE — Basically Available, Soft state, Eventually consistent','Pritchett, "BASE: An Acid Alternative", ACM Queue 6(3), 2008; Brewer 2012, quadro ACID, BASE and CAP',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(115,222,3,'explica os tres termos de BASE: basicamente disponivel = responde sempre, ainda que com dado desatualizado ou resposta degradada; soft state = o estado pode mudar sem escrita nova, pela propagacao entre replicas; eventualmente consistente = na ausencia de novas escritas as replicas convergem para o mesmo valor apos um intervalo','Pritchett 2008; Vogels, "Eventually Consistent" (2008)',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(116,222,4,'situa ACID e BASE como os dois extremos do espectro consistencia x disponibilidade, e nao como mundos estanques: ACID prioriza consistencia, BASE prioriza disponibilidade, e sistemas modernos de larga escala misturam os dois','Brewer, "CAP Twelve Years Later", IEEE Computer fev/2012, quadro ACID, BASE, and CAP',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(117,222,5,'evita o "nunca" com a ressalva certa: varios NoSQL hoje oferecem ACID (MongoDB tem transacao multidocumento desde a 4.0; Neo4j e ACID), mas em geral a garantia forte vale dentro da fronteira do agregado — e o agregado que delimita a operacao ACID','Fowler & Sadalage, NoSQL Distilled — Key Points',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(118,223,1,'enumera os quatro tipos: chave-valor, documento, familia de colunas e grafo; nao existe um modelo unico de NoSQL — dizer que NoSQL armazena sempre em grafos, ou que usa sempre o modelo relacional, e falso','Fowler & Sadalage, NoSQL Distilled; Elmasri & Navathe 7ed cap. 24; prova DATAPREV/FGV 2024, Q66-B e Q66-D (alternativas erradas)',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(119,223,2,'chave-valor: valor opaco ao banco, recuperado por chave, com leitura e escrita muito rapidas; caso de uso caracteristico = sessao de usuario, carrinho de compras ou cache (Redis, Riak, DynamoDB)','Fowler & Sadalage 2012, poster ("User sessions - Redis"; "Shopping Cart - Riak"); DeCandia et al., Dynamo, SOSP 2007',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(120,223,3,'documento: guarda documentos semiestruturados (JSON/BSON/XML) cuja estrutura interna o banco enxerga e consulta, sem esquema fixo por registro; caso de uso = catalogo de produtos com atributos variaveis, perfis e conteudo (MongoDB)','Fowler & Sadalage 2012, poster ("Product Catalog - MongoDB"); Elmasri & Navathe 7ed cap. 24',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(121,223,4,'familia de colunas: linhas com colunas agrupadas em familias, otimizado para volume alto de escrita distribuida e leitura de faixas de colunas; caso de uso = log de atividade, telemetria, serie temporal e analitico em larga escala (Cassandra, HBase)','Fowler & Sadalage 2012, poster ("Analytics / User activity logs - Cassandra"); Chang et al., Bigtable, OSDI 2006',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(122,223,5,'grafo: nos e arestas com propriedades, otimizado para percorrer relacionamentos; caso de uso = recomendacao, rede social, deteccao de fraude e roteamento (Neo4j)','Fowler & Sadalage 2012, poster ("Recomendations - Neo4J"); Neo4j, What is a graph database?',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(123,223,6,'distincao estrutural que agrupa os quatro: chave-valor, documento e familia de colunas sao orientados a agregado — a unidade de armazenamento e acesso e o agregado; o grafo e o unico ignorante de agregado, feito para relacionamentos densos, que e exatamente o que os outros tres percorrem mal','Fowler & Sadalage, NoSQL Distilled — Key Points',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(124,224,1,'responde que nao: ERP e CRM sao terreno tipico do relacional, e a afirmacao de que NoSQL e a melhor escolha para esses sistemas e falsa','Prova DATAPREV/FGV 2024, Q66-E (alternativa errada); gabarito Q66 = C',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(125,224,2,'fundamenta pelo perfil de dados: esquema estavel, conhecido de antemao e altamente relacionado (cliente, pedido, item, nota, estoque, contabilidade), consultado ad hoc de formas nao previstas — e onde o modelo tabular serve, por permitir desmontar o dado e remonta-lo de maneiras diferentes para fins diferentes','Fowler & Sadalage 2012, "the relational model is still relevant"; Fowler, PolyglotPersistence (2011)',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(126,224,3,'fundamenta pelo perfil de transacoes: exigem transacao multi-entidade com integridade forte — baixar estoque, gerar o titulo a receber e lancar na contabilidade tem de ser tudo-ou-nada, e isso atravessa varios agregados; no NoSQL orientado a agregado a garantia ACID normalmente para na fronteira do agregado','Fowler & Sadalage, NoSQL Distilled — Key Points (o agregado como fronteira das operacoes ACID); Harder & Reuter 1983',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(127,224,4,'nomeia o criterio correto de escolha: o padrao de uso dos dados, nao o banco padrao da casa nem a moda — persistencia poliglota; para o perfil de ERP/CRM esse padrao aponta relacional, o que nao impede usar NoSQL em partes especificas (busca, log, cache, sessao)','Fowler, PolyglotPersistence (2011)',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(128,224,5,'diz onde o NoSQL de fato e forte, e que nao e o caso de ERP/CRM: sistemas que exigem alta disponibilidade e escalabilidade horizontal — foi essa a alternativa correta da prova','Prova DATAPREV/FGV 2024, Q66-C (gabarito)',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(129,225,1,'enuncia ACID: Atomicidade (a transacao e tudo-ou-nada), Consistencia (leva o banco de um estado valido a outro, preservando as regras e invariantes), Isolamento (transacoes concorrentes nao enxergam o estado parcial umas das outras) e Durabilidade (o efeito do commit sobrevive a falhas posteriores)','Harder & Reuter, "Principles of Transaction-Oriented Database Recovery", ACM Computing Surveys 15(4), 1983; Silberschatz 7ed cap. 17',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(130,225,2,'enuncia BASE: Basically Available (responde sempre, ainda que degradado), Soft state (o estado pode mudar sem escrita nova, pela propagacao entre replicas) e Eventually consistent (as replicas convergem apos um intervalo sem novas escritas)','Pritchett, "BASE: An Acid Alternative", ACM Queue 6(3), 2008; Brewer 2012, quadro ACID, BASE, and CAP',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(131,225,3,'define as tres letras do CAP: Consistencia (uma unica copia atualizada do dado; formalmente, consistencia atomica ou linearizavel), Disponibilidade (toda requisicao recebida por um no que nao falhou termina com resposta) e Tolerancia a particao (o sistema segue operando mesmo que a rede perca arbitrariamente as mensagens entre grupos de nos)','Gilbert & Lynch, ACM SIGACT News 33(2), 2002, secao 2 (Formal Model); Brewer 2012',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(132,225,4,'diz o que o CAP obriga: durante a particao, e so entao, e preciso escolher entre C e A — ou o lado isolado responde e arrisca divergir (escolhe A, abre mao de C), ou se recusa a responder para nao divergir (escolhe C, abre mao de A); insistir em retransmitir ate conseguir consistencia e, na pratica, escolher C sobre A','Brewer 2012, Why "2 of 3" Is Misleading e CAP-Latency Connection; Gilbert & Lynch 2002',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(133,225,5,'nao reduz o CAP a "escolha 2 de 3": o proprio Brewer desfaz a leitura — a particao e rara, e fora dela da para ter C e A juntas; a escolha pode ainda variar por subsistema, operacao, dado ou usuario, e as tres propriedades sao continuas, nao binarias ("CAP prohibits only a tiny part of the design space: perfect availability and consistency in the presence of partitions, which are rare")','Brewer, "CAP Twelve Years Later: How the Rules Have Changed", IEEE Computer, fev/2012',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(134,225,6,'nao confunde o C de ACID com o C de CAP: em ACID, consistencia e preservar as regras do banco (chaves, invariantes) e cabe ao programador; em CAP, consistencia e a de copia unica, um subconjunto estrito da consistencia ACID','Brewer 2012, quadro ACID, BASE, and CAP',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(135,226,1,'vertical (scale up): aumentar o recurso da mesma maquina — mais CPU, memoria e disco; tem teto fisico, o custo cresce mais que proporcionalmente e o ponto unico de falha permanece','Fowler & Sadalage 2012, "to scale, you need buy a bigger machine"; Silberschatz 7ed cap. 10',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(136,226,2,'horizontal (scale out): distribuir dados e carga por muitas maquinas comuns em cluster; a capacidade cresce somando nos e o cluster continua servindo mesmo com nos individualmente pouco confiaveis falhando','Fowler & Sadalage 2012; Silberschatz 7ed cap. 10',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(137,226,3,'horizontal nao e apenas "mais maquinas": exige particionar os dados (sharding) e replica-los entre nos — sao esses dois mecanismos que entregam a escala e a tolerancia a falha','Silberschatz 7ed cap. 10; DeCandia et al., Dynamo, SOSP 2007',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(138,226,4,'por que e ponto forte do NoSQL: ele foi desenhado para rodar em cluster e seu modelo orientado a agregado oferece fronteira natural de particionamento, sem depender de juncoes e transacoes globais; o relacional nasceu para uma unica maquina e paga caro para distribuir — dai a prova apontar alta disponibilidade e escalabilidade horizontal como o ponto do NoSQL','Fowler & Sadalage 2012, "SQL dominance is cracking"; prova DATAPREV/FGV 2024, Q66-C (gabarito)',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(139,226,5,'cita o custo que vem junto: distribuir cobra em consistencia — sob particao e preciso escolher entre consistencia e disponibilidade (CAP), e a opcao tipica do NoSQL e disponibilidade com consistencia eventual','Brewer 2012; Vogels, "Eventually Consistent" (2008)',1,0,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(140,227,1,'(i) pedidos com garantia entre estoque e pagamento = relacional (RDBMS com ACID): a exigencia e transacao multi-entidade tudo-ou-nada atravessando agregados distintos, onde atomicidade e isolamento sao inegociaveis','Fowler & Sadalage 2012, poster ("Financial Data - RDBMS: needs transactional updates, tabular structure fits data"); Harder & Reuter 1983',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(141,227,2,'(ii) catalogo com atributos variaveis por categoria e leitura massiva = banco de documentos (ex.: MongoDB): esquema flexivel registro a registro, cada produto formando um agregado natural lido inteiro, com muitas leituras e escritas infrequentes','Fowler & Sadalage 2012, poster ("Product Catalog - MongoDB: lots of reads, infrequent writes. Products make natural aggregate")',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(142,227,3,'(iii) recomendacao por relacoes entre usuarios e produtos = banco de grafos (ex.: Neo4j): o valor esta nas ligacoes (comprou, avaliou, segue) e a consulta e percorre-las rapidamente, travessia que no relacional viraria cadeia cara de juncoes recursivas','Fowler & Sadalage 2012, poster ("Recomendations - Neo4J: rapidly traverse links between friends, product purchases, and ratings"); Neo4j, What is a graph database?',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(143,227,4,'nomeia o principio que sustenta as tres escolhas: persistencia poliglota — escolher a tecnologia de armazenamento pelo padrao de uso de cada parte dos dados, inclusive dentro de uma mesma aplicacao, em vez de adotar um banco unico por padrao institucional','Fowler, PolyglotPersistence (2011); Fowler & Sadalage 2012, poster',1,1,0,'2026-07-30 13:19:31');
INSERT INTO ponto_chave VALUES(144,227,5,'reconhece o custo da opcao poliglota: mais tecnologias a operar, ferramental imaturo e, sobretudo, ter de conviver com consistencia eventual e sincronizar dados entre os repositorios; so se justifica em projeto estrategico e intensivo em dados, nao em projeto utilitario','Fowler & Sadalage 2012, poster, secoes "problems" e "candidates for polyglot persistence"',1,0,0,'2026-07-30 13:19:31');
CREATE TABLE sessao (
  id           INTEGER PRIMARY KEY,
  modo         TEXT NOT NULL CHECK (modo IN ('revisao','fraquezas','secao','simulado','livre')),
  filtro       TEXT,                      -- ex.: '1.4' quando modo='secao'
  iniciada_em  TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  encerrada_em TEXT,
  observacoes  TEXT
) STRICT;
INSERT INTO sessao VALUES(1,'livre','SOLID','2026-07-23 17:11:52','2026-07-24 08:12:52',NULL);
INSERT INTO sessao VALUES(2,'secao','Princípios SOLID','2026-07-23 17:14:07','2026-07-24 08:12:52',NULL);
INSERT INTO sessao VALUES(3,'secao','Princípios SOLID','2026-07-24 08:12:52','2026-07-24 13:50:57',NULL);
INSERT INTO sessao VALUES(4,'secao','2.13','2026-07-24 15:08:28',NULL,NULL);
INSERT INTO sessao VALUES(5,'secao','Metodologias Ágeis e Gerenciamento de Projetos','2026-07-27 15:46:51',NULL,NULL);
INSERT INTO sessao VALUES(6,'secao','Princípios SOLID','2026-07-27 16:47:30','2026-07-28 08:43:31',NULL);
INSERT INTO sessao VALUES(7,'revisao','Q77 — Princípios SOLID','2026-07-28 08:47:44','2026-07-28 08:53:30',NULL);
INSERT INTO sessao VALUES(8,'revisao',NULL,'2026-07-29 14:19:05','2026-07-29 15:30:00',NULL);
INSERT INTO sessao VALUES(9,'revisao',NULL,'2026-07-30 10:59:57','2026-07-30 11:24:34',NULL);
INSERT INTO sessao VALUES(10,'secao','2.22','2026-07-30 13:22:47',NULL,NULL);
INSERT INTO sessao VALUES(11,'secao','2.22','2026-07-30 15:34:20','2026-07-30 16:36:27','Eixo analítico adiado a pedido do usuário; Q218 e Q221 não foram respondidas nem avaliadas.');
INSERT INTO sessao VALUES(12,'revisao','fila sem eixo analitico de bancos de dados (exclui Q218-Q221)','2026-08-03 09:19:17','2026-08-03 11:25:31',NULL);
INSERT INTO sessao VALUES(13,'secao','Princípios SOLID','2026-08-03 11:30:50','2026-08-03 13:51:56',NULL);
INSERT INTO sessao VALUES(14,'secao','2.13','2026-08-03 13:57:34','2026-08-03 14:31:54',NULL);
INSERT INTO sessao VALUES(15,'revisao','excluir Banco de Dados eixo 1 (Q218-Q221)','2026-08-04 07:47:01',NULL,NULL);
CREATE TABLE resposta (
  id            INTEGER PRIMARY KEY,
  pergunta_id   INTEGER NOT NULL REFERENCES pergunta(id),
  sessao_id     INTEGER REFERENCES sessao(id),
  perguntada_em TEXT,
  respondida_em TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  segundos      INTEGER,
  texto         TEXT NOT NULL,            -- na íntegra, sem edição e sem resumo
  -- confiança é declarada DEPOIS da nota estar gravada e ANTES de você vê-la.
  -- Ver trg_confianca_depois_da_nota.
  confianca     INTEGER CHECK (confianca IS NULL OR confianca BETWEEN 1 AND 5),
  confianca_em  TEXT
) STRICT;
INSERT INTO resposta VALUES(1,73,3,'2026-07-24 08:21:56','2026-07-24 08:21:56',NULL,unistr('Os princípios SOLID são:\u000a\u000aSingle responsability\u000aOpen-closed\u000aLiskov\u000aInteface segregation\u000aDependency inversion\u000a\u000aSingle responsability (responsabilidade única) diz que um componente só deve ter uma responsabilidade no sentido de ter apenas uma fonte de mudança (não significa por exemplo uma classe possuir apenas um método)\u000a\u000aOpen-closed determina que uma entidade deve estar aberta a adições e fechada a modificações. Isso quer dizer que uma classe não deve ser sempre reescrita ou acrescentada para que se adicione funcionalidades ou comportamentos. Idealmente isso ocorrerá por extensões que podem sobrescrever seus métodos em detrimento a um switch ou aninhamento de if/else por exemplo\u000a\u000aO princípio de liskov determina que uma alteração numa subclasse ou componente menor não deve causar alteração na superclasse. As subclasses devem manter contratos e comportamentos esperados\u000a\u000aInterface segregation não me recordo.\u000a\u000aDependency inversion diz respeito a construir a dependência num elemento maior. Um exemplo disso é a dependency injection em que, ao invés de instanciar uma dependência dentro de uma classe, se passa para ela via construtor. Com isso o componente que insancia essa classe passa a instanciar a dependência.'),2,'2026-07-24 08:23:17');
INSERT INTO resposta VALUES(2,74,3,'2026-07-24 08:53:49','2026-07-24 08:53:49',NULL,'O princípio da Responsabilidade única determina que um componente de software deve possuir apenas uma responsabilidade, apenas uma fonte de mudança. Uma classe pode possuir diversos métodos, contanto que todos tenham a mesma fonte de mudança. Por exemplo: um repositório que faz operações com uma tabela no banco pode listar e atualizar elementos dessa tabela. A mudança da tabela ou banco muda a classe, com a mesma fonte de mudança.',4,'2026-07-24 08:54:39');
INSERT INTO resposta VALUES(3,75,3,'2026-07-24 08:56:50','2026-07-24 08:56:50',NULL,'Aberto para adições, fechado para modificações. Se obtêm isso na prática a partir de extensões',4,'2026-07-24 08:58:34');
INSERT INTO resposta VALUES(4,76,3,'2026-07-24 09:06:52','2026-07-24 09:06:52',NULL,'Depende do quanto esse método é alterado. Se o método continua cumprindo o mesmo contrato e executando um comportamento esperado, não viola. Um exemlplo clássico seria de emitir som. Cada classe pode emitir um som diferente (printar algo diferente), mas isso não fere o cumprimento do contrato e executa um tipo de comportamento esperado.',4,'2026-07-24 09:07:43');
INSERT INTO resposta VALUES(5,77,3,'2026-07-24 09:13:36','2026-07-24 09:13:36',NULL,'Não sei',1,NULL);
INSERT INTO resposta VALUES(6,78,3,'2026-07-24 10:13:37','2026-07-24 10:13:37',NULL,'O alvo do princípio de integração da interface está em não herdar elementos que não seram utilizados, o alvo do princípio da responsabilidade única está em não ter mais de uma fonte de mudança para um componente',4,'2026-07-24 10:16:28');
INSERT INTO resposta VALUES(7,79,3,'2026-07-24 10:23:21','2026-07-24 10:23:21',NULL,'Sim, podem existir separados. A injeção de dependência é uma técnica para aplicação da inversão de dependência (que é o princípio). A inversão de dependência diz respeito a abstrações não dependerem de detalhes, e sim suas implementações.',3,'2026-07-24 10:24:19');
INSERT INTO resposta VALUES(8,80,3,'2026-07-24 10:59:32','2026-07-24 10:59:32',NULL,'Fere o princípio de substituição de liskov, quadrado altera o comportamento de retangulo. Deveria haver uma abstração para quadrado e retangulo, algo como polígono com um método abstrato calcularArea, dessa forma o polimorfismo se manteria sem problema algum, quadrado e retangulo seriam extensões de plígono que manteriam o contrato e o comportamento de cálculo de área. O compilador não acusa nada pois não há nenhum erro capturável pelo compilador, a sintaxe pode estar correta e a sobrescrita é permetia',3,'2026-07-24 11:00:38');
INSERT INTO resposta VALUES(9,81,3,'2026-07-24 13:49:22','2026-07-24 13:49:22',NULL,'A violação LSP nasce pode nascer como uma herança modelado com é um no vocabulário do domínio mas não no modelo observável porque muitas vezes algo que "é um" no modelo do domínio pode ter um comportamento diferente. Por exemplo: o quadrado é um retângulo, mas ele tem uma restrição que o retângulo não tem: seus lados devem ser iguais',4,'2026-07-24 13:50:35');
INSERT INTO resposta VALUES(10,146,5,'2026-07-27 15:46:51','2026-07-27 15:51:15',264,'Scrum é timeboced, kanban não. Scrum tem metas de entregas em momentos, Kanban não. Scrum determina um máximo de tarefas em andamento, kanban não.',2,'2026-07-27 15:52:39');
INSERT INTO resposta VALUES(11,150,5,'2026-07-27 15:52:39','2026-07-27 15:59:10',391,'Facilitar que o time encontre a solução. A distribuição das tarefas não cabe ao Scrum Master, e sim a equipe devs. Assumir tarefa do desenvolvedor também tiraria scrum master do seu papel. ',4,'2026-07-27 16:00:55');
INSERT INTO resposta VALUES(12,151,5,'2026-07-27 16:00:55','2026-07-27 16:03:06',131,'Não, durante o Sprint Planning o Product Owner decide o que há de mais valoroso no product Backlog, o time de desenvolvimento determina quais tarefas serão feitas no sprint avaliando quais tarefas cabem no sprint (de acordo com a prioridade determinada pelo PO.',5,'2026-07-27 16:06:31');
INSERT INTO resposta VALUES(13,153,5,'2026-07-27 16:06:31','2026-07-27 16:19:16',765,'XP (Extreme programming) não diz respeito a organização do trabalho, sim uma metodologia de desenvolvimento com testes, padrões arquiteturais, seguindo boas práticas de desenvolvimento de software. Waterfall é o modelo de cascata, não incremental. No waterfall não há entregas contínuas e feedback contínuo. O software é desenvolvido e entregue em sua totalidade tudo de uma vez só. Abordagem ágil híbrida mistura elementos de waterfall (cascata) e agile. Lean eu não me recordo.  ',2,'2026-07-27 16:20:09');
INSERT INTO resposta VALUES(14,147,5,'2026-07-27 16:20:09','2026-07-27 16:33:31',802,'Os papéis do Scrum são Product Owner (PO) que é responsável pelo contato com o cliente e identificar os elementos com mais valor no product backlog, Scrum Master tem como função principal resolver os impedimentos para que o time não fique travado. O time de desenvolvimento tem por função o desenvolvimento do sistema em si (o código).',3,'2026-07-27 16:39:37');
INSERT INTO resposta VALUES(15,73,6,'2026-07-27 16:47:30','2026-07-27 16:59:29',719,unistr('Os princípios solid são: \u000asingle responsability principle: um componente de software deve ter uma única responsabilidade, uma única fonte de mudança. Isso não significa uma classe possuir apenas um método\u000aOpen-closed principle: determina que uma classe deve estar fechada a mudanças e aberta a extensões. Logicamente uma classe pode precisar de alterações, mas um comportamente usualmente mais desejável é que se extenda a classe quando se precise adicionar um comportamento. O clássico exemplo de if/else ou switch trocado por extensão.\u000aliskov substitution principle: Uma subclasse que herda de uma superclasse ao sobrescerver um método deve executar o comportamento esperado sem trocar seu contrato. Caso não haja troca de contrato mas o comportamento seja diferente isso continua ferindo o princípio\u000aInterface segregation principle: um componente não deve herdar comportamentos que não utiliza. Por exemlo: se uma classe implementa uma interface essa classe não deve herdar de uma interface que possui métodos que não são utilizados pela classe\u000adependency inversion principle: O princípio da inversão de dependência consiste em passar a dependência para fora de um componente de software. Um exemplo é no padrão repository: a classe que chama um repository não depende do repositório ela depende de uma interface que é extendida pelo repositório. Analogamente o repositório não depende da classe que a chama, ele implementa uma interface que é conhecida por quem deseja chamar o comportamento do repository. O repositoório não depende da camada que o chama e o chamador não depende do repositório. Ambos passam a depender de uma abstração.'),4,'2026-07-27 17:01:11');
INSERT INTO resposta VALUES(16,76,6,'2026-07-27 17:02:17','2026-07-27 17:06:18',241,'Não. A alteração do comportamente só fere o princípio da substituição se o novo método não executa o que é esperado pelo cliente. Por exemplo o que antes era um repositório passa ser apenas um cálculo, sem guardar a informação em lugar algum',4,'2026-07-27 17:07:21');
INSERT INTO resposta VALUES(17,77,6,'2026-07-27 17:07:26','2026-07-27 17:12:11',285,'Isso eu realmente não me recordo. Preciso inclusive entender o que são pré condições, pós condições e invariantes. Pré condições e pós condições são definidas na assinatura do método?',1,'2026-07-28 07:42:29');
INSERT INTO resposta VALUES(18,80,6,'2026-07-28 07:42:33','2026-07-28 08:05:23',1370,'Há violação. Ao utilizar setAltura e setLargura o cliente pode na verdade estar alterando valores de um quadrado (via polimorfismo) e quebrando a pré condição de que um quadrado deve ter sempre a mesma largura e altura',2,'2026-07-28 08:06:09');
INSERT INTO resposta VALUES(19,81,6,'2026-07-28 08:06:13','2026-07-28 08:10:34',261,'A violação da LSP quase sempre nasce de uma relação de heranção como "é um" no vocabulário do domínio mas não no comportamento porque elementos que no domínio "são um" muitas vezes possuem comportamentos suficientemente diferentes a ponto de sua modelagem como extensão quebrar invariantes ou outra condição. Um exemplo é o exemplo do quadrado e do retângulo. Um quadrado é um retângulo, mas ele possui a invariante de ter lados iguais (algo que é o retângulo não tem). Você pode me dar outros exemplos de ocorrência do problema?',3,'2026-07-28 08:11:42');
INSERT INTO resposta VALUES(20,74,6,'2026-07-28 08:11:46','2026-07-28 08:18:46',420,'O princípio da responsabilidade única diz que um componente de software deve possuir apenas uma responsabilidade. Isso quer dizer que um componente só tem uma fonte de mudança (que é sua responsabilidade), não deve existir mais de uma fonte de mudança que justifique mudança no componente. Por exemplo, ao empregar-se o padrão repository, se há um repositório com um método de listar funcionários e um método de cadastrar funcionário, funcionário é a única fonte de mudança. Caso a tabela funcionário mude o repositório mudará, caso contrário ele permanecerá do modo que está',4,'2026-07-28 08:19:34');
INSERT INTO resposta VALUES(21,75,6,'2026-07-28 08:19:38','2026-07-28 08:24:53',315,'O princípio aberto/fechado determina que um sistema deve ser aberto a adições e fechado a modificações. O mecanismo de orientação de objetos que permite isso na prática são as extensões. Por exemplo: um if/else pode ser substituído com um método abstrato que, quando a classe é extendida, possui diferentes implementação desse método (através da sobrescrita). Com isso, se obtêm diferentes comportamentos e se adiciona subclasses quando desejado sem se alterar a superclasse. Vale ressaltar que isso é um cenário ideal, porém podem ser necessários alterações numa classe',4,'2026-07-28 08:25:44');
INSERT INTO resposta VALUES(22,78,6,'2026-07-28 08:25:48','2026-07-28 08:31:13',325,'O princípio da segregação de interfaces diz que um componente não deve herdar elementos que não utiliza. Por exemplo: se uma classe implementa uma interface, não podem haver nessa interface métodos que não são utilizados pela classe. O princípio da responsabilidade única diz respeito a um componente ter apenas uma responsabilidade que é a fonte de mudança daquele componente. Perceba que o "fazer menos coisas" do princípio da segregação de interfaces é não herdar métodos que não são utilizados. O "fazer menos coisas" do princípio da responsabilidade única é não ter mais de uma responsabilidade. São princípios essencialmente diferentes.',4,'2026-07-28 08:32:04');
INSERT INTO resposta VALUES(23,79,6,'2026-07-28 08:32:10','2026-07-28 08:38:37',387,'O princípio da inversão de dependência diz respeito a componentes passarem a depender de abstrações ao invés de classes concretas, aumentando a modularidade. Por exemplo: se uma classe de serviço instancia diretamente uma classe de persistência, a classe de serviço fica acoplada a persistência. Quando se cria uma abstração a classe de serviço pode passar a depender da abstração e a classe de persistência implementar a abstração. Ambas passam a estar relacionadas (depender) da abstração e não uma da outa. A injeção de dependência é uma maneira de se obter esse resultado ao passar uma dependência para outra via construtor. A classe que recebe a dependência para de depender dos elementos que constroem a classe que é passada via construtor e passa a recebê-la já pronta',3,'2026-07-28 08:43:31');
INSERT INTO resposta VALUES(24,77,7,'2026-07-28 08:47:44','2026-07-28 08:52:33',289,'Pré condições: uma subclasse não pode fortalecê-las, dessa forma a subclasse esperada as condições que já foram determinadas. Uma extensão de uma classe não deve tornar as pré-restrições mais fortes porque isso faria com que a superclasse passe a ser responsável por garanitr essas pré-condições que antes não existiam. Pós condições: uma subclasse não pode enfraquecê-las. A subclasse deve continuar contendo o comportamento e condições esperadas pela superclasse. Invariantes: uma subclasse deve mantê-las, sem alterá-las. Exceções lançadas também não podem ser diferentes das já esperadas, isso seria um comportamento que causaria modificações na superclasse.',4,'2026-07-28 08:53:30');
INSERT INTO resposta VALUES(25,148,5,'2026-07-28 09:07:54','2026-07-28 09:07:54',NULL,unistr('Os eventos scrum são:\u000aSprint planning\u000adaily\u000asprint review\u000asprint retrospective\u000a\u000aToda a equipe participa do sprint planning. Nele são definidas as metas da iteração, quais elementos entram no ciclo atual considerando-se os elementos que possuem mais valor no product backlog e a capacidade do dev team. A daily é uma reunião rápida em que cada pessoa do time de desenvolvimento informa o que fez e possíveis impedimentos aos quais podem ser facilitados pelo scrum master. O sprint review é uma reunião em que são apresentados ao cliente as entregas do ciclo e o sprint retrospective é uma reunião com todos da equipe para avaliar a iteração, o que foi bom e ruim e possíveis melhorias para próximas iterações.'),4,'2026-07-28 09:17:42');
INSERT INTO resposta VALUES(26,149,5,'2026-07-28 09:24:12','2026-07-28 09:24:12',NULL,'Product Backlog é definido pelo PO. Nele estão os artefatos a serem produzidos. O PO determina a prioridade de cada item do product backlog. O Sprint backlog é o backlog da Sprint. Definido pelo próprio dev team de acordo com as prioridades definidas pelo PO e as tarefas cabíveis na Sprint determinada pelo dev team; O Sprint Goal é o objetivo da Sprint, determinado em conjunto com todo o time (Scrum master, PO e dev team).',3,'2026-07-28 09:25:00');
INSERT INTO resposta VALUES(27,152,5,'2026-07-28 09:34:36','2026-07-28 09:34:36',NULL,'A capacidade do time diz respeito ao quanto o dev team consegue produzir. Colocar mais itens na sprint do que o dev team suporta sobrecarrega o time de desenvolvimento. Não adianta colocar mais itens no sprint se o time não comporta todos os itens inseridos, mesmo que seja necessário sobrar para a próxima sprint',4,'2026-07-28 09:35:18');
INSERT INTO resposta VALUES(28,154,5,'2026-07-28 10:41:03','2026-07-28 10:41:03',NULL,'A metodologia ágil mais adequada é o scrum. O scrum é a metodologia que mais prioriza o contato com os stakeholders, o que é muito benéfico quando os requisitos mudam com frequência. Além disso o scrum contém sprints (ciclos incrementais de entrega). Vale ressaltar que na Sprint review há o feedback do cliente a respeito da entrega. Sendo assim cumpre perfeitamente o requisito de valor ao cliente por feedback contínu.',2,'2026-07-28 10:43:19');
INSERT INTO resposta VALUES(29,155,5,'2026-07-28 11:40:34','2026-07-28 11:40:34',NULL,'O scrum master deve retirar impedimentos para que o time de desenvolvimento consiga reorganizar as tarefas para que sejam executadas dentro do sprint (se possível). O scrum master não deve assumir a tarefa, escalar ao PO e nem encerrar o sprint mais cedo. Se o scrum master assumir a tarefa ele passará a executar uma atividade que não deve e ferindo os princípios do scrum. Ao fazer isso ele desorganiza o time. Escalar cai no mesmo problema. Encerrar o sprint mais cedo também não resolve, pois o sprint tem um tempo determinada, se a tarefa não for encerrada ela simplesmente retorna ao product backlog e será feita num sprint posterior',2,'2026-07-28 11:44:00');
INSERT INTO resposta VALUES(30,156,5,'2026-07-28 11:53:28','2026-07-28 11:53:28',NULL,'Quando o Scrum Master decide sozinho, se perder a noção da capacidade de trabalho da equipe. A equipe sabe determinar muito melhor sua própria capacidade de trabalho (para o sprint backlog) e quem executa cada tarefa (visto que compreendem melhor qual funcionário do time de desenvolvimento domina qual tipo de tarefa).',3,'2026-07-28 11:54:31');
INSERT INTO resposta VALUES(31,145,5,'2026-07-28 12:07:47','2026-07-28 12:07:47',NULL,'Eu não me recordo dos valores. "Mais que" não autoriza concluir que fatores não importam. a>b não significa que b não importa',1,'2026-07-28 12:10:02');
INSERT INTO resposta VALUES(32,146,5,'2026-07-28 13:37:16','2026-07-28 13:37:16',NULL,'Kanban não tem ciclos de tempo e nem momento de entrega bem determinada, ele não é timeboxed. No kanban cada artefato pode estar em andamento, a iniciar, concluída ou até podem ser definidas mais etapas. No Kanban o trabalho em andamento também não é limitado. Tudo isso é precisamente mapeado no scrum. O momento da entrega é defenido antes da sprint ( é o final da sprint, quando ocorre o sprint review), os ciclos de tempo são as próprias sprints e a quantidade de trabalho em andamento é bem determinada para evitar a execução de muitas tarefas em paralelo',2,'2026-07-28 13:55:00');
INSERT INTO resposta VALUES(33,150,5,'2026-07-28 15:22:03','2026-07-28 15:22:03',NULL,'O scrum master deve facilitar para que o time encontre a solução, remover impedimentos. O scrum master não deve assumir tarefas por conta própria e nem redistribuir tarefas por conta própria, a distribuição das tarefas é de responsabilidade do time de desenvolvimento e não do scrum master. ',4,'2026-07-28 15:22:51');
INSERT INTO resposta VALUES(34,151,5,'2026-07-28 16:15:56','2026-07-28 16:15:56',NULL,'Não, o product owner não deve decidir sozinho quais itens entram no sprint. O time de desenvolvimento decide quais itens entram no sprint baseado nas prioridades determinados pelo product owner e na capacidade do produtiva do time.',4,'2026-07-28 16:49:32');
INSERT INTO resposta VALUES(35,153,8,'2026-07-29 14:19:08','2026-07-29 14:21:52',152,'XP (Extreme programming) diz respeito a programação utilizando boas práticas como padrões arquiteturais, programação em pares, TDD, ... Waterfal é o modelo em cascata, em que não há entregas recorrentes, todo o programa é feito e entregue num único bloco. Abordagem Ágil híbrida é uma mistura de ágil com waterfall, ele visa entrega recorrentes mas ainda assim valoriza muito documentação pesada, por exemplo. Lean eu não me recordo',3,'2026-07-29 14:22:51');
INSERT INTO resposta VALUES(36,147,8,'2026-07-29 14:25:17','2026-07-29 14:31:14',349,'Os papéis são product owner (PO), Scrum Master e time de desenvolvimento. O PO é responsável por defeneder os valores dos stakeholder, ele organiza o product backlog priorizando o que trás mais valor aos stakeholders. O Scrum Master é quem guia a cerimônia do scrum e ajuda a resolver impedimentos (sem orgnaziar as tarefas e sem assumir o papel de dev) o time de desenvolvimento é responsável por transformar os itens em incremento, distribuindo entre si as tarefas.',4,'2026-07-29 14:54:15');
INSERT INTO resposta VALUES(37,148,8,'2026-07-29 14:55:21','2026-07-29 15:00:48',318,'Os eventos Scrum são o Sprint Planning, Daily, Sprint review e Sprint Retrespective. No Sprint Planing é definido a meta da sprint e os artefatos do product backlog que farão parte do sprint backlog, considerando a capacidade dos developers. O PO define as prioridades do product backlog e os developers limitam a quantidade de artefatos baseado na capacidade. A daily é uma reunião rápida de no máximo 15 minutos em que os developers e o scrum master conversam sobre as tarefas, explicitando impedimentos que podem ser resolvidos pelo Scrum Master. A Sprint review é uma revisão do Sprint com todos os membros da equipe e os stakeholders, nessa reunião são apresentados os incrementos aos stakeholders e a sprint é revisada, considerand-se a meta da sprint. O sprint retrospective é uma retrospectiva da sprint, sem stakeholders. Nessa retrospecitva a equipe avalia aspectos positivos e negativos do sprint e possíveis adaptações para sprints futuros.',3,'2026-07-29 15:02:19');
INSERT INTO resposta VALUES(38,149,8,'2026-07-29 15:05:26','2026-07-29 15:08:33',177,'Product Backlog indica todo produto que precisa ser produzido. Tudo que precisa ser transformado em Incremento. O Product Backlog é mantido pelo PO, atribuindo prioridades de acordo com o atribuído pelos stakeholders. O Sprint backlog é de responsabilidade do próprio time de desenvolvimento. Ele contém os itens que serão transformados em artefatos no sprint atual. O Sprint goal é o objetivo da sprint, decidido em conjunto com todo o time.',3,'2026-07-29 15:09:36');
INSERT INTO resposta VALUES(39,152,8,'2026-07-29 15:11:42','2026-07-29 15:16:26',276,'A capacidade do time é o quanto os developers conseguem produzir na sprint. Colocar mais itens do que o suportado sobrecarrega o time de desenvolvimento, gera um sprint goal que não pode ser alcançado e pode desorganizar o projeto. Com muitos itens no sprint backlog os developers podem acabar entregando Incrementos menos importantes do que alguns não finalizados no sprint (visto que todos ficaram acoplados na mesma sprint)',2,'2026-07-29 15:17:51');
INSERT INTO resposta VALUES(40,154,8,'2026-07-29 15:20:40','2026-07-29 15:23:29',162,'A metodologia adequada é o SCRUM. Kanban não tem necessariamente priorização de valor ao cliente e feedback contínuo, extreme programming diz respeito a boas práticas não a ciclos de entrega, valor ou feedback do cliente, lean também não possui ciclos incrementais. O SCRUM possui todos os requisitos enunciados pelo formulário',4,'2026-07-29 15:27:14');
INSERT INTO resposta VALUES(41,155,9,'2026-07-30 11:00:03','2026-07-30 11:08:27',300,'O Scrum Master deve apenas retirar impedimentos, sem assumir a tarefa ou escalar ao PO e nem encerrar o sprint mais cedo. O Scrum Master só deve avisar ao PO caso realmente a tarefa não possa ser exevutada e isso imapcte o Sprint Goal e a entrega de valor do sprint. O time deve reorganizar as tarefas (por ele mesmo), sem intervenção do Scrum Master. Honestamente prefiro que você me fale das probçemáticas das opções, acredito que seja melhor do que eu inventar uma resposta',2,'2026-07-30 11:09:51');
INSERT INTO resposta VALUES(42,77,9,'2026-07-30 11:12:34','2026-07-30 11:14:31',180,'O princípio da substituição de liskov impõe que pré-condicções não podem ser enfraquecidas, pós condições não podem ser fortalecidas, invariantes não devem ser alteradas e não devem ser lançadas novas exceções',4,'2026-07-30 11:15:40');
INSERT INTO resposta VALUES(43,145,9,'2026-07-30 11:17:15','2026-07-30 11:19:04',120,'mais que não autoriza concluir que não é importante. Ainda que x > y, y ainda importa. Eu não vou chutar os valores, essa pergunta deve ser refeita amanhã',2,'2026-07-30 11:20:10');
INSERT INTO resposta VALUES(44,219,11,'2026-07-30 15:34:20','2026-07-30 15:36:27',127,'Sistemas transacionais utilizam banco de dados relacionais (SQL). Bancos SQL seguem a abordagem do OLTP, em que as transações são garantidas e os princípios ACID.',3,'2026-07-30 15:37:43');
INSERT INTO resposta VALUES(45,220,11,'2026-07-30 15:37:43','2026-07-30 15:40:41',178,'Na abordagem multidimensional os dados são organizados em cubos. O cubo transforma a visualização de dados em algo mais rápido. Consultar dados deixa de ser relacionar diversas tabelas e passa a ser visualizar uma célula do cubo, o que é bem mais simples.',4,'2026-07-30 15:41:28');
INSERT INTO resposta VALUES(46,222,11,'2026-07-30 15:43:06','2026-07-30 15:45:35',149,'Não, bancos de dados NoSQL adotam BASE ao invés de ACID. BASE significa que o banco está Basically available (basicamente disponível), tem um Soft state (tem um estado que pode diferir entre elementos do cluster) e eventually consistency (significando que o estado eventualmente fica consistente).',3,'2026-07-30 15:46:22');
INSERT INTO resposta VALUES(47,224,11,'2026-07-30 15:46:22','2026-07-30 15:49:05',163,'Não, ERPs e CRMs possuem dados estruturados aos quais é possível se definir sua estrutura previamente, precisam de várias combinações entre tabelas (dificultando a formação de agregados), dependem de transações (o que fortalece o modelo relacional). ',3,'2026-07-30 15:50:28');
INSERT INTO resposta VALUES(48,223,11,'2026-07-30 15:50:28','2026-07-30 15:54:15',227,unistr('Bancos NoSQL:\u000a\u000aChave-valor\u000aorientado a documentos\u000aorientado a grafos\u000acolunares\u000a\u000aUm uso para banco de dados chave-valor (como o Redis) é para se cachear informações. O orientado a documentos pode ser utilizado para guardar dados não estruturados ou semi-estruturados. O orientado a grafos quando se precisa determinar proximidade entre elementos (exemplo: rede social) e os colunares para quando se há grandes quantidades de dados e se precisa de visualização rápida'),3,'2026-07-30 15:55:18');
INSERT INTO resposta VALUES(49,225,11,'2026-07-30 15:55:18','2026-07-30 16:06:05',647,unistr('As propriedades ACID são:\u000a\u000aAtomicidade: uma transação é atômica, ou ocorre ou não ocorre. Não é possível que ela seja parcialmente concluída.\u000aConsistência: o banco é consistênte em relação as restrições definidas como foregin keys, primary keys e outras constraints\u000aI:\u000aDurabilidade: as operações são duráveis, uma vez ocorrida não retornará ao estado anterior ou será desfeita (completa ou parcialmente) sem que seja feita uma nova operação com esse propósito\u000a\u000aBASE:\u000a\u000aBasically Available: os dados estão sempre disponíveis mesmo durante particionamentos ou estados inconsistentes\u000aSoft state: dados podem ficar temporariamente inconsistentes entre partições\u000aEventually consistent: dados inconsistentes eventualmente se atualizarão para ficarem consistentes\u000a\u000aO teorema CAP inicialmente foi postulado como uma escolha de 2 dentro de 3 características: consistência, disponibilidade e tolerância ao particionamento. Posteriormente compreende-se que essa escolha é parcial, consistência e disponibilidade não são binários, algo pode estar parcialmente disponível. Além disso essa escolha de duas dentre as três propriedades só é real enquanto se há um particionamento, não o tempo todo.'),3,'2026-07-30 16:07:11');
INSERT INTO resposta VALUES(50,226,11,'2026-07-30 16:07:11','2026-07-30 16:20:05',774,'Escalabilidade vertical consiste em aumentar a capacidade de um dispositvo para comportar mais operações, dados ou processamento. A escalabilidade horizontal consiste aumentar a quantide de dispositivos executando as operações, processamente ou armazenando os dados. Os bancos de dados NoSQL facilitam a escalabilidade horizontal a medida que conseguem gerar agregados que podem ser comportados num único dispositivo e não dependem de informações armazendads em outros dispositivos.',4,'2026-07-30 16:20:56');
INSERT INTO resposta VALUES(51,227,11,'2026-07-30 16:20:56','2026-07-30 16:33:23',747,unistr('i: banco de dados relacional. É o banco que melhor desempenha transações e estoque e pagamento possuem uma estrutura de dados bem definida\u000aii: banco de dados NoSQL, especificamente um banco orientado a documentos. Esses bancos possuem alta capacidade de leitura e permitem o armazenamento de dados semi-estruturados\u000aiii: banco de dados orientado a grafos (NoSQL), esse tipo de banco facilita a visualização da proximidade entre elementos'),3,'2026-07-30 16:36:27');
INSERT INTO resposta VALUES(52,156,12,'2026-08-03 09:19:36','2026-08-03 09:22:28',163,'Quando o Scrum Master decide sozinho tende-se a perder o senso de responsabilidade. O time tende a se responsabilizar mais sobre suas próprias decisões do que sobre decisões de terceiros. Além disso o time conhece melhor suas capacidades e limitações do que o Scrum Master',4,'2026-08-03 09:44:56');
INSERT INTO resposta VALUES(53,222,12,'2026-08-03 09:45:28','2026-08-03 10:06:25',1249,'Não, bancos NoSQL seguem as propriedades BaSE no lugar do ACID. BaSE significa que os bancos são Basically available, referenciando sua alta disponibilidade, Soft State o que significa que seu estado pode ser modificado sem nenhuma nova entrada para se tornar consistente, e eventually consistent significa que os estados eventualmente ficarão consistentes (a mesma informação não terá conteúdo diferente em nós diferentes).',3,'2026-08-03 10:09:02');
INSERT INTO resposta VALUES(54,224,12,'2026-08-03 10:09:28','2026-08-03 10:16:26',408,'Para ERPs e CRMs bancos NoSQL não são a melhor escolha. No caso de CRMs e ERPs os dados são estruturados, há  a necessidade de se combinar os dados de várias formas diferentes, há necessidade de um controle transacional e a consistência é de extrema importância. Ao utilizar SQL você garante uma maior consistência dos dados e facilita consultas combinando diferentes tabelas e um maior controle de transações.',3,'2026-08-03 10:22:00');
INSERT INTO resposta VALUES(55,223,12,'2026-08-03 10:22:28','2026-08-03 10:31:26',523,'Os bancos de dados NoSQL são: chave-valor, orientado a documentos, orientado a grafos e colunares. Os bancos chave-valor são muito utilizados para cache de informações, os banvos orientados a documentos são utilizados para modular dados semi-estruturados, os bancos orientados a grafos são eficientes em determinar relações entre elementos (exemplo: rede social), os bancos colunares são excelentes para grandes volumes dados e foco em operações de leitura.',4,'2026-08-03 10:32:35');
INSERT INTO resposta VALUES(56,225,12,'2026-08-03 10:33:04','2026-08-03 10:47:25',852,'As propriedades ACID são Atomicidade, consistência, Independência e Durabilidade. Atomicidade significa que transações são atômicas, ou ocorrem por completo ou não ocorrem. Consistência significa que o banco garante determinadas regras e limitações no que diz respeito ao uso de chaves primária,s estrangeiras, elementos únicos, ... Independência quer dizer que transações são independentes. Se há entradas referentes a mais de uma transação, essas transações serão executadas de maneiras independentes de acordo com uma determinada ordem, uma transação ainda em andamento não impactará a outra, elas ocorrerão de modo sequencial. Durabilidade quer dizer que operações são duráveis, após commitadas não serão revertidas sem uma nova entrada para revertê-las. Base são propriedades de bancos de dados NoSQL, é um acrônimo para Basically available, soft state e eventually consistent. Isso quer dizer que o sistema trará um retorno ainda que os dados estejam inconsistentes, o estado dos dados pode ser alterado mesmo sem novas entradas para consequenciar consistência entre agregados e eventually consistent quer dizer que em algum momento, cessadas as operações de escrita, os dados retornarão a um estado consistente. O teorema CAP obriga a escolher entre consistencia e disponibilidade enquanto o sistema está particionado. Isso se deve ao fato de que, havendo uma partição, não é possível que agregados se mantenham consistentes visto que estão incomunicáveis (particionados), com isso ou se retorna o dado mesmo que possivelmente inconsistente (garantindo disponibilidade) ou se perde a disponibilidade para garantir a consistência. Enquanto o sistema está particionado não é possível garantir ambos: disponibilidade e consistência.',3,'2026-08-03 10:48:51');
INSERT INTO resposta VALUES(57,226,12,'2026-08-03 10:49:27','2026-08-03 10:55:45',368,'Escalabilidade horizontal consiste em utilizar mais máquinas para se guardar dados e processar requisições. Escalabilidade vertical consiste em aumentar a capacidade de uma máquina para que ela suporte mais dados e requisições. Sistemas NoSQL são mais adaptáveis a escalabilidade horizontal pois dentro de um nó se pode ter todas as informações de um agregado e garantias ACID nesse tipo de banco só existem dentro de um agregado. Já em bancos relacionais, há a necessidade de se garantir controle transacional entre elementos que poderiam acabar ficando distribuídos em caso de escalabilidade horizontal, o que pode ser mais custoso, complexo e menos performático.',3,'2026-08-03 10:56:47');
INSERT INTO resposta VALUES(58,227,12,'2026-08-03 10:57:17','2026-08-03 11:23:13',1547,unistr('i: O banco adequado nesse caso é um banco relacional, visto que se há uma estrutura bem definida para os dados e há a necessidade de transações incluindo dados diferentes que não se encaixariam bem num agregado.\u000aii:  para catálogos com atributos variáveis um banco de dados orientado a documentos é a melhor opção. Com esse tipo de banco de dados é possível utilizar dados semi-estruturados o que é justamente o necessário para os atributos variáveis. Esse banco também possui alta capacidade de leitura, o que também se adequa aos requisitos enunciados.\u000aiii: Para recomendações por relações entre usuários e produtos o banco adequado é o orientado a grafos. A principal característica desse bancp é justamente sua eficiencia em mapear relacionamentos entre dados.'),3,'2026-08-03 11:24:57');
INSERT INTO resposta VALUES(59,77,13,'2026-08-03 11:33:58','2026-08-03 11:33:58',NULL,'O princípio da substituição de liskov impõe a uma subclasse que a subclasse não altere invariantes, não lance novas exceções não mapeadas, não enfraqueça pré-condições e não fortaleça pós-condições',3,'2026-08-03 11:35:10');
INSERT INTO resposta VALUES(60,76,13,'2026-08-03 11:38:25','2026-08-03 11:38:25',NULL,'Não. Contanto que a subclasse mantenha contrato e comportamento esperados, não há violação simplesmente pela alteração do comportamento. Alterar o comportamento não significa que o novo comportamento não será algo diferente do esperado. Por exemplo se simplesmente ao invés de printar "a" printar "b" e printar uma letra for o comportamento esperado, não há violação.',4,'2026-08-03 11:39:58');
INSERT INTO resposta VALUES(61,73,13,'2026-08-03 11:52:19','2026-08-03 11:52:19',NULL,unistr('Os princípios SOLID são:\u000a\u000aSingle responsability principle\u000aOpen-closed principle\u000aLiskov substitution principle\u000aInterface segregation principle\u000aDependency inversion principle\u000a\u000aO princípio da responsabilidade única deternina que um componente de software deve ter apenas uma responsabilidade, no sentido de ter apenas uma fonte de mudanças. Não deve existir mais de uma fonte que causa mudanças no componente.\u000aO princípio aberto-fechado determina que um componente de software deve estar aberto a extensões e fechado a modificações. Isso significa que novas funcionalidades ou opções não devem causar alterações no componente, isso deve ser feito através de extensões e polimorfismo, sem alterar métodos já existentes. Na prática pode ser necessário alterações, mas isso é um comportamento que deve ser mitigado.\u000aO princípio de substituição de Liskov determina que uma extensão de uma classe deve manter o contrato, tratamento de exceções e comportamento esperado pela classe pai. Substituir a subclasse não deve causar alterações na superclasse.\u000aO princípio da segregação de interface diz que um componente não deve herdar comportamentos que não utiliza. Ao implementar uma interface um componente não deve ser obrigado a possuir métodos que não serão utilizados pelo mesmo.\u000aO princípio de inversão de dependência diz que componentes de software não devem ser dependentes entre si. Tanto componentes maiores quanto os menores devem estar associados a abstrações. Um exemplo de inversão de dependência seria a injenção de dependência. Na injeção de dependência o cliente passa a conhecer via construtor uma abstração que é implementada pelo componente que executa o comporamento.'),3,'2026-08-03 11:53:34');
INSERT INTO resposta VALUES(62,80,13,'2026-08-03 13:03:09','2026-08-03 13:03:09',NULL,'O princípio de substituição de Liskov é violado, pois quadrado tem uma invariante (lado e altura iguais) que a superclasse (retângulo) não possui. O problema não está na subclasse pois essa invariante é real para um quadrado, ele precisa possuí-la. O problema está na modelagem de uma extensão que não configura uma extensão do ponto de vista sistêmico. Por mais que todo quadrado seja um retângulo no vocabulário do domínio, quadrado possui regras que retângulo não possui e portanto do ponto de vista de modelagem não pode ser classificado como retângulo.',4,'2026-08-03 13:04:27');
INSERT INTO resposta VALUES(63,81,13,'2026-08-03 13:09:04','2026-08-03 13:09:04',NULL,'A violação da LSP nasce de um é-um do senso comum porque ao modelar algo como um "é um" que do ponto de vista sistêmico não "é um" o que ocorre é que subclasses podem ter comportamentos diferentes que possuem invariantes, pré-condições ou pós-condições distintas. Desse modo acabam ferindo o princípio. O critério correto para decidir se uma herança é legítima é avaliar se "é um" do ponto de vista de modelagem de dados. Com isso quero dizer avaliar se ambos seguem os mesmos tipos de regras mesmo que na prática o comportamento possa diferir em alguns aspectos.',3,'2026-08-03 13:10:26');
INSERT INTO resposta VALUES(64,74,13,'2026-08-03 13:22:23','2026-08-03 13:22:23',NULL,'O princípio da responsabilidade única diz que um componente de software deve possuir apenas uma responsabilidade, no sentido de apenas uma fonte de mudanças. Por exemplo: uma classe de repositório que faz conexão com o banco de dados pode listar e incluir elementos numa tabela (por exemplo uma tabela `Funcionario`). Esses dois métodos terão a mesma fonte de mudanças: o banco de dados. A responsabilidade da classe é implementar o relacionamento com uma tabela e isso é feito em ambos os seus métodos.',3,'2026-08-03 13:23:57');
INSERT INTO resposta VALUES(65,75,13,'2026-08-03 13:30:36','2026-08-03 13:30:36',NULL,'O princípio abert/fechado determina que uma classe deve estar aberta para extensões e fechadas a alterações. A ideia é que incluir novos comportamentos não resulte em alterações em métodos já existentes da classe. Na prática pode haver a necessidade de alterar comportamentos já existentes, mas a ideia é que isso seja evitado e prevenido. Isso é obtido através de extensões e polimorfismo. Um exemplo seria ao invés de incluir if/else ou switch num método fazer extensões que sobrescrevem o método existente aplicando o comportamento desejado.',3,'2026-08-03 13:32:04');
INSERT INTO resposta VALUES(66,78,13,'2026-08-03 13:41:21','2026-08-03 13:41:21',NULL,'O princípio da segregação da interface e o princípio da responsabilidade única dizem respeito a tipos de separação diferentes. O princípio de separação de interfaces diz que um cliente não deve depender de métodos que não utiliza. Um exemplo seria um construtor de uma classe que recebe uma outra classe como atributo e essa outra classe nunca é utilizada, essa dependência existe apenas para outros tipos de cenário em que é necessária essa classe. O princípio da responsabilidade única diz que um componente deve ter apenas uma responsabilidade, uma fonte de mudanças. Dessa forma é uma separação de responsabilidades, se possuem responsabilidades diferentes devem pertencer a métodos diferentes.',3,'2026-08-03 13:42:49');
INSERT INTO resposta VALUES(67,79,13,'2026-08-03 13:49:09','2026-08-03 13:49:09',NULL,'O princípio da inversão de dependência diz que detalhes devem depender de abstrações e não abstrações dependerem dos detalhes. Uma maneira de fazer isso é fazer com que uma classe receba uma abstração de uma dependência via construtor e haver uma implementação dessa abstração que lida com os detalhes. Dessa forma o cliente não conhece a implementação que contém os detalhes e a implementação não conhece o cliente, ela apenas cumpre o contrato e contém os comportamentos esperados por ele. Essa maneira de implementar a inversão de dependência se chama injeção de dependência, mas não é a única maneira possível. Além disso pode haver injeção de dependência sem haver inversão de dependência quando o cliente continua conhecendo detalhes da implementação: por exemplo quando um service conhece o driver do banco que é utilizado por um repository.',3,'2026-08-03 13:51:20');
INSERT INTO resposta VALUES(68,146,14,'2026-08-03 13:57:34','2026-08-03 14:03:23',349,'O scrum e o Kanban possuem diversas diferenças, algumas delas estão presentes no momento de entrega, ciclos de tempo e forma de limitar trabalho em andamento. O scrum é timeboxed, possui ciclos específicos de tempo para seus eventos (sprint, srpint review, sprint retrospective, daily, sprint planning), já o kanban não é timeboxed, não possui um tempo delimitado para seus elementos. Como consequência o scrum possui um momento de entrega bem delimitado com um objetivo em específico (meta da sprint). O Kanban tem uma maneira mais bem definida de limitar o trabalho em andamento com o WIP, já no SCRUM a equipe é autogerenciada e ela mesmo determina a quantidade de trabalho em andamento.',2,'2026-08-03 14:04:51');
INSERT INTO resposta VALUES(69,150,14,'2026-08-03 14:12:00','2026-08-03 14:15:56',236,'Cabe ao Scrum Master facilitar para que o time encontre solução, retirar os impedimentos. Assumir a tarefa do desenvolvedor retira o scrum master do seu papel e quebra o autogerenciamento do time, redistribuir a tarefa por conta própria também fere o autogerenciamento e impacta o senso de responsabilidade dos developers. O Scrum master não é developer e nem gerente da cerimônia, seu papel é de um comunicador e facilitador, facilitando a comunicação da equipe, PO, guiando as cerimônias e mantendo o time coeso.',2,'2026-08-03 14:16:53');
INSERT INTO resposta VALUES(70,151,14,'2026-08-03 14:18:30','2026-08-03 14:30:57',747,'Não, o Product Owner não decide sozingo quais itens entram no Sprint. O Product Owner organiza o Product Backlog por prioridade e os developers decidem quais itens entram no sprint de acordo com as prioridades estabelecidas pelo PO. O PO definir sozinho as tarefas feririam o autogerenciamento e prejudicaria o senso de responsabilidade',4,'2026-08-03 14:31:40');
INSERT INTO resposta VALUES(71,153,15,'2026-08-04 07:47:01','2026-08-04 07:59:58',777,'XP, extreme programming, é um tipo de abordagem para desenvolvimento de software utilizando boas práticas como pair programming, TDD, padrões arquiteturais, ... o extreme programming não diz respeito ao gerenciamento de projeto em si, mas sim ao desenvolvimento de software. Lean busca entregar o que tem valor para o cliente, não priorizando aquilo que não trás valor diretamente. Waterfall é o modelo em cascata, sua principal característica é a documentação pesada antes de se iniciar o desenvolvimento do sistema. A abordagem ágil híbrida mistura elementos da metodologia ágil com a waterfall.',2,'2026-08-04 08:01:37');
INSERT INTO resposta VALUES(72,147,15,'2026-08-04 08:01:37','2026-08-04 10:08:01',7584,'Os papéis do scrum são: Scrum Master, Developers e Product Owner. O Scrum Master tem o papel de remover impedimentos e facilitar que a equipe siga com o projeto, ele também auxilia nas crimônias. O Scrum Master cumpre um papel de líder servidor e não de gerenciador, a equipe de desenvolvimento é auto gerenciada. Os developers são quem transforma os itens em incrementos, é uma equipe autogerenciada que decide como as tarefas serão feitas, capacidade do time, definição de pronto, quem fará o quê. O Product Owner é quem define as prioridades do projeto, definindo e organizando o product backlog de acordo com aquilo que é mais prioritário e entrega mais valor aos stakeholders. O Product Owner determina o porquê das tarefas serem feitas, o time de desenvolvimento o como.',3,'2026-08-04 10:09:19');
INSERT INTO resposta VALUES(73,148,15,'2026-08-04 10:09:19','2026-08-04 10:26:41',1042,'Os eventos scrum são o sprint, o sprint planning, a daily, o sprint review e o sprint retrospective. O sprint é timeboxed, durando 28 dias. Nele é definido uma meta para a equipe contendo as tarefas, incrementos e objetivos da sprint de um modo geral. Toda a equipe é responsável pelo sprint, sua condução não fica atrelado a apenas uma das partes. O sprint planning é o evento em que o sprint é planejado, seus princripais produtos são o sprint backlog e o sprint goal. O sprint backlog é determinado pelos developers, seguindo as prioridades do product backlog determinadas pelo PO. O sprint goal é determinado por toda a equipe. A daily é uma reunião diária do time de desenvolvimento para acompanhar o progresso do sprint e identificar possíveis impedimentos ou atrasos. O sprint review é uma revisão do sprint, fazem parte desse evento todos os membros da equipe e os stakeholders. Nele é revisto tudo que foi feito na sprint e conversado com os stakeholders sobre o projeto. A sprint retrospective é uma retrospectiva da sprint apenas com a equipe, sem stakeholders. Nela são identificados pontos positivos e negativos da sprint, levantando-se possíveis melhorias para próximas sprints',3,'2026-08-04 10:30:15');
INSERT INTO resposta VALUES(74,149,15,'2026-08-04 10:30:15','2026-08-04 10:51:59',1304,'Product backlog são itens a serem produzidos, a serem transformados em incremento. É de responsabilidade do PO se comunicar com os stakeholders, entender suas necessidades, criar o product backlog, ordená-lo de acordo com prioridades e mantélo. O Sprint Backlog são os itens que foram planejados para serem transformados em incremento na sprint planejada (durante o sprint planning). O sprint goal é a meta da sprint, o objetivo do trabalho.',3,'2026-08-04 10:52:38');
INSERT INTO resposta VALUES(75,152,15,'2026-08-04 10:52:38','2026-08-04 14:47:43',14105,'A capacidade do time diz respeito a capacidade produtiva dos developers, a quantidade de tarefas que podem fazer parte de um sprint. Ela é determinada pelos próprios developers, visto que os desenvolvedores são autogerenciados, mantendo o senso de responsabilidade. A ideia de "sobra alguma coisa para o próximo Sprint" não é válida, visto que o product backlog é reordenado em toda Sprint Review.',4,'2026-08-04 14:48:20');
CREATE TABLE avaliacao (
  id          INTEGER PRIMARY KEY,
  resposta_id INTEGER NOT NULL REFERENCES resposta(id),
  nota        INTEGER NOT NULL CHECK (nota BETWEEN 0 AND 5),
  veredito    TEXT    NOT NULL CHECK (veredito IN
                ('branco','errado','vago','parcial','bom','completo')),
  feedback    TEXT    NOT NULL,
  avaliada_em TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
  avaliador   TEXT    NOT NULL DEFAULT 'ia'
) STRICT;
INSERT INTO avaliacao VALUES(1,1,3,'parcial','Nomeou os cinco corretamente. SRP e OCP com formulacao correta. LSP: acertou o nucleo (manter contratos/comportamento esperado) mas misturou uma nocao equivocada (alteracao na subclasse nao afetar a superclasse nao e o que o LSP diz). ISP: em branco. DIP: confundiu com injecao de dependencia; nao enunciou a formulacao (alto/baixo nivel dependem de abstracoes; abstracoes nao dependem de detalhes).','2026-07-24 08:22:51','ia');
INSERT INTO avaliacao VALUES(2,2,4,'bom','Definiu responsabilidade como fonte/motivo de mudanca e respondeu bem o cerne: varios metodos podem coexistir se mudam pela mesma razao (exemplo do repositorio ok). Faltou apenas o acessorio: a ilustracao de que contar metodos nao basta (interface Modem = 4 metodos, 2 responsabilidades) e o vinculo com coesao de classe.','2026-07-24 08:54:18','ia');
INSERT INTO avaliacao VALUES(3,3,3,'parcial','Aberto/fechado corretos (aberto para extensao, fechado para modificacao). Mas a pergunta pede o MECANISMO de OO e a resposta parou em ''extensoes'', que e vago: o mecanismo e abstracao + polimorfismo (o modulo depende de uma base abstrata fixa e o novo comportamento entra como novo derivado, sem tocar no modulo). Faltou nomear isso.','2026-07-24 08:57:18','ia');
INSERT INTO avaliacao VALUES(4,4,4,'bom','Resposta correta: nao viola por esse fato isolado; o criterio esta no contrato/comportamento esperado, nao no ato de sobrescrever. Exemplo do som ok (polimorfismo normal). Faltou o acessorio de precisao: nomear QUANDO ha violacao (fortalecer pre-condicao, enfraquecer pos-condicao, quebrar invariante/expectativa) e o vinculo de que o override e o proprio mecanismo do OCP.','2026-07-24 09:07:19','ia');
INSERT INTO avaliacao VALUES(5,5,0,'branco','Respondeu ''Não sei''. Restricoes do LSP nao recordadas: pre-condicoes (nao fortalecer), pos-condicoes (nao enfraquecer), invariantes (preservar), excecoes (nao lancar as inesperadas). Regra de Meyer.','2026-07-24 09:13:48','ia');
INSERT INTO avaliacao VALUES(6,6,3,'parcial','SRP: alvo correto (a classe/modulo, um unico motivo para mudar). ISP: pegou a nocao de nao usar o que nao precisa, mas errou o verbo (''herdar'' -> e DEPENDER) e, sobretudo, nao nomeou o ALVO que a pergunta pede: o ISP incide sobre o CLIENTE (nenhum cliente forcado a depender de metodos que nao usa). O eixo da distincao e classe (quem mantem) x cliente (quem consome).','2026-07-24 10:14:09','ia');
INSERT INTO avaliacao VALUES(7,7,3,'parcial','Acertou a distincao central (DIP = principio; DI = tecnica) e o sim/nao (podem existir separados) - grande evolucao em relacao ao Q73. Mas nao sustentou: (a) nao caracterizou a tecnica de DI (fornecer a dependencia de fora, ex. construtor, em vez de o objeto cria-la); (b) sobretudo nao justificou a separabilidade com os dois casos - injetar um concreto e DI SEM inverter (ainda acopla ao detalhe), e da para obter DIP por fabrica abstrata SEM injecao classica. A formulacao do DIP saiu pela metade (faltou: alto e baixo nivel dependem de abstracoes).','2026-07-24 10:24:05','ia');
INSERT INTO avaliacao VALUES(8,8,3,'parcial','Acertou 2 das 3 partes: SIM ha violacao, e a explicacao do compilador (relacao de tipos valida, sobrescrita permitida, nao ha erro capturavel). Mas errou o miolo: QUAL restricao foi quebrada. Nao identificou que e a POS-CONDICAO de setLargura da base (altura permanece inalterada), enfraquecida pelo Quadrado; nem fez a conta que expoe o problema (cliente poe 5 e 4 esperando 20, mas o Quadrado da 16). Proposta de abstracao Poligono e boa engenharia, porem nao era o que se pediu.','2026-07-24 11:00:12','ia');
INSERT INTO avaliacao VALUES(9,9,3,'parcial','Pegou a tensao central (é-um do dominio tenta a heranca, mas o comportamento diverge) e usou o exemplo certo (Quadrado tem restricao que Retangulo nao tem). Mas a resposta ficou perto de reescrever a pergunta e faltaram os dois porques mais fortes: (a) o que importa em software e o comportamento PUBLICO do qual os CLIENTES dependem, nao a categoria matematica/intrinseca; (b) a validade NAO e intrinseca - um modelo pode ser autoconsistente sozinho e ainda invalido perante as suposicoes razoaveis dos clientes da base. Acessorio faltante: quebrar LSP tambem quebra o OCP (clientes passam a checar o tipo).','2026-07-24 13:50:03','ia');
INSERT INTO avaliacao VALUES(10,10,3,'parcial','Acertou a distinção entre Sprints timeboxed e fluxo sem timeboxes prescritos. Inverteu o limite de trabalho em andamento: Kanban limita WIP explicitamente por estágio; Scrum o limita indiretamente pela capacidade refletida no Sprint Backlog. A distinção do momento da entrega ficou imprecisa e faltou mencionar papéis e eventos.','2026-07-27 15:51:54','ia');
INSERT INTO avaliacao VALUES(11,11,4,'bom','Identificou corretamente a facilitação, rejeitou a redistribuição e a execução pelo Scrum Master e fundamentou pela autonomia dos Developers, caracterizando o autogerenciamento e a postura de serviço em vez de comando e controle. Faltou explicitar que assumir a tarefa não remove a causa do impedimento.','2026-07-27 15:59:45','ia');
INSERT INTO avaliacao VALUES(12,12,3,'parcial','Acertou que o Product Owner não decide sozinho, que ele orienta valor e ordenação do Product Backlog e que os Developers avaliam quanto cabe na Sprint. Faltou explicitar que os Developers também têm exclusividade sobre como transformar os itens em Incremento e que a Meta da Sprint é definida colaborativamente por todo o Scrum Team.','2026-07-27 16:03:35','ia');
INSERT INTO avaliacao VALUES(13,13,3,'parcial','Reconheceu XP como método ágil voltado a práticas técnicas, caracterizou o Waterfall pela sequência sem entregas contínuas e identificou a abordagem híbrida como combinação de métodos ágeis e tradicionais. Faltaram o Lean e seus princípios; em XP, práticas distintivas como programação em par, TDD, integração contínua, refatoração e pequenas entregas; em Waterfall, as fases lineares e o planejamento antecipado; e, no híbrido, a combinação concreta de iteração ágil com fases e documentação dirigidas a plano. Também faltou a ressalva histórica sobre Royce.','2026-07-27 16:19:49','ia');
INSERT INTO avaliacao VALUES(14,14,3,'parcial','Enumerou corretamente as três responsabilidades do Scrum e associou o PO ao valor, o Scrum Master aos impedimentos e os Developers à construção do produto. Faltou precisar que o PO maximiza o valor e gerencia o Product Backlog; que o Scrum Master estabelece o Scrum e promove a eficácia como líder que serve, provocando a remoção de impedimentos; e que os Developers criam um Incremento utilizável, o Sprint Backlog, seguem a Definition of Done e se autogerenciam. Reduzir Developers a código é estreito demais. Também faltou caracterizar o Scrum Team único, multifuncional e sem hierarquia.','2026-07-27 16:33:59','ia');
INSERT INTO avaliacao VALUES(15,15,4,'bom','Nomeou e formulou os cinco princípios. SRP e OCP corretos. No LSP, capturou a preservação do contrato e do comportamento esperado, mas a formulação canônica é a substituibilidade do objeto derivado no lugar do objeto da base. No ISP, capturou o problema da interface que impõe métodos não usados, mas o alvo preciso são os clientes forçados a depender desses métodos, não herdar comportamentos. No DIP, o exemplo recuperou corretamente que os módulos de alto e baixo nível dependem da abstração; porém, passar a dependência para fora descreve injeção de dependência, e faltou explicitar que abstrações não dependem de detalhes: os detalhes dependem das abstrações.','2026-07-27 17:00:35','ia');
INSERT INTO avaliacao VALUES(16,16,4,'bom','Acertou os dois pontos essenciais: a resposta é não, e o critério está no contrato e no comportamento esperado pelo cliente, não no simples ato de sobrescrever. O exemplo também é válido porque retirar a persistência quebra uma expectativa ou pós-condição do contrato do repositório. Faltou nomear as formas clássicas da violação — fortalecer pré-condição, enfraquecer pós-condição ou quebrar invariante — e observar que redefinir comportamentos por polimorfismo é justamente um mecanismo que sustenta o OCP.','2026-07-27 17:06:35','ia');
INSERT INTO avaliacao VALUES(17,17,0,'branco','Declarou não se recordar das restrições e não respondeu aos quatro itens pedidos. Faltaram: não fortalecer pré-condições; não enfraquecer pós-condições; preservar invariantes da base; e não lançar exceções inesperadas pelos clientes da base. A dúvida sobre esses conceitos será esclarecida após o registro da confiança.','2026-07-27 17:12:26','ia');
INSERT INTO avaliacao VALUES(18,18,3,'parcial','Acertou que há violação de LSP e percebeu que o cliente pode receber um Quadrado via polimorfismo. Porém, classificou incorretamente a restrição quebrada: lados iguais é uma invariante do Quadrado, não uma pré-condição imposta ao cliente. O que o Quadrado quebra é a pós-condição de setLargura herdada de Retangulo: alterar a largura deve manter a altura inalterada. Faltou mostrar o efeito observável — após largura 5 e altura 4, o Quadrado termina com área 16, não 20 — e explicar que o compilador só verifica a compatibilidade dos tipos e assinaturas, não o contrato comportamental.','2026-07-28 08:05:42','ia');
INSERT INTO avaliacao VALUES(19,19,3,'parcial','Acertou a tensão central entre o é-um do domínio e o é-um comportamental e aplicou corretamente o exemplo Quadrado–Retângulo, inclusive identificando a invariante adicional do Quadrado. Faltou tornar explícito que comportamento diferente só é relevante quando viola as suposições dos clientes da base: a validade da herança não é intrínseca, mas depende do contrato público usado pelos clientes. O mesmo par de conceitos pode ser válido sob uma interface somente de leitura e inválido sob uma abstração mutável com largura e altura independentes. Também faltou a consequência sobre OCP: clientes que detectam o subtipo para tratá-lo especialmente mostram que a abstração deixou de ser fechada para modificação.','2026-07-28 08:10:59','ia');
INSERT INTO avaliacao VALUES(20,20,4,'bom','Definiu corretamente responsabilidade como motivo ou fonte de mudança e deixou claro, pelo repositório com listar e cadastrar, que vários métodos podem pertencer à mesma responsabilidade quando mudam pela mesma razão. Os dois pontos essenciais foram atendidos. Como precisão, a fonte de mudança não é simplesmente a entidade Funcionário ou a tabela, mas o ator ou a razão de negócio que exige a alteração; mudanças de persistência e mudanças de regras de negócio podem ser responsabilidades diferentes. Faltaram apenas os acessórios: relacionar SRP à coesão da classe e exemplificar que contar métodos não revela responsabilidades, pois vários métodos podem se dividir entre motivos de mudança distintos.','2026-07-28 08:19:05','ia');
INSERT INTO avaliacao VALUES(21,21,4,'bom','Acertou os três pontos essenciais: aberto para extensão, fechado para modificação e realização prática por uma abstração estável com subclasses que fornecem comportamentos polimórficos por sobrescrita. O exemplo de substituir a seleção if/else por implementações derivadas está adequado. Também reconheceu que o fechamento absoluto não existe; faltou apenas precisar que ele é estratégico, planejado para os tipos de mudança mais prováveis, e citar a atribuição histórica da formulação a Bertrand Meyer.','2026-07-28 08:25:11','ia');
INSERT INTO avaliacao VALUES(22,22,3,'parcial','Acertou o SRP: ele incide sobre a classe ou módulo e seus motivos para mudar. No ISP, capturou a ideia de métodos não utilizados, mas manteve o alvo impreciso: não é a classe implementadora que não deve herdar ou implementar métodos que ela própria não usa; é o cliente que não deve ser forçado a depender de operações que não utiliza. Assim, a distinção pedida ficou incompleta: SRP olha a coesão e os motivos de mudança do lado de quem mantém a classe; ISP olha o acoplamento do lado de quem consome a interface. Também faltou notar que um objeto pode oferecer muitas operações, desde que cada tipo de cliente o enxergue por uma interface pequena e apropriada.','2026-07-28 08:31:39','ia');
INSERT INTO avaliacao VALUES(23,23,3,'parcial','Definiu corretamente o DIP: serviço de alto nível e persistência de baixo nível passam a se relacionar por uma abstração, em vez de o serviço depender do detalhe concreto. Também definiu corretamente a injeção por construtor como fornecimento externo de uma dependência já construída. Faltou responder explicitamente à parte essencial sobre separabilidade: os dois podem existir isoladamente. É possível injetar uma classe concreta e continuar acoplado ao detalhe, obtendo DI sem DIP; e é possível depender de abstrações e escolher a implementação por uma fábrica abstrata, obtendo DIP sem injeção clássica. O exemplo mostrou os dois combinados, mas não demonstrou essa independência.','2026-07-28 08:38:56','ia');
INSERT INTO avaliacao VALUES(24,24,5,'completo','Enumerou corretamente todas as restrições: não fortalecer pré-condições, não enfraquecer pós-condições, preservar invariantes e não lançar exceções inesperadas. Também reproduziu o conteúdo da regra de Meyer. Como refinamento terminológico, quem não pode ser surpreendido é o cliente escrito contra a classe-base, não a própria superclasse. Além disso, as exceções não precisam ser literalmente idênticas: podem variar desde que continuem compatíveis com o contrato esperado. A formulação completa é que a subclasse pode enfraquecer pré-condições e fortalecer pós-condições, nunca o inverso.','2026-07-28 08:52:56','ia');
INSERT INTO avaliacao VALUES(25,25,3,'parcial','Reconheceu os quatro eventos internos e seus propósitos em linhas gerais, mas omitiu a Sprint como evento-contêiner. A condução também ficou incompleta: no Guia 2020, os eventos pertencem ao Scrum Team, e o Scrum Master garante que ocorram e respeitem os timeboxes. Daily e Review ficaram imprecisos, e faltaram os timeboxes.','2026-07-28 09:08:35','ia');
INSERT INTO avaliacao VALUES(26,26,3,'parcial','Acertou a distribuição central de responsabilidades: Product Owner no Product Backlog, Developers no Sprint Backlog e criação colaborativa da Meta da Sprint. As definições ficaram incompletas: o Product Backlog não é uma lista de artefatos; o Sprint Backlog inclui a Meta, os itens selecionados e o plano de entrega; e a Sprint Goal é compromisso do Sprint Backlog e dos Developers, não um artefato independente.','2026-07-28 09:24:37','ia');
INSERT INTO avaliacao VALUES(27,27,3,'parcial','Acertou a noção básica de capacidade como o volume que os Developers conseguem produzir e reconheceu a sobrecarga. Faltou precisar que se trata do trabalho concluído segundo a Definição de Pronto numa Sprint, estimado pelo desempenho anterior, e explicar os danos: perda de previsibilidade, ameaça à Meta da Sprint, trabalho iniciado sem Incremento, troca de contexto e desperdício.','2026-07-28 09:34:58','ia');
INSERT INTO avaliacao VALUES(28,28,4,'bom','Escolheu corretamente o Scrum e relacionou o caso a Sprints, entregas incrementais, participação dos stakeholders e feedback na Sprint Review. Faltou explicitar a ordenação do Product Backlog por valor e responder à segunda metade do enunciado: Kanban trabalha com fluxo contínuo; XP enfatiza práticas de engenharia; e Lean enfatiza eliminação de desperdício e otimização do fluxo.','2026-07-28 10:41:37','ia');
INSERT INTO avaliacao VALUES(29,29,3,'parcial','Acertou que o Scrum Master facilita a remoção de impedimentos e que os Developers reorganizam o trabalho, sem o Scrum Master assumir a tarefa, escalar a execução ao PO ou encerrar a Sprint. Faltou o eixo central: preservar a Sprint Goal por meio do replanejamento do Sprint Backlog e, se necessário, renegociar o escopo com o PO. Também faltou explicar que só o PO cancela a Sprint, apenas quando a Meta se torna obsoleta, e que um item incompleto volta ao Product Backlog para consideração futura, sem garantia de execução na Sprint seguinte.','2026-07-28 11:41:02','ia');
INSERT INTO avaliacao VALUES(30,30,3,'parcial','Acertou que os Developers conhecem melhor sua capacidade, suas competências técnicas e o trabalho do Sprint Backlog, razão pela qual tomam decisões mais adequadas sobre a execução. Faltou explicitar o fundamento do autogerenciamento e o papel do Scrum Master como líder servidor que treina e facilita, sem substituir o time. Também faltaram as perdas concretas: transparência e adaptação, responsabilidade mútua, comprometimento com a Sprint Goal e retorno ao modelo de comando e controle.','2026-07-28 11:53:49','ia');
INSERT INTO avaliacao VALUES(31,31,3,'parcial','Explicou corretamente que “mais que” estabelece prioridade sem eliminar o valor dos itens à direita. Porém, não enumerou nenhum dos quatro valores do Manifesto Ágil, que constituíam o outro ponto essencial da pergunta.','2026-07-28 12:08:06','ia');
INSERT INTO avaliacao VALUES(32,32,3,'parcial','Acertou que o Scrum usa Sprints timeboxed e que o Kanban opera em fluxo contínuo sem iterações prescritas. Porém, repetiu a inversão central sobre trabalho em andamento: Kanban limita WIP explicitamente por etapa, enquanto Scrum o limita indiretamente pela capacidade refletida no Sprint Backlog. O momento da entrega também ficou impreciso: Kanban entrega continuamente conforme cada item fica pronto; no Scrum, a Sprint Review não é uma barreira obrigatória para liberar valor.','2026-07-28 13:37:47','ia');
INSERT INTO avaliacao VALUES(33,33,4,'bom','Acertou a conduta: o Scrum Master facilita a solução e provoca a remoção de impedimentos, sem assumir ou redistribuir tarefas; os Developers decidem a organização do trabalho. Para ficar completa, faltou nomear a postura de líder servidor, mencionar que ele treina o time no autogerenciamento e explicar que assumir a tarefa não remove a causa do impedimento.','2026-07-28 15:22:32','ia');
INSERT INTO avaliacao VALUES(34,34,3,'parcial','Acertou que o Product Owner não decide sozinho, que ele ordena o Product Backlog e que os Developers selecionam quanto cabe conforme a capacidade. Como na tentativa anterior, faltou completar a divisão: o PO orienta valor e propósito; os Developers decidem exclusivamente como transformar os itens em Incremento; e todo o Scrum Team define colaborativamente a Sprint Goal.','2026-07-28 16:16:22','ia');
INSERT INTO avaliacao VALUES(35,35,3,'parcial','XP e Agil Hibrida corretos. Lean em branco (falta o essencial: Toyota / eliminar desperdicio / fluxo de valor). Waterfall parcial: acertou o bloco unico sem entregas recorrentes, mas nao nomeou as fases sequenciais nem o planejamento antecipado. Nao mencionou o distrator sobre Royce.','2026-07-29 14:22:31','ia');
INSERT INTO avaliacao VALUES(36,36,4,'bom','Os tres papeis e suas responsabilidades centrais corretos, incluindo a fronteira negativa do Scrum Master (nao chefe, nao organiza tarefas). Faltou precisao: Definicao de Pronto e o Incremento *utilizavel* a cada Sprint nos Developers; que o PO e uma pessoa e nao um comite; e o ponto acessorio do Scrum Team unico, sem sub-times, com 10 pessoas ou menos. Terminologia do Scrum Guide 2020 e Developers, nao Time de Desenvolvimento.','2026-07-29 14:31:59','ia');
INSERT INTO avaliacao VALUES(37,37,3,'parcial','Faltou o essencial: a propria Sprint e um evento - o conteiner dos demais (um mes ou menos, nova comeca logo apos a anterior). Sao cinco, nao quatro. Nenhum timebox citado (8h/15min/4h/3h para Sprint de um mes). Daily descrita como reuniao de developers com o Scrum Master: o evento e dos Developers; PO e SM so participam se trabalham no Sprint Backlog. Sprint Review descrita como apresentacao de incremento; e sessao de trabalho, e o resultado dela e o ajuste do Product Backlog. Retrospectiva e Planning corretos no nucleo. Nao respondeu o "a quem cabe conduzir" na chave do Guia 2020: os eventos pertencem ao Scrum Team, o SM garante que ocorram e respeitem o timebox mas nao os comanda.','2026-07-29 15:01:55','ia');
INSERT INTO avaliacao VALUES(38,38,3,'parcial','Acertou os tres responsaveis, que e metade do enunciado. Product Backlog ok no nucleo (faltou "ordenado e emergente" e "unica fonte de trabalho do time"; ordenar e accountability do PO, nao repasse do que os stakeholders atribuem). Sprint Backlog parcial: citou so o "o que" e o dono; falta a composicao tripla - Meta da Sprint (porque) + itens selecionados (o que) + plano de entrega (como), feito por e para os Developers. Sprint Goal parcial: acertou objetivo unico criado por todo o Scrum Team, mas nao disse o essencial - nao e artefato a parte, e o compromisso do Sprint Backlog. Nao citou o par artefato/compromisso (Product Backlog-Meta do Produto, Sprint Backlog-Meta da Sprint, Incremento-Definicao de Pronto). Vocabulario: itens viram Incremento, nao "artefatos"; e o papel chama-se Developers no Guia 2020.','2026-07-29 15:09:11','ia');
INSERT INTO avaliacao VALUES(39,39,3,'parcial','Acertou o efeito central: Sprint Backlog inflado gera Meta da Sprint inalcancavel. Definicao de capacidade ficou generica: nao e quanto os Developers conseguem "produzir", e quanto conseguem *concluir* atendendo a Definicao de Pronto, previsto a partir do desempenho anterior - previsao realista, nao meta a estourar. Nao respondeu o nucleo do enunciado ("mesmo quando sobra alguma coisa"): item comecado e nao concluido nao vira Incremento porque nao atende a DoD - e trabalho parcialmente feito, desperdicio, nao valor parcial. O argumento dado foi de priorizacao (entregar itens menos importantes), que e outro problema. Faltou tambem o efeito de WIP alto: troca de contexto, perda de foco, ritmo sustentavel e qualidade que nao deve diminuir na Sprint.','2026-07-29 15:17:09','ia');
INSERT INTO avaliacao VALUES(40,40,3,'parcial','Escolheu Scrum, que e a resposta. Mas o enunciado pede "justifique" e a justificativa nao veio: dizer que o Scrum "possui todos os requisitos" e reafirmar o enunciado, nao casa-lo com os elementos do framework - Sprint = ciclos incrementais de duracao fixa, Sprint Review = feedback periodico dos stakeholders, Product Backlog ordenado pelo PO = valor priorizado. Faltou tambem caracterizar o Scrum como framework de inspecao e adaptacao feito para problemas complexos com requisitos mutaveis. Rejeicoes corretas na direcao, fracas no motivo: o discriminador do Kanban e ser fluxo continuo, sem timeboxes nem papeis/eventos prescritos - nao a ausencia de priorizacao de valor, que o Kanban tem. Erro conceitual em XP: XP tem sim ciclos curtos (small releases, ciclo semanal/trimestral) e feedback do cliente (on-site customer); o que o desqualifica e ser conjunto de praticas de engenharia que complementa o Scrum, nao framework de gestao de entregas. Lean rejeitado sem dizer o que e: filosofia de eliminar desperdicio e otimizar fluxo de valor, responde "como enxugar", nao "como organizar entregas iterativas".','2026-07-29 15:24:20','ia');
INSERT INTO avaliacao VALUES(41,41,3,'parcial','Acertou o papel do Scrum Master (facilita e remove impedimento, nao assume nem manda) e o autogerenciamento do time. Faltou o essencial: replanejar o Sprint Backlog e renegociar o ESCOPO com o PO preservando a Meta da Sprint - ele inverteu, colocando o SM avisando o PO em vez dos Developers renegociando. Nao respondeu a segunda metade da pergunta (o que acontece com a Meta em cada alternativa errada), inclusive a regra de que so o PO cancela a Sprint e so se a Meta ficar obsoleta.','2026-07-30 11:09:02','ia');
INSERT INTO avaliacao VALUES(42,42,2,'errado','INVERTEU as duas clausulas centrais: pre-condicao NAO pode ser FORTALECIDA (pode ser enfraquecida) e pos-condicao NAO pode ser ENFRAQUECIDA (pode ser fortalecida). Ele escreveu exatamente o oposto nas duas. Acertou invariantes preservadas e excecoes novas proibidas. Nao citou a regra de Meyer. Inversao de direcao e pior que omissao: em prova objetiva ele marca o distrator com confianca. Terceiro lapso nesta pergunta - ja tinha tirado 5.','2026-07-30 11:15:06','ia');
INSERT INTO avaliacao VALUES(43,43,3,'parcial','Acertou com precisao o ponto conceitual: -mais que- nao abole o lado direito, ha valor nos itens a direita. Recusou-se a enumerar os quatro valores - metade da pergunta, e o essencial 43, em branco por opcao. Nota 3 pela regra (sustentou um essencial), mas o conteudo memorizavel do Manifesto continua nao sabido; se tivesse deixado tudo em branco seria 0.','2026-07-30 11:19:47','ia');
INSERT INTO avaliacao VALUES(44,44,3,'parcial','Acertou o lado transacional: modelo relacional, OLTP e propriedades ACID. O enunciado exigia também o lado de apoio a decisão, que ficou ausente: abordagem multidimensional e OLAP, com dimensões, métricas, consolidação e consultas agregadas. A fundamentação relacional ficou parcial, sem normalização, orientação a registros, baixa redundância, operações atômicas e alta concorrência. Faltou ainda a ressalva de que modelos dimensionais podem ser implementados em RDBMS, como esquema estrela e ROLAP.','2026-07-30 15:37:09','ia');
INSERT INTO avaliacao VALUES(45,45,3,'parcial','Acertou que o cubo pertence à abordagem multidimensional e capturou a vantagem de evitar a reconstrução da análise por várias tabelas. Faltou definir o cubo como estrutura de dimensões e fatos, explicar que cada célula é endereçada pela combinação dos valores das dimensões e que as consolidações podem vir pré-agregadas em vez de serem refeitas por join e group by. Também não citou as operações OLAP roll-up, drill-down, slice and dice e pivot, nem o acesso analítico por MDX ou XMLA.','2026-07-30 15:41:08','ia');
INSERT INTO avaliacao VALUES(46,46,3,'parcial','Acertou que NoSQL não segue ACID estritamente como regra, nomeou BASE e expandiu corretamente a sigla. Explicou a convergência eventual e capturou parcialmente o soft state como divergência entre réplicas, mas faltou dizer que o estado pode mudar sem nova escrita durante a propagação. Basically Available foi apenas traduzido; faltou explicar que o sistema continua respondendo, mesmo com dado desatualizado ou resposta degradada. Também faltaram as ressalvas de que ACID e BASE são extremos de um espectro e que há bancos NoSQL com transações ACID, geralmente dentro de uma fronteira limitada.','2026-07-30 15:46:07','ia');
INSERT INTO avaliacao VALUES(47,47,3,'parcial','Acertou que ERP e CRM favorecem o relacional e fundamentou bem pelo esquema conhecido, dados estruturados e necessidade de combinar tabelas. A parte transacional ficou genérica: o ponto decisivo é a transação forte multi-entidade e tudo-ou-nada, como atualizar estoque, financeiro e contabilidade conjuntamente; em muitos NoSQL orientados a agregados, ACID para na fronteira de um agregado. Faltou explicitar que a escolha depende do padrão de uso e admite persistência poliglota em partes específicas, além de situar NoSQL como forte em alta disponibilidade e escalabilidade horizontal.','2026-07-30 15:49:37','ia');
INSERT INTO avaliacao VALUES(48,48,3,'parcial','Enumerou os quatro tipos e deu casos adequados para chave-valor, documento e grafo. No quarto tipo, o nome preciso é família de colunas ou wide-column, não simplesmente banco colunar; o caso de uso ficou genérico e misturou volume com visualização rápida. O perfil característico é escrita distribuída em grande volume e leitura por faixas, como logs, telemetria e séries temporais. Faltou ainda a distinção estrutural: chave-valor, documento e família de colunas são orientados a agregados, enquanto grafo é otimizado para percorrer relacionamentos densos.','2026-07-30 15:54:51','ia');
INSERT INTO avaliacao VALUES(49,49,3,'parcial','Acertou Atomicidade e a consistência de ACID, mas deixou Isolamento em branco e definiu Durabilidade sem o ponto decisivo de que o efeito confirmado sobrevive a falhas. Em BASE, Eventually Consistent ficou correto; Basically Available deve significar que o serviço responde, ainda que degradado, e Soft State que o estado pode mudar sem nova escrita pela propagação entre réplicas. No CAP, acertou que a leitura dois de três é enganosa, que a escolha surge durante a partição e que há graus e escolhas locais. Faltou definir precisamente C, A e P e explicitar a decisão durante a partição: responder e arriscar divergência privilegia A; recusar resposta para não divergir privilegia C. Também faltou distinguir explicitamente a consistência de invariantes do ACID da consistência de cópia única ou linearizável do CAP.','2026-07-30 16:06:47','ia');
INSERT INTO avaliacao VALUES(50,50,3,'parcial','Distinguiu corretamente scale up e scale out e capturou uma razão importante do NoSQL: o agregado oferece uma fronteira natural para distribuir dados sem depender de junções e transações globais. Faltou explicar que escala horizontal exige sharding e replicação, não apenas adicionar máquinas; a replicação também dá tolerância à falha. Na vertical, faltaram o teto físico, o custo crescente e a permanência do ponto único de falha. Também faltou situar o NoSQL como projetado para clusters e mencionar o custo da distribuição: sob partição, a disponibilidade costuma ser privilegiada com consistência eventual.','2026-07-30 16:20:38','ia');
INSERT INTO avaliacao VALUES(51,51,3,'parcial','Escolheu corretamente os três bancos. As justificativas, porém, ficaram incompletas: no relacional, o ponto decisivo é uma transação ACID multi-entidade e tudo-ou-nada entre estoque e pagamento; no documento, cada produto é um agregado natural com esquema variável, muitas leituras e escritas infrequentes; no grafo, o ganho é atravessar rapidamente relações como comprou, avaliou e segue, evitando cadeias de junções recursivas. Faltou ainda nomear o princípio essencial que reúne as escolhas: persistência poliglota. Também não mencionou seu custo operacional, de sincronização e de consistência entre repositórios.','2026-07-30 16:33:49','ia');
INSERT INTO avaliacao VALUES(52,52,3,'parcial','Sustentou os dois pontos acessorios (assimetria de conhecimento e perda de responsabilidade/comprometimento), mas nao nomeou nenhum dos dois essenciais: o autogerenciamento do Scrum Team (Sprint Backlog e plano feito por e para os Developers) e o SM como lider servidor, nao gerente. Justificou por consequencia, nao pelo fundamento normativo do Guia.','2026-08-03 09:23:03','ia');
INSERT INTO avaliacao VALUES(53,53,3,'parcial','Respondeu nao e nomeou BASE com os tres termos corretos. Soft state esta certo. Duas imprecisoes seguram a nota: definiu Basically Available de forma circular (alta disponibilidade) em vez de sempre responde, ainda que com dado desatualizado ou servico degradado — e omitiu a condicao do eventually consistent (cessadas as novas escritas as replicas convergem). Faltou tambem a ressalva de que varios NoSQL hoje oferecem ACID dentro da fronteira do agregado.','2026-08-03 10:07:13','ia');
INSERT INTO avaliacao VALUES(54,54,3,'parcial','Respondeu nao e acertou o perfil de dados, inclusive o argumento forte de Fowler (decompor e recombinar de formas diferentes). O perfil de transacoes ficou so asseverado, nao fundamentado: faltou dizer que a transacao e multi-entidade e tudo-ou-nada (baixar estoque + titulo a receber + lancamento contabil) e que isso atravessa varios agregados, sendo o agregado a fronteira onde a garantia ACID do NoSQL para. Faltaram tambem persistencia poliglota como criterio e onde o NoSQL de fato e forte (alta disponibilidade e escalabilidade horizontal, o gabarito da Q66).','2026-08-03 10:17:05','ia');
INSERT INTO avaliacao VALUES(55,55,3,'parcial','Enumerou os quatro tipos corretamente e acertou os casos de uso de chave-valor (cache) e grafo (rede social). Documento: descreveu o modelo (semiestruturado) mas nao deu caso de uso concreto (catalogo com atributos variaveis, CMS, perfil). Familia de colunas: inverteu a caracteristica discriminante — o forte e volume alto de ESCRITA distribuida, nao foco em leitura — e nao deu caso de uso (log de atividade, telemetria, serie temporal). Nomeou colunares onde a taxonomia de Fowler e familia de colunas. Faltou a divisao orientado a agregado x ignorante de agregado, explicada minutos antes.','2026-08-03 10:32:09','ia');
INSERT INTO avaliacao VALUES(56,56,3,'parcial','Resposta bem mais completa que as anteriores. BASE veio correto e corrigiu as duas falhas da Q222 hoje: definiu Basically Available pelo retorno com dado possivelmente inconsistente e incluiu a condicao cessadas as escritas no eventually consistent. A escolha C x A durante a particao veio completa, com os dois ramos. Duas coisas seguram a nota: (1) chamou o I de ACID de Independencia — o termo e ISOLAMENTO, e trocar isso e fatal em prova objetiva; a durabilidade tambem ficou imprecisa, faltou dizer que o efeito do commit SOBREVIVE A FALHAS. (2) Nao definiu as tres letras do CAP e nao mencionou o P (tolerancia a particao) como propriedade. Faltou ainda a distincao C de ACID x C de CAP. Slip menor: a convergencia do soft state e entre REPLICAS, nao entre agregados.','2026-08-03 10:48:23','ia');
INSERT INTO avaliacao VALUES(57,57,3,'parcial','O porque do NoSQL veio muito bem e usou o conceito discutido na sessao: o agregado inteiro cabe num no e a garantia ACID para na fronteira dele, enquanto o relacional precisa coordenar entre elementos que ficariam em nos diferentes. Faltou o mecanismo: escala horizontal nao e apenas mais maquinas — exige PARTICIONAR (sharding) e REPLICAR os dados, e sao esses dois mecanismos que entregam escala e tolerancia a falha. Nenhum dos dois foi citado. As definicoes de vertical e horizontal ficaram so na definicao, sem as consequencias que a banca cobra: teto fisico, custo superlinear e ponto unico de falha na vertical; cluster que segue servindo com nos falhando na horizontal. Faltou tambem o custo do lado NoSQL: distribuir cobra em consistencia (CAP / consistencia eventual).','2026-08-03 10:56:21','ia');
INSERT INTO avaliacao VALUES(58,58,3,'parcial','Acertou as tres escolhas de tecnologia e justificou bem as duas primeiras — em (i) chegou ao argumento exato: transacao multi-entidade que nao cabe num agregado. Tres lacunas: (1) nao nomeou PERSISTENCIA POLIGLOTA, o principio que sustenta as tres escolhas e que e ponto essencial do gabarito; (2) a justificativa do grafo ficou circular (eficiente em mapear relacionamentos) — faltou TRAVESSIA como operacao nativa e o contraste com a cadeia de autojuncoes recursivas no relacional; (3) em (ii) faltou o produto como AGREGADO NATURAL lido inteiro numa leitura so, conceito que ele proprio usou em (i). Faltou tambem o custo da poliglossia: mais tecnologias, ferramental imaturo e conviver com consistencia eventual entre repositorios.','2026-08-03 11:24:02','ia');
INSERT INTO avaliacao VALUES(59,59,2,'errado','Enumerou as quatro categorias certas e acertou invariantes e excecoes, mas inverteu a regra de Meyer nos dois pontos centrais: escreveu ''nao enfraqueca pre-condicoes'' e ''nao fortaleca pos-condicoes'', quando o correto e o oposto exato — nao FORTALECER pre-condicoes e nao ENFRAQUECER pos-condicoes. Inversao, nao omissao.','2026-08-03 11:34:31','ia');
INSERT INTO avaliacao VALUES(60,60,4,'bom','Respondeu ''nao'' corretamente e situou o criterio no contrato/comportamento esperado, e nao no ato de sobrescrever — os dois essenciais. Faltaram os dois acessorios: que o override polimorfico e justamente o mecanismo que sustenta o OCP (logo e esperado, nao proibido), e a especificacao de quando ha violacao (fortalecer pre-condicao, enfraquecer pos-condicao, quebrar invariante).','2026-08-03 11:38:57','ia');
INSERT INTO avaliacao VALUES(61,61,3,'parcial','Nomeou os cinco corretamente. SRP e OCP com formulacao precisa. Tres formulacoes ficaram pela metade: LSP sem a substitutibilidade do ponto de vista do cliente (e com a frase invertida sobre alterar a superclasse); ISP enunciado do lado de quem IMPLEMENTA a interface, quando Martin protege quem a CONSOME; DIP so com a primeira metade (alto e baixo nivel dependem de abstracoes), faltando a segunda (abstracoes nao dependem de detalhes; detalhes e que dependem de abstracoes).','2026-08-03 11:53:04','ia');
INSERT INTO avaliacao VALUES(62,62,3,'parcial','Afirmou a violacao e chegou sozinho a conclusao do artigo — e-um no dominio, nao-e-um no comportamento (ponto 37, acessorio). Mas nao entregou nenhum dos mecanismos: nao identificou a pos-condicao de setLargura (altura permanece inalterada) sendo enfraquecida, nao trouxe o cliente nem o teste 5x4 que da 16 em vez de 20, e nao explicou por que o compilador nao acusa (relacao de tipos valida; LSP e restricao comportamental, fora do verificador de tipos). Diagnosticou por invariante da subclasse, quando o gabarito localiza a quebra na pos-condicao do setter. Terceira vez na sessao em que a dimensao do CLIENTE some da resposta.','2026-08-03 13:03:51','ia');
INSERT INTO avaliacao VALUES(63,63,2,'errado','Primeira metade boa: contrapos o e-um do vocabulario ao e-um sistemico e nomeou o mecanismo (pre, pos, invariantes distintas). A segunda metade — o criterio, que e o payload da pergunta — saiu invertida. Propos um criterio INTRINSECO (''modelagem de dados'', ''mesmos tipos de regras'') e ainda ressalvou ''mesmo que o comportamento possa diferir'', que e o oposto exato de Martin: o criterio e o comportamento publico EXTRINSECO do qual os CLIENTES dependem. Faltou tambem ''validity is not intrinsic'' (modelo autoconsistente isolado pode ser invalido perante as suposicoes razoaveis dos clientes) e os dois acessorios. Quarta vez na sessao em que o cliente nao aparece.','2026-08-03 13:09:53','ia');
INSERT INTO avaliacao VALUES(64,64,4,'bom','Os dois essenciais presentes: definiu responsabilidade como fonte/motivo de mudanca e mostrou, com exemplo proprio e correto (repositorio com listar e incluir mudando pela mesma razao), que uma responsabilidade agrupa varias funcoes e nao equivale a um metodo. Faltaram dois acessorios: o exemplo canonico do Modem (dial, hangup, send, recv — quatro metodos, DUAS responsabilidades: gestao de conexao e comunicacao de dados), que ataca a contagem de metodos pelo lado inverso do seu exemplo, e a ligacao do SRP com coesao no nivel de classe (DeMarco 1979, Page-Jones 1988).','2026-08-03 13:22:51','ia');
INSERT INTO avaliacao VALUES(65,65,3,'parcial','Aberto e fechado enunciados com precisao, e o exemplo if/else trocado por derivadas esta correto. O mecanismo saiu pela metade: citou polimorfismo e extensao, mas nao ancorou em ABSTRACAO — o modulo depende de uma classe base abstrata FIXA e o novo comportamento entra como novo derivado, sem que o modulo seja tocado. Sem a abstracao, o que sobra e heranca, e heranca sozinha nao produz OCP. Faltou atribuir a formulacao a Bertrand Meyer (1988). O fechamento estrategico ficou parcial: reconheceu o limite pratico (''pode haver necessidade de alterar''), mas como algo a evitar, e nao como ESCOLHA deliberada de contra quais mudancas se fecha, ja que nenhum modulo e 100 por cento fechado.','2026-08-03 13:31:28','ia');
INSERT INTO avaliacao VALUES(66,66,3,'parcial','RESSALVA DE VALIDADE: a formulacao do ISP foi revelada duas vezes nesta mesma sessao (correcao da Q73 e explicacao do exemplo da Door, a pedido do usuario) minutos antes desta pergunta. O acerto do ponto 26 e recall recente, nao conhecimento consolidado — reavaliar numa sessao futura sem esse contexto. ISP enunciado com precisao e do lado certo (cliente), mas o exemplo dado esta fora do alvo: dependencia injetada por construtor e nunca usada nao e interface gorda; o ISP incide sobre o conjunto de metodos da interface. No SRP definiu bem (uma responsabilidade, uma fonte de mudanca) mas errou a UNIDADE de separacao, que e justamente o que a pergunta cobra: fechou com ''responsabilidades diferentes devem pertencer a metodos diferentes'' quando o SRP separa CLASSES/MODULOS — e contradiz a propria Q74, onde ele mesmo dissera que uma responsabilidade agrupa varios metodos. Faltaram os dois acessorios: os pontos de vista opostos (SRP olha o eixo de mudanca de quem MANTEM; ISP olha o acoplamento do lado do CLIENTE, pois interface gorda acopla clientes distintos entre si) e a saida por interfaces segregadas sobre o mesmo objeto (delegacao/Adapter).','2026-08-03 13:42:07','ia');
INSERT INTO avaliacao VALUES(67,67,3,'parcial','Melhor raciocinio da sessao no eixo ''distinga X de Y'': separou principio de tecnica e respondeu as duas direcoes da pergunta (DI sem DIP e DIP sem DI). DI definida corretamente como tecnica de fornecer a dependencia de fora, via construtor. No DIP entregou so a segunda metade (abstracoes nao dependem de detalhes; detalhes e que dependem) — justamente a que faltou na Q73 — e agora perdeu a primeira (modulos de alto E de baixo nivel dependem de abstracoes): tem as duas metades, nunca as duas juntas. A conclusao de que um existe sem o outro esta certa, mas mal substanciada: o mecanismo canonico de DI-sem-DIP e injetar um tipo CONCRETO (segue acoplado ao detalhe), e o exemplo dado (service que conhece o driver usado pelo repository) descreve vazamento entre camadas, nao injecao de concreto; e DIP-sem-DI foi apenas afirmado (''nao e a unica maneira'') sem citar fabrica abstrata ou equivalente. Faltou o acessorio Button/ButtonClient, que mostra a ortogonalidade dos dois.','2026-08-03 13:49:56','ia');
INSERT INTO avaliacao VALUES(68,68,3,'parcial','Acertou o eixo timebox (Scrum timeboxed x Kanban sem timebox) e a direcao do limite de WIP (explicito no Kanban, indireto no Scrum). Faltou precisao: Sprint de um mes ou menos; WIP limitado por estagio do fluxo (sistema pull); no Scrum o limite vem da capacidade refletida no Sprint Backlog. O eixo momento da entrega ficou pela metade: nao citou o Incremento entregue a cada Sprint e apresentado na Sprint Review, nem a entrega item a item continua do Kanban. Nao mencionou que Kanban nao prescreve papeis nem eventos.','2026-08-03 14:04:36','ia');
INSERT INTO avaliacao VALUES(69,69,4,'bom','Escolheu a opcao certa e desmontou os dois distratores com o fundamento correto: assumir a tarefa tira o SM do papel de remover impedimentos, e redistribuir por conta propria viola o autogerenciamento dos Developers. O que bloqueou o 5 foi vocabulario: nao nomeou o SM como LIDER SERVIDOR (servant leader, termo literal do Scrum Guide 2020) nem citou o dever de TREINAR o time no autogerenciamento; usou cerimonias, palavra aposentada no Scrum Guide 2020 (sao EVENTOS), e descreveu guiar as cerimonias quando o Guide diz facilitar os eventos - o Daily e dos Developers, o SM nao conduz.','2026-08-03 14:16:42','ia');
INSERT INTO avaliacao VALUES(70,70,3,'parcial','Acertou o nucleo: o PO nao decide sozinho, quem seleciona os itens sao os Developers, e o PO responde pela ordem do Product Backlog. Faltou metade da divisao pedida: a META DA SPRINT e definida por TODO o Scrum Team (nao foi citada em momento algum) e o PO propoe o valor/porque, nao so a prioridade. Tambem nao separou o QUANTO cabe (Developers) do COMO realizar - o como e criterio exclusivo dos Developers, ninguem lhes diz como transformar itens em Incremento. Impreciso: a selecao e feita EM DISCUSSAO com o PO, nao apenas seguindo prioridade ja estabelecida; e no Planning selecionam-se ITENS do Product Backlog, nao tarefas.','2026-08-03 14:31:28','ia');
INSERT INTO avaliacao VALUES(71,71,4,'bom','Identificou corretamente o traco central de XP, Lean, Waterfall e Agil Hibrida. Em Waterfall, reduziu o modelo a documentacao pesada, sem explicitar as fases lineares e sequenciais e o direcionamento por plano. Omitiu a ressalva de que Royce nao defendia a cascata pura e reconhecia iteracoes.','2026-08-04 08:00:25','ia');
INSERT INTO avaliacao VALUES(72,72,4,'bom','Enumerou corretamente Product Owner, Scrum Master e Developers e descreveu bem suas responsabilidades centrais, inclusive valor e Product Backlog, lideranca servidora e remocao de impedimentos, Incremento, Definicao de Pronto e autogerenciamento. Faltou precisar que o Product Owner e uma pessoa, nao um comite; que os Developers criam um Incremento utilizavel a cada Sprint e o Sprint Backlog; e que as tres responsabilidades formam um unico Scrum Team, multifuncional, sem sub-times nem hierarquia e normalmente com 10 pessoas ou menos.','2026-08-04 10:08:26','ia');
INSERT INTO avaliacao VALUES(73,73,3,'parcial','Enumerou corretamente os cinco eventos e acertou em linhas gerais Daily, Review e Retrospective, alem da participacao dos Developers e stakeholders. A duracao da Sprint nao e fixamente 28 dias: e de um mes ou menos, e a proxima comeca imediatamente. No Planning faltaram por que, o que e como e o timebox de 8h; a Meta nao e um recipiente de tarefas. Na Daily faltaram adaptacao do plano e 15 min; na Review, ajuste do Product Backlog e 4h; na Retrospective, planejamento de melhorias e 3h. Os eventos pertencem ao Scrum Team; o Scrum Master garante sua ocorrencia e os timeboxes, sem comanda-los.','2026-08-04 10:27:21','ia');
INSERT INTO avaliacao VALUES(74,74,3,'parcial','Definiu bem o Product Backlog como lista ordenada e atribuiu corretamente seu gerenciamento ao Product Owner. O Sprint Backlog ficou reduzido aos itens selecionados: ele inclui a Meta da Sprint, os itens e o plano de entrega, sendo criado por e para os Developers. A Sprint Goal foi reconhecida como objetivo, mas faltou dizer que e unica, integra o Sprint Backlog como seu compromisso, e criada por todo o Scrum Team no Planning e compromete os Developers. Faltaram ainda os compromissos dos demais artefatos.','2026-08-04 10:52:18','ia');
INSERT INTO avaliacao VALUES(75,75,3,'parcial','Acertou que capacidade e a previsao feita pelos Developers sobre quanto cabe na Sprint e relacionou isso ao autogerenciamento. Faltou defini-la como trabalho concluido segundo a Definicao de Pronto, previsto pelo desempenho anterior. A justificativa central da sobrecarga nao apareceu: o Sprint Backlog vira uma previsao falsa, perde-se previsibilidade e a Meta da Sprint fica ameacada. Item iniciado e nao pronto nao vira Incremento nem valor; gera trabalho parcial, WIP e troca de contexto. Itens incompletos voltam ao Product Backlog para nova ordenacao, que nao ocorre apenas na Review.','2026-08-04 14:48:03','ia');
CREATE TABLE avaliacao_ponto (
  avaliacao_id   INTEGER NOT NULL REFERENCES avaliacao(id)   ON DELETE CASCADE,
  ponto_chave_id INTEGER NOT NULL REFERENCES ponto_chave(id) ON DELETE CASCADE,
  status         TEXT    NOT NULL CHECK (status IN ('citou','parcial','faltou','errou')),
  PRIMARY KEY (avaliacao_id, ponto_chave_id)
) STRICT;
INSERT INTO avaliacao_ponto VALUES(1,1,'citou');
INSERT INTO avaliacao_ponto VALUES(1,2,'citou');
INSERT INTO avaliacao_ponto VALUES(1,3,'parcial');
INSERT INTO avaliacao_ponto VALUES(1,4,'faltou');
INSERT INTO avaliacao_ponto VALUES(1,5,'errou');
INSERT INTO avaliacao_ponto VALUES(2,6,'citou');
INSERT INTO avaliacao_ponto VALUES(2,7,'citou');
INSERT INTO avaliacao_ponto VALUES(2,8,'citou');
INSERT INTO avaliacao_ponto VALUES(2,9,'faltou');
INSERT INTO avaliacao_ponto VALUES(2,10,'faltou');
INSERT INTO avaliacao_ponto VALUES(3,11,'citou');
INSERT INTO avaliacao_ponto VALUES(3,12,'citou');
INSERT INTO avaliacao_ponto VALUES(3,13,'parcial');
INSERT INTO avaliacao_ponto VALUES(3,14,'faltou');
INSERT INTO avaliacao_ponto VALUES(3,15,'faltou');
INSERT INTO avaliacao_ponto VALUES(4,16,'citou');
INSERT INTO avaliacao_ponto VALUES(4,17,'citou');
INSERT INTO avaliacao_ponto VALUES(4,18,'faltou');
INSERT INTO avaliacao_ponto VALUES(4,19,'faltou');
INSERT INTO avaliacao_ponto VALUES(5,20,'faltou');
INSERT INTO avaliacao_ponto VALUES(5,21,'faltou');
INSERT INTO avaliacao_ponto VALUES(5,22,'faltou');
INSERT INTO avaliacao_ponto VALUES(5,23,'faltou');
INSERT INTO avaliacao_ponto VALUES(5,24,'faltou');
INSERT INTO avaliacao_ponto VALUES(6,25,'citou');
INSERT INTO avaliacao_ponto VALUES(6,26,'parcial');
INSERT INTO avaliacao_ponto VALUES(6,27,'faltou');
INSERT INTO avaliacao_ponto VALUES(6,28,'faltou');
INSERT INTO avaliacao_ponto VALUES(7,29,'citou');
INSERT INTO avaliacao_ponto VALUES(7,30,'parcial');
INSERT INTO avaliacao_ponto VALUES(7,31,'parcial');
INSERT INTO avaliacao_ponto VALUES(7,32,'faltou');
INSERT INTO avaliacao_ponto VALUES(8,33,'citou');
INSERT INTO avaliacao_ponto VALUES(8,34,'faltou');
INSERT INTO avaliacao_ponto VALUES(8,35,'faltou');
INSERT INTO avaliacao_ponto VALUES(8,36,'citou');
INSERT INTO avaliacao_ponto VALUES(8,37,'faltou');
INSERT INTO avaliacao_ponto VALUES(9,38,'citou');
INSERT INTO avaliacao_ponto VALUES(9,39,'parcial');
INSERT INTO avaliacao_ponto VALUES(9,40,'faltou');
INSERT INTO avaliacao_ponto VALUES(9,41,'parcial');
INSERT INTO avaliacao_ponto VALUES(9,42,'faltou');
INSERT INTO avaliacao_ponto VALUES(10,46,'citou');
INSERT INTO avaliacao_ponto VALUES(10,47,'errou');
INSERT INTO avaliacao_ponto VALUES(10,48,'parcial');
INSERT INTO avaliacao_ponto VALUES(10,49,'faltou');
INSERT INTO avaliacao_ponto VALUES(11,64,'citou');
INSERT INTO avaliacao_ponto VALUES(11,65,'citou');
INSERT INTO avaliacao_ponto VALUES(11,66,'citou');
INSERT INTO avaliacao_ponto VALUES(11,67,'parcial');
INSERT INTO avaliacao_ponto VALUES(12,68,'citou');
INSERT INTO avaliacao_ponto VALUES(12,69,'parcial');
INSERT INTO avaliacao_ponto VALUES(12,70,'parcial');
INSERT INTO avaliacao_ponto VALUES(13,75,'parcial');
INSERT INTO avaliacao_ponto VALUES(13,76,'faltou');
INSERT INTO avaliacao_ponto VALUES(13,77,'parcial');
INSERT INTO avaliacao_ponto VALUES(13,78,'parcial');
INSERT INTO avaliacao_ponto VALUES(13,79,'faltou');
INSERT INTO avaliacao_ponto VALUES(14,50,'parcial');
INSERT INTO avaliacao_ponto VALUES(14,51,'parcial');
INSERT INTO avaliacao_ponto VALUES(14,52,'parcial');
INSERT INTO avaliacao_ponto VALUES(14,53,'faltou');
INSERT INTO avaliacao_ponto VALUES(15,1,'citou');
INSERT INTO avaliacao_ponto VALUES(15,2,'citou');
INSERT INTO avaliacao_ponto VALUES(15,3,'citou');
INSERT INTO avaliacao_ponto VALUES(15,4,'citou');
INSERT INTO avaliacao_ponto VALUES(15,5,'citou');
INSERT INTO avaliacao_ponto VALUES(16,16,'citou');
INSERT INTO avaliacao_ponto VALUES(16,17,'citou');
INSERT INTO avaliacao_ponto VALUES(16,18,'faltou');
INSERT INTO avaliacao_ponto VALUES(16,19,'parcial');
INSERT INTO avaliacao_ponto VALUES(17,20,'faltou');
INSERT INTO avaliacao_ponto VALUES(17,21,'faltou');
INSERT INTO avaliacao_ponto VALUES(17,22,'faltou');
INSERT INTO avaliacao_ponto VALUES(17,23,'faltou');
INSERT INTO avaliacao_ponto VALUES(17,24,'faltou');
INSERT INTO avaliacao_ponto VALUES(18,33,'citou');
INSERT INTO avaliacao_ponto VALUES(18,34,'errou');
INSERT INTO avaliacao_ponto VALUES(18,35,'parcial');
INSERT INTO avaliacao_ponto VALUES(18,36,'faltou');
INSERT INTO avaliacao_ponto VALUES(18,37,'parcial');
INSERT INTO avaliacao_ponto VALUES(19,38,'citou');
INSERT INTO avaliacao_ponto VALUES(19,39,'parcial');
INSERT INTO avaliacao_ponto VALUES(19,40,'faltou');
INSERT INTO avaliacao_ponto VALUES(19,41,'citou');
INSERT INTO avaliacao_ponto VALUES(19,42,'faltou');
INSERT INTO avaliacao_ponto VALUES(20,6,'citou');
INSERT INTO avaliacao_ponto VALUES(20,7,'citou');
INSERT INTO avaliacao_ponto VALUES(20,8,'citou');
INSERT INTO avaliacao_ponto VALUES(20,9,'faltou');
INSERT INTO avaliacao_ponto VALUES(20,10,'faltou');
INSERT INTO avaliacao_ponto VALUES(21,11,'citou');
INSERT INTO avaliacao_ponto VALUES(21,12,'citou');
INSERT INTO avaliacao_ponto VALUES(21,13,'citou');
INSERT INTO avaliacao_ponto VALUES(21,14,'faltou');
INSERT INTO avaliacao_ponto VALUES(21,15,'parcial');
INSERT INTO avaliacao_ponto VALUES(22,25,'citou');
INSERT INTO avaliacao_ponto VALUES(22,26,'parcial');
INSERT INTO avaliacao_ponto VALUES(22,27,'faltou');
INSERT INTO avaliacao_ponto VALUES(22,28,'faltou');
INSERT INTO avaliacao_ponto VALUES(23,29,'citou');
INSERT INTO avaliacao_ponto VALUES(23,30,'citou');
INSERT INTO avaliacao_ponto VALUES(23,31,'faltou');
INSERT INTO avaliacao_ponto VALUES(23,32,'parcial');
INSERT INTO avaliacao_ponto VALUES(24,20,'citou');
INSERT INTO avaliacao_ponto VALUES(24,21,'citou');
INSERT INTO avaliacao_ponto VALUES(24,22,'citou');
INSERT INTO avaliacao_ponto VALUES(24,23,'citou');
INSERT INTO avaliacao_ponto VALUES(24,24,'citou');
INSERT INTO avaliacao_ponto VALUES(25,54,'faltou');
INSERT INTO avaliacao_ponto VALUES(25,55,'parcial');
INSERT INTO avaliacao_ponto VALUES(25,56,'parcial');
INSERT INTO avaliacao_ponto VALUES(25,57,'parcial');
INSERT INTO avaliacao_ponto VALUES(25,58,'parcial');
INSERT INTO avaliacao_ponto VALUES(25,59,'faltou');
INSERT INTO avaliacao_ponto VALUES(26,60,'parcial');
INSERT INTO avaliacao_ponto VALUES(26,61,'parcial');
INSERT INTO avaliacao_ponto VALUES(26,62,'parcial');
INSERT INTO avaliacao_ponto VALUES(26,63,'faltou');
INSERT INTO avaliacao_ponto VALUES(27,71,'parcial');
INSERT INTO avaliacao_ponto VALUES(27,72,'parcial');
INSERT INTO avaliacao_ponto VALUES(27,73,'faltou');
INSERT INTO avaliacao_ponto VALUES(27,74,'faltou');
INSERT INTO avaliacao_ponto VALUES(28,80,'citou');
INSERT INTO avaliacao_ponto VALUES(28,81,'citou');
INSERT INTO avaliacao_ponto VALUES(28,82,'faltou');
INSERT INTO avaliacao_ponto VALUES(28,83,'faltou');
INSERT INTO avaliacao_ponto VALUES(28,84,'faltou');
INSERT INTO avaliacao_ponto VALUES(29,85,'parcial');
INSERT INTO avaliacao_ponto VALUES(29,86,'faltou');
INSERT INTO avaliacao_ponto VALUES(29,87,'parcial');
INSERT INTO avaliacao_ponto VALUES(29,88,'parcial');
INSERT INTO avaliacao_ponto VALUES(29,89,'parcial');
INSERT INTO avaliacao_ponto VALUES(30,90,'citou');
INSERT INTO avaliacao_ponto VALUES(30,91,'faltou');
INSERT INTO avaliacao_ponto VALUES(30,92,'parcial');
INSERT INTO avaliacao_ponto VALUES(30,93,'faltou');
INSERT INTO avaliacao_ponto VALUES(31,43,'faltou');
INSERT INTO avaliacao_ponto VALUES(31,44,'citou');
INSERT INTO avaliacao_ponto VALUES(31,45,'faltou');
INSERT INTO avaliacao_ponto VALUES(32,46,'citou');
INSERT INTO avaliacao_ponto VALUES(32,47,'errou');
INSERT INTO avaliacao_ponto VALUES(32,48,'parcial');
INSERT INTO avaliacao_ponto VALUES(32,49,'faltou');
INSERT INTO avaliacao_ponto VALUES(33,64,'citou');
INSERT INTO avaliacao_ponto VALUES(33,65,'citou');
INSERT INTO avaliacao_ponto VALUES(33,66,'citou');
INSERT INTO avaliacao_ponto VALUES(33,67,'parcial');
INSERT INTO avaliacao_ponto VALUES(34,68,'citou');
INSERT INTO avaliacao_ponto VALUES(34,69,'parcial');
INSERT INTO avaliacao_ponto VALUES(34,70,'faltou');
INSERT INTO avaliacao_ponto VALUES(35,75,'citou');
INSERT INTO avaliacao_ponto VALUES(35,76,'faltou');
INSERT INTO avaliacao_ponto VALUES(35,77,'parcial');
INSERT INTO avaliacao_ponto VALUES(35,78,'citou');
INSERT INTO avaliacao_ponto VALUES(35,79,'faltou');
INSERT INTO avaliacao_ponto VALUES(36,50,'citou');
INSERT INTO avaliacao_ponto VALUES(36,51,'citou');
INSERT INTO avaliacao_ponto VALUES(36,52,'citou');
INSERT INTO avaliacao_ponto VALUES(36,53,'faltou');
INSERT INTO avaliacao_ponto VALUES(37,54,'faltou');
INSERT INTO avaliacao_ponto VALUES(37,55,'parcial');
INSERT INTO avaliacao_ponto VALUES(37,56,'parcial');
INSERT INTO avaliacao_ponto VALUES(37,57,'parcial');
INSERT INTO avaliacao_ponto VALUES(37,58,'citou');
INSERT INTO avaliacao_ponto VALUES(37,59,'faltou');
INSERT INTO avaliacao_ponto VALUES(38,60,'citou');
INSERT INTO avaliacao_ponto VALUES(38,61,'parcial');
INSERT INTO avaliacao_ponto VALUES(38,62,'parcial');
INSERT INTO avaliacao_ponto VALUES(38,63,'faltou');
INSERT INTO avaliacao_ponto VALUES(39,71,'parcial');
INSERT INTO avaliacao_ponto VALUES(39,72,'citou');
INSERT INTO avaliacao_ponto VALUES(39,73,'parcial');
INSERT INTO avaliacao_ponto VALUES(39,74,'faltou');
INSERT INTO avaliacao_ponto VALUES(40,80,'parcial');
INSERT INTO avaliacao_ponto VALUES(40,81,'faltou');
INSERT INTO avaliacao_ponto VALUES(40,82,'parcial');
INSERT INTO avaliacao_ponto VALUES(40,83,'parcial');
INSERT INTO avaliacao_ponto VALUES(40,84,'parcial');
INSERT INTO avaliacao_ponto VALUES(41,85,'parcial');
INSERT INTO avaliacao_ponto VALUES(41,86,'faltou');
INSERT INTO avaliacao_ponto VALUES(41,87,'parcial');
INSERT INTO avaliacao_ponto VALUES(41,88,'parcial');
INSERT INTO avaliacao_ponto VALUES(41,89,'faltou');
INSERT INTO avaliacao_ponto VALUES(42,20,'errou');
INSERT INTO avaliacao_ponto VALUES(42,21,'errou');
INSERT INTO avaliacao_ponto VALUES(42,22,'citou');
INSERT INTO avaliacao_ponto VALUES(42,23,'citou');
INSERT INTO avaliacao_ponto VALUES(42,24,'faltou');
INSERT INTO avaliacao_ponto VALUES(43,43,'faltou');
INSERT INTO avaliacao_ponto VALUES(43,44,'citou');
INSERT INTO avaliacao_ponto VALUES(43,45,'faltou');
INSERT INTO avaliacao_ponto VALUES(44,99,'parcial');
INSERT INTO avaliacao_ponto VALUES(44,100,'parcial');
INSERT INTO avaliacao_ponto VALUES(44,101,'faltou');
INSERT INTO avaliacao_ponto VALUES(44,102,'faltou');
INSERT INTO avaliacao_ponto VALUES(45,103,'citou');
INSERT INTO avaliacao_ponto VALUES(45,104,'parcial');
INSERT INTO avaliacao_ponto VALUES(45,105,'parcial');
INSERT INTO avaliacao_ponto VALUES(45,106,'faltou');
INSERT INTO avaliacao_ponto VALUES(45,107,'faltou');
INSERT INTO avaliacao_ponto VALUES(46,113,'citou');
INSERT INTO avaliacao_ponto VALUES(46,114,'citou');
INSERT INTO avaliacao_ponto VALUES(46,115,'parcial');
INSERT INTO avaliacao_ponto VALUES(46,116,'faltou');
INSERT INTO avaliacao_ponto VALUES(46,117,'faltou');
INSERT INTO avaliacao_ponto VALUES(47,124,'citou');
INSERT INTO avaliacao_ponto VALUES(47,125,'citou');
INSERT INTO avaliacao_ponto VALUES(47,126,'parcial');
INSERT INTO avaliacao_ponto VALUES(47,127,'faltou');
INSERT INTO avaliacao_ponto VALUES(47,128,'faltou');
INSERT INTO avaliacao_ponto VALUES(48,118,'citou');
INSERT INTO avaliacao_ponto VALUES(48,119,'citou');
INSERT INTO avaliacao_ponto VALUES(48,120,'citou');
INSERT INTO avaliacao_ponto VALUES(48,121,'parcial');
INSERT INTO avaliacao_ponto VALUES(48,122,'citou');
INSERT INTO avaliacao_ponto VALUES(48,123,'faltou');
INSERT INTO avaliacao_ponto VALUES(49,129,'parcial');
INSERT INTO avaliacao_ponto VALUES(49,130,'parcial');
INSERT INTO avaliacao_ponto VALUES(49,131,'parcial');
INSERT INTO avaliacao_ponto VALUES(49,132,'parcial');
INSERT INTO avaliacao_ponto VALUES(49,133,'citou');
INSERT INTO avaliacao_ponto VALUES(49,134,'faltou');
INSERT INTO avaliacao_ponto VALUES(50,135,'citou');
INSERT INTO avaliacao_ponto VALUES(50,136,'citou');
INSERT INTO avaliacao_ponto VALUES(50,137,'parcial');
INSERT INTO avaliacao_ponto VALUES(50,138,'parcial');
INSERT INTO avaliacao_ponto VALUES(50,139,'faltou');
INSERT INTO avaliacao_ponto VALUES(51,140,'parcial');
INSERT INTO avaliacao_ponto VALUES(51,141,'parcial');
INSERT INTO avaliacao_ponto VALUES(51,142,'parcial');
INSERT INTO avaliacao_ponto VALUES(51,143,'faltou');
INSERT INTO avaliacao_ponto VALUES(51,144,'faltou');
INSERT INTO avaliacao_ponto VALUES(52,90,'faltou');
INSERT INTO avaliacao_ponto VALUES(52,91,'faltou');
INSERT INTO avaliacao_ponto VALUES(52,92,'parcial');
INSERT INTO avaliacao_ponto VALUES(52,93,'citou');
INSERT INTO avaliacao_ponto VALUES(53,113,'citou');
INSERT INTO avaliacao_ponto VALUES(53,114,'citou');
INSERT INTO avaliacao_ponto VALUES(53,115,'parcial');
INSERT INTO avaliacao_ponto VALUES(53,116,'faltou');
INSERT INTO avaliacao_ponto VALUES(53,117,'faltou');
INSERT INTO avaliacao_ponto VALUES(54,124,'citou');
INSERT INTO avaliacao_ponto VALUES(54,125,'citou');
INSERT INTO avaliacao_ponto VALUES(54,126,'parcial');
INSERT INTO avaliacao_ponto VALUES(54,127,'faltou');
INSERT INTO avaliacao_ponto VALUES(54,128,'faltou');
INSERT INTO avaliacao_ponto VALUES(55,118,'citou');
INSERT INTO avaliacao_ponto VALUES(55,119,'citou');
INSERT INTO avaliacao_ponto VALUES(55,120,'parcial');
INSERT INTO avaliacao_ponto VALUES(55,121,'errou');
INSERT INTO avaliacao_ponto VALUES(55,122,'citou');
INSERT INTO avaliacao_ponto VALUES(55,123,'faltou');
INSERT INTO avaliacao_ponto VALUES(56,129,'parcial');
INSERT INTO avaliacao_ponto VALUES(56,130,'citou');
INSERT INTO avaliacao_ponto VALUES(56,131,'parcial');
INSERT INTO avaliacao_ponto VALUES(56,132,'citou');
INSERT INTO avaliacao_ponto VALUES(56,133,'parcial');
INSERT INTO avaliacao_ponto VALUES(56,134,'faltou');
INSERT INTO avaliacao_ponto VALUES(57,135,'parcial');
INSERT INTO avaliacao_ponto VALUES(57,136,'parcial');
INSERT INTO avaliacao_ponto VALUES(57,137,'faltou');
INSERT INTO avaliacao_ponto VALUES(57,138,'citou');
INSERT INTO avaliacao_ponto VALUES(57,139,'faltou');
INSERT INTO avaliacao_ponto VALUES(58,140,'citou');
INSERT INTO avaliacao_ponto VALUES(58,141,'citou');
INSERT INTO avaliacao_ponto VALUES(58,142,'parcial');
INSERT INTO avaliacao_ponto VALUES(58,143,'faltou');
INSERT INTO avaliacao_ponto VALUES(58,144,'faltou');
INSERT INTO avaliacao_ponto VALUES(59,20,'errou');
INSERT INTO avaliacao_ponto VALUES(59,21,'errou');
INSERT INTO avaliacao_ponto VALUES(59,22,'citou');
INSERT INTO avaliacao_ponto VALUES(59,23,'citou');
INSERT INTO avaliacao_ponto VALUES(59,24,'faltou');
INSERT INTO avaliacao_ponto VALUES(60,16,'citou');
INSERT INTO avaliacao_ponto VALUES(60,17,'citou');
INSERT INTO avaliacao_ponto VALUES(60,18,'faltou');
INSERT INTO avaliacao_ponto VALUES(60,19,'faltou');
INSERT INTO avaliacao_ponto VALUES(61,1,'citou');
INSERT INTO avaliacao_ponto VALUES(61,2,'citou');
INSERT INTO avaliacao_ponto VALUES(61,3,'parcial');
INSERT INTO avaliacao_ponto VALUES(61,4,'parcial');
INSERT INTO avaliacao_ponto VALUES(61,5,'parcial');
INSERT INTO avaliacao_ponto VALUES(62,33,'parcial');
INSERT INTO avaliacao_ponto VALUES(62,34,'faltou');
INSERT INTO avaliacao_ponto VALUES(62,35,'faltou');
INSERT INTO avaliacao_ponto VALUES(62,36,'faltou');
INSERT INTO avaliacao_ponto VALUES(62,37,'citou');
INSERT INTO avaliacao_ponto VALUES(63,38,'citou');
INSERT INTO avaliacao_ponto VALUES(63,39,'errou');
INSERT INTO avaliacao_ponto VALUES(63,40,'faltou');
INSERT INTO avaliacao_ponto VALUES(63,41,'faltou');
INSERT INTO avaliacao_ponto VALUES(63,42,'faltou');
INSERT INTO avaliacao_ponto VALUES(64,6,'citou');
INSERT INTO avaliacao_ponto VALUES(64,7,'citou');
INSERT INTO avaliacao_ponto VALUES(64,8,'citou');
INSERT INTO avaliacao_ponto VALUES(64,9,'faltou');
INSERT INTO avaliacao_ponto VALUES(64,10,'faltou');
INSERT INTO avaliacao_ponto VALUES(65,11,'citou');
INSERT INTO avaliacao_ponto VALUES(65,12,'citou');
INSERT INTO avaliacao_ponto VALUES(65,13,'parcial');
INSERT INTO avaliacao_ponto VALUES(65,14,'faltou');
INSERT INTO avaliacao_ponto VALUES(65,15,'parcial');
INSERT INTO avaliacao_ponto VALUES(66,25,'parcial');
INSERT INTO avaliacao_ponto VALUES(66,26,'citou');
INSERT INTO avaliacao_ponto VALUES(66,27,'faltou');
INSERT INTO avaliacao_ponto VALUES(66,28,'faltou');
INSERT INTO avaliacao_ponto VALUES(67,29,'parcial');
INSERT INTO avaliacao_ponto VALUES(67,30,'citou');
INSERT INTO avaliacao_ponto VALUES(67,31,'parcial');
INSERT INTO avaliacao_ponto VALUES(67,32,'faltou');
INSERT INTO avaliacao_ponto VALUES(68,46,'citou');
INSERT INTO avaliacao_ponto VALUES(68,47,'parcial');
INSERT INTO avaliacao_ponto VALUES(68,48,'parcial');
INSERT INTO avaliacao_ponto VALUES(68,49,'faltou');
INSERT INTO avaliacao_ponto VALUES(69,64,'citou');
INSERT INTO avaliacao_ponto VALUES(69,65,'citou');
INSERT INTO avaliacao_ponto VALUES(69,66,'citou');
INSERT INTO avaliacao_ponto VALUES(69,67,'citou');
INSERT INTO avaliacao_ponto VALUES(70,68,'citou');
INSERT INTO avaliacao_ponto VALUES(70,69,'parcial');
INSERT INTO avaliacao_ponto VALUES(70,70,'faltou');
INSERT INTO avaliacao_ponto VALUES(71,75,'citou');
INSERT INTO avaliacao_ponto VALUES(71,76,'citou');
INSERT INTO avaliacao_ponto VALUES(71,77,'citou');
INSERT INTO avaliacao_ponto VALUES(71,78,'citou');
INSERT INTO avaliacao_ponto VALUES(71,79,'faltou');
INSERT INTO avaliacao_ponto VALUES(72,50,'citou');
INSERT INTO avaliacao_ponto VALUES(72,51,'citou');
INSERT INTO avaliacao_ponto VALUES(72,52,'citou');
INSERT INTO avaliacao_ponto VALUES(72,53,'faltou');
INSERT INTO avaliacao_ponto VALUES(73,54,'parcial');
INSERT INTO avaliacao_ponto VALUES(73,55,'parcial');
INSERT INTO avaliacao_ponto VALUES(73,56,'parcial');
INSERT INTO avaliacao_ponto VALUES(73,57,'parcial');
INSERT INTO avaliacao_ponto VALUES(73,58,'parcial');
INSERT INTO avaliacao_ponto VALUES(73,59,'parcial');
INSERT INTO avaliacao_ponto VALUES(74,60,'citou');
INSERT INTO avaliacao_ponto VALUES(74,61,'parcial');
INSERT INTO avaliacao_ponto VALUES(74,62,'parcial');
INSERT INTO avaliacao_ponto VALUES(74,63,'faltou');
INSERT INTO avaliacao_ponto VALUES(75,71,'parcial');
INSERT INTO avaliacao_ponto VALUES(75,72,'faltou');
INSERT INTO avaliacao_ponto VALUES(75,73,'parcial');
INSERT INTO avaliacao_ponto VALUES(75,74,'faltou');
CREATE TABLE agendamento (
  pergunta_id     INTEGER PRIMARY KEY REFERENCES pergunta(id),
  facilidade      REAL    NOT NULL DEFAULT 2.5,   -- EF do SM-2, piso 1.3
  intervalo_dias  INTEGER NOT NULL DEFAULT 0,
  repeticoes      INTEGER NOT NULL DEFAULT 0,     -- acertos consecutivos
  lapsos          INTEGER NOT NULL DEFAULT 0,     -- quantas vezes você já derrubou
  proxima_revisao TEXT    NOT NULL DEFAULT (date('now','localtime')),
  ultima_nota     INTEGER,
  atualizado_em   TEXT
) STRICT;
INSERT INTO agendamento VALUES(1,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(2,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(3,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(4,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(5,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(6,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(7,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(8,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(9,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(10,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(11,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(12,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(13,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(14,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(15,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(16,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(17,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(18,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(19,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(20,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(21,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(22,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(23,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(24,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(25,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(26,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(27,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(28,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(29,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(30,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(31,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(32,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(33,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(34,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(35,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(36,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(37,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(38,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(39,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(40,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(41,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(42,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(43,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(44,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(45,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(46,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(47,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(48,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(49,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(50,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(51,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(52,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(53,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(54,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(55,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(56,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(57,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(58,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(59,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(60,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(61,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(62,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(63,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(64,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(65,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(66,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(67,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(68,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(69,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(70,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(71,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(72,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(73,2.2199999999999998,14,3,0,'2026-08-17',3,'2026-08-03 11:53:04');
INSERT INTO agendamento VALUES(74,2.5,15,3,0,'2026-08-18',4,'2026-08-03 13:22:51');
INSERT INTO agendamento VALUES(75,2.2199999999999998,14,3,0,'2026-08-17',3,'2026-08-03 13:31:28');
INSERT INTO agendamento VALUES(76,2.5,15,3,0,'2026-08-18',4,'2026-08-03 11:38:57');
INSERT INTO agendamento VALUES(77,1.3,1,0,4,'2026-08-04',2,'2026-08-03 11:34:31');
INSERT INTO agendamento VALUES(78,2.0799999999999996,13,3,0,'2026-08-16',3,'2026-08-03 13:42:07');
INSERT INTO agendamento VALUES(79,2.0799999999999996,13,3,0,'2026-08-16',3,'2026-08-03 13:49:56');
INSERT INTO agendamento VALUES(80,2.0799999999999996,13,3,0,'2026-08-16',3,'2026-08-03 13:03:51');
INSERT INTO agendamento VALUES(81,1.8999999999999997,1,0,1,'2026-08-04',2,'2026-08-03 13:09:53');
INSERT INTO agendamento VALUES(82,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(83,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(84,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(85,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(86,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(87,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(88,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(89,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(90,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(91,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(92,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(93,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(94,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(95,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(96,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(97,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(98,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(99,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(100,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(101,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(102,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(103,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(104,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(105,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(106,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(107,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(108,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(109,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(110,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(111,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(112,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(113,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(114,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(115,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(116,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(117,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(118,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(119,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(120,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(121,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(122,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(123,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(124,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(125,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(126,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(127,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(128,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(129,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(130,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(131,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(132,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(133,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(134,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(135,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(136,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(137,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(138,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(139,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(140,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(141,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(142,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(143,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(144,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(145,2.2199999999999998,6,2,0,'2026-08-05',3,'2026-07-30 11:19:47');
INSERT INTO agendamento VALUES(146,2.0799999999999996,13,3,0,'2026-08-16',3,'2026-08-03 14:04:36');
INSERT INTO agendamento VALUES(147,2.36,14,3,0,'2026-08-18',4,'2026-08-04 10:08:26');
INSERT INTO agendamento VALUES(148,2.0799999999999996,13,3,0,'2026-08-17',3,'2026-08-04 10:27:21');
INSERT INTO agendamento VALUES(149,2.0799999999999996,13,3,0,'2026-08-17',3,'2026-08-04 10:52:18');
INSERT INTO agendamento VALUES(150,2.5,15,3,0,'2026-08-18',4,'2026-08-03 14:16:42');
INSERT INTO agendamento VALUES(151,2.0799999999999996,13,3,0,'2026-08-16',3,'2026-08-03 14:31:28');
INSERT INTO agendamento VALUES(152,2.0799999999999996,13,3,0,'2026-08-17',3,'2026-08-04 14:48:03');
INSERT INTO agendamento VALUES(153,2.2199999999999998,13,3,0,'2026-08-17',4,'2026-08-04 08:00:25');
INSERT INTO agendamento VALUES(154,2.36,6,2,0,'2026-08-04',3,'2026-07-29 15:24:20');
INSERT INTO agendamento VALUES(155,2.2199999999999998,6,2,0,'2026-08-05',3,'2026-07-30 11:09:02');
INSERT INTO agendamento VALUES(156,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 09:23:03');
INSERT INTO agendamento VALUES(157,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(158,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(159,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(160,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(161,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(162,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(163,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(164,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(165,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(166,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(167,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(168,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(169,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(170,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(171,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(172,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(173,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(174,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(175,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(176,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(177,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(178,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(179,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(180,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(181,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(182,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(183,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(184,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(185,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(186,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(187,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(188,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(189,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(190,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(191,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(192,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(193,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(194,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(195,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(196,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(197,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(198,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(199,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(200,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(201,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(202,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(203,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(204,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(205,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(206,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(207,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(208,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(209,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(210,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(211,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(212,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(213,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(214,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(215,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(216,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(217,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(218,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(219,2.36,1,1,0,'2026-07-31',3,'2026-07-30 15:37:09');
INSERT INTO agendamento VALUES(220,2.36,1,1,0,'2026-07-31',3,'2026-07-30 15:41:08');
INSERT INTO agendamento VALUES(221,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(222,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 10:07:13');
INSERT INTO agendamento VALUES(223,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 10:32:09');
INSERT INTO agendamento VALUES(224,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 10:17:05');
INSERT INTO agendamento VALUES(225,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 10:48:23');
INSERT INTO agendamento VALUES(226,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 10:56:21');
INSERT INTO agendamento VALUES(227,2.2199999999999998,6,2,0,'2026-08-09',3,'2026-08-03 11:24:02');
INSERT INTO agendamento VALUES(228,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(229,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(230,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(231,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(232,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(233,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(234,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(235,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(236,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(237,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(238,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(239,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(240,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(241,2.5,0,0,0,'2026-07-23',NULL,NULL);
INSERT INTO agendamento VALUES(242,2.5,0,0,0,'2026-07-23',NULL,NULL);
CREATE TABLE config (
  chave TEXT PRIMARY KEY,
  valor TEXT
) STRICT;
INSERT INTO config VALUES('data_prova','2026-10-11');
CREATE TABLE IF NOT EXISTS "pergunta" (
  id             INTEGER PRIMARY KEY,
  codigo         TEXT    NOT NULL UNIQUE, -- 'Q94' — chave natural, estável entre reimportações
  numero         INTEGER NOT NULL,
  secao_id       INTEGER NOT NULL REFERENCES secao(id),
  enunciado      TEXT    NOT NULL,
  enunciado_hash TEXT    NOT NULL,        -- detecta edição no .md sem perder histórico
  tag_prova      TEXT,                    -- 'Q44' (questão da prova real) ou NULL
  eh_distrator   INTEGER NOT NULL DEFAULT 0 CHECK (eh_distrator IN (0,1)),
  eh_caso        INTEGER NOT NULL DEFAULT 0 CHECK (eh_caso     IN (0,1)),
  ativa          INTEGER NOT NULL DEFAULT 1 CHECK (ativa       IN (0,1)),
  criada_em      TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
  atualizada_em  TEXT,
  -- profundidade absoluta da pergunta gerada, escala D0–D5 (ver perguntas.md).
  -- O CHECK é a fonte de verdade dos valores aceitos; importar.py o espelha.
  profundidade   TEXT CHECK (profundidade IS NULL OR profundidade IN
                   ('D0','D1','D2','D3','D4','D5'))
) STRICT;
INSERT INTO pergunta VALUES(1,'Q1',1,1,'Segundo a LAI, o que é classificar uma informação quanto ao sigilo, e qual é a regra geral do ordenamento que essa classificação excepciona?','0f567b5f836506b2e96a06ab313aad4680d2f35ce82618f2b1135b85d3e00689',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(2,'Q2',2,1,'Liste os três graus de sigilo previstos na LAI e informe, em anos, o prazo máximo de restrição de acesso de cada um deles.','bc0a02b2c7367190ddb4f6fca13862006b54103f3f1f7925449834106e4d72fb','Q36',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(3,'Q3',3,1,'Distinga desclassificação, reavaliação e redução do prazo de sigilo. Diga, para cada uma, quem tem competência para realizá-la e o que a provoca.','1a27a0192ccc166c65fc6ba7b2135a43bc02b34faf197672afb231412ae840c4','Q36',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(4,'Q4',4,1,'Findo o prazo de classificação, ou ocorrido o evento que constitui seu termo final, a informação se torna pública automaticamente ou é preciso procedimento próprio e decisão específica? Justifique.','62de31c15c80b4dedf56882f0acdf9a31c62eb3576b00389635e2d74bbc5bedf','Q36',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(5,'Q5',5,1,'Indique quais autoridades têm competência para classificar informação em cada um dos três graus de sigilo.','39f5323ac1cb61830bf2320da93c3ce116602b5e32c3ad2a6b45af8c65d426d2',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(6,'Q6',6,1,'A decisão que classifica uma informação é pública e acessível a qualquer interessado? Explique em que grau de sigilo essa decisão é mantida e o que dela deve constar.','f6553e216f528af30f985993955fedd00bbb3f031826c52e241dff21b69ca0ad','Q36',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(7,'Q7',7,1,'Existe hipótese em que a LAI proíbe qualquer restrição de acesso, independentemente do grau de sigilo cabível? Qual é ela e qual a razão da vedação.','9935fd387925290823e02d1a6665012b32add8c1df1e89b0931a650839d565e3','Q36',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(8,'Q8',8,1,'Um órgão federal classifica como ultrassecreto, por 25 anos, o relatório de uma operação em que agentes públicos são apontados como autores de tortura. Um jornalista pede acesso e o órgão nega, invocando o prazo de classificação ainda em curso. Avalie a legalidade da negativa e diga o que a lei determina nesse caso.','b745048740898b8eb47f93e9fe7249c8cbc6afaacff2e35a36dc27a084284969','Q36',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(9,'Q9',9,2,'Descreva a conduta típica do art. 154-A do Código Penal e as finalidades que o tipo penal exige do agente.','ef000171ba8beda45f44c91a25594bb63513853ecd0eeec2dfd7dd4f546dee06',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(10,'Q10',10,2,'A conexão do dispositivo invadido a uma rede de computadores é elementar do crime de invasão de dispositivo informático? Fundamente com a redação vigente do tipo.','277ff17ff28cc32c0306b28c77ca1a88f986d77392102b71dc491f8f37562a90','Q37',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(11,'Q11',11,2,'A "violação indevida de mecanismo de segurança" continua sendo elementar do art. 154-A? Explique o que mudou na redação do tipo e qual o efeito prático dessa mudança sobre a configuração do crime.','f5a57cef458bd297565848692db77c35f937fec21f4aac1417febe9b530b41bf','Q37',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(12,'Q12',12,2,'Enumere as causas de aumento de pena do art. 154-A, indicando a fração de aumento de cada uma e, no caso do sujeito passivo qualificado, o rol de autoridades protegidas.','d9268c15994346cfffcc9696aa0f33b247e2dbf50321ec53f9d7c1ef3d0dfc95','Q37',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(13,'Q13',13,2,'Qual é a natureza da ação penal no crime de invasão de dispositivo informático? Indique a regra e a exceção, e diga se a queixa-crime é via adequada para deflagrá-la.','dcd9d4bb6933299b829629e6b5efac03c2ef14b38b4eb3553f1a3ccf988ee768','Q37',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(14,'Q14',14,2,'O crime do art. 154-A se consuma com a mera invasão ou exige a efetiva obtenção, adulteração ou destruição dos dados? Classifique o crime quanto ao resultado e explique como fica a tentativa.','d3115597fae36c16bcb61f8753f964c7abf56957dcb43406a37c3f5175eb9498','Q37',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(15,'Q15',15,2,'Descreva a figura qualificada do § 3º do art. 154-A: que resultado a caracteriza e qual a pena cominada.','6b51f4c36d201c40ad505ea79ed67a388c22f5b6d75b5221a312b26db2ca7a45',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(16,'Q16',16,2,'Um atacante obtém previamente a senha de acesso e, com ela, entra no tablet do vice-Presidente da Câmara dos Deputados, adulterando informações e causando prejuízo político à Casa. Analise: houve crime do art. 154-A mesmo sem violação de mecanismo de segurança? Qual fração de aumento incide? Quem é legitimado a promover a ação penal?','559e070e76c9668a3fd4b9bd84d05c91b3af41dbfa2f90eb0863d40a2b198a24','Q37',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(17,'Q17',17,2,'Explique por que o legislador escolheu a representação da vítima como condição da ação penal na regra geral do art. 154-A, e por que essa condição cai quando o crime é praticado contra a administração pública.','ea841bf71c7096483bbe62becb3e7a5fb7f4a21bd13fa8d509c6f057c650b20b',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D5');
INSERT INTO pergunta VALUES(18,'Q18',18,3,'Qual é o objeto do Marco Civil da Internet e o que, especificamente, os dispositivos sobre proteção a registros, dados pessoais e comunicações privadas exigem dos provedores?','96a45972e43ccdd0e41fa45317cefbdedb70e049be83d4ca6fd12e3adb0c8efd',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(19,'Q19',19,3,'Liste as sanções previstas no Marco Civil da Internet para o descumprimento das normas de proteção a registros e dados pessoais.','98f2b261fe012bebbd235bdf94649b9105de40e82532badc333e02fe60920805','Q38',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(20,'Q20',20,3,'As sanções do Marco Civil podem ser aplicadas cumulativamente ou apenas de forma isolada? Reproduza a regra legal.','2f288f404cb85ef8b890ff165ba5e06d810e43ec72e149ff421d934db64cccb3','Q38',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(21,'Q21',21,3,'Descreva com precisão o cálculo da multa prevista no Marco Civil: percentual, se é teto ou valor fixo, sobre qual base incide, referente a qual período e com quais exclusões.','8a0da34e579bdede0909d72e4b5c71189c4c49dedae4ec0a4c12ad13912061e1','Q38',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(22,'Q22',22,3,'A advertência prevista no Marco Civil tem apenas caráter repressivo? Explique o que a lei exige que a advertência contenha e o efeito disso.','a1b278098eacaaee5113595af3c9a40115bb5cb06bc16962dde7748dfd07b557','Q38',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(23,'Q23',23,3,'O Marco Civil deixa as empresas estrangeiras fora do seu regramento sancionatório? Explique como a lei alcança a atuação delas no Brasil.','337735275b917a1a9d7ed87275dc271aa9d1c7e96df7624a6d4f3da1ff4ae2b2','Q38',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(24,'Q24',24,3,'Quanto à guarda de registros no Marco Civil, informe: quem guarda registro de conexão e por quanto tempo; quem guarda registro de acesso a aplicações e por quanto tempo; e quais requisitos o provedor de aplicações precisa cumprir para estar sujeito a essa obrigação.','0dcb7a4891a500e936b9b432bd74601c3a3b5adb144d49e51958d5f7dfd641c0',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(25,'Q25',25,3,'Um provedor de aplicações com sede no exterior, mas com filial no Brasil, coleta dados pessoais de usuários brasileiros sem consentimento e descumpre ordem de regularização anterior. Indique quais sanções do Marco Civil podem ser aplicadas, se podem incidir ao mesmo tempo, e quem responde pelo pagamento da multa.','1af2fc6104a82a60604a2b4370bc734922ce7f71ea70d26cc0eb0b5b409e0f96','Q38',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(26,'Q26',26,4,'Que matéria o capítulo de fiscalização da LGPD disciplina e qual órgão detém competência exclusiva para aplicar as sanções nele previstas?','3ec785df6f0e8fbc156823e42141f0f4a9238ad25e09aa3fa45e3bfeb4902075',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(27,'Q27',27,4,'Enumere as sanções administrativas previstas no art. 52 da LGPD.','8a846e2631e34b1d7de07ddeef7ce56fdadeb91fda96a43e4c60418121d6a5bc','Q39',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(28,'Q28',28,4,'Informe os dois limites da multa simples da LGPD: o percentual, sobre qual base ele incide, e o teto em reais por infração.','a976484fe5a4ea376db1cd85f8bfb1f2327f58a872eb8344c7cf836296499056','Q39',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(29,'Q29',29,4,'É possível aplicar sanção da LGPD sem processo administrativo prévio quando ficar comprovado que o agente de tratamento é violador contumaz? Fundamente.','2859b4472425df00cf175c3cc84301e6b7eb2fef5c7001138be83963e800f7cc','Q39',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(30,'Q30',30,4,'Cite ao menos seis parâmetros que a LGPD manda considerar na dosimetria da sanção e aponte um critério de aparência plausível que a lei **não** prevê.','f819285592957bec29e2dae34e9976221453cb2d8d29d4ae12343ce819b23c95','Q39',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(31,'Q31',31,4,'Quais sanções da LGPD podem ser aplicadas a órgãos e entidades públicas, e quais estão excluídas? Diga também o que a lei manda considerar quando o infrator é ente público.','3a2a70030a709f84b30a57bef955153277c555dcc20ed4ecb1f598c0ac9431a5','Q39',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(32,'Q32',32,4,'Qual é a destinação do produto da arrecadação das multas aplicadas pela ANPD, inscritas ou não em dívida ativa?','98141565f61cc422bf2e81db96992a9a7a8ab2483e8f6b1609206f4658748993','Q39',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(33,'Q33',33,4,'Defina controlador, operador, encarregado e titular na LGPD. Em seguida, explique o critério que separa controlador de operador quando ambos tratam os mesmos dados.','ffd904fa5b1cd49768357c448cf0b4fca6248ee8304dda916d5a0d15ed7ce528',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(34,'Q34',34,4,'Uma autarquia estadual sofre vazamento de dados de 200 mil cidadãos por configuração indevida de um bucket público. Apurou-se que havia política de boas práticas documentada, que a autarquia comunicou o incidente espontaneamente em 48 horas e que é a primeira ocorrência. Indique quais sanções são cabíveis, quais não são, e quais parâmetros de dosimetria pesam a favor do infrator.','4b79e6418039e3a2e82f473dae269e36e67536c211097ab49ff11cdfd8cbb500','Q39',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(35,'Q35',35,4,'Compare os regimes sancionatórios do Marco Civil e da LGPD quanto ao percentual da multa, à base de cálculo e à existência de teto absoluto.','7a7acf91cc5c2eec4f7f304c221a5cb9dabf6edd28e2b35aece7e004a6d7d66f',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(36,'Q36',36,5,'O que é a ANPD e quais são suas três grandes frentes de competência?','2aff931fbe4f6f9b4f418f499c11371b090158dd81cc50ff92ca8a62626538a4',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(37,'Q37',37,5,'Qual é a natureza jurídica atual da ANPD e sua posição na administração pública federal? Explique o que mudou em relação à natureza que ela tinha na redação original da LGPD.','5cddaa181b0a685ad3f96676e14533d3c3076a86aecd818f78f992e1107031f1','Q40',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(38,'Q38',38,5,'Descreva a composição do Conselho Diretor da ANPD: número de membros, forma de nomeação, exigência de aprovação legislativa e duração do mandato.','c24fd39c5ab849ddb506f5288828ecac0e8c5d30fc522bc2e871d0953d33f8d7','Q40',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(39,'Q39',39,5,'Além do Conselho Diretor, quais órgãos integram a estrutura da ANPD?','6728b866f05814ca502159f48dc95b4aa83a5bd4bcc6578430ea6c71d0025aa9','Q40',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(40,'Q40',40,5,'Distinga ANPD e CNPD quanto à natureza, à composição e ao poder de sancionar. Aponte qual dos dois edita normas e fiscaliza, e qual apenas propõe e sugere.','8bdf7ef7272d6ad901ed885c21a1b1f683ca32f2f506edd7c5820d91456f5b32','Q40',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(41,'Q41',41,5,'Uma empresa é multada pela ANPD e alega, em defesa, que o Conselho Diretor não poderia decidir porque não conta com representantes do Senado e da Câmara em sua composição. Avalie o argumento e explique onde está a confusão institucional.','5cdaca053870497eb6e89414225999cc7c7eb91d54b03a767d2cd32e2e5d9315','Q40',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(42,'Q42',42,6,'O que é o CNPD e qual é sua natureza no desenho institucional da LGPD?','5352468520d54e4e91abd5e6621afb5b3a6834b8d22bbc904e6e43172049a53a',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(43,'Q43',43,6,'Descreva a composição do CNPD: número total de representantes e quais segmentos e instituições os indicam.','33fa5761fe74617d031af2148286d9849a770a368143da0a828cfe05ba32da13','Q40',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(44,'Q44',44,6,'Enumere as atribuições do CNPD previstas na LGPD.','eda75f6efbcaa047136d94d9391b69e67927d02cef1666dcf9f7791c843d7006','Q40',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(45,'Q45',45,6,'O CNPD é órgão integrante da estrutura da ANPD ou entidade autônoma externa a ela? Explique a relação institucional entre os dois e por que o Conselho Diretor não se confunde com o CNPD.','1dd791c83d98de9cdf3d8738d3e516f1ae3d53b1209f3b54fc12c5880e9b12fd','Q40',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(46,'Q46',46,6,'Os membros do CNPD são remunerados pelo exercício da função? Explique também como é a investidura e o que a lei prevê sobre a perda do cargo.','af31f1cf7572caa1a6978bdd423f14d05e66839dea9002ee9b109a07f71ec2eb','Q40',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(47,'Q47',47,6,'Uma associação de defesa do consumidor quer que o Estado brasileiro edite norma obrigando anonimização em determinado setor. Indique a qual das duas figuras — ANPD ou CNPD — ela deve dirigir a demanda para obter norma com força vinculante, e qual seria o papel da outra nesse processo.','c3c02d0657d010b98ac8bd0d2970fb694dc521c9aff8b19af360bc78dc1d8961','Q40',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(48,'Q48',48,7,'O que é o Spring Framework e o que significam, nele, inversão de controle e injeção de dependência?','dc52dff77e062eb3a22f01917d4d722155f50a39aa6d3f5000b893f272c922c5',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(49,'Q49',49,7,'Distinga Spring Boot de Spring Cloud: qual dos dois resolve autoconfiguração e inicialização da aplicação, e qual resolve os problemas de sistemas distribuídos?','6320690f69e389b666f577803baf43edeb1344e59f64c0954fe42b0ec61886ac','Q41',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(50,'Q50',50,7,'Qual dos dois é framework de mapeamento objeto-relacional e qual é framework de testes de unidade: Hibernate ou JUnit? Descreva o que cada um faz.','125ee96f79e02400cd64efcf713a0814b7228086ff268f56c54f32820f9afac3','Q41',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(51,'Q51',51,7,'O Spring Boot elimina a configuração manual de dependências e servidores, mas ainda exige que se use Tomcat ou JBoss em modo standalone? Explique a diferença entre servidor embarcado e servidor standalone.','b1b20538ed721cf0edbc2d882ba0ecf2fff778c0c4e2ac6369730af57f2ae73e','Q41',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(52,'Q52',52,7,'Explique o que é um *starter* do Spring Boot e o que exatamente a autoconfiguração faz durante a inicialização da aplicação.','1143775154a0accba0fa91fe225384d49b6b56c770feb4a8c1905c6ae55ea29b',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(53,'Q53',53,7,'Liste os problemas típicos de sistemas distribuídos que o Spring Cloud se propõe a resolver, nomeando o recurso correspondente a cada um.','96304e8a9bac8a386af9a58d3a032f839a45b8913be52b944ceaf97f28b7c227','Q41',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(54,'Q54',54,7,'O Spring é um framework voltado exclusivamente ao desenvolvimento de aplicações monolíticas? Fundamente.','c55e0839e1c095f05312bb32c55885443de5cd8e28195cc5f53da3ac23c9fc98','Q41',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(55,'Q55',55,7,'Distinga Tomcat de JBoss/WildFly quanto ao que cada um implementa da plataforma Java corporativa, e diga em que situação a escolha entre eles é indiferente.','8c35e5ac3c75bf6cdddd5463cd55d97be26475fddbdddc8fbadf305f056101d8',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(56,'Q56',56,7,'Uma equipe vai construir cinco serviços independentes, com configuração centralizada, descoberta de serviços e tolerância a falhas entre eles, cada um empacotado como artefato executável único. Indique quais projetos do ecossistema Spring atendem a cada exigência e justifique.','823958a6f9b9dd85ab0765fe213b538c15e7aefea283c65008d10f925712e9c8','Q41',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(57,'Q57',57,8,'O que é XSLT, sobre que tipo de documento ele opera e em que formatos de saída pode produzir resultado?','f48f0a9d55f0bfdf709c30c01019b4f3af9715c4bb77d6ef59bf0d30bde6540a','Q42',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(58,'Q58',58,8,'O XSLT é uma linguagem para transformar documentos JSON em outros formatos? Explique.','7f768894118c626e0082f12e2c119868e8696faae28ab82318038e34a50df523','Q42',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(59,'Q59',59,8,'Compare XML e JSON quanto a verbosidade, legibilidade e compactação, e diga qual dos dois predomina hoje em APIs web e por quê.','68914446f749ac8d4c8e60fee82c16be9f0c5e22455428f0c5f7a9ae767efd6b','Q42',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(60,'Q60',60,8,'XML e JSON são estritamente equivalentes em expressividade? Cite recursos do XML que não têm correspondente direto no JSON.','12fc2508c4edaced8a72533530f96726d13fd2877102d5bad7351621d382797b','Q42',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(61,'Q61',61,8,'Enumere os recursos do ecossistema XML que sustentam contratos e validação de documentos, indicando a função de cada um.','389d49073b2926a2efa5cbdad93ab28f2b29157aa79d6eb3647988bfb1f94902',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(62,'Q62',62,8,'Quais tipos de dados o JSON suporta nativamente? Aponte ao menos dois tipos comuns em sistemas corporativos que ele **não** representa nativamente e explique como se costuma contorná-los.','cb50b728b8fbbae64b8106099051313646416b77ac7bfbe03ab5c76b9814fe1b',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(63,'Q63',63,8,'Por que o JSON se tornou o formato dominante no transporte de dados entre cliente e servidor em APIs?','484d4351961a1070a056a2b275df872023a6d354bd3299a0461e830efdbc3206','Q42',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(64,'Q64',64,8,'Um sistema precisa trocar documentos fiscais com validação estrutural obrigatória, assinatura digital sobre trechos do documento e contrato verificável entre as partes. Outro precisa alimentar um front-end SPA com listas paginadas em chamadas de baixa latência. Escolha o formato para cada caso e justifique.','b146b5992b169182b4aa781b2426e650b3fed0e3cc4777de2ee0ef71784c4f2a','Q42',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(65,'Q65',65,9,'O que é design de software e em que ele se distingue da atividade de codificação?','d575e1d9132453c017007429df297a84ee2c79c9995878e27e696bc6d0ce9a0a',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(66,'Q66',66,9,'Qual é a principal diferença entre Arquitetura de Software e Design de Software quanto ao alcance das decisões tomadas em cada um?','02e53cc8512d1664da251a6f6d9c678b7163b17c30d0b0fc4318077dddd0bff6','Q43',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(67,'Q67',67,9,'Qual dos dois — design de alto nível ou design de baixo nível — trata da estrutura geral do sistema, com definição de módulos e suas interações? E qual trata da implementação de funções e métodos específicos?','9e49ae97ab55ac019e5b8035db21b27c10a4d76a4c42f73351392a7d6b0b7126','Q43',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(68,'Q68',68,9,'O design de software é o processo de codificar funcionalidades seguindo diretamente os requisitos do usuário, sem envolver abstrações ou estruturas maiores? Fundamente.','1aa64fdec69c4e430802b5b06b9c89d6a9a66a4ea50dfdd25ae1bef143542adf','Q43',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(69,'Q69',69,9,'A Arquitetura de Software é conceito aplicável apenas a projetos de grande escala, sendo irrelevante em sistemas menores? Fundamente.','72ad4a98b30f89fb7f88ff66a05f227042dba243816b1e2b722797858232aa8f','Q43',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(70,'Q70',70,9,'Defina módulo, componente e interface, e explique o que significa dizer que a arquitetura define as **interações** entre eles.','a79fcf2b2b3b7e2b32f1a4deb2151d58fdcec0c61477fd8b4f357ef6d33ff5aa',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(71,'Q71',71,9,'Explique o papel da abstração e da modularização como instrumentos de decisão estrutural, e o que se perde quando um sistema é modularizado por critério errado.','373166716cba4214ba6ff7de762bab4310f09f20a8be2f0171f592ffbe037f7d',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(72,'Q72',72,9,'Numa reunião, decide-se (i) que o sistema terá três camadas com comunicação apenas por interface, (ii) que o repositório de clientes usará cache em memória com expiração de 5 minutos e (iii) que o método de cálculo de juros ficará em classe utilitária estática. Classifique cada decisão como arquitetural, de design de alto nível ou de design de baixo nível, e justifique.','351c7a8968f6635b7f5ea9555d2b309b33b0c8e2d5b0351a908859b327c3e491','Q43',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(73,'Q73',73,10,'Enuncie os cinco princípios SOLID, dando o nome e a formulação de cada um.','19c60302199fbefb2a1a83beb6eed633464fc469c3cbe470d0f2eb2bdf68f789',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(74,'Q74',74,10,'Explique o Princípio da Responsabilidade Única e diga por que "uma responsabilidade" não é o mesmo que "uma única função ou método".','8c1bd1b4a4ae75d7f558ce00a2846d6bee1129502835aebe42645d87e39e5991',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(75,'Q75',75,10,'Explique o Princípio Aberto/Fechado: aberto para o quê, fechado para o quê, e por qual mecanismo da orientação a objetos isso se obtém na prática.','bd50c6aa392f11f7c01b798438f96bd133d058da55f6416f80e18eca33eb3786',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(76,'Q76',76,10,'Uma subclasse que sobrescreve um método herdado e altera seu comportamento viola, por esse fato, o Princípio da Substituição de Liskov? Fundamente.','be8795af6c7b00c617fac5578275b09d5182dbc0da7fdf3e67ddd6864a777943','Q49',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(77,'Q77',77,10,'Enumere as restrições que o Princípio da Substituição de Liskov impõe a uma subclasse quanto a pré-condições, pós-condições, invariantes e exceções lançadas.','e6592a42ed37e868e95143c62f74ac97bf3424a7245f9ef6cd77809bf02206bb','Q49',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(78,'Q78',78,10,'Distinga o Princípio da Segregação de Interfaces do Princípio da Responsabilidade Única: os dois falam de "fazer menos coisas", mas incidem sobre alvos diferentes. Qual é cada alvo?','f82d4dd9af0959a16b731366495689ec6e7013554079db1f6e8a63ea34700e79',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(79,'Q79',79,10,'Distinga o Princípio da Inversão de Dependência da técnica de injeção de dependência. Um pode existir sem o outro?','6c28728ed14c1570c05d40f5227c95feecd01e04320c1ae92a7d344dbec95480',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(80,'Q80',80,10,'Considere uma classe `Retangulo` com `setLargura` e `setAltura`, e uma subclasse `Quadrado` que sobrescreve ambos para manter os lados iguais. Um cliente escrito contra `Retangulo` define largura 5, altura 4 e espera área 20. Indique se há violação de LSP, qual restrição foi quebrada, e por que o compilador não acusa nada.','55c0869b01150b2e11359ea70aa3ef5e42b4b48abf3a09d54da37a9198c20e08','Q49',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(81,'Q81',81,10,'Explique por que a violação de LSP quase sempre nasce de uma relação de herança modelada como "é um" no vocabulário do domínio, mas não no comportamento observável.','25ab61a1630c9d1820dc3e2e8c81d63ea636e9fefe1a88771b3327bb5fca8a69','Q49',0,0,1,'2026-07-23 16:33:36',NULL,'D5');
INSERT INTO pergunta VALUES(82,'Q82',82,11,'Defina herança, sobrescrita e polimorfismo, e explique como os três se articulam numa chamada de método em tempo de execução.','a0655311f1237db5012561f0cf67a8e9fff30c34a8d6da6d893ada2613e7c1bd',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(83,'Q83',83,11,'O propósito da sobrescrita é justamente especializar o comportamento herdado. Sendo assim, quando é que especializar comportamento passa a ser defeito?','720d7a2ff08f42a1e79e6cdbde41c3d5a462494246f296a227f2817216ef99ee','Q49',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(84,'Q84',84,11,'Distinga sobrecarga de sobrescrita quanto à assinatura, ao momento da resolução e ao efeito sobre o polimorfismo.','96c56f1e433db8ab8dadaa7f6d8a21e6b5700147192feb98ca3593724949f9df',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(85,'Q85',85,11,'O que compõe o contrato de uma classe além das assinaturas dos métodos, e por que essa parte do contrato não é verificada pelo compilador?','f0b0d1f6ddb94b2efe00c0947d5462591dcb88174eb0219e4afae8ed4b97c5b9',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(86,'Q86',86,11,'O princípio da substituição exige que o método sobrescrito seja exatamente igual ao da classe base? E exige que ele lance exceção quando chamado? Responda às duas e explique de onde vêm esses dois equívocos.','076126d42012326aad949bda168e2c015148adc65115db607c3d6502ea55d159','Q49',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(87,'Q87',87,11,'Dado o código em que `Cachorro extends Animal` sobrescreve `emitirSom()` para imprimir "Latido" no lugar de "Som genérico", diga se o código respeita a Substituição de Liskov e justifique em termos de corretude do programa cliente.','47477fa57b1de62337f45d410824b5fae53025e17d818f68eb3784d34ca33da8','Q49',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(88,'Q88',88,11,'O que significa, com precisão, dizer que a corretude do programa é preservada ao substituir a classe base pela derivada? Corretude aferida por quem, e observada de onde?','d244434e9d82d03626757c8764a6fe43efeae933259e893a406673b90edb7eaa','Q49',0,0,1,'2026-07-23 16:33:36',NULL,'D5');
INSERT INTO pergunta VALUES(89,'Q89',89,12,'Defina Internet, intranet e extranet quanto ao alcance e ao público autorizado de cada uma.','05cb44355cb2a61dbc81be3e593ae737104d09f13cb2a2ecfd0f91f3863a45cd',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(90,'Q90',90,12,'Qual das três — Internet, intranet ou extranet — usa tecnologias da Internet para dar acesso controlado a parceiros externos autorizados, além dos usuários internos?','9b2cb480276234b86d1cc6ec3d54441a9d11f0e2b68fbd39646a15114f3a14c4','Q44',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(91,'Q91',91,12,'Um portal corporativo interno é uma página acessada publicamente, que centraliza informações e serviços para clientes e fornecedores? Corrija a afirmação e defina o que um portal corporativo interno de fato é.','794e88f32e179564589a445c7b878bb09a566eddc4f4b7c792be893685a3b94d','Q44',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(92,'Q92',92,12,'Distinga servidor web de servidor de aplicações quanto à função principal, ao tipo de conteúdo entregue e à relação com a lógica de negócios e os bancos de dados.','d4d66b19d580dc2ca753e36adb2c2009c49632900aafce4d1beeab5f6296e897','Q50',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(93,'Q93',93,12,'O servidor web é responsável exclusivamente por conteúdo estático? Explique como ele participa da entrega de conteúdo dinâmico.','205edf701099442450bc92d70c437d402899ded192f46e880b9618fb08e5c408','Q50',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(94,'Q94',94,12,'O balanceamento de carga é atribuição do servidor de aplicações? Explique onde o balanceamento costuma ficar na arquitetura web e qual seu objetivo.','a2ed4aee86d7421d565da1de486311db1d4829a739d4913597e112c15e8a8e67','Q50',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(95,'Q95',95,12,'Cite produtos típicos de cada categoria — servidor web e servidor de aplicações — e explique por que alguns produtos aparecem nas duas listas.','758f2745c180a916428965eba8973bc7f9b9f0b272981732f66af07daec3d972',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(96,'Q96',96,12,'Uma multinacional precisa: publicar o catálogo público de produtos; dar aos funcionários acesso a holerite e circulares internas; e permitir que distribuidores homologados consultem estoque e emitam pedidos. Indique que tipo de rede atende a cada necessidade e que tipo de servidor sustenta cada uma.','ad329b94d1c67132db4791f091120102c12614f4d9bbef020760c5f631a02421','Q44',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(97,'Q97',97,13,'O que é Arquitetura Orientada a Serviços e quais são seus dois objetivos declarados quanto a acoplamento e interoperabilidade?','63076596d2b61530eac20eb08fb73497dba41903c6e08d6b2cb08470fd014faa',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(98,'Q98',98,13,'Compare Web Services RESTful e SOAP quanto ao contrato, ao formato das mensagens, ao acoplamento resultante e à independência de plataforma.','1a33d62b62fde73f857b3448e324913dd75f0a8565bd102578cee72dc9556be5','Q45',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(99,'Q99',99,13,'Enumere as restrições arquiteturais do estilo REST e explique o que cada uma exige.','81cdb74ccb018cd7bf7d0633e6b34d17a61e2c5e5f39d3364dc0a03e532f91bb',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(100,'Q100',100,13,'Implementar serviços SOAP **sem** definição de contratos formais aumenta a flexibilidade da comunicação? Fundamente.','c0c4c42769067176a7efc8cd5f5e0bfd9a57215ca5b0e2ce7e1474c234055bfb','Q45',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(101,'Q101',101,13,'O que é WSDL, a que tecnologia ele se associa e o que exatamente ele descreve?','d4e6963982fda9c5a55b1dbdda690f98104c2919ecc72504288198fec6139421','Q45',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(102,'Q102',102,13,'Uma integração em que a mudança em um serviço se reflete diretamente no outro caracteriza baixo ou alto acoplamento? Defina os dois termos e diga qual deles a SOA busca.','158ebf4a31723fa40e37ce063174548b7d0178ede3ffc11ebb2482ea32519193','Q45',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(103,'Q103',103,13,'Adotar arquitetura monolítica, com todos os provedores de pagamento integrados diretamente ao sistema, elimina a necessidade de web services e melhora o desempenho? Avalie o ganho e o custo dessa escolha.','4328b45881ef0da08f5c377e93714184bebc3820b71ae5d46148b25ceb64603c','Q45',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(104,'Q104',104,13,'Uma empresa de comércio eletrônico vai integrar quatro provedores de pagamento externos, cada um com evolução independente e stack tecnológico próprio. Indique a tecnologia de integração adequada para garantir baixo acoplamento e alta interoperabilidade, e explique por que RPC com contrato rígido seria escolha pior.','09b2db16854223b05b3c4a000e9c9aa5d34776d930eef297c39a0c307979bab2','Q45',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(105,'Q105',105,13,'Explique por que a ausência de estado no servidor (statelessness) reduz acoplamento e habilita escalabilidade horizontal, e qual custo ela transfere ao cliente.','8bf850a9c3b98ee6e3f4d73c31d1d7a59c07d5dfbfec757be1fdec6af27d6bd7','Q45',0,0,1,'2026-07-23 16:33:36',NULL,'D5');
INSERT INTO pergunta VALUES(106,'Q106',106,14,'O que o HTTPS acrescenta ao HTTP, e quais garantias de segurança resultam disso?','f3218a64b216592422f6785f64e752f4c9cd0e0a6d79bfc01416167bc64b0bef',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(107,'Q107',107,14,'Qual é a relação entre SSL e TLS? Indique qual sucedeu qual e o que motivou a substituição.','2c2fe8acc46f2b8995a84e554b7a32390c0023e6645469d71a5ac066d8fe0f77','Q46',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(108,'Q108',108,14,'SSL e TLS são usados conjuntamente, cabendo ao SSL a autenticação e ao TLS a criptografia dos dados? Corrija a afirmação.','01823b8777e02f9c3b889f0ff91d8141d3afeaeebaca443a85c79bf2c4f8556b','Q46',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(109,'Q109',109,14,'SSL e TLS são intercambiáveis, oferecendo o mesmo nível de segurança e diferindo apenas na compatibilidade com navegadores? Fundamente.','002b1b0360d533a270cfbaa9ddeb47bec0c5f721e5df60031b62aeadc48fd7cb','Q46',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(110,'Q110',110,14,'Descreva as etapas do handshake TLS, indicando em que momento ocorre a autenticação do servidor e em que momento passa a valer a criptografia simétrica.','d25e0762fe45dabc694dc486ab160626aa167090ef79d3f2e342c88e7c7d7d40',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(111,'Q111',111,14,'O que um certificado digital de servidor contém, quem o assina e o que exatamente o navegador verifica ao recebê-lo.','5e980efd085e40f7fa0e8d3f11658da522737f7a280e85c2c8004921ac75a396',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(112,'Q112',112,14,'Informe quais versões de SSL e de TLS estão hoje depreciadas e quais seguem em uso recomendado.','9cf7c63b3245e42bce541f9777dd521bf8db29f590e99644cb16a361972b31b9',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(113,'Q113',113,14,'Um site exibe cadeado no navegador. Um gestor conclui que o site é confiável e que os dados armazenados no servidor estão protegidos. Aponte o que o HTTPS efetivamente garante e o que essa conclusão extrapola.','fac885f760d705927a7e304fb0fd7939272efb119ae0f0474f94531afce1aa5b','Q46',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(114,'Q114',114,15,'O que a Análise de Pontos de Função mede e a partir de que insumo ela é calculada?','7c3cfc9040aa7b570f418265e9bae62c6a7915f028fcccd7b49a4aca1b05f87c',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(115,'Q115',115,15,'Qual das duas técnicas oferece mensuração objetiva e independente do time de desenvolvimento: Ponto de Função ou Story Points? Fundamente.','5dcb58c3d86bc9c376eba07dc2467951539ca1fc1a593443307223648fad5877','Q47',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(116,'Q116',116,15,'Story Points permitem melhor padronização de estimativas entre projetos e times diferentes? Explique por que a comparabilidade entre equipes é justamente o ponto fraco deles.','37bde5e5b943f03c24e6545790784e0ef9042a0be747fe98910c4e8bf1a83f02','Q47',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(117,'Q117',117,15,'Qual das duas técnicas é adequada a contratos formais com escopo fechado e orçamento rígido, e por quê a outra não é?','bbbca8c444f8c095458dae927a7b5a85b8337e9a693faa40b91167391e6ab995','Q47',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(118,'Q118',118,15,'O Ponto de Função é mais flexível por levar em conta o contexto subjetivo do time ao estimar o esforço? Corrija a afirmação, separando o que é objetivo do que é subjetivo em cada técnica.','5435dde204f2914b317f9f994ff7ef9c5ad7f176cce41d17c1c696b90c1055f5','Q47',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(119,'Q119',119,15,'Distinga estimativa de **tamanho** de estimativa de **esforço**, e explique como se converte uma na outra.','04af0a6c5a889490f7123b55248de644338be130b45d5102290e8efcffae5d77','Q47',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(120,'Q120',120,15,'Enumere os tipos de função contados na APF, separando os de dados dos de transação.','79fd2afe7382b143a47a95603536ee386dca2790f9aedef658a7574033d66fd5',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(121,'Q121',121,15,'Um órgão público vai contratar fábrica de software por escopo fechado, com medição de entrega auditável por terceiro, e internamente a equipe quer planejar sprints de duas semanas. Indique qual técnica serve a cada finalidade e por que usar a mesma para as duas seria erro.','cc205eff7a236ceffe665d1387728a72f7664820d1f53cb86b332d6870058253','Q47',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(122,'Q122',122,16,'Qual framework de desenvolvimento multiplataforma para Android e iOS utiliza a linguagem Dart?','4de4d835cc2dc6ca37bd3d2575547ecf0f1ccbeed650e723ec5bed75d534b2ad','Q48',0,0,1,'2026-07-23 16:33:36',NULL,'D0');
INSERT INTO pergunta VALUES(123,'Q123',123,16,'Distinga desenvolvimento nativo de desenvolvimento multiplataforma quanto a esforço de codificação, desempenho e acesso a recursos do dispositivo.','d37ab71d915d562ccf39df9c31cac5ec439b7456730552fa5fb3d4687771bf76','Q48',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(124,'Q124',124,16,'Associe cada framework à sua linguagem ou tecnologia de base: Flutter, React Native, Xamarin, Ionic e SwiftUI.','ca46bd0ace6987b027dc8edb46bf01a839263affad3611bf0ace3935bef34b21','Q48',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(125,'Q125',125,16,'O SwiftUI é um framework multiplataforma para Android e iOS? Explique a que plataformas ele efetivamente se destina.','4e5695dd08668c23e78134e08a7255b2a3a3c024e460fd317ffbe27fb11469c0','Q48',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(126,'Q126',126,16,'Distinga a abordagem do Ionic da abordagem do React Native quanto à forma como a interface é renderizada no dispositivo.','3b00a2200b53a203a53ac0b90d66a254c5ccd3b8871281c56e3c1cc11a46312a',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(127,'Q127',127,16,'Explique como o Flutter renderiza sua interface e por que essa escolha o diferencia dos frameworks que mapeiam componentes para widgets nativos.','16033c9b8697e6443e6297909632d43200168a2b0d71e89d2df93385c7f4c938',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(128,'Q128',128,16,'Uma equipe pequena precisa lançar em Android e iOS em quatro meses, com telas muito customizadas e uso intenso de câmera e sensores, e a empresa já tem um time forte em TypeScript. Avalie as opções multiplataforma e o custo de ir nativo, indicando a escolha e os riscos assumidos.','eeb7ea020f39b067a2f96fa3d277421eb3c6d6e39f2018f572da2f953bbdff3d','Q48',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(129,'Q129',129,17,'O que caracteriza uma Single Page Application quanto ao carregamento inicial e à navegação entre telas?','d870cb6ad27847028fc89f3905e601889454b272dfefe7ed3dd8d99fbe0e0429',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(130,'Q130',130,17,'Distinga SPA de PWA. Aponte qual das duas se define pela navegação sem recarregar a página e qual se define pela possibilidade de instalação no dispositivo com experiência próxima à de aplicativo nativo.','d2977d65c0906685e3673515313fcfbb7acf7da71e15537980de556a9bbda147','Q51',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(131,'Q131',131,17,'Uma SPA requer Service Workers para funcionar? Explique de qual das duas arquiteturas o Service Worker é peça essencial.','0f1cc317fbff312467d805eb57b41c2202220d279e00dca03d070850b9050e7c','Q51',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(132,'Q132',132,17,'O que um Service Worker permite fazer que a página comum não permite? Enumere as capacidades.','1679f5a98984d103912552b6333139928daaf3767cdfac5a85f6843016d19f24','Q51',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(133,'Q133',133,17,'SPA e PWA dependem exclusivamente de frameworks JavaScript, sendo impossível implementá-las sem eles? Fundamente.','0cedf8034fb8dc52431481764d6e9f98ab2f401b4ac3fb283910b2058bd078d0','Q51',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(134,'Q134',134,17,'Enumere os requisitos técnicos mínimos para que uma aplicação web seja considerada instalável como PWA.','b9382874fcff129680f6c53f4fe5a0254d2fa23c0ab2027a5c488bf3d8cecef0',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(135,'Q135',135,17,'Uma SPA e uma PWA são mutuamente exclusivas? Explique a relação possível entre as duas.','a7e6e59248053749c6d1e736ba8be15672beea21d6a2f1a4a2785ee58b563d48','Q51',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(136,'Q136',136,17,'Uma seguradora quer que os peritos de campo consultem apólices e registrem laudos em áreas sem cobertura de rede, com o ícone do sistema na tela inicial do celular e sem publicar em loja de aplicativos. Indique a arquitetura front-end adequada, os recursos que a viabilizam e o que ela ainda assim não resolve.','e7da994fcc531b6c056d6476f161f448ac086a6518c8304479638ef635219939','Q51',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(137,'Q137',137,18,'O que um teste unitário verifica e qual é a unidade típica sob teste?','97e052cf82e63547dc57b7b523b72f4be4975c771c60afcfe30e955b884af21b','Q52',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(138,'Q138',138,18,'Distinga teste unitário de teste de integração quanto ao alvo da verificação e ao que cada um consegue e não consegue detectar.','9a285a4acb8567440b2fc29e79b0bea84582dfa34c4f993b82a158d89857edea','Q52',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(139,'Q139',139,18,'O que um teste de usabilidade avalia e por que ele não substitui nem é substituído por testes automatizados.','6b3e7651854e49bc36a6064973225b7a3f156e44fa6ee84cb2864e79f22a3b36','Q52',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(140,'Q140',140,18,'No TDD, os testes são escritos antes ou depois do código funcional? Explique qual efeito essa ordem produz sobre o desenho do código.','feb65b8e3668214dd52a2a2540e801e3985a2c7f5592822934568a2826a98b29','Q52',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(141,'Q141',141,18,'Descreva o ciclo do TDD, nomeando suas três etapas e o que se faz em cada uma.','5f132858054e19376220f864e732866503ece356f7062bef5ab187a3a0823913','Q52',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(142,'Q142',142,18,'Descreva a pirâmide de testes: quais níveis a compõem, em que proporção e qual o critério que justifica essa proporção.','c65f968ddc47f9e7f327ce1c93ef9d129e5b72b52c8a591a75c1340d97198a61',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(143,'Q143',143,18,'Todo teste automatizado é teste unitário? E todo teste unitário é automatizado? Responda às duas e explique por que a confusão entre os dois termos é comum.','06ef32ae507302aaca1c3dcbc34991acbaee3241fb481612c9cbc047d1a5b5b5','Q52',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(144,'Q144',144,18,'Uma equipe tem 900 testes verdes, todos exercitando classes isoladas com todas as dependências substituídas por dublês, e mesmo assim a integração com o gateway de pagamento quebra em produção a cada release. Diagnostique a lacuna e indique que tipos de teste faltam.','100a6b1928986312c5172bcec5d2209b06b5a427922900310a9f349a3789c053','Q52',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(145,'Q145',145,19,'Enuncie os quatro valores do Manifesto Ágil, na forma "X mais que Y", e explique o que a expressão "mais que" não autoriza concluir.','b8b9b888a91a7f588d0f4fba5607bdc72133346520581b4011497f3f895334ed',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(146,'Q146',146,19,'Distinga Scrum de Kanban quanto a ciclos de tempo, momento da entrega, forma de limitar trabalho em andamento e prescrição de papéis e eventos.','11081d759b43b7e440ef73fa9e6fc97cb2b59ace2c6f34bf1ac59f43f4a35762','Q53',1,0,1,'2026-07-23 16:33:36','2026-08-03 14:08:02','D2');
INSERT INTO pergunta VALUES(147,'Q147',147,19,'Enumere os papéis do Scrum e a responsabilidade central de cada um.','8ef22947f7190ec57a4239c9d5e3ea85c0dbf329222b39a9dfb832ff1c471f55','Q68',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(148,'Q148',148,19,'Enumere os eventos do Scrum, informando o propósito de cada um e a quem cabe conduzi-lo.','5b04bc50f3048ba9d9fafd71257dd76233d28158a6845d5aa446034232999dd3','Q69',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(149,'Q149',149,19,'Distinga Product Backlog, Sprint Backlog e Sprint Goal, indicando quem é responsável por cada artefato.','2f6817e68c695f2e9f79263ab67564f33cf361ffa0280f0b922421e40ae08d10','Q69',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(150,'Q150',150,19,'Diante de um impedimento levantado no Daily Scrum, cabe ao Scrum Master redistribuir as tarefas por conta própria, assumir a tarefa do desenvolvedor, ou facilitar para que o time encontre a solução? Fundamente na postura esperada do papel.','384bc0c4347feae82b7ea22208a04f04ad96c07d7337630a657decf53405cd79','Q68',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(151,'Q151',151,19,'O Product Owner deve decidir sozinho quais itens entram no Sprint? Explique a divisão de decisão entre PO e time no Sprint Planning.','9e4faebb3277fd7c10dd9b018085d58c4f7b2c0aeb535a08ea088218161351e8','Q69',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(152,'Q152',152,19,'Explique o que é a capacidade do time e por que colocar no Sprint mais itens do que ela comporta é prejudicial mesmo quando "sobra alguma coisa para o próximo Sprint".','8814a2d688c12f50975f96ee9e43b37ecb9ae7c58cf09288e270e43dc463f40c','Q69',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(153,'Q153',153,19,'Caracterize XP, Lean, Waterfall e a abordagem Ágil Híbrida, apontando o traço que distingue cada uma das demais.','1e16535634c6a0f60f92acc3b29e5e76cff5b8f78ab04c42c649fb1c8ef27914','Q70',1,0,1,'2026-07-23 16:33:36','2026-07-23 16:37:46','D3');
INSERT INTO pergunta VALUES(154,'Q154',154,19,'Num projeto de alta complexidade, com requisitos que mudam com frequência e necessidade de entregas rápidas em ciclos incrementais, com priorização de valor ao cliente por feedback contínuo, qual metodologia ágil é a mais adequada? Justifique e explique por que Kanban, XP e Lean, ainda que ágeis, não são a melhor resposta a esse enunciado específico.','4a06218345d6d2ae4731992234285485a990811c809bdc77506048d2907b6a09','Q53',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(155,'Q155',155,19,'Um desenvolvedor avisa no Daily que não concluirá sua tarefa até o fim do Sprint. Descreva a sequência de ações correta do Scrum Master e do time, e diga o que aconteceria com o Sprint Goal em cada alternativa errada (assumir a tarefa, escalar ao PO, encerrar o Sprint mais cedo).','b7751409e157825ea77252c4a6248a784a4e483da1510a6abb7776dc6ee2d92d','Q68',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(156,'Q156',156,19,'Explique por que o Scrum atribui ao time, e não ao Scrum Master, a decisão de reorganizar o trabalho dentro do Sprint. O que se perde, concretamente, quando o Scrum Master decide sozinho?','55666f5baaecc04c194370ae1c8c0af67bc815bbd721342292497a0bd6c24ce3','Q68',0,0,1,'2026-07-23 16:33:36',NULL,'D5');
INSERT INTO pergunta VALUES(157,'Q157',157,20,'Distinga requisito funcional de requisito não funcional e dê um exemplo de cada num sistema bancário.','834ccc2c00cf0ee605f0a57c225db1fd9e63a857764c5e1376d1ba6d741af70a','Q54',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(158,'Q158',158,20,'A exigência de que o saldo da conta passe a ser apresentado em tempo real é requisito funcional ou não funcional? Fundamente pelo critério que separa as duas categorias.','04e0160e9aaaf17f7aaa677897c07ca4407c98aa3c7b72f268430cea43c97cee','Q54',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(159,'Q159',159,20,'Enumere as técnicas de elicitação de requisitos e descreva brevemente cada uma.','2475cb1e38e921cb6bec26850c32c2010f5d1825fda616c64bb59c08fe1612d8','Q54',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(160,'Q160',160,20,'Uma entrevista com o gerente do projeto é exemplo de técnica de prototipação? Distinga as duas técnicas quanto ao que produzem.','20a3811660dde71aad7a53f1b08f12e15f9a88f050aed41da9ba437c8fd9e3c8','Q54',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(161,'Q161',161,20,'Uma sessão de brainstorming com a equipe de desenvolvimento é técnica inadequada de elicitação, por não envolver usuários finais? Avalie a afirmação.','8759d105239cb205dccc5326d97699cc357c2f8c3cf9da303c6d2caa8aae8b73','Q54',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(162,'Q162',162,20,'Em que ponto do ciclo de vida do software se posiciona a engenharia de requisitos, e por que a ideia de que ela ocorre após a implementação é equivocada?','2d58ac60d51b17410036e93a7af85e068fd3a20115cdae2598b000f589f2bc61','Q54',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(163,'Q163',163,20,'Distinga verificação de validação de requisitos, indicando a pergunta que cada uma responde.','5106c4684b2bc043e05c01c953a8ab4d4b5b194dc5f5928754935923200867fd',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(164,'Q164',164,20,'Um cliente pede "um relatório de vendas que abra rápido". Decomponha esse pedido nos requisitos funcionais e não funcionais implicados, tornando cada um verificável, e indique que técnica de elicitação você usaria para fechar cada lacuna.','02490bb230fe2c7ebdfd9985a10cefc2d8baeebed8a63eabd922824293b5bb4c','Q54',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(165,'Q165',165,20,'Explique por que classificar um requisito não funcional como funcional costuma sair caro, e em que momento do projeto o erro normalmente aparece.','af391c1b6de0e5a8a8c7e3073d0423361f33154e3b9213a964ceec15ac131233','Q54',0,0,1,'2026-07-23 16:33:36',NULL,'D5');
INSERT INTO pergunta VALUES(166,'Q166',166,21,'O que é Integração Contínua e qual problema de desenvolvimento em equipe ela ataca?','d54146207cc54ecbe906e1e1f5c1ae609b80a4da46649c12b3ea9771d1b4de61','Q55',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(167,'Q167',167,21,'Qual conceito descreve, única e corretamente, a prática de fornecer rapidamente uma nova versão ao ambiente de produção com o mínimo de interrupção para os usuários?','d1ea1eb6780a3a46f5994cfc6e5e91dbdc0561d2147d815eb4284142aaa79e5c','Q55',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(168,'Q168',168,21,'Distinga Entrega Contínua de Implantação Contínua: onde exatamente está a diferença entre as duas.','151b585f33f341c9dd751b45b5ebbd1cf990861bef3b075debe34d320adc5c2c','Q55',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(169,'Q169',169,21,'Distinga Integração Contínua de Entrega Contínua quanto ao que cada uma automatiza e ao artefato que cada uma produz.','0e3594b37de21db2671c9a1517b4fc3c24590ca43769cc143e778c7aeaea6887','Q55',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(170,'Q170',170,21,'Defina gerenciamento de configuração, monitoramento contínuo e controle de versão, e explique por que nenhum dos três é a resposta para "publicar nova versão em produção com mínima interrupção".','af7d99bb12d2d2e5ac744b2a87b405270bb7d62caf157f107235a6a3980c3453','Q55',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(171,'Q171',171,21,'Enumere estratégias de publicação que reduzem a interrupção percebida pelo usuário, explicando o mecanismo de cada uma.','f6a749fb93ca6a0775fc0bd8272d7962ca0ed78129325e0171c49a1784d03bca','Q55',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(172,'Q172',172,21,'DevOps é um conjunto de ferramentas ou uma cultura? Fundamente apontando o que não se resolve comprando ferramenta.','ea3c92585921a1092ead0e33bc1409b41c109b20a22e7f2693a0d8bd3ec928ab',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(173,'Q173',173,21,'Uma equipe integra e testa a cada commit, gera artefato versionado e o mantém sempre pronto para produção, mas a subida depende de aprovação manual do gerente. Classifique a maturidade dessa esteira nos termos de CI, Entrega Contínua e Implantação Contínua, e diga o que falta para o estágio seguinte.','c0c9c053de66af990a59c835f329e27a428af873afd4a651300261ee82e48932','Q55',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(174,'Q174',174,22,'O que é um bloco em uma blockchain e o que significa dizer que os blocos são encadeados?','de57d61b074f95ce0453706d05dbe1438fe24db80c261a825beced64adff9ee2',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(175,'Q175',175,22,'Enumere os elementos armazenados diretamente em um bloco de uma blockchain pública como Bitcoin ou Ethereum.','bdbb4a060d51fc634f1878c6f7e48ad06e03e0b4520b9fab3ad1343520c5836c','Q56',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(176,'Q176',176,22,'O registro de saldo das carteiras participantes é armazenado diretamente no bloco? Explique como o saldo é obtido no Bitcoin.','c92288feac11911f1d2467b8a62b1e55bf1507ea723604156b36c067cc7b1321','Q56',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(177,'Q177',177,22,'Distinga o modelo UTXO do modelo de contas, indicando qual blockchain adota cada um e como cada modelo representa o saldo de um participante.','c6f245f4264727d7fd33373c1ffb94c11742e568b53263ca521db454409d293e','Q56',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(178,'Q178',178,22,'Explique a função do hash do bloco anterior, do Merkle root e do nonce dentro da estrutura do bloco.','1167879863697787e85e63d0fcfed09df8da951aeb59a34219f5021baad46b4b','Q56',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(179,'Q179',179,22,'Explique por que alterar uma transação antiga exigiria refazer todos os blocos posteriores, e o que nessa cadeia torna a fraude economicamente inviável.','67673834e302d98cdb61d826d8cbb6184ac4259526f3487eb1256f4ae5c2b806',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(180,'Q180',180,22,'Distinga validação de transação de mecanismo de consenso, e compare Proof of Work e Proof of Stake quanto ao recurso que cada um exige do validador.','be3cc77fdda62ff1fc0fc39ccf661970c1fd2a4e7fc7e037fd38befc675212ce',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(181,'Q181',181,22,'Um auditor recebe o número de um bloco e quer provar que determinada transação está incluída nele sem baixar o bloco inteiro. Explique qual elemento do bloco viabiliza essa prova e como.','49da88a6e001bd66a9d6dfbd61276a0f21b9f3bde15c9a1e0abac77efb3a94ee','Q56',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(182,'Q182',182,23,'O que é a Arquitetura Hexagonal, por que também se chama Portas e Adaptadores, e o que ela separa de quê?','30640daed23ca5820db985c96d837124f4a3837b71693a2072c04854f551b569','Q57',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(183,'Q183',183,23,'Numa arquitetura hexagonal, distinga porta de adaptador e diga qual dos dois pertence ao núcleo de negócio.','fc1ba777fd06959575954b967bf81af0d0be268077cb87b7e3582d49c01b3171','Q57',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(184,'Q184',184,23,'Microsserviços compartilham o mesmo banco de dados para garantir a consistência dos dados? Corrija a afirmação e explique o padrão esperado quanto à propriedade dos dados.','e8a022e1d4815d127b65da5366a98953c7e475fa1eee8d6b610818f2cc6509c6','Q57',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(185,'Q185',185,23,'O que é um monolito distribuído, por que ele é considerado o pior dos dois mundos, e qual característica dos microsserviços ele deixa de entregar?','6ae61baa78d11a2977b7d917fae9d3de3339fc7fc8813b4be1a4a49353db8f99','Q57',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(186,'Q186',186,23,'Uma arquitetura monolítica pode ser distribuída? Explique o que ainda assim a diferencia de microsserviços quanto ao processo de implantação.','d05cdb6daeea3453e3e19195f1a41fd14a41e19f11f46b11c6929dcb6604aa2f','Q57',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(187,'Q187',187,23,'Defina acoplamento e coesão e explique por que microsserviços perseguem alta coesão interna e baixo acoplamento entre serviços.','5bf9b8c6b6eecedfc34bbfee26a68db0ad8ce409e0717355994dfaebc3fad36c','Q57',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(188,'Q188',188,23,'Como se mantém a consistência de dados entre serviços que não compartilham banco? Descreva a abordagem e o que ela troca em relação à consistência forte.','1e7769c6b08de897876305fa4b808343d9af58eba17c2f31c456ec52625fd521',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(189,'Q189',189,23,'Uma empresa quebrou seu sistema em oito serviços, mas todos leem e escrevem no mesmo esquema de banco e precisam subir juntos a cada release. Classifique a arquitetura resultante, aponte os sintomas que a denunciam e indique o primeiro passo de correção.','ecca7b444638aab17309eaa796d10763be196e085700a09a2967cb0c0362a7e3','Q57',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(190,'Q190',190,24,'Qual conceito está mais diretamente relacionado ao desenvolvimento de sistemas que aprendem com os dados e melhoram seu desempenho ao longo do tempo?','b973f0f747b1b2d2aa1c48be25307ff19cfef9a5ae24a9ca61b18aab1c8fa34c','Q58',0,0,1,'2026-07-23 16:33:36',NULL,'D0');
INSERT INTO pergunta VALUES(191,'Q191',191,24,'Defina Inteligência Artificial e delimite seu escopo em relação à automação convencional.','80b68d914d15eab7999a4b5e487c78c2191365af717f67c4bbdb911e5728bc8d','Q58',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(192,'Q192',192,24,'Qual é a relação entre Aprendizado de Máquina e Redes Neurais Artificiais: são sinônimos, disjuntos, ou um contém o outro? Fundamente.','e7f3a55ae7af673aab40f14616b3dbfad9d73ee08c69fdcdf61a8747a7429ff9','Q58',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(193,'Q193',193,24,'Explique o que são Algoritmos Genéticos, Busca Heurística, Lógica Booleana e Programação Linear, e diga por que nenhum deles é a resposta para "sistemas que aprendem com os dados".','325aade999240c99cab7008d35d24351704eaa8bbed53133431f2e8cc1c8ef09','Q58',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(194,'Q194',194,24,'Enumere os tipos de aprendizado de máquina e descreva o que caracteriza cada um quanto ao dado disponível para o treinamento.','671dd4c5b0f6cc2d215df8c22a03cfc75a3c9a7e97cc08b46007b73718f80cc8',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(195,'Q195',195,24,'Explique o aninhamento entre Inteligência Artificial, Aprendizado de Máquina e Aprendizado Profundo.','21254487a26caedc8d6373d52bbdfff1c779bbe689812de9fb518c12b0bc8496','Q58',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(196,'Q196',196,24,'Um sistema precisa alocar 40 equipes de manutenção em 300 chamados minimizando o custo total de deslocamento, com restrições rígidas conhecidas. Outro precisa prever quais chamados vão reincidir em 30 dias a partir do histórico. Indique a técnica adequada a cada um e justifique.','7c91efcc3ea70a64b018621c122fa092aa151ef7d0d3edb8ae17fbd1f5fa2b99','Q58',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(197,'Q197',197,25,'Qual é o principal objetivo do processo de ETL em uma solução de Data Warehousing?','f26d193e761e0c9474ed78e26f62a10468a849bfaad9d343dccfad1ad83f6768','Q59',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(198,'Q198',198,25,'O objetivo do ETL é criar visualizações e dashboards interativos, realizar análises estatísticas preditivas ou gerenciar o acesso e a segurança dos dados armazenados? Corrija a afirmação e diga a que camada cada uma dessas atividades pertence.','48bd44e9c255f03209ea29b89513bcf8888d6bb6d88487600d7291c99729a931','Q59',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(199,'Q199',199,25,'Distinga ETL de ELT quanto ao momento e ao local em que a transformação ocorre.','8dcd50c6ff61cce22730bbeed63fd4da8db82c0a234c06dafe57f44659b923a2','Q67',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(200,'Q200',200,25,'O ELT é mais eficiente em cenários de volume pequeno, com processamento feito fora do sistema de destino? Corrija a afirmação e indique o cenário em que o ELT de fato vence.','bbf8624cdb5f40bebe905025eb045f314b5749d5c196c700ad06e1f067d84fb7','Q67',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(201,'Q201',201,25,'Em que situação o ETL pode ser mais lento que o ELT? Explique qual característica do sistema de destino determina essa comparação.','5016c439f117458d56daa6cfec98147f420d50c8fe8e93a2d83dec256d3427c2','Q67',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(202,'Q202',202,25,'O que é um Data Warehouse e o que o distingue de um banco transacional quanto à finalidade, ao histórico e ao perfil de consulta?','6af8847247fb64f12e812abcbff810c70fdb2f62ff4bf2ad4ed286048f0ad69e',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(203,'Q203',203,25,'Distinga Data Warehouse, Data Mart e Data Lake quanto a escopo, estrutura do dado armazenado e momento em que o esquema é aplicado.','e479438316dbca7e6be0ea2f36cf66227f7afdc89ea64aa8ff89b18705b71910',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(204,'Q204',204,25,'Uma empresa migra seu DW on-premises para uma plataforma analítica em nuvem com processamento elástico e cobrança por consumo, e ingere 4 TB diários de logs semiestruturados. Indique se ETL ou ELT é a escolha adequada, o que muda no pipeline e qual risco de governança a mudança introduz.','b4c373190469273d8eadaf3aecff7108b32fd2123093a6c7e2582e5ec856be2a','Q67',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(205,'Q205',205,26,'O que é Business Intelligence e qual é o papel do mapeamento de fontes de dados dentro de um projeto de BI?','eeee608d5dba76539d0c832ff6a800aea726fc2e8dafc253310407e2fcb236a3',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(206,'Q206',206,26,'Coletar dados de todas as fontes disponíveis, sem discriminação, incluindo as que apresentam inconsistências ou baixa relevância, é prática recomendada para maximizar a quantidade de dados no sistema? Fundamente.','5be2f09e909f01ee062907481e0e4b8b8fb1ebf05242a804a5116831abd54637','Q61',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(207,'Q207',207,26,'Enumere as boas práticas de mapeamento de fontes de dados em um projeto de BI.','fcd46f71bf1f5c6e7d4c49015b8c818ad6079c1b79dcf912b49b21043cb8045e','Q61',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(208,'Q208',208,26,'Explique o que se avalia em uma fonte de dados sob os critérios de qualidade, relevância e confiabilidade, e por que os três não se confundem.','67cd82a1095d3d6570fa8030e5551277c07858a304fcf9c8f5d760ed995fc360','Q61',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(209,'Q209',209,26,'Qual o papel da documentação detalhada das fontes — características, formatos e relacionamentos — na governança de dados e em auditorias futuras?','b4e8552c98dca5d1c5d3912aaeb9437186f82ea760e944009227881815ef2896','Q61',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(210,'Q210',210,26,'Que técnicas de elicitação se aplicam ao levantamento de requisitos de BI, e o que a análise de documentos e sistemas legados acrescenta ao que as entrevistas revelam.','61216ba2899eaffc51f7d520a51be764906a578e2cee7ce043e47c2059f52500','Q61',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(211,'Q211',211,26,'Um projeto de BI vai construir o indicador "ticket médio por região". Três sistemas informam faturamento, com regras distintas de cancelamento e sem documentação. Descreva como você conduziria o mapeamento das fontes, o que documentaria e qual prática deve ser explicitamente evitada.','1b06c50d7b299cc4fac87491c89c33e807e300090327b868ca5017b38a0887a7','Q61',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(212,'Q212',212,27,'O que é um Sistema de Suporte à Decisão e a quem ele se destina?','095c586217da6881d48bd2d7f9173851c1b9dbdb03d6c2a14db26d54cc1c9243',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(213,'Q213',213,27,'Defina problema estruturado, semiestruturado e não estruturado, dando um exemplo organizacional de cada.','ae1865434fafdcbba0ffb5f24be3b8127b6bcfa45a1545e282905e9a881e0bbe','Q60',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(214,'Q214',214,27,'Os SSDs são adequados apenas a problemas estruturados, ideais apenas para não estruturados, ou mais eficazes apenas em semiestruturados? Responda qual é a abrangência correta e por que as outras três formulações são restritivas demais.','a79dc5836b06895c523f776e91a2a3f1496482d6d6d99e69568cdc9818af2548','Q60',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(215,'Q215',215,27,'Qual é o papel da intuição e do julgamento humano na operação de um SSD, e por que "suporte" à decisão não é sinônimo de "decisão automatizada"?','76e9fa79668f9b067566c241c18f1a598ec2e12648b2b7c1962338c1d961a2ad','Q60',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(216,'Q216',216,27,'Os SSDs são limitados a problemas de uma única área funcional da organização? Fundamente.','ae99598cbe96af3b2851237757bfaf1ca809facf6afe6e947686e317a944307a','Q60',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(217,'Q217',217,27,'Um diretor quer um sistema que recomende o preço de venda de cada produto considerando custo, demanda histórica, ações da concorrência e percepção de marca. Classifique o problema quanto à estruturação, indique o que o SSD pode entregar e o que necessariamente fica com o decisor humano.','4d4ca9806942780c554f8f7ca08a95affb947af06d27623a0de3866ed0d6a2d5','Q60',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(218,'Q218',218,28,'Distinga OLTP de OLAP quanto ao perfil de carga, ao volume por consulta e ao objetivo de cada um.','d6becf53b68cffbab543f81c5c1386ce1be289b37f35ea2c39b0eb34ae905934',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(219,'Q219',219,28,'Qual abordagem é usada principalmente em sistemas transacionais e qual em sistemas de apoio à decisão: relacional ou multidimensional? Fundamente.','3031d3fc756388b8c5a91484f88a290b3880ace0979e26927516f19f455c0435','Q65',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(220,'Q220',220,28,'Em qual das duas abordagens os dados são organizados em cubos? Explique o que o cubo acrescenta em relação à organização em tabelas.','b3177faa8d07f468dfc19ece0a50ff6f6c41d2a98df771b6a751a3dd540032eb','Q65',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(221,'Q221',221,28,'Defina dimensão, métrica e agregação no contexto multidimensional, e explique por que a afirmação de que a abordagem multidimensional não suporta somas e médias é o oposto de sua finalidade.','eb3fdcf0a7bccfb5d74ced6b20382a208bebd102ecdd5e5614f084579186f76b','Q65',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(222,'Q222',222,28,'Bancos NoSQL seguem estritamente as propriedades ACID? Explique o que a maioria deles adota no lugar.','f4fc61f4119da4117ad06b79ede1331b4ab22c9b6b3e8d38d6b0c4ef5aee8ea8','Q66',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(223,'Q223',223,28,'Enumere os tipos de bancos NoSQL e dê um caso de uso característico de cada um.','1ef747b26a8ce1db05ee82d002ba6f6a0c70a27ddc856556494f24be80e2d973','Q66',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(224,'Q224',224,28,'Bancos NoSQL são a melhor escolha para sistemas como ERPs e CRMs? Fundamente pelo perfil de dados e de transações desses sistemas.','1b0fd8872e7aaf57c9111e3cf9d826df030bb666269573167edf60e14f3027a1','Q66',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(225,'Q225',225,28,'Enuncie as propriedades ACID e as propriedades BASE, e explique o que o teorema CAP obriga a escolher em um sistema distribuído sujeito a partição.','c5d1839a0963f3571ca1f822ffb58b4a08672b2d9a80f73f548e220e9765768e','Q66',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(226,'Q226',226,28,'Distinga escalabilidade horizontal de vertical e explique por que a horizontal é apontada como ponto forte dos bancos NoSQL.','4f3b7e6bb315ca887cd9ddb9d9a88574dcb04b9465a2ccce93136ee90e6c175e','Q66',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(227,'Q227',227,28,'Um marketplace precisa de: (i) registro de pedidos com garantia transacional entre estoque e pagamento; (ii) catálogo com atributos variáveis por categoria e leitura massiva; (iii) recomendação por relações entre usuários e produtos. Indique o tipo de banco adequado a cada necessidade e justifique.','75290b81b285f96bfdd8c39ce9526191ec5cd715745ae32641919b27936389cc','Q66',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(228,'Q228',228,29,'Qual política de controle de acesso baseia seu procedimento na comparação de rótulos de segurança com autorizações que indicam quais entidades têm direito de acessar determinados recursos?','0d581ad87375de3c6f67b2468aa8156c7a698840ac77137b3b1f610850725d44','Q62',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(229,'Q229',229,29,'Distinga controle de acesso discricionário de mandatório quanto a quem define a permissão e à possibilidade de o proprietário do recurso repassar acesso a terceiros.','ccda5df98a508b715446676282985cd0ad7a2e55e314b8e1aa4449db7de00333','Q62',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(230,'Q230',230,29,'Descreva o controle de acesso baseado em papéis: sobre o que a permissão é concedida e qual vantagem administrativa isso traz.','7e2c5c3e68b3afb3c3450150becf6aa058bb8fb9ed2e1c7f8a917c9f87814ed9','Q62',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(231,'Q231',231,29,'O princípio do privilégio mínimo é uma política de controle de acesso, no mesmo plano de DAC, MAC e RBAC? Explique o que ele de fato é.','949be577b446a9d79d7369f2e8977192370e0ce2929dd1025d49c26f43e966a6','Q62',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(232,'Q232',232,29,'Distinga autenticação de autorização, indicando a pergunta que cada uma responde e a ordem em que ocorrem.','d45c314dda47cf8ebcfa47355e9d2b1398b24e98ad8cfbb4e50fdbe3499f4a56',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(233,'Q233',233,29,'Descreva o controle de acesso baseado em atributos e diga o que ele oferece que o RBAC não oferece.','84fcca60a091f354e70fb9886c8f93468e994dc192a39c0d05ef83439d6a9c56',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(234,'Q234',234,29,'Um sistema militar exige que documentos rotulados como "secreto" só sejam lidos por usuários com habilitação igual ou superior, sem que o autor do documento possa liberar acesso a quem quiser. Indique a política adequada, explique por que DAC não serve e como o RBAC se encaixaria ou não.','169656d60051f1ee20b09b132bffa8a53174178210b1d30d29e68c23b22f6ec7','Q62',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
INSERT INTO pergunta VALUES(235,'Q235',235,30,'O que é a OWASP e o que representa a lista OWASP Top 10?','a93064da91a59758fac5fa0fb9b20ed99b4b4d77f3c87953f92cf347e58c2fd6','Q63',0,0,1,'2026-07-23 16:33:36',NULL,'D1');
INSERT INTO pergunta VALUES(236,'Q236',236,30,'Enumere as dez categorias do OWASP Top 10:2021.','48a8d16426743acc374d88b83ae7fc21f421f5d894db161891d5bf7df3484a4f','Q63',0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(237,'Q237',237,30,'O que é Server-Side Request Forgery, como o ataque acontece e por que o servidor é o instrumento da exploração?','ae6bce49d96d7b2e2632aecdbb4fbc0c949f270993fd1d1714f74c09b12b2adc','Q63',1,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(238,'Q238',238,30,'"Proteção da cadeia de suprimentos de software", "proteção do ambiente de engenharia", "treinamento operacional" e "uso de recursos de linguagens e frameworks" são categorias do OWASP Top 10:2021? Para as que não são, indique a categoria real que mais se aproxima.','e2dd9f02dc2658b6025fd2e571f66d26debe36e12e582188db9baf6e530c7cd2','Q63',1,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(239,'Q239',239,30,'Distinga Broken Access Control de Identification and Authentication Failures, indicando em que momento da requisição cada falha se manifesta.','7d86447fc15e1af6dd8afc7f370d376c4ca6a4547c8ef59c4e534770794081a2','Q63',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(240,'Q240',240,30,'Distinga Insecure Design de Security Misconfiguration: qual das duas não se corrige com ajuste de parâmetro e por quê.','9fb1ce015615a381e6cc14d64896849f994d2bfbc451fb5caad6c0d11e8ccf86','Q63',0,0,1,'2026-07-23 16:33:36',NULL,'D2');
INSERT INTO pergunta VALUES(241,'Q241',241,30,'Indique as categorias que entraram no Top 10 em 2021 e as que mudaram de posição ou foram absorvidas em relação à edição de 2017.','cb91a9c54eb79d57526996de3ca13ed081193c923a41c7e19fc1c43550d7a93d',NULL,0,0,1,'2026-07-23 16:33:36',NULL,'D3');
INSERT INTO pergunta VALUES(242,'Q242',242,30,'Uma aplicação permite que o usuário informe uma URL para importar uma imagem de perfil, e o servidor faz a requisição a essa URL. Um atacante informa um endereço interno da rede da empresa e recebe de volta o conteúdo. Classifique a vulnerabilidade na taxonomia do Top 10:2021 e indique duas mitigações.','821dcfbfb3588cbb544e8ffe8941d37f47cf0fd0d8ff8945e55ca04486ab04ae','Q63',0,1,1,'2026-07-23 16:33:36',NULL,'D4');
CREATE VIEW v_fila AS
SELECT
  p.codigo,
  s.codigo AS secao,
  s.titulo AS secao_titulo,
  p.enunciado,
  p.tag_prova,
  p.eh_distrator,
  p.eh_caso,
  a.proxima_revisao,
  CAST(julianday('now','localtime') - julianday(a.proxima_revisao) AS INTEGER) AS dias_atraso,
  a.repeticoes,
  a.lapsos,
  a.ultima_nota,
  p.id AS pergunta_id
FROM pergunta p
JOIN secao s       ON s.id = p.secao_id
JOIN agendamento a ON a.pergunta_id = p.id
WHERE p.ativa = 1
  AND a.proxima_revisao <= date('now','localtime')
  AND EXISTS (SELECT 1 FROM ponto_chave pc WHERE pc.pergunta_id = p.id)
ORDER BY
  dias_atraso DESC,
  -- distrator vale mais: banca recicla alternativa errada
  (p.eh_distrator * 2 + (p.tag_prova IS NOT NULL)) DESC,
  s.peso_prova DESC,
  p.numero
;
CREATE VIEW v_estatistica_pergunta AS
SELECT
  p.id                       AS pergunta_id,
  COUNT(av.id)               AS tentativas,
  ROUND(AVG(av.nota), 2)     AS nota_media,
  MIN(av.nota)               AS pior_nota,
  MAX(r.respondida_em)       AS ultima_vez
FROM pergunta p
LEFT JOIN resposta  r  ON r.pergunta_id = p.id
LEFT JOIN avaliacao av ON av.resposta_id = r.id
GROUP BY p.id;
CREATE VIEW v_fila_fraquezas AS
SELECT
  p.codigo,
  s.codigo AS secao,
  s.titulo AS secao_titulo,
  p.enunciado,
  p.tag_prova,
  p.eh_distrator,
  p.eh_caso,
  e.tentativas,
  e.nota_media,
  e.pior_nota,
  a.lapsos,
  a.ultima_nota,
  a.proxima_revisao,
  p.id AS pergunta_id
FROM pergunta p
JOIN secao s                  ON s.id = p.secao_id
JOIN agendamento a            ON a.pergunta_id = p.id
JOIN v_estatistica_pergunta e ON e.pergunta_id = p.id
WHERE p.ativa = 1
  AND e.tentativas > 0
  AND e.nota_media < 4
ORDER BY e.nota_media, a.lapsos DESC, s.peso_prova DESC, p.numero;
CREATE VIEW v_gabarito AS
SELECT
  p.codigo   AS pergunta,
  p.id       AS pergunta_id,
  pc.id      AS ponto_chave_id,
  pc.ordem,
  pc.descricao,
  pc.fonte,
  pc.peso,
  pc.essencial,
  pc.revisado
FROM pergunta p
JOIN ponto_chave pc ON pc.pergunta_id = p.id
ORDER BY p.numero, pc.ordem;
CREATE VIEW v_calibracao AS
SELECT
  p.codigo AS pergunta,
  s.codigo AS secao,
  s.titulo AS secao_titulo,
  r.confianca,
  av.nota,
  (r.confianca - av.nota) AS gap,
  CASE
    WHEN r.confianca - av.nota >=  2 THEN 'ilusao de saber'
    WHEN r.confianca - av.nota <= -2 THEN 'subestimou'
    ELSE 'calibrado'
  END AS alerta,
  av.veredito,
  r.respondida_em
FROM resposta  r
JOIN avaliacao av ON av.resposta_id = r.id
JOIN pergunta  p  ON p.id  = r.pergunta_id
JOIN secao     s  ON s.id  = p.secao_id
WHERE r.confianca IS NOT NULL
ORDER BY gap DESC, av.nota;
CREATE VIEW v_desempenho_secao AS
SELECT
  s.codigo AS secao,
  s.titulo,
  s.peso_prova,
  COUNT(DISTINCT p.id)                        AS perguntas,
  COUNT(av.id)                                AS respostas,
  ROUND(AVG(av.nota), 2)                      AS nota_media,
  COUNT(av.id) FILTER (WHERE av.nota <= 2)    AS respostas_ruins,
  ROUND(AVG(r.confianca - av.nota), 2)        AS gap_medio
FROM secao s
JOIN pergunta       p  ON p.secao_id  = s.id AND p.ativa = 1
LEFT JOIN resposta  r  ON r.pergunta_id = p.id
LEFT JOIN avaliacao av ON av.resposta_id = r.id
GROUP BY s.id
ORDER BY nota_media, s.peso_prova DESC;
CREATE VIEW v_cobertura AS
SELECT
  s.codigo AS secao,
  s.titulo,
  s.peso_prova,
  COUNT(*) AS perguntas,
  SUM(CASE WHEN EXISTS (SELECT 1 FROM ponto_chave pc WHERE pc.pergunta_id = p.id)
           THEN 1 ELSE 0 END) AS com_gabarito,
  SUM(CASE WHEN EXISTS (SELECT 1 FROM resposta r WHERE r.pergunta_id = p.id)
           THEN 1 ELSE 0 END) AS ja_respondidas,
  SUM(CASE WHEN NOT EXISTS (SELECT 1 FROM resposta r WHERE r.pergunta_id = p.id)
           THEN 1 ELSE 0 END) AS nunca_vistas
FROM secao s
JOIN pergunta p ON p.secao_id = s.id AND p.ativa = 1
GROUP BY s.id
ORDER BY s.ordem;
CREATE VIEW v_progresso AS
SELECT
  (SELECT COUNT(*) FROM pergunta WHERE ativa = 1)      AS total_perguntas,
  (SELECT COUNT(DISTINCT pergunta_id) FROM ponto_chave) AS com_gabarito,
  (SELECT COUNT(DISTINCT pergunta_id) FROM resposta)    AS ja_respondidas,
  (SELECT COUNT(*) FROM v_fila)                         AS devidas_hoje,
  (SELECT ROUND(AVG(nota), 2) FROM avaliacao)           AS nota_media_geral,
  (SELECT valor FROM config WHERE chave = 'data_prova') AS data_prova,
  CAST(julianday((SELECT valor FROM config WHERE chave = 'data_prova'))
       - julianday('now','localtime') AS INTEGER)       AS dias_para_prova;
CREATE VIEW v_auditoria AS
  SELECT 'reavaliacao' AS problema, p.codigo AS pergunta, r.id AS resposta_id,
         'resposta com ' || COUNT(av.id) || ' avaliacoes' AS detalhe
  FROM resposta r
  JOIN avaliacao av ON av.resposta_id = r.id
  JOIN pergunta  p  ON p.id = r.pergunta_id
  GROUP BY r.id HAVING COUNT(av.id) > 1

UNION ALL
  SELECT 'confianca_antes_da_nota', p.codigo, r.id,
         'confianca em ' || r.confianca_em || ' / nota em ' || av.avaliada_em
  FROM resposta r
  JOIN avaliacao av ON av.resposta_id = r.id
  JOIN pergunta  p  ON p.id = r.pergunta_id
  WHERE r.confianca_em IS NOT NULL AND r.confianca_em < av.avaliada_em

UNION ALL
  -- gabarito escrito depois de já existir resposta: o critério pode ter sido
  -- moldado ao que você escreveu
  SELECT 'gabarito_contaminado', p.codigo, NULL,
         'ponto-chave gerado em ' || pc.gerado_em ||
         ' apos resposta de ' || MIN(r.respondida_em)
  FROM ponto_chave pc
  JOIN pergunta p ON p.id = pc.pergunta_id
  JOIN resposta r ON r.pergunta_id = p.id
  GROUP BY pc.id HAVING pc.gerado_em > MIN(r.respondida_em)

UNION ALL
  SELECT 'sem_avaliacao', p.codigo, r.id, 'respondida em ' || r.respondida_em
  FROM resposta r
  JOIN pergunta p ON p.id = r.pergunta_id
  WHERE NOT EXISTS (SELECT 1 FROM avaliacao av WHERE av.resposta_id = r.id)

UNION ALL
  -- nota generosa demais: a regua diz que 4 ou 5 exige TODOS os pontos
  -- essenciais citados. Torna a escala verificavel em vez de so documentada.
  SELECT 'nota_incoerente', p.codigo, r.id,
         'nota ' || av.nota || ' com ponto essencial ' || ap.status ||
         ': ' || pc.descricao
  FROM avaliacao       av
  JOIN resposta        r  ON r.id  = av.resposta_id
  JOIN pergunta        p  ON p.id  = r.pergunta_id
  JOIN avaliacao_ponto ap ON ap.avaliacao_id = av.id
  JOIN ponto_chave     pc ON pc.id = ap.ponto_chave_id
  WHERE av.nota >= 4 AND pc.essencial = 1 AND ap.status IN ('faltou','errou')
;
CREATE VIEW v_pontos_falhados AS
SELECT
  pc.id      AS ponto_chave_id,
  p.codigo   AS pergunta,
  s.codigo   AS secao,
  s.titulo   AS secao_titulo,
  pc.descricao,
  pc.fonte,
  pc.essencial,
  COUNT(*) FILTER (WHERE ap.status = 'citou')              AS vezes_citou,
  COUNT(*) FILTER (WHERE ap.status = 'faltou')             AS vezes_faltou,
  COUNT(*) FILTER (WHERE ap.status = 'errou')              AS vezes_errou,
  COUNT(*) FILTER (WHERE ap.status = 'parcial')            AS vezes_parcial,
  COUNT(*) FILTER (WHERE ap.status IN ('faltou','errou'))  AS vezes_falhou,
  COUNT(*)                                                 AS vezes_avaliado,
  ROUND(100.0 * COUNT(*) FILTER (WHERE ap.status = 'citou')
        / COUNT(*), 0)                                     AS pct_citou,
  ROUND(100.0 * COUNT(*) FILTER (WHERE ap.status = 'faltou')
        / COUNT(*), 0)                                     AS pct_faltou,
  ROUND(100.0 * COUNT(*) FILTER (WHERE ap.status = 'errou')
        / COUNT(*), 0)                                     AS pct_errou,
  ROUND(100.0 * COUNT(*) FILTER (WHERE ap.status = 'parcial')
        / COUNT(*), 0)                                     AS pct_parcial,
  ROUND(100.0 * COUNT(*) FILTER (WHERE ap.status IN ('faltou','errou'))
        / COUNT(*), 0)                                     AS pct_falha
FROM ponto_chave     pc
JOIN pergunta        p  ON p.id  = pc.pergunta_id
JOIN secao           s  ON s.id  = p.secao_id
JOIN avaliacao_ponto ap ON ap.ponto_chave_id = pc.id
GROUP BY pc.id
HAVING vezes_falhou > 0
ORDER BY vezes_falhou DESC, pct_falha DESC;
CREATE VIEW v_sugestao_ponto AS
WITH recentes AS (
  SELECT
    ap.ponto_chave_id,
    ap.status,
    ROW_NUMBER() OVER (PARTITION BY ap.ponto_chave_id
                        ORDER BY av.avaliada_em DESC, av.id DESC) AS rn
  FROM avaliacao_ponto ap
  JOIN avaliacao av ON av.id = ap.avaliacao_id
),
base AS (
  SELECT
    pc.id      AS ponto_chave_id,
    p.codigo   AS pergunta,
    s.codigo   AS secao,
    s.titulo   AS secao_titulo,
    pc.descricao,
    pc.fonte,
    pc.essencial,
    p.eh_distrator,
    COUNT(*)                                                  AS vezes_avaliado,
    COUNT(*) FILTER (WHERE ap.status IN ('faltou','errou'))   AS vezes_falhou,
    COUNT(*) FILTER (WHERE ap.status = 'errou')                AS vezes_errou,
    ROUND(100.0 * COUNT(*) FILTER (WHERE ap.status IN ('faltou','errou'))
          / COUNT(*), 0)                                      AS pct_falha,
    ROUND(AVG(av.nota) FILTER (WHERE ap.status IN ('faltou','errou')), 2)
                                                                AS nota_media_quando_falha,
    r.status                                                   AS status_mais_recente
  FROM ponto_chave     pc
  JOIN pergunta        p  ON p.id  = pc.pergunta_id
  JOIN secao           s  ON s.id  = p.secao_id
  JOIN avaliacao_ponto ap ON ap.ponto_chave_id = pc.id
  JOIN avaliacao       av ON av.id = ap.avaliacao_id
  JOIN recentes         r ON r.ponto_chave_id = pc.id AND r.rn = 1
  GROUP BY pc.id
)
-- amostra >=3 avaliacoes do ponto, ponto ainda falhando na tentativa mais
-- recente (SM-2 nao corrigiu sozinho) e taxa de falha >=60% no historico.
-- Bifurcacao: essencial, concepcao errada ('errou') ou distrator real da
-- prova nunca viram sugestao de remocao -- so pergunta dedicada. So se
-- nenhuma dessas bandeiras vale e a nota nao cai quando o ponto falha e
-- que a remocao entra como candidata.
SELECT
  *,
  CASE
    WHEN essencial = 1                THEN 'pergunta dedicada — essencial'
    WHEN vezes_errou > 0              THEN 'pergunta dedicada — concepcao errada'
    WHEN eh_distrator = 1             THEN 'pergunta dedicada — distrator real da prova'
    WHEN nota_media_quando_falha >= 4 THEN 'sugerir remocao do ponto'
    ELSE 'revisar classificacao essencial'
  END AS sugestao
FROM base
WHERE vezes_avaliado >= 3
  AND status_mais_recente != 'citou'
  AND pct_falha >= 60
ORDER BY pct_falha DESC, vezes_falhou DESC
;
CREATE VIEW v_frequencia_notas_secao AS
SELECT
  s.codigo AS secao,
  s.titulo,
  s.peso_prova,
  COUNT(av.id) AS respostas,
  COUNT(av.id) FILTER (WHERE av.nota = 0) AS nota_0,
  COUNT(av.id) FILTER (WHERE av.nota = 1) AS nota_1,
  COUNT(av.id) FILTER (WHERE av.nota = 2) AS nota_2,
  COUNT(av.id) FILTER (WHERE av.nota = 3) AS nota_3,
  COUNT(av.id) FILTER (WHERE av.nota = 4) AS nota_4,
  COUNT(av.id) FILTER (WHERE av.nota = 5) AS nota_5
FROM secao s
JOIN pergunta      p  ON p.secao_id = s.id AND p.ativa = 1
LEFT JOIN resposta  r  ON r.pergunta_id = p.id
LEFT JOIN avaliacao av ON av.resposta_id = r.id
GROUP BY s.id
ORDER BY s.peso_prova DESC, s.ordem;
CREATE TRIGGER trg_sm2 AFTER INSERT ON avaliacao
BEGIN
  UPDATE agendamento SET
    facilidade = MAX(1.3,
      facilidade + (0.1 - (5 - NEW.nota) * (0.08 + (5 - NEW.nota) * 0.02))),
    repeticoes = CASE WHEN NEW.nota < 3 THEN 0 ELSE repeticoes + 1 END,
    lapsos     = CASE WHEN NEW.nota < 3 THEN lapsos + 1 ELSE lapsos END,
    intervalo_dias = CASE
        WHEN NEW.nota < 3   THEN 1
        WHEN repeticoes = 0 THEN 1
        WHEN repeticoes = 1 THEN 6
        ELSE MAX(1, CAST(ROUND(intervalo_dias * facilidade) AS INTEGER))
      END,
    ultima_nota   = NEW.nota,
    atualizado_em = datetime('now','localtime')
  WHERE pergunta_id = (SELECT pergunta_id FROM resposta WHERE id = NEW.resposta_id);

  -- segunda instrução: agora intervalo_dias já é o novo
  UPDATE agendamento SET
    proxima_revisao = date('now','localtime','+' || intervalo_dias || ' days')
  WHERE pergunta_id = (SELECT pergunta_id FROM resposta WHERE id = NEW.resposta_id);
END
;
CREATE TRIGGER trg_confianca_depois_da_nota
BEFORE UPDATE OF confianca ON resposta
WHEN NEW.confianca IS NOT NULL
 AND NOT EXISTS (SELECT 1 FROM avaliacao WHERE resposta_id = NEW.id)
BEGIN
  SELECT RAISE(ABORT,
    'Confianca so pode ser registrada depois que a nota ja estiver gravada em avaliacao.');
END;
CREATE TRIGGER trg_confianca_timestamp
AFTER UPDATE OF confianca ON resposta
WHEN NEW.confianca IS NOT NULL AND NEW.confianca_em IS NULL
BEGIN
  UPDATE resposta SET confianca_em = datetime('now','localtime') WHERE id = NEW.id;
END;
CREATE TRIGGER trg_resposta_imutavel
BEFORE UPDATE OF texto, pergunta_id, respondida_em ON resposta
BEGIN
  SELECT RAISE(ABORT,
    'resposta.texto e imutavel: registre uma nova resposta em vez de editar.');
END;
CREATE TRIGGER trg_avaliacao_imutavel BEFORE UPDATE ON avaliacao
BEGIN
  SELECT RAISE(ABORT,
    'avaliacao e imutavel: para reavaliar, insira uma nova linha.');
END;
CREATE TRIGGER trg_resposta_sem_delete BEFORE DELETE ON resposta
BEGIN
  SELECT RAISE(ABORT, 'respostas nao podem ser apagadas.');
END;
CREATE TRIGGER trg_avaliacao_sem_delete BEFORE DELETE ON avaliacao
BEGIN
  SELECT RAISE(ABORT, 'avaliacoes nao podem ser apagadas.');
END;
CREATE TRIGGER trg_pergunta_agenda AFTER INSERT ON pergunta
BEGIN
  INSERT INTO agendamento (pergunta_id) VALUES (NEW.id);
END;
CREATE INDEX ix_ponto_chave_pergunta ON ponto_chave(pergunta_id);
CREATE INDEX ix_resposta_pergunta ON resposta(pergunta_id);
CREATE INDEX ix_resposta_sessao   ON resposta(sessao_id);
CREATE INDEX ix_resposta_data     ON resposta(respondida_em);
CREATE INDEX ix_avaliacao_resposta ON avaliacao(resposta_id);
CREATE INDEX ix_avaliacao_ponto_pc ON avaliacao_ponto(ponto_chave_id);
CREATE INDEX ix_agendamento_proxima ON agendamento(proxima_revisao);
CREATE INDEX ix_pergunta_secao ON pergunta(secao_id);
COMMIT;
