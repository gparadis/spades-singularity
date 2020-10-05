#!/bin/bash
# install Singularity 3.2.1 (to match version on sockey.arc.ubc.ca)
export SINGULARITY_VERSION=3.5.2
export GO_VERSION=1.13.5
export OS=linux
export ARCH=amd64

# clean up old installs if present
sudo rm -rf \
     singularity \
     /usr/local/go \
     /usr/local/libexec/singularity \
     /usr/local/var/singularity \
     /usr/local/etc/singularity \
     /usr/local/bin/singularity \
     /usr/local/bin/run-singularity \
     /usr/local/etc/bash_completion.d/singularity

# install system dependencies
sudo apt-get update
sudo apt-get -y install \
     build-essential \
     uuid-dev \
     libgpgme-dev \
     squashfs-tools \
     libseccomp-dev \
     wget \
     pkg-config \
     git\
     cryptsetup-bin

# download and install Go
wget https://dl.google.com/go/go$GO_VERSION.$OS-$ARCH.tar.gz 
sudo tar -C /usr/local -xzvf go$GO_VERSION.$OS-$ARCH.tar.gz
rm go$GO_VERSION.$OS-$ARCH.tar.gz   

# edit path to include Go
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc && source ~/.bashrc

# download Singularity
wget https://github.com/sylabs/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-${SINGULARITY_VERSION}.tar.gz
tar -xzf singularity-${SINGULARITY_VERSION}.tar.gz
rm singularity-${SINGULARITY_VERSION}.tar.gz
cd singularity

# compile Singularity
./mconfig
make -C builddir
sudo make -C builddir install


