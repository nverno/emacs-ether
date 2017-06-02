#!/usr/bin/env bash

install_deps() {
    if ! hash geth 2>/dev/null ; then
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository -y ppa:ethereum/ethereum
        sudo apt-get update -qq
        sudo apt-get install -y ethereum
    fi
}

install_cpp_ethereum() {
    if ! hash eth 2>/dev/null ; then
        sudo apt-get install -y cpp-ethereum
    fi
}

"$@"
