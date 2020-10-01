option(KLIB_BUILD_SHARED "Build shared library" OFF)
option(KLIB_BUILD_TESTS "Build tests" OFF)
option(KLIB_BUILD_BENCHMARKS "Build benchmarks" OFF)
option(KLIB_BUILD_DOCS "Build documentations" OFF)

option(KLIB_FORMAT "Format code using clang-format and cmake-format" OFF)
option(KLIB_CLANG_TIDY "Analyze code with clang-tidy" OFF)

if(CMAKE_CXX_COMPILER_ID MATCHES "(Apple)?Clang")
  option(KLIB_USE_LIBCXX "Use libc++" OFF)
endif()

include(CMakeDependentOption)
cmake_dependent_option(KLIB_COVERAGE "Build tests with coverage information"
                       OFF "KLIB_BUILD_TESTS" OFF)
cmake_dependent_option(KLIB_VALGRIND "Execute tests with valgrind" OFF
                       "KLIB_BUILD_TESTS" OFF)

set(KLIB_SANITIZER
    ""
    CACHE
      STRING
      "Build with a sanitizer. Options are: Address, Thread, Memory, Undefined and Address;Undefined"
)
