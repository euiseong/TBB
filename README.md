# Designing AI Serving Systems (at Cloud Scale)

An open textbook on the principles beneath AI services — virtualization,
containers, Kubernetes, serving engines, and the bill — told as one continuous
story: from a demo that collapses at 21:04 to a service that runs, on purpose,
at exactly $900 a month.

This repository holds the LaTeX source for the book, organized one directory per
chapter.

---

## What's in the book

Three parts, thirteen chapters, a preface, and an epilogue.

**Part 1 — Infrastructure and Principles**
1. Course Overview: The Big Picture of AI Services
2. Virtualization Principles and Cloud Compute
3. Inside Containers
4. Docker and the Container Runtime Stack
5. Kubernetes
6. Storage and Networking

**Part 2 — AI Serving Systems**
7. Introduction to Serving Systems
9. Model Serving Frameworks
10. Inference Optimization
11. LLM Serving
12. Scaling and Cost Optimization

**Part 3 — Operations**
13. MLOps and Deployment Automation
14. Monitoring and Reliability

*(Chapter 8 is the course midterm and has no chapter of its own, so the numbering
intentionally skips from 7 to 9. Each chapter file declares its own number, so
the gap is self-contained.)*

---

## Repository layout

```
main.tex                     master file: document class, front matter, parts, \include of chapters
style/
  tbb.sty                    the whole house style — palette, fonts, boxes, tables, headings
  tbb-fallback.tex           per-glyph font fallback (symbols, circled digits, Korean)
  tbb-codeactive.tex         lets those glyphs fall back inside code blocks too
  tbb-dyncolors.tex          extra colours used inline in the text
frontmatter/
  titlepage.tex              the title page
  preface.tex                "The Layer Above"
chapters/
  ch01/ … ch14/              one directory per chapter
    chNN.tex                 the chapter text
    figures/                 that chapter's figures, as PNG
backmatter/
  epilogue/
    epilogue.tex             "The Boring Service"
    figures/
Makefile
```

Each chapter is a single `.tex` file (not split by section) plus its own
`figures/` directory of PNGs.

---

## Building the PDF

The book is typeset with **XeLaTeX** (it uses system fonts and a good deal of
Unicode — arrows, Greek, circled digits, box-drawing, a little Korean).

**Requirements**

- A TeX Live (2022 or newer) with XeLaTeX and `latexmk`.
- Fonts, all freely available and usually already present on Linux:
  - **Carlito** (a metric-compatible clone of Calibri — the body font)
  - **DejaVu Sans** and **DejaVu Sans Mono** (symbols, box-drawing, code)
  - **Noto Serif CJK KR** (the handful of Korean glyphs)

  On Debian/Ubuntu: `sudo apt install texlive-xetex texlive-fonts-extra fonts-crosextra-carlito fonts-dejavu fonts-noto-cjk`

**Build**

```bash
make            # runs latexmk -xelatex (two passes, for the table of contents)
# or, by hand:
xelatex main.tex && xelatex main.tex
```

The result is `main.pdf` (A4, ~400 pp.). `make clean` removes the build artifacts.

---

## Editing

The `.tex` files under `chapters/`, `frontmatter/`, and `backmatter/` are the
source — edit them directly. The style is centralized in `style/tbb.sty`; change
a colour, a size, or a box there and it changes everywhere.

Handy building blocks defined by the style (used throughout the chapters):

- `\section{…}` / `\subsection*{…}` — the numbered section rule and grey subheads
- `\namedsection{Summary}{subtitle}` — the end-of-chapter sections
- `\begin{calloutbox}{accent}{fill} … \end{calloutbox}` — the accent boxes
- `\begin{terminalbox}` + `\begin{Verbatim}…\end{Verbatim}` — dark transcripts
- `\qitem{n}{…}` — a numbered exercise/answer item
- `\code{…}` — inline monospace

To add a figure, drop the PNG in that chapter's `figures/` directory and use
`\includegraphics{figures/yourfig.png}` (the search path is set in `main.tex`).

If you use a non-ASCII glyph the body font lacks (a new symbol, arrow, or CJK
character), add one line to `style/tbb-fallback.tex` so it renders — a
`\newunicodechar` mapping to `\symfont` (symbols) or `\cjkfont` (CJK). If that
glyph also appears inside a `terminalbox`, add it to `\tbbcodeactive` in
`style/tbb-codeactive.tex` as well.

---

## Figures

Figures are committed as **PNG** only. Each chapter keeps its own figures under
`chapters/chNN/figures/`.

---

## Contributing

Corrections and improvements are welcome — open an issue or a pull request.
Please keep the house style centralized in `style/tbb.sty` rather than adding
per-chapter formatting, and run `make` before submitting so the book still
builds cleanly.

---

## License

See [`LICENSE`](LICENSE) — the text and figures are licensed under
CC BY-NC-SA 4.0.

---

## Author

Euiseong Seo · Sungkyunkwan University. The book's preface, *"The Layer Above,"*
tells the story of why it was written.
