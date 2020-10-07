message(STATUS "Build benchmarks")

file(GLOB_RECURSE BENCHMARK_SRC CONFIGURE_DEPENDS
     ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

find_package(benchmark REQUIRED)

add_executable(${BENCHMARKS_EXECUTABLE} ${BENCHMARK_SRC})
target_link_libraries(${BENCHMARKS_EXECUTABLE} PRIVATE ${LIBRARY}
                                                       benchmark::benchmark)
