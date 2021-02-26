set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(AddCompilerFlag)

# ---------------------------------------------------------------------------------------
# Coverage
# ---------------------------------------------------------------------------------------
if(KLIB_BUILD_COVERAGE OR KLIB_BUILD_ALL)
  if(CMAKE_COMPILER_IS_GNUCXX)
    add_compiler_flag("--coverage")
  else()
    add_compiler_flag("-fprofile-instr-generate")
    add_compiler_flag("-fcoverage-mapping")
  endif()
endif()

# ---------------------------------------------------------------------------------------
# libc++
# ---------------------------------------------------------------------------------------
if(KLIB_USE_LIBCXX)
  if(CMAKE_COMPILER_IS_GNUCXX)
    message(FATAL_ERROR "GCC does not support libc++")
  endif()

  message(STATUS "Use libc++")
  add_cxx_compiler_flag("-stdlib=libc++")

  # https://blog.jetbrains.com/clion/2019/10/clion-2019-3-eap-debugger-improvements/
  if((CMAKE_BUILD_TYPE STREQUAL "Debug") OR (CMAKE_BUILD_TYPE STREQUAL
                                             "RelWithDebInfo"))
    add_compiler_flag("-fstandalone-debug")
  endif()
endif()

# ---------------------------------------------------------------------------------------
# lld
# ---------------------------------------------------------------------------------------
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  message(STATUS "Use lld")
  add_link_options("-fuse-ld=lld")
endif()

# ---------------------------------------------------------------------------------------
# Sanitizer
# ---------------------------------------------------------------------------------------
if(KLIB_SANITIZER)
  if(NOT (KLIB_SANITIZER STREQUAL "Thread"))
    add_compiler_flag("-fno-omit-frame-pointer")
  endif()

  macro(append_address_sanitizer_flags)
    add_compiler_flag("-fsanitize=address")
    add_compiler_flag("-fsanitize-address-use-after-scope")
    add_compiler_flag("-fno-optimize-sibling-calls")
  endmacro()

  macro(append_undefined_sanitizer_flags)
    add_compiler_flag("-fsanitize=undefined")
    add_compiler_flag("-fno-sanitize-recover=all")

    if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
      add_compiler_flag("-fsanitize=float-divide-by-zero")
      add_compiler_flag("-fsanitize=unsigned-integer-overflow")
      add_compiler_flag("-fsanitize=implicit-conversion")
      add_compiler_flag("-fsanitize=local-bounds")
      add_compiler_flag("-fsanitize=nullability")
      add_compiler_flag("-fsanitize-recover=unsigned-integer-overflow")
    endif()
  endmacro()

  if(KLIB_SANITIZER STREQUAL "Address")
    message(STATUS "Build with AddressSanitizer")
    append_address_sanitizer_flags()
  elseif(KLIB_SANITIZER STREQUAL "Thread")
    message(STATUS "Build with ThreadSanitizer")
    add_compiler_flag("-fsanitize=thread")
  elseif(KLIB_SANITIZER STREQUAL "Memory")
    if(CMAKE_COMPILER_IS_GNUCXX)
      message(FATAL_ERROR "GCC does not support MemorySanitizer")
    endif()

    message(STATUS "Build with MemorySanitizer")

    add_compiler_flag("-fsanitize=memory")
    add_compiler_flag("-fsanitize-memory-track-origins")
    add_compiler_flag("-fsanitize-memory-use-after-dtor")
    add_compiler_flag("-fno-optimize-sibling-calls")
  elseif(KLIB_SANITIZER STREQUAL "Undefined")
    message(STATUS "Build with UndefinedSanitizer")
    append_undefined_sanitizer_flags()
  elseif(KLIB_SANITIZER STREQUAL "Address;Undefined")
    message(STATUS "Build with AddressSanitizer and UndefinedSanitizer")
    append_address_sanitizer_flags()
    append_undefined_sanitizer_flags()
  else()
    message(FATAL_ERROR "The Sanitizer is not supported: ${KLIB_SANITIZER}")
  endif()
endif()

# ---------------------------------------------------------------------------------------
# Warning
# ---------------------------------------------------------------------------------------
add_compiler_flag("-Wall")
add_compiler_flag("-Wextra")
add_compiler_flag("-Wpedantic")
add_compiler_flag("-Werror")

if(CMAKE_COMPILER_IS_GNUCXX)
  # TODO Use for C++
  add_c_compiler_flag("-fanalyzer")
else()
  add_compiler_flag("-Weverything")
  add_compiler_flag("-Wno-c++98-compat")
endif()
