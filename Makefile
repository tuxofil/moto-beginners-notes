.PHONY: all pdf html clean

TEXS = $(wildcard *.tex)
PDFS = $(patsubst %.tex, %.pdf, $(TEXS))
HTMS = $(patsubst %.tex, %, $(TEXS))

all: pdf html

pdf: $(PDFS)

html: $(TEXS)
	for TEX in $(TEXS); do \
	    echo "latex2html $$TEX"; \
	    latex2html $$TEX || exit 1; \
	done

%.pdf: %.tex %.toc
	pdflatex -file-line-error -halt-on-error -interaction=batchmode $<

%.toc: %.tex
	pdflatex -file-line-error -halt-on-error -interaction=batchmode $<
	rm -f $(patsubst %.tex, %.pdf, $<)

clean:
	rm -f \
	 $(patsubst %.tex, %.log, $(TEXS)) \
	 $(patsubst %.tex, %.aux, $(TEXS)) \
	 $(patsubst %.tex, %.out, $(TEXS)) \
	 $(patsubst %.tex, %.toc, $(TEXS)) \
	 $(patsubst %.tex, %.pdf, $(TEXS)) \
	 $(patsubst %.tex, %.dvi, $(TEXS)) \
	 $(patsubst %.tex, %.backup, $(TEXS))
	rm -rf $(HTMS)
