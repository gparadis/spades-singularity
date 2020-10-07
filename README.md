# spades-singularity

## About this project

This project implements a scripted framework for automating the process of building Singularity containers for running SpaDES simulations on HPC clusters.

## I am super impatient, and refuse to take the time to understand what I am doing before running any commands. Just tell me how to do the thing right now!

To build, sign, and push the base container flavour to the cloud image repository, simply run `make all flavour=FLAVOUR`, where `FLAVOUR` is one of `base`, `github-master`, or `github-development`. 

Not sure which flavour to use? Read on!

Note that, if you do not have Singularity installed yet, you will need to run `make install-singularity` first.


## Singularity container definition files

This Singularity container definition files follow standard Singularity definition file naming conventions (i.e., they are prefixed with `Singularity.` followed by a _tag_ string). There are three flavours (tags) defined in this project: `base`, `github-master`, and `github-development`. Note that the R code that installs SpaDES packages for each flavour is contained in a script named `spades-setup_flavour.R` 

You can also create new custom flavours by copying and modifying some files from an existing flavour. New flavours should be compatible with automated make targets (as long as you did not break the filename patterns). 

### Base flavour

The base container flavour includes the latest stable CRAN versions of core SpaDES R packages. This base can be used to run SpaDES models directly (for simpler projects, where the CRAN packages are all you need). The base image also serves as a _bootstrap_ image for other flavours. The base container flavour is implemented in `Singularity.spades_base` and `spades-setup_base.R`.

### GitHub flavours

There are two GitHub container flavours (`github-master`, `github-development`). These install core SpaDES R packages from the latest code pushed to GitHub repositories for `master` and `development` branches, respectively. The GitHub container flavours are implemented in the `Singularity.spades-github_BRANCH` and `spades-setup_github-BRANCH` (where `BRANCH` is one of `master` or `development`). 

The GitHub container flavours are _bootstrapped_ from the base container flavour. Defintion file implementation assumes that a local base container image is available in path `build/spades.sif`, so the base container must be built first (the base container will automatically get built if not present if you run `make build flavour=FLAVOUR`, where `FLAVOUR` is any value except for `base`). 

### Custom flavours

You can create a custom container flavour but copying `Singularity.spades_github-master` and `spades-setup_github-master.R`---rename these to `Singularity.spades_foo` and `spades-setup_foo.R` (where `foo` is whatever unique flavour name you want) and modify as required. Minimally, you just need to edit one line of code in the Singularity definition file to point to `spades-setup_foo.R`, and edit the code in `spades-setup_foo.R` to install whatever versions of SpaDES R packages you need.


## Makefile details

The `Makefile` implements a number of make targets. 

Run `make build flavour=FLAVOUR sandbox=true` to build a sandbox container (in `build/spades_FLAVOUR_sandbox`). See Singularity documentation for details on sandbox containers. 

Run `make build flavour=FLAVOUR` to build a container as a single _singularity image file_ (in `build/spades_FLAVOUR.sif`). See Singularity documentation for details on SIF containers. 

Run `make push flavour=FLAVOUR` to sign your SIF image and push it to your Sylabs cloud image library account. See the [Sylabs Container Library](https:\\cloud.sylabs.io) to create and configure your account.

Run `make all flavour=FLAVOUR` to build and push your image in one step.
