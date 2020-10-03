if(KLIB_CLANG_TIDY)
  message(STATUS "Analyze code with clang-tidy")

  find_program(CLANG_TIDY_EXECUTABLE clang-tidy)

  if(NOT CLANG_TIDY_EXECUTABLE)
    message(FATAL_ERROR "Can not find clang-tidy")
  endif()

  set(CMAKE_CXX_CLANG_TIDY "clang-tidy;--export-fixes=clang-tidy.txt")
endif()
