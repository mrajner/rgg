VERSION := $(shell git describe --tags --abbrev=0)
COMMITS := $(shell git rev-list --count $(VERSION)..HEAD)
DIR     := $(shell basename $$PWD)

all: package
	@tput setaf 2 ; echo rog.cls $(VERSION).$(COMMITS) ; tput sgr0

authordep := rog.cls sample_article.bib sample_article.tex sample_article.pdf
editordep := $(authordep) master.tex master.pdf

package: \
	rog-latex-guide-for-author-$(VERSION).tar.gz \
	rog-latex-guide-for-editor-$(VERSION).tar.gz

rog-latex-guide-for-author-$(VERSION).tar.gz: $(authordep)
	tar czf $@ -C ../  $(addprefix $(DIR)/,$(authordep))

rog-latex-guide-for-editor-$(VERSION).tar.gz: $(editordep)
	tar czf $@ -C ../  $(addprefix $(DIR)/,$(editordep))

clean:
	rm *.aux

figure.pdf: figure.tex
	pdflatex $<
figure.ps: figure.tex
	latex $<
	dvips $(<v:.tex=.dvi)

%.pdf: %.tex figure.pdf
	latexmk $< > /dev/null
