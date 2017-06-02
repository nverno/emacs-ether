#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

. ~/bin/utils.sh

install_deps() {
    if ! hash geth 2>/dev/null ; then
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository -y ppa:ethereum/ethereum
        sudo apt-get update -qq
        sudo apt-get install -y ethereum
    fi
}

# TODO: install CUDA
ensure_cuda_gpu() {
    if ! lspci | grep -i nvidia; then
        _error_exit "No nvidia driver found"
    fi
}

# NOTE: assumes CUDA is installed
# to install just openCL support, use -DBUNDLE=miner
install_cpp_miner() {
    if ! hash ethminer 2>/dev/null ; then
        # make sure there is a compatible GPU
        ensure_cuda_gpu
        
        sudo apt-get install -y git cmake libcryptopp-dev libleveldb-dev      \
             libjsoncpp-dev libjsonrpccpp-dev libboost-all-dev libgmp-dev     \
             libreadline-dev libcurl4-gnutls-dev ocl-icd-libopencl1           \
             opencl-headers mesa-common-dev libmicrohttpd-dev build-essential \
             cuda

        # install from repo
        (
            cd ~/src/
            if [ ! -d cpp-ethereum ]; then
                git clone https://github.com/Genoil/cpp-ethereum
            fi
            cd cpp-ethereum
            mkdir build && cd build
            cmake -DBUNDLE=cudaminer ..
            make -j4
        )
        
        # Link ethminer
        ln -s ~/src/cpp-ethereum/build/ethminer/ethminer ~/.local/bin/ethminer
    fi
}

"$@"
