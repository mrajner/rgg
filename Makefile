VERSION := $(shell git describe --tags --abbrev=0)
DIR     := $(shell basename $$PWD)

authordep := rog.cls sample_article.bib sample_article.tex
editordep := $(authordep) master.tex

package: rog-latex-guide-for-author-$(VERSION).tar.gz rog-latex-guide-for-editor-$(VERSION).tar.gz

rog-latex-guide-for-author-$(VERSION).tar.gz: $(authordep)
	tar czvf $@ -C ../  $(addprefix $(DIR)/,$(authordep))

rog-latex-guide-for-editor-$(VERSION).tar.gz: $(editordep)
	tar czvf $@ -C ../  $(addprefix $(DIR)/,$(editordep))
