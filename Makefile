SUFFIX = .sif
ifdef sandbox
SUFFIX = _sandbox
BUILD_FLAGS += --sandbox
endif

flavour = base # default
###########################################################################
## push target will not run unless both of these are set
## can be set here or in shell environment from which you run make commands
SYLABS_LIBRARY_USERNAME = gparadis
SYLABS_LIBRARY_PROJECT = spades
###########################################################################

foo:
	echo GITHUB_PAT $(GITHUB_PAT)

all: build sign push

build: Singularity.spades_$(flavour) spades-setup_$(flavour).R
ifneq ($(flavour), base)
ifeq (,$(wildcard build/spades_base.sif))
	make build flavour=base
endif
endif
	SINGULARITY_GITHUB_PAT=$(GITHUB_PAT) sudo singularity build $(BUILD_FLAGS) build/spades_$(flavour)$(SUFFIX) Singularity.spades_$(flavour)

ifndef SANDBOX 
push: guard-SYLABS_LIBRARY_USERNAME guard-SYLABS_LIBRARY_PROJECT build/spades_$(flavour).sif
	singularity sign build/spades_$(flavour).sif
	singularity push build/spades_$(flavour).sif library://$(SYLABS_LIBRARY_USERNAME)/$(SYLABS_LIBRARY_PROJECT)/spades_$(flavour):latest
endif

###################
# other stuff

install-singularity: install-singularity.sh
	./install-singularity.sh

clean:
	sudo rm -rf build/*
	rm -rf singularity*
	rm -rf go*
	rm -rf .sygp
	rm *~

.PHONY: install-singularity build clean sign push all

guard-%:
	@ if [ "${${*}}" = "" ]; then echo "Environment variable $* not set"; exit 1; fi
