#!/bin/bash

set -e

BUILD_TYPE=Release

while getopts 'g' OPT; do
    case $OPT in
    m)
        BUILD_TYPE=RelWithDebInfo
        ;;
    ?)
        exit 1
        ;;
    esac
done

if [ ! -d "dependencies" ]; then
    echo "The dependencies directory does not exist"
    exit 1
fi

source $(dirname "$0")/install-system.sh

cd dependencies

if [ -d llvm-project-llvmorg-* ]; then
    cd llvm-project-llvmorg-*
    sudo cmake --build build --config RelWithDebInfo --target install-cxx install-cxxabi
    cd ..
    echo "Install libc++ completed"
fi

cd benchmark-*
sudo cmake --build build --config Release --target install
cd ..
echo "Install google benchmark completed"

cd googletest-release-*
sudo cmake --build build --config $BUILD_TYPE --target install
cd ..
echo "Install google test completed"

cd lcov-*
sudo make install
cd ..
echo "Install lcov completed"

cd doxygen-Release_*
sudo cmake --build build --config Release --target install
cd ..
echo "Install doxygen completed"

cd ..

sudo ldconfig

echo "Install completed"
