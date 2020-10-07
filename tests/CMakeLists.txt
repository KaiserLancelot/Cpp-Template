file(GLOB_RECURSE TESTS_SRC CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

find_package(GTest REQUIRED)

add_executable(${TESTS_EXECUTABLE} ${TESTS_SRC})
target_link_libraries(${TESTS_EXECUTABLE} PRIVATE ${LIBRARY} GTest::gtest)
gtest_discover_tests(${TESTS_EXECUTABLE})
