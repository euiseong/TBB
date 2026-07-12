# Designing AI Serving Systems (at Cloud Scale) — build
#
#   make          build main.pdf with latexmk + XeLaTeX (handles the TOC passes)
#   make once     a single XeLaTeX pass (faster while drafting)
#   make clean    remove build artifacts (keeps main.pdf)
#   make distclean remove build artifacts and main.pdf

MAIN    = main
LATEX   = xelatex
LATEXMK = latexmk

CHAPTERS := $(wildcard chapters/*/*.tex)
PARTS    := $(wildcard frontmatter/*.tex backmatter/*/*.tex)
STYLE    := $(wildcard style/*.sty style/*.tex)

.PHONY: all once clean distclean

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(STYLE) $(CHAPTERS) $(PARTS)
	@if command -v $(LATEXMK) >/dev/null 2>&1; then \
		$(LATEXMK) -xelatex -interaction=nonstopmode -halt-on-error $(MAIN).tex ; \
	else \
		$(LATEX) -interaction=nonstopmode $(MAIN).tex && \
		$(LATEX) -interaction=nonstopmode $(MAIN).tex ; \
	fi

once:
	$(LATEX) -interaction=nonstopmode $(MAIN).tex

clean:
	-$(LATEXMK) -c $(MAIN).tex 2>/dev/null || true
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.xdv
	rm -f chapters/*/*.aux frontmatter/*.aux backmatter/*/*.aux

distclean: clean
	rm -f $(MAIN).pdf
