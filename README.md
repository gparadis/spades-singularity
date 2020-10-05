# spades-singularity

This project implements a scripted framework for automating the process of building Singularity containers for running SpaDES simulations on HPC clusters.

The Makefile defines some useful build targets that should help further automate use of the framework.

Run the `install_singularity` make target to install a valid version of Singularity (and dependencies, assumes you are running this on an Ubuntu linux system, that you have `sudo` privileges, and can run `apt-get install` commands to install system packages).

Run the `build-spades_sandbox` make target to build a Singularity sandbox container using the `Singularity.spades` build script. Use the sandbox container for container debugging in your development environment.

Run the `build-spades` make target to build a Singularity SIF container using the `Singularity.spades` build script. Use the SIF container for deployment to your production environment.

Run the `sign-spades` make target to sign your SIF container image before pushing it to the Singularity cloud container image repository.

Run the `push-spades` make target to push your SIF container image to the Singularity cloud container image repository. 

Run the `all` target to build, sign, and push a SIF container image in one step.

Run the `clean` target to delete all temporary files and reset to the project working directory state.

The `spades-setup.R` script contains all the SpaDES-specific R packages installation code. Edit this file as needed to install the package versions you need for your project.
