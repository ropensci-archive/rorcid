all: move rmd2md

move:
		cp inst/vign/rorcid.md vignettes

rmd2md:
		cd vignettes;\
		mv rorcid.md rorcid.Rmd
