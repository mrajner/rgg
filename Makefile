VERSION := $(shell git describe --tags)
DIR     := $(shell basename $$PWD)

authordep = rog.cls sample_article.bib sample_article.tex
editordep = rog.cls sample_article.bib sample_article.tex master.tex

rog-latex-guide-for-author-$(VERSION).tar.gz: $(authordep)
	echo $(VERSION) $(DIR)
	tar czvf $@ \
    -C ../   \
    $(addprefix $(DIR)/,$(authordep))
