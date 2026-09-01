# Sistemas de Suporte à Decisão (SSD / DSS)

> Item **26** ("*Sistemas de suporte a decisão e gestão de conteúdo*") do bloco *Inteligência de Negócios (Business Intelligence)*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.21** do banco de questões.

---

## 1. O que é um Sistema de Suporte à Decisão (SSD / DSS)

Um **Sistema de Suporte à Decisão (SSD)** — internacionalmente conhecido como *Decision Support System* (**DSS**) — é um sistema de informação computacional interativo, flexível e adaptável, projetado especificamente para **auxiliar gestores e tomadores de decisão a utilizar dados e modelos analíticos/matemáticos na resolução de problemas complexos**.

### 1.1 A quem se destina?

* Destina-se primariamente aos **níveis tático (gerência média) e estratégico (diretoria e executivos)** da organização, além de **analistas de negócio e especialistas de planejamento**.
* Enquanto os Sistemas de Processamento de Transações (SPT / OLTP) atendem à operação rotineira do dia a dia (nível operacional), o SSD foca no planejamento, na análise de cenários futuros e na resolução de problemas gerenciais.

```
                  PIRÂMIDE ORGANIZACIONAL E SISTEMAS DE INFORMAÇÃO

                       ▲
                      / \
                     /   \     NÍVEL ESTRATÉGICO (Diretoria / Alta Gestão)
                    / ESS \    • Sistemas de Apoio Executivo (ESS / EIS)
                   /───────\   • Problemas Não Estruturados
                  /         \
                 /   SSD /   \ NÍVEL TÁTICO (Gerentes / Analistas)
                /     DSS     \• Sistemas de Suporte à Decisão (SSD / DSS)
               /───────────────\• Problemas Semiestruturados e Analíticos
              /                 \
             /     SPT / OLTP    \ NÍVEL OPERACIONAL (Supervisores / Atendentes)
            /   (Transacional)    \• Sistemas de Processamento de Transações
           /───────────────────────\• Problemas Estruturados e Rotineiros
```

---

## 2. Taxonomia de Problemas de Decisão (Herbert Simon)

A clássica classificação de **Herbert Simon** (expandida por Gorry e Scott-Morton) categoriza as decisões organizacionais quanto ao seu grau de estruturação:

```
┌─────────────────────────┐      ┌─────────────────────────┐      ┌─────────────────────────┐
│  PROBLEMA ESTRUTURADO   │      │ PROBLEMA SEMIESTRUTURADO│      │ PROBLEMA NÃO ESTRUTURADO│
│   (Totalmente claro)    │      │  (Parte lógica + Humana)│      │  (Alta incerteza/Inédito│
├─────────────────────────┤      ├─────────────────────────┤      ├─────────────────────────┤
│ • Regras determinísticas│      │ • Parte calculável por  │      │ • Sem procedimentos    │
│ • Resolução algorítmica │      │   modelos e dados       │   padronizados         │
│ • Decisão programável   │      │ • Parte exige intuição  │      │ • Depende de intuição,  │
│                         │      │   e julgamento humano   │   visão e experiência   │
├─────────────────────────┤      ├─────────────────────────┤      ├─────────────────────────┤
│ Ex: Cálculo de folha de │      │ Ex: Precificação de     │      │ Ex: Entrada em novo     │
│ pagamento, ponto de     │      │ produto, orçamento      │   mercado internacional,│
│ reposição de estoque.   │      │ anual de vendas.        │   fusão de empresas.    │
└─────────────────────────┘      └─────────────────────────┘      └─────────────────────────┘
```

1. **Problemas Estruturados (Programáveis / Rotineiros):**
   
   * Todas as etapas, variáveis, critérios e procedimentos de resolução são conhecidos, repetitivos e claros.
   * Não exigem intuição: um algoritmo determinístico pode chegar à resposta ideal sozinho.
   * *Exemplos:* Emissão de folha de pagamento, cálculo de reabastecimento automático de estoque por ponto de pedido pré-fixado, cálculo de imposto retido na fonte.

2. **Problemas Semiestruturados:**
   
   * Uma parte do problema possui dados históricos e pode ser resolvida por formulações matemáticas/estatísticas, mas **outra parte relevante depende do julgamento qualitativo, da intuição e da experiência do tomador de decisão**.
   * *Exemplos:* **Definição de preço de venda de um novo produto** (os custos de produção e a elasticidade histórica são calculáveis por modelos, mas a percepção da marca e as reações da concorrência exigem avaliação do decisor humano); aprovação de limite de crédito especial para grandes empresas.

3. **Problemas Não Estruturados:**
   
   * Problemas inéditos, com alto grau de incerteza, múltiplos fatores imponderáveis e sem método ou procedimento predefinido de resolução.
   * *Exemplos:* Decisão de abrir filial em outro país, fusão ou aquisição de uma empresa concorrente, plano de contenção de uma crise de relações públicas inédita.

---

## 3. Abrangência e Eficácia dos SSDs

> **Atenção — Ponto Crítico de Prova:** Bancas frequentemente criam assertivas excessivamente restritivas sobre o escopo dos SSDs.

* **Onde o SSD é MAIS EFICAZ:** Nos **problemas semiestruturados**, pois é exatamente na união entre o poder computacional de processamento de dados/modelos e a capacidade de discernimento do cérebro humano que o sistema entrega seu valor máximo.
* **Abrangência Ampla:** Embora tenham foco principal em decisões semiestruturadas, os SSDs **também dão suporte valioso a decisões não estruturadas** (gerando simulações de cenários prospectivos) e podem incorporar módulos que resolvem rotinas estruturadas.
* Dizer que os SSDs são *"adequados apenas a problemas estruturados"* ou *"exclusivos para não estruturados"* é incorreto.

---

## 4. O Papel do Julgamento Humano: "Suporte" NÃO é "Automação"

A palavra **Suporte** na sigla SSD é intencional e define a fronteira operacional do sistema:

### 4.1 Suporte à Decisão vs Decisão Automatizada

* **Decisão Automatizada:** O sistema de computador toma a decisão sozinho e a executa diretamente no banco de dados sem qualquer intervenção humana (ex.: sistema antifraude que bloqueia instantaneamente um cartão com base em regras rígidas).
* **Sistema de Suporte à Decisão (SSD):** O sistema **NÃO toma a decisão final**. O SSD atua como uma ferramenta analítica e interativa que processa grandes volumes de dados, projeta tendências e avalia opções, mas a **escolha da decisão e a responsabilidade final cabem exclusivamente ao gestor humano**.

### 4.2 Recursos Típicos de Simulação de um SSD

1. **Análise "What-If" (*E se...?*):** O usuário altera variáveis de entrada para observar o impacto no resultado final (ex.: *"E se o custo da matéria-prima subir 12% e o dólar cair 5%, qual será nossa margem de lucro líquido?"*).
2. **Análise de Sensibilidade (*Sensitivity Analysis*):** Avalia quais variáveis de entrada causam maior impacto sobre os resultados do modelo, identificando os fatores mais críticos de risco.
3. **Busca de Metas (*Goal-Seeking Analysis*):** O usuário define o resultado desejado e o sistema calcula quais valores de entrada são necessários para atingi-lo (ex.: *"Para obter um lucro de 2 milhões de reais, quantas unidades precisamos vender a que preço médio?"*).

---

## 5. Abrangência Organizacional dos SSDs

* **Não há limitação funcional:** Os SSDs **NÃO são restritos a uma única área da empresa**.
* Podem ser implantados em **Finanças** (análise de investimentos e fluxo de caixa), **Marketing e Vendas** (segmentação de clientes, precificação e previsão de vendas), **Logística e Produção** (planejamento de rotas e capacidade fabril), **Recursos Humanos** (planejamento de sucessão e retenção de talentos) ou de forma **Corporativa Integrada** cruzando dados de toda a organização.

---

## 6. Estudo de Caso: Precificação Estratégica

> **Cenário:** Um diretor comercial deseja um sistema para precificar um novo produto considerando o custo contábil dos insumos, o histórico de elasticidade-preço, as ações recentes da concorrência e a percepção de valor da marca.

**Análise do Caso:**

* **Classificação do Problema:** Trata-se de um problema **semiestruturado**.
* **O que o SSD entrega (Lado Computacional):**
  * Consolida os custos de fabricação e despesas operacionais.
  * Executa modelos econométricos para estimar a curva de demanda com base em vendas passadas.
  * Executa simulações *What-If* de rentabilidade para diferentes faixas de preço.
* **O que fica NECESSARIAMENTE com o Decisor Humano:**
  * Ponderar a reação psicológica do público em relação ao prestígio da marca.
  * Avaliar se os concorrentes iniciarão uma guerra de preços predatória.
  * Assumir o risco estratégico e bater o martelo sobre a tabela final de preços.
