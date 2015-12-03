VERSION := $(shell git describe --tags --abbrev=0)
COMMITS := $(shell git rev-list --count $(VERSION)..HEAD)
DIR     := $(shell basename $$PWD)

all: package rgg_editor.pdf
	@tput setaf 2 ; echo rgg.cls $(VERSION).$(COMMITS) ; tput sgr0

authordep :=                     \
	rgg.cls rgg_sample_article.bib \
	rgg_sample_article.tex         \
	rgg_sample_article.pdf         \
	figure.pdf 

package: rgg-latex-guide-for-author.tar.gz

rgg-latex-guide-for-author.tar.gz: rgg-latex-guide-for-author-$(VERSION).tar.gz
	ln -sf $< $@
rgg-latex-guide-for-author-$(VERSION).tar.gz: $(authordep)
	tar czf $@ -C ../  $(addprefix $(DIR)/,$(authordep))

clean:
	rm *.aux

figure.pdf: figure.tex
	pdflatex $<
figure.ps: figure.tex
	latex $<
	dvips $(<v:.tex=.dvi)

%.pdf: %.tex figure.pdf
	latexmk $< > /dev/null
