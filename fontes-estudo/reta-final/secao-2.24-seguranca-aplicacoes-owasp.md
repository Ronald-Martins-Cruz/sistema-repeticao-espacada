# Segurança de Aplicações Web (OWASP Top 10)

> Item **38** ("*Ciclo de Vida de Desenvolvimento Seguro (SDL), OWASP Top 10*") do bloco *Segurança da Informação*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.24** do banco de questões.

---

## 1. O que é a OWASP e o OWASP Top 10

A **OWASP** (*Open Web Application Security Project*) é uma fundação global sem fins lucrativos dedicada a melhorar a segurança de software através de projetos comunitários abertos, metodologias, ferramentas e documentações técnicas.

O **OWASP Top 10** é o documento de conscientização em segurança de aplicações mais reconhecido no mundo. Ele representa uma lista consensual atualizada periodicamente que consolida os **dez riscos e categorias de vulnerabilidades mais críticos em aplicações web**, baseando-se em dados massivos de telemetria de vulnerabilidades reais coletados junto a empresas de segurança e na opinião de especialistas globais.

---

## 2. As Dez Categorias Oficiais do OWASP Top 10:2021

Na edição **OWASP Top 10:2021**, a taxonomia passou por uma grande reestruturação para focar em causas-raiz em vez de sintomas isolados:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        OWASP TOP 10:2021                               │
├─────────┬──────────────────────────────────────────────────────────────┤
│ A01     │ Broken Access Control (Quebra de Controle de Acesso)         │
│ A02     │ Cryptographic Failures (Falhas Criptográficas)               │
│ A03     │ Injection (Injeção — inclui XSS)                             │
│ A04     │ Insecure Design (Design Inseguro) — [NOVA]                   │
│ A05     │ Security Misconfiguration (Configuração Incorreta)           │
│ A06     │ Vulnerable and Outdated Components (Componentes Desatualiz.) │
│ A07     │ Identification and Authentication Failures (Falhas de Aut.)  │
│ A08     │ Software and Data Integrity Failures (Integridade) — [NOVA]  │
│ A09     │ Security Logging and Monitoring Failures (Logs e Monitoram.) │
│ A10     │ Server-Side Request Forgery — SSRF — [NOVA]                  │
└─────────┴──────────────────────────────────────────────────────────────┘
```

### Detalhamento das 10 Categorias:

1. **A01:2021 — Broken Access Control (Quebra de Controle de Acesso):**
   * *Subiu para o 1º lugar*. Ocorre quando as restrições sobre o que usuários autenticados podem fazer não são aplicadas adequadamente.
   * *Exemplos:* Acesso direto a objetos por ID na URL (*IDOR — Insecure Direct Object References*, ex.: mudar `?id=10` para `?id=11` para ver a conta de outro usuário); elevação de privilégios (usuário comum acessando telas administrativas); burla de verificação de permissões no back-end.

2. **A02:2021 — Cryptographic Failures (Falhas Criptográficas):**
   * Anteriormente chamada de *Sensitive Data Exposure*. Foca na proteção de dados sensíveis em trânsito e em repouso.
   * *Exemplos:* Transmissão de senhas e dados de cartão em HTTP claro sem TLS; uso de algoritmos criptográficos obsoletos (MD5, SHA-1, DES); chaves criptográficas embutidas diretamente no código-fonte (*hardcoded keys*).

3. **A03:2021 — Injection (Injeção):**
   * Dados não confiáveis enviados pelo usuário são interpretados como comandos ou instruções pelo interpretador.
   * *Exemplos:* **SQL Injection**, Command Injection, LDAP Injection.
   * *Atenção:* O **XSS (*Cross-Site Scripting*)** deixou de ser uma categoria própria e foi **absorvido dentro de Injeção** na versão 2021.

4. **A04:2021 — Insecure Design (Design Inseguro):**
   * **Nova categoria em 2021**. Representa vulnerabilidades originadas na **fase de concepção e arquitetura** do software, antes de qualquer linha de código ser escrita.
   * *Exemplos:* Ausência de modelagem de ameaças (*threat modeling*); arquitetura de recuperação de senhas baseada em perguntas e respostas fáceis de adivinhar; regras de negócio sem limites conceituais contra fraude.

5. **A05:2021 — Security Misconfiguration (Configuração Incorreta de Segurança):**
   * Falhas de parametrização e endurecimento (*hardening*) no ambiente de execução.
   * *Exemplos:* Contas e senhas padrão de fábrica mantidas em servidores de banco de dados; portas desnecessárias abertas; mensagens de erro detalhadas expondo *stack traces* e versões internas ao usuário final; cabeçalhos de segurança HTTP desabilitados.

6. **A06:2021 — Vulnerable and Outdated Components (Componentes Vulneráveis e Desatualizados):**
   * Uso de bibliotecas de terceiros, frameworks ou dependências desatualizadas que contenham vulnerabilidades públicas conhecidas (CVEs).

7. **A07:2021 — Identification and Authentication Failures (Falhas de Identificação e Autenticação):**
   * Anteriormente *Broken Authentication*. Falhas que permitem a atacantes personificar usuários legítimos.
   * *Exemplos:* Ausência de autenticação multifator (MFA); permissão para senhas fracas; vulnerabilidade a ataques de força bruta (*credential stuffing*); gerenciamento inseguro de tokens de sessão que não expiram.

8. **A08:2021 — Software and Data Integrity Failures (Falhas de Integridade de Software e Dados):**
   * **Nova categoria em 2021**. Código e infraestrutura que realizam atualizações ou processam dados sem validar sua integridade e proveniência.
   * *Exemplos:* Atualizações automáticas de plugins sem assinatura digital; **Desserialização Insegura (*Insecure Deserialization*)**; ataques à cadeia de suprimentos (*supply chain attacks* via bibliotecas corrompidas no npm/pip).

9. **A09:2021 — Security Logging and Monitoring Failures (Falhas de Registro e Monitoramento de Segurança):**
   * Anteriormente *Insufficient Logging & Monitoring*. Falta de registro de eventos críticos de segurança (como tentativas sucessivas de login falho) e ausência de alertas em tempo real para permitir que incidentes sejam detectados e contidos rapidamente.

10. **A10:2021 — Server-Side Request Forgery (SSRF):**
    * **Nova categoria em 2021**. Ocorre quando uma aplicação web lê ou envia dados para uma URL fornecida pelo usuário sem a devida validação de destino, induzindo o servidor a agir como um procurador (*proxy*) involuntário para acessar recursos internos.

---

## 3. Fronteiras Conceituais Críticas para Provas

### 3.1 Broken Access Control (Autorização) vs Identification and Authentication Failures (Autenticação)

| Aspecto | Falhas de Identificação e Autenticação (A07) | Quebra de Controle de Acesso (A01) |
|---|---|---|
| **Pergunta Central** | *"Quem é você?"* | *"O que você tem permissão para fazer?"* |
| **Momento da Manifestação** | **No momento do acesso/login:** O sistema falha em verificar de forma confiável a identidade da pessoa. | **Após o login bem-sucedido:** A identidade foi confirmada, mas o sistema permite ações além dos seus privilégios. |
| **Exemplo Típico** | Um invasor descobre a senha de Maria por força bruta porque o sistema não exige MFA nem bloqueia tentativas. | João faz login legítimo com sua própria conta, mas muda o parâmetro `id_cliente=123` para `id_cliente=456` na URL e visualiza o extrato bancário de Maria. |

---

### 3.2 Insecure Design vs Security Misconfiguration

* **Security Misconfiguration (A05):**
  * O software foi **bem projetado e programado com segurança**, mas foi **mal configurado no ambiente de hospedagem**.
  * **Como se corrige:** Através de **ajuste de parâmetros**, desativação de módulos padrão, fechamento de portas e scripts de automação de *hardening*.
* **Insecure Design (A04):**
  * A falha está na **concepção de regras de negócio e na arquitetura** do projeto. O modelo conceitual possui brechas estruturais (ex.: permitir transferências financeiras sem dupla validação).
  * **Como se corrige:** **NÃO se corrige apenas com configuração de servidor**. Exige redesenho arquitetural, refatoração de código e mudança nas regras de negócio.

---

## 4. Server-Side Request Forgery (SSRF) em Detalhes

### 4.1 Mecânica do Ataque
No SSRF, a aplicação web oferece uma funcionalidade legítima que realiza requisições de rede a partir do servidor (ex.: importar foto de perfil a partir de uma URL informada pelo usuário, processar webhooks ou gerar visualizações prévias de links).

```
   ATACANTE                        SERVIDOR WEB (Vulnerável)                 REDE INTERNA / NUVEM
      │                                       │                                        │
  (1) │ ── Informa URL Maliciosa ───────────► │                                        │
      │    "http://169.254.169.254/meta-data" │                                        │
      │                                       │                                        │
      │                                   (2) │ ── Requisição Interna (Bypass Firewall)──►│
      │                                       │    Servidor busca metadados confidenciais│
      │                                       │                                        │
      │                                   (3) │ ◄─ Retorna Credenciais da Nuvem ───────┤
      │                                       │                                        │
  (4) │ ◄─ Exibe Conteúdo Obtido ──────────── │                                        │
      │    Atacante rouba chaves de acesso!   │                                        │
```

O atacante informa um endereço da **rede interna protegida** (ex.: `http://192.168.1.50/admin` ou o serviço de metadados da nuvem AWS/Azure/GCP no IP de enlace local `http://169.254.169.254/latest/meta-data/`). Como o servidor da aplicação está dentro da rede interna confiável, sua requisição ultrapassa os firewalls de borda e devolve informações altamente confidenciais ao atacante. **O servidor torna-se o instrumento da exploração**.

### 4.2 Duas Mitigações Fundamentais contra SSRF
1. **Validação Estrita de Entrada (*Whitelisting*):** Utilizar listas de permissão estritas para protocolos permitidos (`https` apenas), portas autorizadas e domínios de destino confiáveis.
2. **Bloqueio de Faixas de IPs Privados e Loopback:** Validar no código e em firewalls de saída (*egress filtering*) o bloqueio sistemático de requisições para IPs de loopback (`127.0.0.1`, `localhost`) e para faixas de endereços privados da **RFC 1918** (`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) e de *link-local* (`169.254.0.0/16`).

---

## 5. Evolução do OWASP Top 10 (2017 vs 2021)

* **Novas Categorias em 2021:**
  * `A04:2021 - Insecure Design`
  * `A08:2021 - Software and Data Integrity Failures`
  * `A10:2021 - Server-Side Request Forgery (SSRF)`
* **Categorias Reestruturadas e Absorvidas:**
  * **Cross-Site Scripting (XSS):** Deixou de ser categoria separada (era 7ª em 2017) e foi **incorporada em Injection (A03)**.
  * **Insecure Deserialization:** Deixou de ser categoria separada (era 8ª em 2017) e foi **incorporada em Software and Data Integrity Failures (A08)**.
* **Termos de Mercado que NÃO são Categorias Oficiais:**
  * Expressões como *"Proteção do ambiente de engenharia"*, *"Treinamento operacional"* ou *"Uso de recursos de linguagens"* são boas práticas genéricas de engenharia, mas **NÃO constam na lista oficial do OWASP Top 10:2021**. Já *"Proteção da cadeia de suprimentos de software"* é uma preocupação real incorporada dentro de **Software and Data Integrity Failures (A08)**.
