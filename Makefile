.PHONY: install-singularity build_spades sign-spades push-spades clean

install-singularity: install-singularity.sh
	./install-singularity.sh

build-spades_sandbox: Singularity.spades
	sudo singularity build --sandbox build/spades_sandbox

build-spades: Singularity.spades
	sudo singularity build build/spades.sif Singularity.spades

sign-spades: build/spades.sif
	singularity sign build/spades.sif

push-spades: sign-spades
	singularity push build/spades.sif library://gparadis/spades/spades:latest

all: build_spades sign-spades push-spades

clean:
	sudo rm -rf build/*
	rm -rf singularity*
	rm -rf go*
	rm -rf .sygp
	rm *~

