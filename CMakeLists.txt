cmake_minimum_required(VERSION 3.12)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(Version)
klib_extract_version()

project(
  klib
  VERSION ${KLIB_VERSION}
  LANGUAGES C CXX)

message(STATUS "Build ${PROJECT_NAME}: ${KLIB_VERSION}")

include(Options)
include(Check)
include(ClangTidy)
include(CompilerOptions)
include(Doxygen)
include(Format)
include(Sanitizer)

set(LIBRARY ${PROJECT_NAME})
set(EXECUTABLE executable)
set(TESTS_EXECUTABLE gtest)
set(BENCHMARKS_EXECUTABLE benchmark)

file(GLOB_RECURSE LIBRARY_SRC CONFIGURE_DEPENDS
     ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
set(EXECUTABLE_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp)
list(REMOVE_ITEM LIBRARY_SRC ${EXECUTABLE_SRC})

if(KLIB_BUILD_SHARED)
  message(STATUS "Build shared library")
  include(LTO)
  add_library(${LIBRARY} SHARED ${LIBRARY_SRC})
else()
  message(STATUS "Build static library")
  add_library(${LIBRARY} STATIC ${LIBRARY_SRC})
endif()

add_library(${LIBRARY}::${LIBRARY} ALIAS ${LIBRARY})

if(NOT KLIB_BUILD_SHARED)
  include(LTO)
endif()

target_include_directories(
  ${LIBRARY} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
                    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")
set_target_properties(${LIBRARY} PROPERTIES VERSION ${KLIB_VERSION}
                                            SOVERSION ${KLIB_VERSION_MAJOR})
set_target_properties(${LIBRARY} PROPERTIES DEBUG_POSTFIX d)

add_executable(${EXECUTABLE} ${EXECUTABLE_SRC})
target_link_libraries(${EXECUTABLE} PRIVATE ${LIBRARY})

add_custom_target(
  run
  COMMAND ${EXECUTABLE}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${EXECUTABLE}
  COMMENT "Run")

include(CTest)
if(BUILD_TESTING AND KLIB_BUILD_TESTS)
  message(STATUS "Build tests")

  enable_testing()

  include(Coverage)
  include(Valgrind)

  file(GLOB_RECURSE TESTS_SRC CONFIGURE_DEPENDS
       ${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp)

  find_package(GTest REQUIRED)

  add_executable(${TESTS_EXECUTABLE} ${TESTS_SRC})
  target_link_libraries(${TESTS_EXECUTABLE} PRIVATE ${LIBRARY} GTest::gtest)
  gtest_discover_tests(${TESTS_EXECUTABLE})

  add_custom_target(
    run-tests
    COMMAND ${TESTS_EXECUTABLE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${TESTS_EXECUTABLE}
    COMMENT "Run tests")
endif()

if(KLIB_BUILD_BENCHMARKS)
  message(STATUS "Build benchmarks")

  file(GLOB_RECURSE BENCHMARK_SRC CONFIGURE_DEPENDS
       ${CMAKE_CURRENT_SOURCE_DIR}/benchmarks/*.cpp)

  find_package(benchmark REQUIRED)

  add_executable(${BENCHMARKS_EXECUTABLE} ${BENCHMARK_SRC})
  target_link_libraries(${BENCHMARKS_EXECUTABLE} PRIVATE ${LIBRARY}
                                                         benchmark::benchmark)

  add_custom_target(
    run-benchmarks
    COMMAND ${BENCHMARKS_EXECUTABLE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${BENCHMARKS_EXECUTABLE}
    COMMENT "Run benchmarks")
endif()

include(Install)
include(TheCPack)
