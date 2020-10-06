#!/bin/bash

set -e

if [ ! -d "dependencies" ]; then
    echo "The dependencies directory does not exist"
    exit 1
fi

source $(dirname "$0")/install-system.sh

cd dependencies

# FIXME
ls

if [ -d llvm-project-llvmorg-* ]; then
    cd llvm-project-llvmorg-*
    # FIXME
    ls
    sudo cmake --build build --config Release --target install-cxx install-cxxabi
    cd ..
    echo "Install libc++ completed"
fi

cd benchmark-*
sudo cmake --build build --config Release --target install
cd ..
echo "Install google benchmark completed"

cd googletest-release-*
sudo cmake --build build --config Release --target install
cd ..
echo "Install google test completed"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cd lcov-*
    sudo make install
    cd ..
    echo "Install lcov completed"

    cd doxygen-Release_*
    sudo cmake --build build --config Release --target install
    cd ..
    echo "Install doxygen completed"
fi

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo ldconfig
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sudo update_dyld_shared_cache
fi

echo "Install completed"
