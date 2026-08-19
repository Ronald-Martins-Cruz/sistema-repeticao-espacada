### As Nuances do termo "Multiplataforma"

No contexto de concursos e provas de TI, **"multiplataforma móvel"** quase sempre significa **gerar código para Android e iOS a partir de uma única base**. Porém, existem **3 nuances importantes** que as bancas costumam explorar:

#### Nuance 1: O que é compartilhado? (UI + Lógica vs. Apenas Lógica)
* **UI + Lógica compartilhadas (Flutter, React Native, .NET MAUI, Ionic):** Você escreve a tela e a regra de negócio uma única vez; o framework se encarrega de desenhar nos dois sistemas.
* **Apenas Lógica compartilhada (Kotlin Multiplatform - KMP tradicional):** Você compartilha regras de negócio, chamadas de API e banco de dados, mas desenha a interface do Android em *Jetpack Compose* e a do iOS em *SwiftUI*.

#### Nuance 2: Escopo das Plataformas (Apenas Mobile vs. Mobile + Desktop + Web)
* Alguns nasceram **Mobile-First** (focados estritamente em Android e iOS, como *React Native*).
* Outros são **Universais / Multi-telas** desde a concepção (Mobile + Desktop + Web/PWA, como *Flutter* e *.NET MAUI*).

#### Nuance 3: A Classificação Clássica de Bancas (Nativo vs. Híbrido vs. Cross-Platform)
Muitas bancas dividem o desenvolvimento móvel em 3 caixas:
1. **Nativo:** 1 linguagem $\rightarrow$ 1 sistema (*Kotlin* para Android, *Swift* para iOS).
2. **Híbrido (Web-based):** Tecnologias web rodando dentro de uma WebView (*Ionic*, *Cordova*).
3. **Multiplataforma Nativo / Compilado:** Código único compilado para binário ou com ponte nativa (*Flutter*, *React Native*, *.NET MAUI*).

---

### Tabela Atualizada (com menção explícita a PWA e Desktop)

| Ferramenta / Framework | Tipo / Classificação | Linguagem Principal | Mantenedor | Plataformas Suportadas (com PWA / Desktop) | Como funciona / Arquitetura |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Flutter** | Multiplataforma (UI e Lógica) | **Dart** | **Google** | • **Mobile:** Android, iOS<br>• **Web:** Sites e **PWA**<br>• **Desktop:** Windows, macOS, Linux | **Renderização Própria:** Motor gráfico (Skia/Impeller) desenha pixel a pixel. |
| **React Native** | Multiplataforma (UI e Lógica) | **JavaScript / TypeScript** | **Meta (Facebook)** | • **Mobile:** Android, iOS<br>• *(Web/Desktop via bibliotecas da comunidade/Microsoft)* | **Ponte Nativa:** O JavaScript instrui o SO a criar componentes visuais nativos reais. |
| **Kotlin Multiplatform (KMP)** | Multiplataforma (Lógica de Negócio) | **Kotlin** | **JetBrains** | • **Mobile:** Android, iOS<br>• **Web:** Sites e **PWA** (via Wasm/JS)<br>• **Desktop:** Windows, macOS, Linux | **Lógica Compartilhada:** Compila nativamente para cada SO; UI geralmente feita separada. |
| **.NET MAUI** *(Sucessor do Xamarin)* | Multiplataforma (UI e Lógica) | **C#** (.NET) | **Microsoft** | • **Mobile:** Android, iOS<br>• **Desktop:** Windows, macOS | **Compilado Nativo:** Código C#/XAML mapeado diretamente para controles nativos de cada SO. |
| **Xamarin** *(Legado)* | Multiplataforma (UI e Lógica) | **C#** (.NET) | **Microsoft** | • **Mobile:** Android, iOS<br>• **Desktop:** Windows | **Nativo/Compartilhado:** Antecessor do .NET MAUI. |
| **Ionic** | Híbrido / Baseado em Web | **HTML, CSS, JS/TS** (Angular, React, Vue) | **Ionic / Open Source** | • **Mobile:** Android, iOS (via WebView)<br>• **Web:** Foco forte em **PWA**<br>• **Desktop:** via Electron | **Baseado em WebView:** Aplicação web rodando dentro de um navegador embutido. |
| **Apache Cordova / PhoneGap** | Híbrido / Baseado em Web | **HTML, CSS, JS** | **Apache / Adobe** | • **Mobile:** Android, iOS (via WebView) | **Baseado em WebView:** Modelo pioneiro de empacotamento web para apps móveis. |
| **Kotlin (Puro / Tradicional)** | **Nativo (Único SO)** | **Kotlin** | **JetBrains / Google** | • **Mobile:** Apenas Android<br>• *(Também roda em Servidores JVM)* | **Nativo Oficial:** Compila diretamente para bytecode do ecossistema Android. |
| **Swift / SwiftUI** | **Nativo (Único Ecossistema)** | **Swift** | **Apple** | • **Mobile/Desktop:** Apenas ecossistema Apple (iOS, iPadOS, macOS, watchOS) | **Nativo Oficial:** Linguagem e framework declarativo proprietários da Apple. |