.PHONY: all build submit

all: tikz-lake-fig-doc.pdf 

pngs: tikz-lake-fig-doc.tex tikz-lake-fig.sty
	-pdflatex "\def\makepng{1} \input{$<}"
	make -f tikz-lake-fig-doc.makefile
	-@rm *.log *.out *.aux *.nav *.toc *.snm *.dep *.md5 *.figlist *.makefile 2>/dev/null || true

build: ctan.R tikz-lake-fig-doc.pdf example.png ctan_banner.png
	Rscript $< --build --validate
	-@rm *.log *.out *.aux *.nav *.toc *.snm 2>/dev/null || true

submit: ctan.R tikz-lake-fig-doc.pdf
	Rscript $< --submit --validate

tikz-lake-fig-doc.pdf: tikz-lake-fig-doc.tex tikz-lake-fig.sty
	pdflatex $<
	-@rm *.log *.out *.aux *.nav *.toc *.snm 2>/dev/null || true
	
example.png: example.tex tikz-lake-fig.sty
	pdflatex $<
	convert -density 300 example.pdf -quality 100 $@
	convert -flatten $@ $@
	-@rm *.log *.out *.aux *.nav *.toc *.snm 2>/dev/null || true
	
ctan_banner.png: ctan_banner.tex tikz-lake-fig.sty
	pdflatex $<
	convert -density 48.5 ctan_banner.pdf -quality 100 -splice 0x16 $@
	convert -flatten $@ $@
	-@rm *.log *.out *.aux *.nav *.toc *.snm 2>/dev/null || true

test.pdf: test.tex
	pdflatex -shell-escape $<

clean: 
	-@rm *-figure*.pdf *-figure*.png
	