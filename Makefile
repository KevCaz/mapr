all: move rmd2md

move:
		cp inst/vign/spoccutils_vignette.md vignettes
		cp -rf inst/vign/img/* vignettes/img/

rmd2md:
		cd vignettes;\
		mv spoccutils_vignette.md spoccutils_vignette.Rmd
