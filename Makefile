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

package: rgg-latex-guide-for-author-latest.tar.gz

rgg-latex-guide-for-author-latest.tar.gz: rgg-latex-guide-for-author-$(VERSION).$(COMMITS).tar.gz
	ln -sf $< $@
rgg-latex-guide-for-author-$(VERSION).$(COMMITS).tar.gz: $(authordep)
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

test:
	rm -rf tmp
	mkdir tmp
	cd tmp                                                                       \
		&& wget www.grat.gik.pw.edu.pl/rgg/rgg-latex-guide-for-author-latest.tar.gz \
		&& tar zxvf rgg-latex-guide-for-author-latest.tar.gz                        \
		&& cd rgg                                                                   \
		&& pdflatex rgg_sample_article                                              \
		&& wget www.grat.gik.pw.edu.pl/rgg/rgg_editor.tex                           \
		&& pdflatex rgg_editor                                                      \
		&& zathura rgg_sample_article.pdf rgg_editor.pdf
