# Use Bash shell expansion
SHELL=/bin/bash
UNAME_S := $(shell uname -s)
OPEN-CMD=""


# Change name of this if you change the name of demothesis.tex, should be name of the main tex file
TEXMAINFILE = hanel742-thesis.tex
# Name that you would like for your resulting pdf file, without extension.
# Defaults to $(TEXMAINFILE) with .pdf as extension
PDFNAME = $(shell basename -s.tex $(TEXMAINFILE))
#Location of latexmk binary
MKLATEX = latexmk
#Options to latexmk, should need to be changed
MKLATEXOPTS = -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make -jobname=$(PDFNAME)

all: .PHONY $(PDFNAME).pdf

.PHONY: platform-check

platform-check:
	@echo "Platoform.."
ifeq ($(UNAME_S),Linux)
	$(eval OPEN-CMD = xdg-open)
else ifeq ($(UNAME_S),Darwin)
	$(eval OPEN-CMD = open)
else
	$(error "The author only runs Linux and macOS on their machine. If tou have another platform, feel free to adapt this work to that platform.")
endif

$(PDFNAME).pdf: $(TEXMAINFILE) *.tex
	$(MKLATEX) $(MKLATEXOPTS) $<

view: $(PDFNAME).pdf
	$(OPEN-CMD) $(PDFNAME).pdf &

clean:
	$(MKLATEX) -CA
	rm -f $(PDFNAME).pdf settings.aux \
           $(PDFNAME).{aux,bbl,bcf,blg,cb,fdb_latexmk,fls,lof,log,lot,out,run.xml,rel,synctex.gz,toc}
