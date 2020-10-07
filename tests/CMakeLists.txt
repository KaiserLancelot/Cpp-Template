message(STATUS "Build tests")

file(GLOB_RECURSE TESTS_SRC CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

find_package(GTest REQUIRED)

add_executable(${TESTS_EXECUTABLE} ${TESTS_SRC})
target_link_libraries(${TESTS_EXECUTABLE} PRIVATE ${LIBRARY} GTest::gtest)
gtest_discover_tests(${TESTS_EXECUTABLE})

if(KLIB_VALGRIND)
  message(STATUS "Execute tests with valgrind")

  find_program(VALGRIND_EXECUTABLE valgrind)

  if(NOT VALGRIND_EXECUTABLE)
    message(FATAL_ERROR "Can not find valgrind")
  endif()

  add_test(
    NAME ${TESTS_EXECUTABLE}-valgrind
    COMMAND ${VALGRIND_EXECUTABLE} --error-exitcode=1 --track-origins=yes
            --gen-suppressions=all --leak-check=full ./${TESTS_EXECUTABLE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()
