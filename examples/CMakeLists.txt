cmake_minimum_required(VERSION 3.12)
project(examples LANGUAGES C CXX)

option(EXAMPLES_USE_ADD_SUBDIRECTORY "Use find package" OFF)

if(EXAMPLES_USE_ADD_SUBDIRECTORY)
  message(STATUS "Use add_subdirectory")
  add_subdirectory(cpp-template)
else()
  message(STATUS "Use find_package")
  find_package(klib REQUIRED)
endif()

file(GLOB SRC CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
foreach(FILE_PATH ${SRC})
  get_filename_component(FILE_NAME ${FILE_PATH} NAME_WE)
  add_executable(${FILE_NAME} ${FILE_PATH})
  target_link_libraries(${FILE_NAME} PRIVATE klib::klib)

  add_custom_target(
    run-${FILE_NAME} ALL
    COMMAND ${FILE_NAME}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${FILE_NAME}
    COMMENT "Run ${FILE_NAME}")

  # FIXME Cannot find header file on macos
  if(NOT (APPLE OR EXAMPLES_USE_ADD_SUBDIRECTORY))
    add_custom_target(
      run-${FILE_NAME}-pkg-config ALL
      COMMAND ${CMAKE_CXX_COMPILER} ${FILE_PATH} -o ${FILE_NAME}-pkg-config
              `pkg-config --libs --cflags klib`
      COMMAND ${FILE_NAME}
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      COMMENT "Run ${FILE_NAME} pkg-config")
  endif()
endforeach()
