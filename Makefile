PACKAGE := $(shell grep '^Package:' DESCRIPTION | sed -E 's/^Package:[[:space:]]+//')
RSCRIPT = Rscript --no-init-file

vign:
	cd vignettes;\
	${RSCRIPT} -e "Sys.setenv(NOT_CRAN='true'); knitr::knit('mapr.Rmd.og', output = 'mapr.Rmd')";\
	cd ..

test:
	${RSCRIPT} -e 'library(methods); devtools::test()'

doc:
	${RSCRIPT} -e "devtools::document()"


egs:
	${RSCRIPT} -e "devtools::run_examples(run = TRUE)"

install: doc build
	R CMD INSTALL . && rm *.tar.gz

build:
	R CMD build .

check: build
	_R_CHECK_CRAN_INCOMING_=FALSE R CMD check --as-cran --no-manual `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -f `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -rf ${PACKAGE}.Rcheck

readme: README.Rmd
	${RSCRIPT} -e "knitr::knit('README.Rmd')"
