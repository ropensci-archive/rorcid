PACKAGE := $(shell grep '^Package:' DESCRIPTION | sed -E 's/^Package:[[:space:]]+//')
RSCRIPT = Rscript --no-init-file

vign:
	cd vignettes;\
	${RSCRIPT} -e "Sys.setenv(NOT_CRAN='true'); knitr::knit('rorcid.Rmd.og', output = 'rorcid.Rmd')";\
	cd ..

vign_auth:
	cd vignettes;\
	${RSCRIPT} -e "Sys.setenv(NOT_CRAN='true'); knitr::knit('authentication.Rmd.og', output = 'authentication.Rmd')";\
	cd ..

install: doc build
		R CMD INSTALL . && rm *.tar.gz

build:
		R CMD build .

doc:
		${RSCRIPT} -e "devtools::document()"

eg:
		${RSCRIPT} -e "devtools::run_examples(run_dontrun = TRUE)"

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
