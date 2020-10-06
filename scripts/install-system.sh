#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa
    sudo apt update
    sudo apt install gcc-10 g++-10 llvm valgrind flex bison libtinfo5

    # FIXME clang-tidy failed to install using apt
    wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
    tar -xf clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
    sudo ln clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang-tidy /usr/bin/clang-tidy

    PARALLEL=$(nproc)

    echo "System: $OSTYPE"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew update

    ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
    ln -s "$(brew --prefix llvm)/bin/llvm-cov" "/usr/local/bin/llvm-cov"
    ln -s "$(brew --prefix llvm)/bin/llvm-profdata" "/usr/local/bin/llvm-profdata"
    ln -s "$(brew --prefix llvm)/bin/llvm-ar" "/usr/local/bin/llvm-ar"
    ln -s "$(brew --prefix llvm)/bin/llvm-nm" "/usr/local/bin/llvm-nm"
    ln -s "$(brew --prefix llvm)/bin/llvm-ranlib" "/usr/local/bin/llvm-ranlib"
    ln -s "$(brew --prefix llvm)/bin/llvm-symbolizer" "/usr/local/bin/llvm-symbolizer"

    PARALLEL=$(sysctl -n hw.ncpu)

    echo "System: $OSTYPE"
else
    echo "The system does not support"
    exit 1
fi
