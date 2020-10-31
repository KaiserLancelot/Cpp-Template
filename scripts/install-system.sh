#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa
    sudo apt update
    sudo apt install gcc-10 g++-10 valgrind

    bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

    sudo apt install llvm-11

    sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 100
    sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 100
    sudo update-alternatives --install /usr/bin/llvm-profdata llvm-profdata /usr/bin/llvm-profdata-11 100
    sudo update-alternatives --install /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-11 100
    sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-11 100
    sudo update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-11 100
    sudo update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-11 100
    sudo update-alternatives --install /usr/bin/llvm-ranlib llvm-ranlib /usr/bin/llvm-ranlib-11 100
    sudo update-alternatives --install /usr/bin/llvm-symbolizer llvm-symbolizer /usr/bin/llvm-symbolizer-11 100
    sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-11 100
    sudo update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-11 100

    export CC=gcc-10
    export CXX=g++-10
else
    echo "The system does not support: $OSTYPE"
    exit 1
fi
