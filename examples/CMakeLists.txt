cmake_minimum_required(VERSION 3.12)
project(examples LANGUAGES C CXX)

set(CMAKE_MODULE_PATH
    "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/../cmake")

include(Check)
include(CompilerOptions)
include(LTO)

find_package(klib REQUIRED)

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
endforeach()
