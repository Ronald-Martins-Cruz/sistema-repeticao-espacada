# Provas FGV selecionadas — cargos de sistemas, de 2024 em diante

Recorte das provas da pasta [../](../README.md): as da **FGV**, de **2024 para
cá**, para cargos de **sistemas** — analista de sistemas, desenvolvimento de
sistemas, desenvolvedor de sistemas, analista programador. São as de recorte
mais próximo do alvo atual (DATAPREV 2026, Analista de TI — Desenvolvimento de
Software) e as mais recentes, então é onde a banca aparece com o estilo e a
dificuldade que valem para hoje.

Cada concurso tem uma pasta com três coisas:

| Arquivo | Papel |
|---|---|
| `fgv-<ano>-<órgão>-<cargo>-tipo-1.pdf` | O caderno de prova, como estava na pasta de cima. |
| `edital-<órgão>-<ano>-<nº>[-retificado/-consolidado].pdf` | O edital do concurso, baixado de `conhecimento.fgv.br`. Quando existe versão com as retificações incorporadas, é ela que está aqui — o sufixo diz qual. |
| `EMENTA.md` | O Anexo I (conteúdo programático) do edital transcrito, **recortado para o cargo** e com a tabela de distribuição de questões da prova. |

## O que está aqui

| Pasta | Concurso | Cargo | Prova | Questões |
|---|---|---|---|:--:|
| [2024-alep-desenvolvedor-de-sistemas/](2024-alep-desenvolvedor-de-sistemas/EMENTA.md) | ALEP, Edital nº 02/2024 | Analista Legislativo — Desenvolvedor de Sistemas | 07/04/2024 | 70 obj. + 1 disc. |
| [2024-tj-ap-desenvolvimento-de-sistemas/](2024-tj-ap-desenvolvimento-de-sistemas/EMENTA.md) | TJ-AP, Edital nº 01/2023 | Analista Judiciário — Apoio Especializado — TI — Desenvolvimento de Sistemas | 24/03/2024 | 80 obj. |
| [2024-tj-rr-desenvolvimento-de-sistemas/](2024-tj-rr-desenvolvimento-de-sistemas/EMENTA.md) | TJ-RR, Edital nº 01/2024 | Analista Judiciário — Desenvolvimento de Sistemas | 17/11/2024 | 70 obj. + 1 diss. |
| [2025-dpe-ro-analista-programador/](2025-dpe-ro-analista-programador/EMENTA.md) | DPE-RO, Edital nº 01/2025 | Analista Programador — Classe B | 01/06/2025 | 70 obj. + 1 disc. |
| [2025-mpu-desenvolvimento-de-sistemas/](2025-mpu-desenvolvimento-de-sistemas/EMENTA.md) | MPU, Edital nº 01/2025 | A06 — Analista do MPU — Desenvolvimento de Sistemas | 04/05/2025 | 80 obj. + redação |
| [2025-tce-rr-desenvolvimento-de-sistemas/](2025-tce-rr-desenvolvimento-de-sistemas/EMENTA.md) | TCE-RR, Edital nº 001/2024 | Analista Administrativo — TI, esp. Desenvolvimento de Sistemas | 26/01/2025 | 80 obj. |
| [2026-tj-rj-analista-de-sistemas/](2026-tj-rj-analista-de-sistemas/EMENTA.md) | TJ-RJ, Edital nº 01/2025 | Analista Judiciário — TI — Analista de Sistemas | 01/02/2026 | 70 obj. + 1 disc. |

O ano na pasta é o da **aplicação da prova**, não o do edital — por isso TJ-AP
aparece como 2024 com edital de 2023, TCE-RR como 2025 com edital de 2024 e
TJ-RJ como 2026 com edital de 2025.

Os **gabaritos** ficam na pasta de cima (`../gabarito-fgv-<ano>-<órgão>.pdf`):
são por concurso, cobrem todos os cargos, e um mesmo arquivo serve a mais de uma
pasta daqui — procure o cargo certo dentro do PDF.

## O que ficou de fora

Provas de 2024 em diante que **não** são de sistemas, e por isso continuam na
pasta de cima: DNIT 2024 (Analista Administrativo — TI, que é TI geral: muito de
redes, infraestrutura e governança), TCE-RR 2025 (esp. Banco de Dados), TJ-RJ
2026 (esp. Cientista de Dados) e os demais perfis da DATAPREV 2024 — nenhum
deles é cargo de sistemas.

## Sobre as ementas

O `EMENTA.md` é **transcrição, não paráfrase**: o texto sai do PDF oficial pela
extração em [`md/`](../../../../md/docs/provas/fgv/selecionadas/), preservando a
numeração do edital. Ele recorta o Anexo I para o cargo — as disciplinas comuns
que valem para ele, mais o bloco da especialidade — e descarta os blocos dos
outros cargos do mesmo concurso.

Ressalva de sempre: extração automática distorce tabela e fórmula de vez em
quando. Em trecho decisivo — um número, um prazo, um rol — confira no PDF. O
edital do TCE-RR é o mais sensível: é um documento do SEI cuja extração perdeu as
ligaduras tipográficas (`ti`, `ft`, `fi`), restauradas na transcrição.

> Material de referência, para conhecer o terreno da banca. Vale a regra do
> [CLAUDE.md](../../../../CLAUDE.md): **não puxe conteúdo daqui** para perguntas,
> gabaritos ou qualquer parte do banco de estudo a menos que seja pedido
> explicitamente.
