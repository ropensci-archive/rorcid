PACKAGE := $(shell grep '^Package:' DESCRIPTION | sed -E 's/^Package:[[:space:]]+//')
RSCRIPT = Rscript --no-init-file

all: move rmd2md

move:
		cp inst/vign/rorcid.md vignettes

rmd2md:
		cd vignettes;\
		mv rorcid.md rorcid.Rmd

install: doc build
		R CMD INSTALL . && rm *.tar.gz

build:
		R CMD build .

doc:
		${RSCRIPT} -e "devtools::document()"

eg:
		${RSCRIPT} -e "devtools::run_examples()"

check: build
	_R_CHECK_CRAN_INCOMING_=FALSE R CMD CHECK --as-cran --no-manual `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -f `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -rf ${PACKAGE}.Rcheck

test:
	${RSCRIPT} -e "devtools::test()"

readme:
	${RSCRIPT} -e "knitr::knit('README.Rmd')"

check_windows:
	${RSCRIPT} -e "devtools::check_win_devel(); devtools::check_win_release()"
