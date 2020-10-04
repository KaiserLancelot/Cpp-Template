if(NOT DEFINED KLIB_MASTER_PROJECT)
  if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(KLIB_MASTER_PROJECT ON)
  else()
    set(KLIB_MASTER_PROJECT OFF)
  endif()
endif()

option(KLIB_BUILD_SHARED "Build shared library" OFF)

option(KLIB_BUILD_ALL
       "Build all executable, tests, benchmarks, documentations and coverage"
       OFF)
option(KLIB_BUILD_EXECUTABLE "Build executable" ${KLIB_MASTER_PROJECT})
option(KLIB_BUILD_TESTS "Build tests" OFF)
option(KLIB_BUILD_BENCHMARKS "Build benchmarks" OFF)
option(KLIB_BUILD_DOCS "Build documentations" OFF)

option(KLIB_FORMAT "Format code using clang-format and cmake-format" OFF)
option(KLIB_CLANG_TIDY "Analyze code with clang-tidy" OFF)

option(KLIB_INSTALL "Generate the install target" ${KLIB_MASTER_PROJECT})

if(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
  option(KLIB_USE_LIBCXX "Use libc++" ON)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  option(KLIB_USE_LIBCXX "Use libc++" OFF)
endif()

include(CMakeDependentOption)
cmake_dependent_option(
  KLIB_BUILD_COVERAGE "Build tests with coverage information" OFF
  "BUILD_TESTING;KLIB_BUILD_TESTS OR KLIB_BUILD_ALL" OFF)
cmake_dependent_option(KLIB_VALGRIND "Execute tests with valgrind" OFF
                       "BUILD_TESTING;KLIB_BUILD_TESTS OR KLIB_BUILD_ALL" OFF)

set(KLIB_SANITIZER
    ""
    CACHE
      STRING
      "Build with a sanitizer. Options are: Address, Thread, Memory, Undefined and Address;Undefined"
)
