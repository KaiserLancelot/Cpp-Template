if(KLIB_VALGRIND)
  if(NOT (BUILD_TESTING AND (KLIB_BUILD_TESTS OR KLIB_BUILD_ALL)))
    message(
      FATAL_ERROR
        "Need to build tests, pass -DKLIB_BUILD_TESTS=ON or -DKLIB_BUILD_ALL=ON"
    )
  endif()

  if(APPLE)
    message(FATAL_ERROR "macOS does not support valgrind")
  endif()

  message(STATUS "Execute tests with valgrind")

  find_program(VALGRIND_EXECUTABLE valgrind)

  if(NOT VALGRIND_EXECUTABLE)
    message(FATAL_ERROR "Can not find valgrind")
  endif()

  add_test(
    NAME ${TESTS_EXECUTABLE}-valgrind
    COMMAND ${VALGRIND_EXECUTABLE} --error-exitcode=1 --track-origins=yes
            --gen-suppressions=all --leak-check=full ${TESTS_EXECUTABLE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()
