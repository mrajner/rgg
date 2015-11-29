VERSION := $(shell git describe --tags --abbrev=0)
COMMITS := $(shell git rev-list --count $(VERSION)..HEAD)
DIR     := $(shell basename $$PWD)

all: package
	@tput setaf 2 ; echo rgg.cls $(VERSION).$(COMMITS) ; tput sgr0

authordep := rgg.cls sample_article.bib sample_article.tex sample_article.pdf
editordep := $(authordep) master.tex master.pdf

package: rgg-latex-guide-for-author.tar.gz

rgg-latex-guide-for-author.tar.gz: rgg-latex-guide-for-author-$(VERSION).tar.gz
	ln -s $< $@
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
