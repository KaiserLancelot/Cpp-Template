#!/bin/bash

set -e

if [ ! -d "dependencies" ]; then
    echo "The dependencies directory does not exist"
    exit 1
fi

source $(dirname "$0")/install-system.sh

cd dependencies

if [ -d llvm-project-llvmorg-* ]; then
    cd llvm-project-llvmorg-*
    sudo cmake --build build --config Release --target install-cxx install-cxxabi
    cd ..
fi

cd benchmark-*
sudo cmake --build build --config Release --target install

cd ..

cd googletest-release-*
sudo cmake --build build --config Release --target install

cd ..

cd lcov-*
sudo make install

cd ..

cd doxygen-Release_*
sudo cmake --build build --config Release --target install

cd ..

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo ldconfig
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sudo update_dyld_shared_cache
fi

echo "Install completed"
