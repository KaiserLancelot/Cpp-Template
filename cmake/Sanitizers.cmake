if(SANITIZER)
  if(SANITIZER STREQUAL "Address")
    if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
      message(FATAL_ERROR "Windows does not support AddressSanitizer")
    endif()

    message(STATUS "Building with AddressSanitizer")
    string(APPEND CMAKE_CXX_FLAGS " -fsanitize=address -fno-omit-frame-pointer")
  elseif(SANITIZER STREQUAL "Thread")
    if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
      message(FATAL_ERROR "Windows does not support ThreadSanitizer")
    endif()

    message(STATUS "Building with ThreadSanitizer")
    string(APPEND CMAKE_CXX_FLAGS " -fsanitize=thread")
  elseif(SANITIZER STREQUAL "Undefined")
    if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
      message(FATAL_ERROR "MSVC does not support UndefinedSanitizer")
    endif()

    message(STATUS "Building with UndefinedSanitizer")
    string(APPEND CMAKE_CXX_FLAGS " -fsanitize=undefined")
  else()
    message(FATAL_ERROR "The Sanitizer is not supported: ${SANITIZER}")
  endif()
endif()
