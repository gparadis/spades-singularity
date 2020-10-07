# spades-singularity

## What is this project?

This project implements a scripted framework for automating the process of building Singularity containers for running SpaDES simulations on HPC clusters.

## I am super impatient, and refuse to take the time to understand what I am doing before running any commands. Just tell me how to do the thing right now!

To build, sign, and push the base container flavour to the cloud image repository, simply run `make all` from the project root directory. This uses `Singularity.spades` base definition file, which includes the latest stable CRAN versions of core SpaDES R packages.

In many (most?) cases, you will need or want to run the GitHub `master` or `development` branch versions of SpaDES packages (or some other non-standard combination of GitHub package versions). In these cases, you will want to use the commands in the `Makefile` targets as a cheat sheet, and manually run an appropriate sequence of commands that implements whatever workflow makes sense for your project. Some common scenarios are described later in this document.

## Details

## Singularity container definition files

This Singularity container definition files follow standard Singularity definition file naming conventions (i.e., they are prefixed with `Singularity.` followed by a _tag_ string). 

### Base flavour

The base container flavour includes the latest stable CRAN versions of core SpaDES R packages. This base can be used to run SpaDES models directly (for simpler projects, where the CRAN packages are all you need). The base image also serves as a _bootstrap_ image for other flavours. The base container flavour is implemented in the `Singularity.spades` definition file.

Run the `build-spades_sandbox` make target to build a Singularity sandbox container using the `Singularity.spades` build script. Use the sandbox container for container debugging in your development environment.

Run the `build-spades` make target to build a Singularity SIF container using the `Singularity.spades` build script. Use the SIF container for deployment to your production environment.

Run the `sign-spades` make target to sign your SIF container image before pushing it to the Singularity cloud container image repository.

Run the `push-spades` make target to push your SIF container image to the Singularity cloud container image repository. 

Run the `all` target to build, sign, and push a SIF container image in one step.

## GitHub flavours

There are two GitHub container flavours, which install core SpaDES R packages from the latest code pushed to GitHub repositories for `master` and `development` branches. The GitHub container flavours are implemented in the `Singularity.spades-github_master` and `Singularity.spades-github_development` definition files. 

Both GitHub container flavours are _bootstrapped_ from the base container flavour. Defintion file implementation assumes that a local base container image is available in path `build/spades.sif`, so you must build the base container flavour before building GitHub container flavours (run the `build_spades` make target to satisfy this dependency). 

We have implemented analogous `build*`, `sign*` and `push*` make targets in the `Makefile` for each of the two GitHub container flavours. 


## Custom flavours

You create a custom container flavour, you are basically going to need a implement a custom SpaDES R package installation script, and a custom container definition file. Bootstrap this process by coping `Singularity.spades_github-master` and `spades-setup_github-master.R`---rename these to `Singularity.spades_foo` and `spades-setup_foo.R` (or whatever name works for you) and modify as required. 
