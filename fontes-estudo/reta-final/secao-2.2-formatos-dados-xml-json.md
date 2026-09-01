# Formatos e Tecnologias de Dados e Marcação (XML, XSLT e JSON)

> Item **9** ("*Padrões XML, XSLT, UDDI, REST e JSON*") do bloco *Desenvolvimento de Sistemas*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.2** do banco de questões.

---

## 1. O Ecossistema XML (*eXtensible Markup Language*)

O **XML** é uma linguagem de marcação extensível recomendada pelo W3C (*World Wide Web Consortium*), projetada para armazenar e transportar dados de maneira estruturada, legível tanto por humanos quanto por máquinas, e independente de plataformas de hardware ou software.

Ao contrário do HTML, que possui um conjunto fixo de tags voltadas à **exibição** e apresentação visual, o XML não define tags prévias: ele é um **meta-formato** onde o desenvolvedor cria suas próprias tags para descrever o **significado semântico** e a estrutura dos dados.

### 1.1 Estrutura e Regras de Formação

Um documento XML organiza seus dados em uma **árvore hierárquica** estrita, composta por nós:
* **Prólogo XML:** Declaração opcional no início do arquivo informando a versão e a codificação (ex.: `<?xml version="1.0" encoding="UTF-8"?>`).
* **Elemento Raiz (*Root Element*):** Todo documento XML **deve conter exatamente um único elemento raiz**, que envelopa todos os demais elementos.
* **Elementos e Conteúdo:** Delimitados por tags de abertura e fechamento (`<tag>conteúdo</tag>`) ou tags de fechamento automático para elementos vazios (`<tag />`).
* **Atributos:** Pares de nome e valor embutidos dentro da tag de abertura para fornecer metadados sobre o elemento (ex.: `<cliente id="104" ativo="true">`). Todo valor de atributo no XML deve obrigatoriamente estar entre aspas (`"` ou `'`).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<pedido id="9823">
    <data>2026-09-01</data>
    <cliente id="501">
        <nome>Ronald Cruz</nome>
        <email>ronald@exemplo.com</email>
    </cliente>
    <itens>
        <item codigo="A12">
            <descricao>Teclado Mecânico</descricao>
            <preco moeda="BRL">350.00</preco>
        </item>
    </itens>
</pedido>
```

### 1.2 Documento Bem-Formado (*Well-Formed*) vs Documento Válido (*Valid*)

Esta é uma das distinções conceituais mais cobradas em concursos:

1. **Documento Bem-Formado (*Well-Formed*):**
   * Atende às **regras sintáticas universais** da especificação XML:
     * Possui um único elemento raiz.
     * Todas as tags abertas são devidamente fechadas.
     * O aninhamento das tags é estritamente correto (sem sobreposição como `<a><b></a></b>`).
     * É sensível a maiúsculas e minúsculas (*case-sensitive*).
     * Os valores de atributos estão entre aspas.
   * Se um documento não for bem-formado, os analisadores (*parsers*) XML interrompem o processamento imediatamente com erro fatal.

2. **Documento Válido (*Valid*):**
   * Além de ser obrigatoriamente bem-formado, o documento **obedece a um esquema ou contrato formal de regras pré-definido** (especificado via DTD ou XSD).
   * A validação verifica se os nomes dos elementos, a ordem das tags, a quantidade de ocorrências (cardinalidade), os atributos obrigatórios e os tipos de dados estão em estrita conformidade com o contrato.

> **Regra de ouro:** Todo documento válido é bem-formado, mas nem todo documento bem-formado é válido.

---

## 2. Contratos, Validação e Navegação no Ecossistema XML

Para garantir interoperabilidade e integridade no intercâmbio de dados entre sistemas corporativos, o ecossistema XML fornece ferramentas robustas de contrato, consulta e validação:

### 2.1 DTD (*Document Type Definition*)
* Mecanismo clássico e mais antigo de definição de estrutura para XML.
* Usa uma **sintaxe própria e não-XML** (herança do SGML).
* **Limitações:** Não suporta tipagem de dados rica (trata quase tudo como texto genérico `CDATA`/`PCDATA`), não oferece suporte nativo a *namespaces* e possui expressividade limitada para regras de cardinalidade complexas.

### 2.2 XSD (*XML Schema Definition* ou *W3C XML Schema*)
* Padrão moderno e predominante para contratos de dados em XML.
* É escrito na **própria sintaxe XML** (documentos com extensão `.xsd`), permitindo que seja manipulado e validado pelas mesmas ferramentas que processam XML.
* **Recursos fundamentais:**
  * **Tipagem forte de dados:** Suporta dezenas de tipos primitivos (`xs:string`, `xs:integer`, `xs:decimal`, `xs:boolean`, `xs:date`, `xs:dateTime`) e permite a criação de tipos complexos derivados.
  * **Restrições e Facetas:** Permite validar faixas de valores (`minInclusive`, `maxInclusive`), tamanhos de strings, listas enumeradas (`enumeration`) e expressões regulares (*patterns* com regex, como máscaras de CPF, CNPJ ou CEP).
  * **Suporte a *Namespaces*:** Permite compor documentos complexos combinando múltiplos esquemas sem colisão de nomes de tags.
  * **Cardinalidade rigorosa:** Controle preciso de mínimo e máximo de ocorrências de um elemento (`minOccurs` e `maxOccurs`).

### 2.3 XPath (*XML Path Language*)
* Linguagem de expressões declarativa usada para **navegar pela hierarquia de nós** de um documento XML e selecionar nós ou conjuntos de nós específicos (elementos, atributos, textos).
* Utiliza uma sintaxe baseada em caminhos similar à de sistemas de arquivos (ex.: `/pedido/itens/item[@codigo='A12']/preco`).
* É a base de navegação e seleção utilizada por tecnologias como XSLT e XQuery.

### 2.4 XQuery (*XML Query Language*)
* Linguagem de consulta desenhada para buscar, extrair e manipular dados em coleções de documentos XML ou bancos de dados nativos XML, análoga ao que o SQL representa para bancos relacionais. Utiliza expressões FLWOR (*For, Let, Where, Order by, Return*).

---

## 3. XSLT (*eXtensible Stylesheet Language Transformations*)

### 3.1 O que é e como opera
**XSLT** é uma linguagem de programação declarativa baseada em XML (especificada pelo W3C) projetada especificamente para **transformar a estrutura de documentos XML** em outros formatos.

O processador XSLT recebe dois insumos:
1. O **documento XML de entrada** (cuja estrutura é interpretada como uma árvore de nós).
2. A **folha de estilos XSLT** (um arquivo `.xsl` contendo regras e modelos de transformação definidos por elementos como `<xsl:template match="...">`, `<xsl:for-each>`, `<xsl:value-of>` e expressões XPath).

O processador percorre a árvore do documento de entrada, aplica as regras de template correspondentes e gera um documento de saída transformado.

```
┌──────────────────┐      ┌─────────────────────────┐
│ Documento XML    │      │ Folha de Estilo XSLT    │
│ de Entrada       │      │ (.xsl / Regras e XPath) │
└─────────┬────────┘      └────────────┬────────────┘
          │                            │
          └──────────────┬─────────────┘
                         ▼
             ┌───────────────────────┐
             │   Processador XSLT    │
             │ (Motor de Conversão)  │
             └───────────┬───────────┘
                         ▼
             ┌───────────────────────┐
             │  Documento de Saída   │
             │ (HTML, XML, CSV, TXT) │
             └───────────────────────┘
```

### 3.2 Formatos de Saída do XSLT
O XSLT é extremamente versátil quanto ao formato do documento resultante. Ele pode gerar:
* **Outro documento XML** (com esquema, hierarquia ou nomenclatura completamente reestruturados para integração entre sistemas legados).
* **HTML / XHTML** (para renderização visual direta em navegadores web).
* **Texto puro não estruturado ou delimitado** (como arquivos de texto simples `.txt`, arquivos separados por vírgula `.csv` ou scripts).
* **XSL-FO (*Formatting Objects*)** (formato intermediário comumente convertido em documentos **PDF** para impressão e relatórios).

> **Atenção — Ponto Crítico de Prova:** O XSLT **opera nativamente sobre documentos XML**. Ele **NÃO** é uma linguagem criada para transformar documentos JSON. Embora existam extensões em versões recentes (XSLT 3.0) para manipulação pontual de JSON, o propósito e a definição canônica do XSLT nas bancas é a transformação de documentos XML.

---

## 4. JSON (*JavaScript Object Notation*)

O **JSON** (padronizado pela RFC 8259 e ECMA-404) é um formato aberto e textual para intercâmbio de dados, derivado da notação de literais de objetos da linguagem JavaScript, mas totalmente **independente de linguagem**.

### 4.1 Tipos de Dados Suportados Nativamente
O JSON define uma gramática intencionalmente minimalista com apenas **6 tipos de dados nativos**:

| Tipo Nativo | Descrição | Exemplo |
|---|---|---|
| **`string`** | Sequência de caracteres Unicode delimitada exclusivamente por **aspas duplas** (`"`) | `"Ronald"`, `"São Paulo"` |
| **`number`** | Número em formato decimal (inteiro ou ponto flutuante em notação científica), sem distinção rígida de tipo | `42`, `3.1415`, `-10`, `1.5e3` |
| **`boolean`** | Valor lógico literal em minúsculas | `true` ou `false` |
| **`array`** | Lista ordenada de zero ou mais valores delimitada por colchetes | `["TI", 100, true]` |
| **`object`** | Coleção não ordenada de pares chave/valor delimitada por chaves, onde a chave é obrigatoriamente uma `string` | `{"id": 1, "ativo": true}` |
| **`null`** | Literal que representa valor vazio ou ausência de valor | `null` |

### 4.2 Tipos Corporativos NÃO Suportados Nativamente e Formas de Contorno
Por ser minimalista, o JSON **não possui tipos de dados primitivos para diversas estruturas comuns em sistemas corporativos**:

1. **Datas e Horas (`Date`, `DateTime`, `Timestamp`):**
   * *O problema:* Não existe literal de data no JSON.
   * *Como contornar:* Padroniza-se o envio como **string no formato ISO 8601** (ex.: `"2026-09-01T10:30:00Z"`) ou como número representando o **timestamp Unix epoch** em milissegundos (ex.: `1788258600000`).
2. **Dados Binários / Arquivos (`Binary`, `Blob`, `Byte Array`):**
   * *O problema:* JSON é puramente textual e não aceita fluxos binários brutos.
   * *Como contornar:* Codifica-se o binário em uma string no padrão **Base64** (ex.: `"dados": "iVBORw0KGgoAAAANSUhEUgAA..."`).
3. **Decimais de Precisão Monetária Arbitrária (`BigDecimal`):**
   * *O problema:* O tipo `number` do JSON segue a representação de ponto flutuante IEEE 754 de 64 bits na maioria dos analisadores JavaScript, o que pode causar erros de arredondamento em cálculos financeiros de alta precisão.
   * *Como contornar:* Transmite-se o valor monetário como **string** (ex.: `"valor": "12500450.85"`) ou como um número inteiro representando os **centavos** (ex.: `"valor_centavos": 1250045085`).

---

## 5. Comparativo Estrutural: XML vs JSON

| Critério | XML (*eXtensible Markup Language*) | JSON (*JavaScript Object Notation*) |
|---|---|---|
| **Sintaxe e Verbosidade** | **Alta verbosidade:** tags de abertura e fechamento repetem o nome do campo (`<nome>João</nome>`). | **Baixa verbosidade / Compacto:** utiliza delimitadores concisos (`"nome": "João"`), consumindo menos banda. |
| **Legibilidade e Parsing** | Mais pesado para leitura rápida. Exige analisadores complexos (DOM ou SAX). | Altamente legível e natural. Mapeia diretamente para objetos e matrizes na maioria das linguagens. |
| **Tipos de Dados** | Trata todo conteúdo textual como string na ausência de esquema. Com XSD, possui tipagem rica. | Tipagem nativa básica embutida no próprio formato (`string`, `number`, `boolean`, `array`, `object`, `null`). |
| **Atributos vs Elementos** | **Sim:** Suporta metadados em atributos dentro das tags (`<item id="1">`). | **Não:** Tudo é modelado como par chave-valor dentro de um objeto. |
| **Contratos e Validação** | **Altamente maduros:** Esquemas formais consolidados (XSD, DTD) e universais. | JSON Schema existe, mas é historicamente menos adotado em padrões legados e normas governamentais. |
| **Namespaces** | **Nativo (`xmlns`):** Permite mesclar múltiplos vocabulários no mesmo documento sem colisão. | **Inexistente:** Não há suporte nativo a namespaces. |
| **Assinatura Digital Parcial** | **Nativo (XML-DSig):** Permite assinar digitalmente e criptografar nós específicos do documento. | JSON Web Signature (JWS) / JWT assinam o payload como um todo, sem granularidade nativa em árvore. |
| **Comentários** | Suporta comentários nativamente (`<!-- comentário -->`). | A especificação estrita da RFC **proíbe comentários**. |
| **Domínio Atual** | Padrão em documentos fiscais, processos B2B corporativos, setor bancário e SOAP. | **Formato dominante** absoluto na web, SPAs, aplicativos móveis e APIs RESTful. |

---

## 6. Recursos do XML sem Correspondente Direto no JSON

XML e JSON **não são estritamente equivalentes em expressividade**. O XML possui recursos avançados de modelagem documental que não têm contraparte direta no JSON nativo:

1. **Separação entre Conteúdo e Metadados (Atributos):** No XML, um elemento pode conter texto e, simultaneamente, carregar metadados em atributos (`<preco moeda="BRL" cotacao="oficial">150.00</preco>`). No JSON, é necessário criar objetos aninhados artificiais para reproduzir essa distinção.
2. **Namespaces XML (`xmlns`):** Permitem a coexistência de tags com o mesmo nome, originárias de esquemas e organizações distintas, dentro de um único documento composto, evitando ambiguidade semântica.
3. **Assinatura Digital Granular (XML-DSig) e Criptografia (XML-Enc):** Padrões internacionais que permitem aplicar assinatura digital com certificado digital ICP-Brasil sobre um subconjunto de nós da árvore XML (mantendo o restante do documento editável por intermediários sem invalidar a assinatura).
4. **Comentários estruturais:** Permite documentar o arquivo sem violar a gramática do analisador.

---

## 7. Por que o JSON Domina as APIs Web e SPAs Modernas?

O JSON tornou-se o formato de transporte padrão na arquitetura web moderna por razões técnicas decisivas:
* **Menor *Payload* e Menor Latência:** A ausência de tags de fechamento redundantes reduz significativamente o tamanho das mensagens trafegadas na rede.
* **Integração Nativa com JavaScript e Navegadores:** No ambiente front-end (SPAs em React, Angular, Vue), o parsing de JSON é executado pelo motor JavaScript em código nativo de altíssima velocidade (`JSON.parse()` e `JSON.stringify()`), convertendo a mensagem instantaneamente em objetos manipuláveis no código.
* **Mapeamento Direto para Estruturas de Linguagens Modernas:** Chaves e valores mapeiam perfeitamente para dicionários/mapas (Python, Java, C#, Go, PHP) e arrays para listas, dispensando a complexidade de árvores de nós DOM ou processadores SAX.

---

## 8. Casos Práticos e Decisão Arquitetural

### Cenário A: Documentos Fiscais Eletrônicos (NF-e, CT-e, SPED)
* **Requisitos:** Validação estrutural obrigatória pré-transmissão contra esquemas oficiais de órgãos públicos, contrato verificável entre partes heterogêneas e assinatura digital com certificado ICP-Brasil sobre nós específicos do documento fiscal (sem invalidar o protocolo de autorização).
* **Escolha Adequada:** **XML (com XSD e XML-DSig)**. O ecossistema XML oferece todo o ferramental nativo para validação formal de tipos, regras de formato por regex e assinatura digital padronizada de trechos de documentos.

### Cenário B: Alimentação de Front-End SPA com Listas Paginadas de Baixa Latência
* **Requisitos:** Transferência de dados via chamadas assíncronas (`fetch`/AJAX) para um front-end SPA, com paginação de milhares de registros, baixo consumo de banda e renderização dinâmica imediata na interface do usuário.
* **Escolha Adequada:** **JSON**. O baixo overhead do payload, a velocidade do parsing nativo pelo navegador e a facilidade de iteração sobre arrays garantem o melhor desempenho e a menor latência percebida pelo usuário final.
