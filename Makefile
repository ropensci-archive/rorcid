all: move rmd2md

move:
		cp inst/vign/rorcid_vignette.md vignettes

rmd2md:
		cd vignettes;\
		mv rorcid_vignette.md rorcid_vignette.Rmd
