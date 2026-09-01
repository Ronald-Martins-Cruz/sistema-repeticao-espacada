# Métricas, Estimativas e Mensuração de Software (Ponto de Função e Story Points)

> Item **15** ("*Metodologia de Ponto de Função e Story Points*") do bloco *Desenvolvimento de Sistemas*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.9** do banco de questões.

---

## 1. As Três Grandezas da Engenharia de Software: Tamanho, Esforço e Duração

Um dos conceitos mais importantes em gestão e métricas de software é a distinção rigorosa entre três dimensões frequentemente confundidas:

```
┌─────────────────────────┐      ┌─────────────────────────┐      ┌─────────────────────────┐
│         TAMANHO         │ ───► │         ESFORÇO         │ ───► │         DURAÇÃO         │
│  Volume funcional puro  │      │  Trabalho humano total  │      │   Tempo de calendário   │
│   (Pontos de Função)    │      │  (Horas, Homens-Mês)    │      │     (Dias, Meses)       │
└─────────────────────────┘      └─────────────────────────┘      └─────────────────────────┘
         ▲                                ▲                                ▲
         │                                │                                │
Independente de tecnologia        Depende da produtividade         Depende da quantidade
 e da equipe executora             da equipe e das ferramentas      de pessoas e do paralelismo
```

1. **Tamanho de Software:**
   * Medida do volume intrínseco de funcionalidades (tamanho funcional) ou de código (tamanho estrutural) a ser entregue.
   * **É independente da equipe que vai implementar**, da linguagem de programação adotada, do nível de senioridade dos desenvolvedores ou da metodologia de trabalho.
   * Unidades típicas: **Pontos de Função (PF)**, Linhas de Código (*SLOC*).

2. **Esforço de Desenvolvimento:**
   * Quantidade total de trabalho humano necessária para construir o software com o tamanho especificado.
   * **Depende fortemente do contexto:** senioridade da equipe, familiaridade com o domínio, ferramentas utilizadas e produtividade histórica.
   * Unidades típicas: **Horas-Homem (HH)**, Pessoas-Mês (*Person-Months*).

3. **Duração (Prazo / Tempo de Calendário):**
   * Tempo cronológico transcorrido do início ao fim do projeto.
   * Depende do esforço total, do tamanho da equipe alocada e do grau de paralelismo possível nas tarefas (limitado pela Lei de Brooks: *"adicionar pessoas a um projeto atrasado o atrasa ainda mais"*).
   * Unidades típicas: **Dias, Semanas, Meses**.

### 1.1 A Fórmula de Conversão de Tamanho em Esforço
A conversão entre tamanho e esforço é mediada pela **taxa de produtividade** da organização:

$$\text{Esforço (em Horas)} = \frac{\text{Tamanho (em PF)}}{\text{Produtividade (em PF/Hora)}} = \text{Tamanho (em PF)} \times \text{Taxa de Entrega (em Horas/PF)}$$

* *Exemplo prático:* Se um módulo possui tamanho medido em **100 Pontos de Função** e a equipe possui uma taxa de entrega histórica de **10 horas por Ponto de Função**, o esforço estimado será de **1.000 horas-homem**.

---

## 2. Análise de Pontos de Função (APF / IFPUG)

Criada por Allan Albrecht na IBM (1979) e padronizada internacionalmente pelo **IFPUG** (*International Function Point Users Group* - norma **ISO/IEC 20926**), a **Análise de Pontos de Função (APF)** é uma técnica de medição do **tamanho funcional** de software.

### 2.1 O que a APF Mede e quais são seus Insumos
* **O que mede:** A quantidade de funcionalidades de negócio entregues ao usuário, baseando-se estritamente na **visão externa do usuário** (*User View*) e nos requisitos funcionais.
* **Insumos de cálculo:** Especificação de requisitos de negócio, diagramas de entidades e relacionamentos (modelo lógico de dados) e fluxos de navegação/telas das transações.
* **O que a APF NÃO mede diretamente:** Aspectos puramente técnicos ou de arquitetura interna (linguagem, padrão de projeto, hardware, índices de banco de dados).

### 2.2 Os 5 Tipos de Função na APF (IFPUG)
A APF categoriza todas as funções de um sistema em dois grandes grupos: **Funções do Tipo Dados** (armazenamento lógico) e **Funções do Tipo Transação** (processamento de dados).

```
                            ANÁLISE DE PONTOS DE FUNÇÃO (APF)
                                           │
             ┌─────────────────────────────┴─────────────────────────────┐
             ▼                                                           ▼
     FUNÇÕES DE DADOS                                           FUNÇÕES DE TRANSAÇÃO
  (Armazenamento Lógico)                                      (Processamento de Negócio)
             │                                                           │
   ┌─────────┴─────────┐                               ┌─────────────────┼─────────────────┐
   ▼                   ▼                               ▼                 ▼                 ▼
  ALI                 AIE                             EE                SE                CE
(Arquivo Lógico    (Arquivo de                     (Entrada          (Saída            (Consulta
   Interno)     Interface Externa)                 Externa)          Externa)          Externa)
```

#### A. Funções do Tipo Dados (Armazenamento Lógico)
1. **ALI — Arquivo Lógico Interno (*Internal Logical File - ILF*):**
   * Grupo de dados logicamente relacionados, reconhecível pelo usuário, **mantido e atualizado dentro da fronteira da aplicação** que está sendo contada.
   * *Exemplo:* Tabela/Entidade de `Clientes`, `Contratos` ou `Produtos` mantida pelo próprio sistema.
2. **AIE — Arquivo de Interface Externa (*External Interface File - EIF*):**
   * Grupo de dados logicamente relacionados, reconhecível pelo usuário, **mantido por outra aplicação externa**, referenciado e consultado pela aplicação sob contagem apenas para leitura.
   * *Exemplo:* Tabela de `Tabelas de Alíquotas da Receita Federal` ou base de `CEP dos Correios` consumida pelo sistema.

#### B. Funções do Tipo Transação (Processamento de Dados)
3. **EE — Entrada Externa (*External Input - EI*):**
   * Processo elementar que processa dados vindos de fora da fronteira do sistema com o objetivo primário de **manter um ou mais ALIs** (inclusão, alteração, exclusão de dados) ou alterar o comportamento do sistema.
   * *Exemplo:* Tela de `Cadastrar Novo Usuário`, `Alterar Senha`, `Importar Arquivo de Pedidos`.
4. **SE — Saída Externa (*External Output - EO*):**
   * Processo elementar que envia dados ou informações de controle para fora da fronteira do sistema, cujo processamento contém **fórmulas matemáticas, cálculos derivados, criação de dados derivados ou atualização de estado de ALIs**.
   * *Exemplo:* `Relatório Consolidado de Vendas com Cálculo de Médias e Margem de Lucro`, `Emissão de Fatura com Cálculo de Juros e Multas`.
5. **CE — Consulta Externa (*External Inquiry - EQ*):**
   * Processo elementar que recupera dados de ALIs ou AIEs e envia para fora da fronteira do sistema **sem executar cálculos matemáticos derivados** nem alterar o estado de nenhum ALI (recuperação direta e simples de dados).
   * *Exemplo:* `Tela de Busca de Clientes por CPF`, `Listagem Simples de Produtos`.

---

## 3. Story Points e Métricas Ágeis

No desenvolvimento ágil (Scrum, Extreme Programming - XP), o **Story Point** é uma unidade de medida **relativa e abstrata** utilizada para estimar o esforço total, a complexidade técnica, o volume de trabalho e as incertezas associadas à conclusão de um item do backlog (História de Usuário).

### 3.1 A Dinâmica de Estimativa e a Subjetividade
* **Técnica Usual:** Sessões de estimativa colaborativa como o **Planning Poker**, onde a equipe discute a história de usuário e vota anonimamente utilizando cartas baseadas na **sequência modificada de Fibonacci** (1, 2, 3, 5, 8, 13, 21, 34, 55...).
* **Natureza Relativa:** A equipe define uma história padrão pequena como referência (ex.: "Criar tela de login simples = 2 Story Points") e estima as demais por comparação direta de complexidade ("Esta funcionalidade é cerca de quatro vezes mais trabalhosa que o login, logo vale 8 pontos").
* **Subjetividade Contextual:** A pontuação incorpora o conhecimento prático, a experiência tecnológica específica e os riscos percebidos **pela própria equipe**.

### 3.2 O Ponto Fraco Crucial: Incomparabilidade entre Equipes
> **Atenção — Ponto Crítico de Prova:** **Story Points NÃO são comparáveis entre equipes diferentes.**
>
> A velocidade (*velocity*) de uma equipe (ex.: 40 pontos por sprint) não pode ser confrontada com a velocidade de outra equipe (ex.: 25 pontos por sprint). A régua de Story Points é uma convenção **interna e calibrada exclusivamente para aquele time específico**.
>
> Tentar usar Story Points para comparar produtividade entre fornecedores ou entre times distintos é um erro metodológico clássico, pois qualquer equipe pode simplesmente "inflar" suas estimativas para parecer mais produtiva.

---

## 4. Comparativo Sistemático: APF vs Story Points

| Critério | Análise de Pontos de Função (APF) | Story Points |
|---|---|---|
| **O que Mede** | **Tamanho funcional puro** sob a ótica do usuário. | **Esforço relativo, complexidade e incerteza** sob a ótica do time de desenvolvimento. |
| **Grau de Objetividade** | **Objetivo e Normatizado:** Baseado no manual de regras estritas do IFPUG (ISO/IEC 20926). | **Subjetivo:** Baseado no consenso, percepção e experiência dos membros da equipe. |
| **Independência da Equipe** | **Totalmente independente:** O tamanho é o mesmo se o software for feito por seniores ou juniores, em Java ou C++. | **Totalmente dependente:** Varia de acordo com o contexto e calibragem do time específico. |
| **Reprodutibilidade e Auditoria** | **Alta:** Dois contadores certificados chegam a contagens praticamente idênticas para a mesma especificação. | **Nula fora do time:** Não permite auditoria independente de terceiros. |
| **Comparabilidade entre Projetos** | **Total:** Permite benchmarking, comparação de produtividade e precificação uniforme de mercado. | **Inexistente:** Não se pode comparar pontos entre diferentes equipes. |
| **Momento Ideal de Aplicação** | Contratos formais, licitações públicas, precificação de software e escopo fechado. | Planejamento de sprints de curto prazo (1 a 4 semanas), gestão de capacidade e ritmo sustentável do time ágil. |

---

## 5. Casos de Aplicação e Decisão de Métricas

### Caso 1: Contratação Pública de Fábrica de Software por Escopo Fechado e Medição Auditável
* **Cenário:** Um órgão público vai licitar a contratação de uma fábrica de software para desenvolver um grande sistema corporativo. O contrato exige pagamento por produto entregue com medição auditável por uma empresa terceira de auditoria de métricas.
* **Técnica Correta:** **Análise de Pontos de Função (APF)**.
* **Justificativa:** A APF oferece regras internacionais formais, objetividade matemática e independência da tecnologia e da equipe executora. Qualquer auditor de métricas certificado pode recontar os pontos e validar o valor a ser faturado com segurança jurídica.

### Caso 2: Planejamento de Sprints de Duas Semanas de um Time Ágil Interno
* **Cenário:** Uma equipe interna multidisciplinar trabalha com Scrum e precisa planejar o trabalho que cabe na próxima sprint de 15 dias.
* **Técnica Correta:** **Story Points (Planning Poker)**.
* **Justificativa:** Story Points capturam a complexidade técnica imediata, o esforço real percebido por quem vai codificar e a incerteza do dia a dia, permitindo calibrar o ritmo de entrega (*velocity*) sem a burocracia de contagens formais de APF a cada tarefa diária.

> **O erro de trocar as técnicas:** Usar Story Points em contratos de fábrica de software cria risco jurídico inaceitável e vulnerabilidade a fraudes; usar APF para planejar o dia a dia de uma sprint de duas semanas engessa o processo ágil e introduz custos de contagem desproporcionais para micro-tarefas.
