.PHONY: all

all: beamer-lake-fig-doc.pdf

beamer-lake-fig-doc.pdf: beamer-lake-fig-doc.tex beamer-lake-fig.sty
	pdflatex $<
	
beamer-lake-fig.zip: ctan_submit.R beamer-lake-fig-doc.pdf
	Rscript $<
