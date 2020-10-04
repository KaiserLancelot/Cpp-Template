# cpp-template

[![Build](https://github.com/KaiserLancelot/cpp-template/workflows/Build/badge.svg)](https://github.com/KaiserLancelot/cpp-template/actions?query=workflow%3ABuild)
[![Coverage Status](https://coveralls.io/repos/github/KaiserLancelot/cpp-template/badge.svg)](https://coveralls.io/github/KaiserLancelot/cpp-template)
[![Documentation](https://img.shields.io/badge/docs-doxygen-blue)](https://kaiserlancelot.github.io/cpp-template)
[![GitHub License](https://img.shields.io/github/license/KaiserLancelot/cpp-template)](https://raw.githubusercontent.com/KaiserLancelot/cpp-template/master/LICENSE)
[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)
[![GitHub Releases](https://img.shields.io/github/release/KaiserLancelot/cpp-template)](https://github.com/KaiserLancelot/cpp-template/releases/latest)
[![GitHub Downloads](https://img.shields.io/github/downloads/KaiserLancelot/cpp-template/total)](https://github.com/KaiserLancelot/cpp-template/releases)
[![Bugs](https://img.shields.io/github/issues/KaiserLancelot/cpp-template/bug)](https://github.com/KaiserLancelot/cpp-template/issues?q=is%3Aopen+is%3Aissue+label%3Abug)

A template for C++ projects using CMake

## Build

```shell
cmake -S . -B build
cmake --build build --config Release
```

[CMake options](https://raw.githubusercontent.com/KaiserLancelot/cpp-template/master/cmake/Options.cmake)

## Install

```shell
sudo cmake --build build --config Release --target install
```

## Usage with CMake

```cmake
add_subdirectory(klib)
```

or

```cmake
find_package(klib)
target_link_libraries(<your-target> PRIVATE klib::klib)
```

## Benchmark

https://kaiserlancelot.github.io/cpp-template/dev/bench/

## Reference

### Github Action

- https://docs.github.com/cn/actions
- https://github.com/actions/virtual-environments
- https://github.com/actions/checkout
- https://github.com/actions/upload-release-asset
- https://github.com/actions/upload-artifact
- https://github.com/github/codeql-action
- https://github.com/coverallsapp/github-action
- https://github.com/rhysd/github-action-benchmark
- https://github.com/peaceiris/actions-gh-pages

### CMake

- https://cmake.org/cmake/help/latest/
- https://gcc.gnu.org/onlinedocs/gcc-10.2.0/gcc/Option-Summary.html#Option-Summary
- https://clang.llvm.org/docs/ClangCommandLineReference.html
- https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/RPATH-handling
- https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators

### Coverage

- https://github.com/linux-test-project/lcov
- https://llvm.org/docs/CommandGuide/llvm-cov.html
- https://clang.llvm.org/docs/SourceBasedCodeCoverage.html

### Sanitizer

- https://github.com/google/sanitizers/wiki/AddressSanitizer
- https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
- https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
- https://github.com/google/sanitizers/wiki/MemorySanitizer
- https://github.com/google/sanitizers/wiki/MemorySanitizerLibcxxHowTo
- https://clang.llvm.org/docs/AddressSanitizer.html
- https://clang.llvm.org/docs/LeakSanitizer.html
- https://clang.llvm.org/docs/ThreadSanitizer.html
- https://clang.llvm.org/docs/MemorySanitizer.html
- https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html

### Tools

- https://www.valgrind.org/docs/manual/manual.html
- https://github.com/cheshirekow/cmake_format
- https://clangd.llvm.org/
- https://clang.llvm.org/docs/ClangFormat.html
- https://clang.llvm.org/extra/clang-tidy/
- https://clang.llvm.org/extra/clang-tidy/checks/readability-identifier-naming.html
- https://clang.llvm.org/extra/clang-tidy/checks/list.html
- https://clang.llvm.org/docs/analyzer/checkers.html
- https://www.doxygen.nl/manual/index.html
