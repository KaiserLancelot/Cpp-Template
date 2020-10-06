#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa
    sudo apt update
    sudo apt install gcc-10 g++-10 llvm valgrind

    # FIXME clang-tidy failed to install using apt
    wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
    tar -xf clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
    sudo ln clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang-tidy /usr/bin/clang-tidy

    export CC=gcc-10
    export CXX=g++-10
else
    echo "The system does not support: $OSTYPE"
    exit 1
fi
