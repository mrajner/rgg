all: figure.pdf figure.ps
COMMITS := $(shell git rev-list --count $(VERSION)..HEAD)
VERSION := $(shell git describe --tags --abbrev=0)
DIR     := $(shell basename $$PWD)

	echo $(VERSION).$(COMMITS)

authordep := rog.cls sample_article.bib sample_article.tex sample_article.pdf
editordep := $(authordep) master.tex master.pdf

package: \
	rog-latex-guide-for-author-$(VERSION).tar.gz \
	rog-latex-guide-for-editor-$(VERSION).tar.gz

rog-latex-guide-for-author-$(VERSION).tar.gz: $(authordep)
	tar czvf $@ -C ../  $(addprefix $(DIR)/,$(authordep))

rog-latex-guide-for-editor-$(VERSION).tar.gz: $(editordep)
	tar czvf $@ -C ../  $(addprefix $(DIR)/,$(editordep))

clean:
	rm *.aux

figure.pdf: figure.tex
	pdflatex $<
figure.ps: figure.tex
	latex $<
	dvips $(<:.tex=.dvi)
