# SPA e PWA

> Item **13.2** do Anexo I do edital DATAPREV 2026 — *"Tecnologias e práticas frontend web: HTML, CSS, UX, Ajax, frameworks (VueJS, Angular e React)"*. Corresponde ao item **17.2** na numeração contínua da ementa.

---

## 1. SPA (*Single Page Application* — Aplicação de Página Única)

**Definição:**
É uma arquitetura de aplicação web cuja interface é carregada em uma **única página HTML**. A partir do carregamento inicial, toda a navegação, atualização de conteúdo e interação do usuário ocorrem de forma dinâmica no lado do cliente via JavaScript (manipulação do DOM e requisições assíncronas via `fetch`/`AJAX` a APIs), **sem a necessidade de recarregar a página inteira** no navegador.

> **O que define a SPA é a navegação, não a renderização.** A aplicação vive em **uma única instância de documento**, e as trocas de tela não trazem documento novo do servidor. Onde o HTML da *primeira* carga é gerado é uma escolha independente — ver 1.4.

### 1.1 Principais características

* **Roteamento no cliente (*Client-Side Routing*):** A URL muda no navegador, mas quem intercepta e renderiza a visualização correspondente é o JavaScript local
* **Renderização no cliente:** Cada tela subsequente é montada pelo JavaScript no navegador. A carga inicial pode ou não vir pronta do servidor (ver 1.4).
* **Desacoplamento Front-end/Back-end:** O servidor geralmente atua apenas como fornecedor de dados (APIs REST/GraphQL), trafegando **JSON** em vez de páginas prontas, enquanto o front-end cuida da renderização e do estado da aplicação.
* **Experiência do usuário (UX):** Transições fluidas e rápidas, similares às de um aplicativo desktop.
* **Estado persistente:** Como o documento não é recarregado, o estado da aplicação (sessão, carrinho, filtros, formulário em preenchimento) **sobrevive à troca de telas** — o que não acontece no modelo multipágina.
* **Exemplos de ecossistema:** React, Vue.js, Angular, Svelte.

### 1.2 Vantagens

* Resposta percebida quase instantânea **depois** da carga inicial: só dados trafegam, não a página inteira.
* Menor consumo de banda por interação e menor carga de processamento no servidor.
* Separação clara entre times de front-end e back-end; a mesma API serve web, mobile e terceiros.
* Comportamento *app-like*, com transições e animações controladas.

### 1.3 Desvantagens

* **Carga inicial pesada:** o *bundle* JavaScript precisa ser baixado, interpretado e executado antes de qualquer conteúdo aparecer — piora o *First Contentful Paint* e o *Time to Interactive*.
* **SEO e indexação frágeis:** o HTML entregue vem praticamente vazio; rastreador que não executa JavaScript enxerga página em branco. Mitiga-se com SSR, SSG ou pré-renderização.
* **Dependência de JavaScript:** com o script bloqueado ou falho, a aplicação simplesmente não funciona.
* **Histórico e botão "voltar":** precisam ser implementados manualment; é fonte clássica de defeito.
* **Acessibilidade:** trocas de rota não disparam a leitura automática que um novo documento dispararia — foco e anúncio de mudança de tela exigem tratamento explícito (regiões `aria-live`, gestão de foco).
* **Consumo de memória no cliente** em sessões longas e risco de vazamento de memória.

### 1.4 Onde o HTML é gerado: CSR, SSR e SSG

São **três estratégias de renderização**, aplicáveis a uma SPA sem que ela deixe de ser SPA:

| Estratégia | Quem monta o HTML | Quando | Carga inicial | SEO |
| :--- | :--- | :--- | :--- | :--- |
| **CSR** (*Client-Side Rendering*) | Navegador | Em runtime, a cada visita | Lenta (cascata HTML → JS → API) | Frágil |
| **SSR** (*Server-Side Rendering*) | Servidor | A cada requisição | Rápida | Bom |
| **SSG** (*Static Site Generation*) | Servidor | Uma vez, no *build* | Mais rápida | Bom |

* **CSR** é o comportamento padrão de uma SPA "crua": o servidor devolve uma casca (`<div id="root"></div>` mais o `<script>`) e o JavaScript escreve todo o DOM.
* **SSR e SSG** atuam **na porta de entrada**: o HTML da primeira rota chega pronto e, em seguida, o *bundle* JavaScript **hidrata** (*hydration*) essa marcação — religa estado e *event listeners* ao HTML já existente, em vez de remontá-lo. Da segunda navegação em diante, o comportamento volta a ser o de uma SPA comum.
* Aplicação que roda o mesmo código nos dois lados é chamada **universal** (ou *isomórfica*). Frameworks: Next.js (React), Nuxt (Vue), Angular Universal, SvelteKit.

### 1.5 O oposto da SPA: a MPA

**MPA (*Multi-Page Application*)** é o modelo tradicional: **cada navegação requisita um novo documento HTML** ao servidor, que o renderiza por completo. É o funcionamento de aplicações em PHP, Rails, Django, JSF e afins.

| | SPA | MPA |
| :--- | :--- | :--- |
| **Documentos** | Um só, atualizado no lugar | Um novo a cada navegação |
| **Renderização das telas** | Cliente | Servidor |
| **Estado entre telas** | Preservado | Perdido a cada carga |
| **Tráfego por interação** | Só dados (JSON) | Página inteira |
| **SEO** | Exige SSR/SSG | Natural |
| **Carga inicial** | Pesada | Leve |

> **Atenção:** o oposto da SPA é a **MPA**, não o SSR. Renderizar no servidor e navegar em página única são coisas compatíveis.

---

## 2. PWA (*Progressive Web App* — Aplicação Web Progressiva)

**Definição:**
É uma aplicação web construída com tecnologias padrão (HTML, CSS e JavaScript) que incorpora um conjunto de APIs e padrões modernos para oferecer **recursos, confiabilidade e experiência de uso semelhantes aos de um aplicativo nativo** (mobile ou desktop), diretamente a partir do navegador — sem depender de loja de aplicativos.

Não é uma tecnologia única, e sim um **conjunto de práticas e APIs web**. O termo foi cunhado por Alex Russell e Frances Berriman, do Google, em **2015**.

### 2.1 Por que "progressiva"?

A letra **P** vem de ***progressive enhancement*** (melhoria progressiva): a aplicação **funciona em qualquer navegador**, mesmo nos que não suportam os recursos avançados, e vai **ganhando capacidades conforme o suporte disponível**. Em um navegador antigo, é um site comum; em um moderno, instala-se, funciona offline e recebe notificações. Não há "tudo ou nada".

### 2.2 Os três pilares técnicos

1. **Service Worker**
   * Script executado em **thread separada**, independente da interface, que atua como **proxy de rede** entre a aplicação e o servidor — é o que permite **interceptar requisições** e respondê-las a partir do cache.
   * Responsável por cache programável, funcionamento **offline**, sincronização em segundo plano e recepção de push.
   * **Não acessa o DOM** e é orientado a eventos; o navegador pode encerrá-lo e reativá-lo a qualquer momento.
   * Ciclo de vida próprio: `install` → `activate` → `fetch`. Seu **escopo** é limitado pelo diretório em que é registrado.

2. **Web App Manifest (`manifest.json`)**
   * Arquivo de configuração que define metadados: `name` / `short_name`, `icons`, `start_url`, `scope`, `display` (`fullscreen`, `standalone`, `minimal-ui`, `browser`), `orientation`, `theme_color` e `background_color`.
   * É o que permite **instalar a aplicação na tela inicial** e executá-la sem a barra do navegador, **sem necessidade obrigatória de uma loja** (*App Store* / *Google Play*).

3. **HTTPS (contexto seguro)**
   * Exigência de segurança para garantir integridade e confidencialidade dos dados — e requisito técnico: o **Service Worker só se registra em contexto seguro** (*secure context*), pois um proxy de rede sobre HTTP seria vetor de ataque.
   * Exceção prevista na especificação: `localhost`, para desenvolvimento.

> **Critérios de instalabilidade** = HTTPS + manifest válido (com nome, ícones e `start_url`) + Service Worker registrado.

### 2.3 Capacidades habilitadas pelos pilares

Não são pilares — são **consequências** deles, sobretudo do Service Worker:

* **Funcionamento offline e em rede instável:** respostas servidas do cache. Estratégias usuais: *cache-first*, *network-first* e *stale-while-revalidate*.
* **Notificações Push (*Web Push*):** capacidade de reengajar o usuário mesmo com o navegador fechado. Combina **Push API** (recebimento) mais **Notifications API** (exibição) mais o Service Worker (quem escuta o evento). Depende de permissão explícita do usuário.
* **Sincronização em segundo plano (*Background Sync*):** enfileira ações feitas offline e as envia quando a conexão volta.
* **Instalação na tela inicial** e execução em janela própria, sem a moldura do navegador.

### 2.4 Demais características canônicas

* **Responsiva:** adapta-se a qualquer tamanho de tela.
* **Independente de conectividade:** funciona offline ou em rede ruim.
* **Atualizável:** o Service Worker busca a versão nova em segundo plano; não depende de o usuário atualizar pela loja.
* **Segura:** servida sobre HTTPS.
* **Descobrível:** é indexável por buscadores, ao contrário de um app de loja.
* **Linkável:** tem URL — compartilha-se por link, sem instalação.
* ***App-like*:** interações e navegação no estilo de aplicativo.

### 2.5 Vantagens

* Uma só base de código para web, mobile e desktop.
* Dispensa loja de aplicativos, suas taxas e seus ciclos de revisão.
* Atualização imediata e transparente para todos os usuários.
* Instalação leve (não há pacote de dezenas de MB) e sem consumo relevante de armazenamento.
* Indexável pelos buscadores e compartilhável por URL.

### 2.6 Limitações

* **Acesso a recursos nativos mais restrito** que o de um aplicativo nativo (integrações profundas com o sistema operacional, alguns sensores, Bluetooth), embora o leque venha crescendo.
* **Suporte desigual no iOS/Safari:** o web push só chegou no iOS 16.4 (2023) e apenas para PWAs instaladas na tela inicial; não há convite automático de instalação (o usuário precisa usar "Adicionar à Tela de Início"); e há políticas agressivas de expurgo do armazenamento de sites pouco usados.
* **Ausência da vitrine da loja**, o que prejudica a descoberta pelo usuário.
* **Desempenho inferior** em cargas gráficas ou de processamento pesadas.

### 2.7 PWA × aplicativo híbrido (WebView)

Distinção cobrada com frequência, porque ambos usam tecnologias web:

| | **PWA** | **Híbrido (WebView)** |
| :--- | :--- | :--- |
| **Execução** | No próprio navegador | Em um contêiner nativo (*WebView*) empacotado |
| **Distribuição** | Pelo navegador, via URL | Pela loja de aplicativos |
| **Instalação** | "Adicionar à tela inicial" | Pacote `.apk` / `.ipa` |
| **Acesso nativo** | APIs web disponíveis no navegador | Plugins e *bridges* nativos (acesso mais amplo) |
| **Atualização** | Imediata, pelo servidor | Sujeita à revisão da loja |
| **Exemplos** | — | Apache Cordova, Ionic sobre Capacitor |

---

## 3. Relação entre SPA e PWA

* **SPA** é um padrão de **arquitetura de renderização/navegação** (como a aplicação troca de telas e consome dados).
* **PWA** é um conjunto de **capacidades de experiência e distribuição** (instalação, uso offline, notificações nativas).
* **São conceitos independentes (ortogonais)**, e a independência vale nos dois sentidos:
  * Uma **SPA não é automaticamente PWA** — sem Service Worker e manifest, ela não instala, não funciona offline e não recebe push.
  * Uma **PWA não precisa ser SPA** — uma aplicação multipágina (MPA) vira PWA bastando HTTPS, manifest e Service Worker.

### 3.1 Por que aparecem juntas: o padrão *App Shell*

O **App Shell** é a arquitetura que faz a ponte entre os dois: separa-se a **casca** da interface (HTML, CSS e JS mínimos do cabeçalho, do menu e do esqueleto de layout), que o Service Worker guarda em cache e serve instantaneamente, do **conteúdo dinâmico**, buscado por API e injetado depois. O resultado é abertura imediata, mesmo offline.

Como a SPA já mantém uma casca fixa e troca apenas o conteúdo interno, o encaixe é natural — daí a combinação frequente. Mas é **conveniência prática, não definição**.

---

## 4. Pontos de atenção para a prova

* Assertivas **absolutas** costumam ser as falsas: *"em uma SPA o servidor nunca gera HTML"* e *"SPA e SSR são mutuamente excludentes"* estão **erradas** (ver 1.4). Já *"a SPA carrega um único documento HTML e o atualiza via JavaScript, sem recarregar a página"* está **correta**.
* PWA descrita como *"uma tecnologia"* ou *"um framework"* é **falsa** — é um conjunto de práticas e APIs.
* Cuidado ao contar os **pilares**: são **três** (Service Worker, Manifest, HTTPS). Notificação push é capacidade derivada, não pilar.
* "Equivalente ao aplicativo nativo" é exagero: o correto é **semelhante** ou **próximo**, com acesso nativo ainda mais restrito.
* **CSR é sigla ambígua.** Aqui significa *Client-Side Rendering*; no item **14 do edital** (HTTPS, SSL/TLS) significa ***Certificate Signing Request*** — o bloco PKCS#10 com a chave pública e os dados de identificação, assinado com a chave privada e enviado à Autoridade Certificadora. O item do edital é que desempata.
