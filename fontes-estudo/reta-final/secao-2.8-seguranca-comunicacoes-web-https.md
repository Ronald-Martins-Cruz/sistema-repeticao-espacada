# Segurança em Comunicações Web (HTTPS, SSL/TLS e Criptografia)

> Item **18** ("*Protocolos HTTPS, SSL/TLS*") do bloco *Desenvolvimento de Sistemas*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.8** do banco de questões.

---

## 1. O Protocolo HTTPS (*Hypertext Transfer Protocol Secure*)

O **HTTPS** é a versão segura do protocolo HTTP. Tecnicamente, não se trata de um protocolo de aplicação completamente novo, mas sim do **HTTP tradicional operando encapsulado sobre uma camada criptográfica de transporte (TLS/SSL)**, utilizando por padrão a **porta TCP 443** (em oposição à porta 80 do HTTP puro).

```
  ┌────────────────────────────────────────────────────────┐
  │       Camada de Aplicação (HTTP, REST, JSON, HTML)     │
  ├────────────────────────────────────────────────────────┤
  │       Camada de Segurança Criptográfica (TLS)          │  ◄── Adição do HTTPS
  │         • Handshake  • Criptografia Simétrica/Assim.   │
  ├────────────────────────────────────────────────────────┤
  │       Camada de Transporte (TCP — Porta 443)           │
  ├────────────────────────────────────────────────────────┤
  │       Camada de Rede (IP)                              │
  └────────────────────────────────────────────────────────┘
```

### 1.1 As Três Garantias Fundamentais do HTTPS
Ao trafegar sobre TLS, a comunicação entre o navegador do cliente e o servidor web passa a usufruir de três garantias canônicas de segurança:

1. **Confidencialidade (Privacidade):**
   * Os dados trafegados (URLs, cabeçalhos, cookies de sessão, corpos de requisições POST e respostas) são cifrados.
   * Impede que terceiros que monitorem a rede (provedores de internet, administradores de roteadores Wi-Fi públicos ou atacantes com sniffers) consigam ler o conteúdo das mensagens (*anti-eavesdropping*).

2. **Integridade:**
   * Garante que nenhum dado foi alterado, corrompido, truncado ou injetado por intermediários maliciosos durante o trânsito (*anti-tampering*).
   * A integridade é assegurada por códigos de autenticação de mensagens baseados em hash criptográfico (**MAC / HMAC** ou cifras autenticadas como AES-GCM). Qualquer bit alterado no caminho invalida o pacote no receptor.

3. **Autenticação (Identidade):**
   * Garante ao cliente que ele está se comunicando exatamente com o servidor correspondente ao domínio solicitado (e não com um impostor na rede).
   * Elimina o risco de ataques do tipo *Man-in-the-Middle* (MitM) e falsificação de DNS (*DNS spoofing*).

---

## 2. Criptografia Simétrica vs Criptografia Assimétrica

O TLS atinge alto nível de segurança e excelente desempenho combinando duas classes de criptografia fundamentais:

```
CRIPTOGRAFIA SIMÉTRICA (Chave Única)
  Mensagem Clara ──► [ Cifragem com Chave Secreta K ] ──► Mensagem Cifrada ──► [ Decifragem com Chave Secreta K ] ──► Mensagem Clara

CRIPTOGRAFIA ASSIMÉTRICA (Par de Chaves)
  Mensagem Clara ──► [ Cifragem com Chave Pública B ] ──► Mensagem Cifrada ──► [ Decifragem com Chave Privada B ] ──► Mensagem Clara
```

### 2.1 Criptografia Simétrica (Chave Secreta)
* **Mecânica:** Utiliza uma **única chave secreta compartilhada** tanto para cifrar quanto para decifrar a informação.
* **Vantagens:** **Altíssimo desempenho computacional e velocidade**. É centenas a milhares de vezes mais rápida que a assimétrica, sendo perfeitamente viável para cifrar fluxos contínuos de grandes volumes de dados (vídeos, páginas, payloads pesados).
* **Desvantagens:** **O problema da distribuição de chaves (*Key Exchange*)**. Se cliente e servidor nunca se comunicaram antes, como transmitir a chave secreta pela internet sem que ela seja interceptada por um atacante?
* **Algoritmos representativos:** **AES** (*Advanced Encryption Standard* - 128/256 bits), **ChaCha20**, 3DES (legado), DES (obsoleto).

### 2.2 Criptografia Assimétrica (Chave Pública / Privada)
* **Mecânica:** Utiliza um **par matemático de chaves correlacionadas**:
  * **Chave Pública:** Pode ser distribuída abertamente para qualquer pessoa. Usada para *cifrar* dados destinados ao dono do par ou para *verificar assinaturas* feitas por ele.
  * **Chave Privada:** Deve ser mantida em segredo absoluto pelo seu titular. Usada para *decifrar* dados cifrados com a chave pública correspondente ou para *assinar digitalmente* documentos.
* **Vantagens:** Resolve elegantemente a distribuição de chaves e viabiliza autenticação e assinaturas digitais com **não repúdio**.
* **Desvantagens:** **Elevado custo computacional e lentidão extrema**. Cifrar grandes arquivos exclusivamente com algoritmos assimétricos sobrecarregaria o processador do servidor e tornaria a navegação inviável.
* **Algoritmos representativos:** **RSA**, **ECC** (*Elliptic Curve Cryptography*), **Diffie-Hellman / ECDHE** (troca de chaves), DSA.

### 2.3 A Arquitetura Híbrida do TLS
O TLS resolve o dilema operando como um **sistema criptográfico híbrido**:
1. Na fase inicial de conexão (**Handshake**), utiliza a **criptografia assimétrica** (junto a certificados digitais) para autenticar a identidade do servidor e negociar com segurança uma chave temporária.
2. Uma vez estabelecida essa chave de sessão compartilhada (*Session Key*), o canal comuta imediatamente para a **criptografia simétrica** (como AES-GCM), garantindo velocidade máxima na transferência dos dados da aplicação.

---

## 3. A Relação Histórica entre SSL e TLS

* **SSL (*Secure Sockets Layer*):** Desenvolvido originalmente pela Netscape na década de 1990 (versões 1.0 não lançada, 2.0 em 1995 e 3.0 em 1996).
* **TLS (*Transport Layer Security*):** Padronizado pela IETF (*Internet Engineering Task Force*) a partir da RFC 2246 (1999) como o **sucessor oficial do SSL 3.0**. O TLS incorporou correções de vulnerabilidades, cifras mais robustas e independência em relação a fornecedores proprietários.

### 3.1 Correção de Mitos Clássicos de Prova
> **Mito 1: "SSL e TLS são usados conjuntamente, cabendo ao SSL a autenticação e ao TLS a criptografia."**  
> **Falso:** SSL e TLS são protocolos completos e independentes. O TLS **substituiu integralmente** o SSL. Não operam em conjunto.

> **Mito 2: "SSL e TLS são intercambiáveis, oferecendo o mesmo nível de segurança."**  
> **Falso:** O SSL é uma tecnologia obsoleta, insegura e formalmente proibida na internet. Todas as versões do SSL possuem falhas criptográficas conhecidas e não devem ser utilizadas. O termo "certificado SSL" continua sendo usado no mercado apenas por hábito comercial, mas o protocolo em execução sob o capô é estritamente o TLS.

---

## 4. Versões Depreciadas vs Versões Recomendadas

As normas da IETF e os órgãos de segurança da informação (NIST, PCI-DSS) estabelecem de forma categórica o ciclo de vida dos protocolos:

```
┌────────────────────────────────────────────────────────────────────────┐
│ PROIBIDOS E DEPRECIADOS (Inseguros — NÃO USAR)                         │
│ • SSL 2.0 (Depreciado em 2011 — RFC 6176)                              │
│ • SSL 3.0 (Depreciado em 2015 — RFC 7568 / Vulnerabilidade POODLE)     │
│ • TLS 1.0 (Depreciado em 2021 — RFC 8996 / Cifras fracas CBC, SHA-1)   │
│ • TLS 1.1 (Depreciado em 2021 — RFC 8996 / Cifras fracas CBC, MD5)     │
├────────────────────────────────────────────────────────────────────────┤
│ PADRÕES MODERNOS EM USO RECOMENDADO                                    │
│ • TLS 1.2 (RFC 5246 — Amplamente suportado, suporte a AES-GCM e SHA-256)│
│ • TLS 1.3 (RFC 8446 — Padrão atual: mais seguro, mais rápido, 1-RTT)   │
└────────────────────────────────────────────────────────────────────────┘
```

* **Destaque do TLS 1.3:** Eliminou suporte a cifras legadas vulneráveis (como RSA estático para troca de chaves e cifras em modo CBC), tornou obrigatório o *Forward Secrecy* via Diffie-Hellman efêmero (ECDHE) e reduziu o tempo de estabelecimento da conexão de dois *round-trips* (2 RTT) para apenas um (1 RTT ou 0-RTT na retomada de sessão).

---

## 5. Certificados Digitais X.509 e Infraestrutura de Chaves Públicas (PKI)

O certificado digital do servidor é a credencial eletrônica no padrão internacional **ITU-T X.509** que vincula uma chave pública à identidade de um domínio da web.

### 5.1 Conteúdo de um Certificado Digital de Servidor
1. **Identificação do Titular (*Subject / Common Name / SAN*):** O domínio completo do site (ex.: `*.dataprev.gov.br` ou `sistema.dataprev.gov.br`).
2. **Chave Pública do Servidor:** A chave pública que será usada pelo cliente para iniciar a troca de segredos.
3. **Identificação do Emissor (*Issuer*):** Nome da Autoridade Certificadora (CA) que emitiu o certificado.
4. **Período de Validade:** Datas estritas de início (*Not Before*) e expiração (*Not After*).
5. **Número de Série e Versão do Padrão X.509.**
6. **Algoritmo de Assinatura:** Algoritmo hash e criptográfico utilizado (ex.: `SHA256withRSA` ou `ECDSA-SHA384`).
7. **Assinatura Digital da Autoridade Certificadora (CA):** O valor criptográfico gerado pela CA ao assinar os dados do certificado com a **chave privada da CA**.

### 5.2 O que o Navegador Verifica ao Receber o Certificado
Ao receber o certificado do servidor web, o navegador executa quatro verificações automáticas e sucessivas:
1. **Correspondência de Domínio:** Verifica se a URL digitada na barra de endereços corresponde exatamente ao nome registrado no campo *Subject* ou *Subject Alternative Name* (SAN) do certificado.
2. **Prazo de Validade:** Compara a data e hora do relógio local do sistema com a janela `Not Before` e `Not After`.
3. **Cadeia de Confiança (*Trust Chain*):** Valida a assinatura digital do certificado utilizando a chave pública da Autoridade Certificadora emissora, subindo a cadeia hierárquica até encontrar uma **Autoridade Certificadora Raiz confiável (*Root CA*)** presente no repositório de confiança nativo do sistema operacional ou do navegador.
4. **Estado de Revogação:** Consulta se o certificado não foi cancelado antes do vencimento por perda de chaves ou comprometimento, através de Listas de Certificados Revogados (**CRL**) ou pelo protocolo de consulta online de status (**OCSP** / *OCSP Stapling*).

---

## 6. O Handshake TLS (Passo a Passo)

O *Handshake* é a fase de negociação inicial na qual cliente e servidor estabelecem os parâmetros de segurança antes do envio de qualquer dado da aplicação:

```
  CLIENTE (Navegador)                              SERVIDOR WEB
          │                                              │
      (1) │ ─────────── ClientHello ───────────────────► │
          │   (Versões TLS, Cipher Suites, ClientRandom) │
          │                                              │
      (2) │ ◄────────── ServerHello ──────────────────── │
          │   (Versão escolhida, Cipher Suite, SrvRandom)│
          │ ◄────────── Certificate ──────────────────── │
          │   (Certificado X.509 + Chave Pública)        │
          │ ◄────────── ServerKeyExchange (ECDHE) ────── │
          │ ◄────────── ServerHelloDone ──────────────── │
          │                                              │
      (3) │ ── [Validação da Cadeia do Certificado] ──  │ (Autenticação do Servidor)
          │                                              │
      (4) │ ────────── ClientKeyExchange ──────────────► │ (Troca do Segredo)
          │                                              │
      (5) │ ────────── [Cálculo da Chave de Sessão] ───► │ (Ambos geram Master Secret)
          │ ────────── ChangeCipherSpec ───────────────► │
          │ ────────── Finished (Cifrado) ─────────────► │
          │                                              │
      (6) │ ◄───────── ChangeCipherSpec ──────────────── │
          │ ◄───────── Finished (Cifrado) ────────────── │
          │                                              │
   ═══════╪══════════════════════════════════════════════╪═══════
          │ ◄══════ DADOS DA APLICAÇÃO (HTTP) ═════════► │ (Criptografia Simétrica Ativa)
          │         (Cifrados com AES / ChaCha20)        │
```

1. **`ClientHello`:** O cliente envia as versões de TLS que suporta, a lista de suítes de algoritmos de cifragem aceitas (*cipher suites*) e um valor aleatório de 32 bytes (*Client Random*).
2. **`ServerHello` + `Certificate`:** O servidor seleciona a melhor versão mútua de TLS, escolhe a suíte de cifras, gera seu próprio número aleatório (*Server Random*) e envia seu **Certificado Digital X.509**.
3. **Autenticação do Servidor:** O navegador do cliente verifica a assinatura da CA no certificado e valida a integridade e legitimidade da identidade do servidor.
4. **Troca de Parâmetros de Chave (*Key Exchange*):** As partes trocam parâmetros criptográficos (via Diffie-Hellman efêmero/ECDHE) para gerar um segredo compartilhado (*Pre-Master Secret*).
5. **Geração da Chave de Sessão Simétrica:** Utilizando o *Client Random*, o *Server Random* e o *Pre-Master Secret*, ambas as partes derivam independentemente a **chave simétrica de sessão (*Session Key*)**.
6. **`ChangeCipherSpec` e `Finished`:** Ambas as partes trocam mensagens confirmando que todo o tráfego a partir daquele momento estará protegido por **criptografia simétrica**. O handshake se encerra e o tráfego HTTP convencional se inicia.

---

## 7. O que o HTTPS Garante vs O que NÃO Garante

Uma das armadilhas prediletas das bancas de concurso é induzir o candidato a superestimar as garantias do HTTPS:

| O que o HTTPS EFETIVAMENTE Garante | O que o HTTPS NÃO Garante (Falácias do "Cadeado") |
|---|---|
| ✅ **Canal de Trânsito Seguro:** Dados trafegam criptografados e íntegros entre o navegador do usuário e o servidor web. | ❌ **Idoneidade do Site:** Sites maliciosos, golpes e páginas de *phishing* podem perfeitamente emitir certificados TLS válidos e exibir o cadeado de segurança. |
| ✅ **Autenticidade do Domínio:** O servidor conectado detém as chaves criptográficas legítimas do domínio exibido na URL. | ❌ **Segurança da Aplicação:** Não impede vulnerabilidades de código como SQL Injection, Cross-Site Scripting (XSS) ou CSRF. |
| ✅ **Proteção contra escuta de rede e MitM.** | ❌ **Segurança dos Dados em Repouso:** Não garante que o banco de dados do servidor está criptografado nem que os dados não serão vazados por invasão interna no servidor. |
| | ❌ **Segurança no Dispositivo do Usuário:** Não protege contra malwares, keyloggers ou extensões espiãs instaladas no computador/celular do usuário. |
