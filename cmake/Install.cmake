# https://github.com/gabime/spdlog/blob/v1.x/CMakeLists.txt
# https://github.com/gabime/spdlog/blob/v1.x/cmake/spdlogCPack.cmake
# https://github.com/facebook/zstd/blob/dev/build/cmake/lib/CMakeLists.txt
if(KLIB_INSTALL)
  message(STATUS "Generate the install target")

  include(GNUInstallDirs)

  # ---------------------------------------------------------------------------------------
  # Install executable
  # ---------------------------------------------------------------------------------------
  if(KLIB_BUILD_EXECUTABLE OR KLIB_BUILD_ALL)
    set(CMAKE_SKIP_BUILD_RPATH FALSE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
    set(CMAKE_INSTALL_RPATH
        "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR};$\{ORIGIN\}")
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

    list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES
         "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}" isSystemDir)
    if(${isSystemDir} STREQUAL "-1")
      set(CMAKE_INSTALL_RPATH
          "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR};$\{ORIGIN\}")
    endif()

    install(TARGETS ${EXECUTABLE} DESTINATION ${CMAKE_INSTALL_BINDIR})
  endif()

  # ---------------------------------------------------------------------------------------
  # Include files
  # ---------------------------------------------------------------------------------------
  install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
  install(
    TARGETS ${LIBRARY_TARGETS}
    EXPORT KLIBEXPORTS
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

  # ---------------------------------------------------------------------------------------
  # Install CMake config files
  # ---------------------------------------------------------------------------------------
  set(KLIB_EXPORT_DEST_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/${LIBRARY}")
  set(KLIB_CONFIG_TARGETS_FILE "${LIBRARY}ConfigTargets.cmake")

  install(
    EXPORT KLIBEXPORTS
    DESTINATION ${KLIB_EXPORT_DEST_DIR}
    NAMESPACE ${LIBRARY}::
    FILE ${KLIB_CONFIG_TARGETS_FILE})

  set(KLIB_PROJECT_CONFIG_IN
      "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${LIBRARY}Config.cmake.in")
  set(KLIB_PROJECT_CONFIG_OUT
      "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY}Config.cmake")
  set(KLIB_VERSION_CONFIG_FILE
      "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY}ConfigVersion.cmake")

  include(CMakePackageConfigHelpers)
  configure_file(${KLIB_PROJECT_CONFIG_IN} ${KLIB_PROJECT_CONFIG_OUT} @ONLY)

  write_basic_package_version_file(${KLIB_VERSION_CONFIG_FILE}
                                   COMPATIBILITY SameMajorVersion)
  install(FILES ${KLIB_PROJECT_CONFIG_OUT} ${KLIB_VERSION_CONFIG_FILE}
          DESTINATION ${KLIB_EXPORT_DEST_DIR})

  # ---------------------------------------------------------------------------------------
  # Project information
  # ---------------------------------------------------------------------------------------
  set(KLIB_VENDOR "kaiser")
  set(KLIB_CONTACT "kaiser <KaiserLancelot123@gmail.com>")
  set(KLIB_PROJECT_URL "https://github.com/KaiserLancelot/cpp-template")
  set(KLIB_DESCRIPTION_SUMMARY "A template for C++ projects using CMake")

  # ---------------------------------------------------------------------------------------
  # Install pkg-config file
  # ---------------------------------------------------------------------------------------
  set(KLIB_PKG_CONFIG_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/pkgconfig")
  set(KLIB_PKG_CONFIG "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY}.pc")
  set(KLIB_PKG_CFLAGS "-std=c++2a")

  get_target_property(KLIB_PKG_CONFIG_DEFINES ${LIBRARY}
                      INTERFACE_COMPILE_DEFINITIONS)
  string(REPLACE ";" " -D" KLIB_PKG_CONFIG_DEFINES "${KLIB_PKG_CONFIG_DEFINES}")
  string(CONCAT KLIB_PKG_CONFIG_DEFINES "-D" "${KLIB_PKG_CONFIG_DEFINES}")
  configure_file("cmake/${LIBRARY}.pc.in" "${KLIB_PKG_CONFIG}" @ONLY)
  install(FILES "${KLIB_PKG_CONFIG}"
          DESTINATION "${KLIB_PKG_CONFIG_INSTALL_DIR}")

  # ---------------------------------------------------------------------------------------
  # Support creation of installable packages
  # ---------------------------------------------------------------------------------------
  set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0)
  set(CPACK_INSTALL_CMAKE_PROJECTS ${CMAKE_CURRENT_BINARY_DIR} ${LIBRARY} ALL .)

  set(CPACK_PROJECT_URL ${KLIB_PROJECT_URL})
  set(CPACK_PACKAGE_VENDOR ${KLIB_VENDOR})
  set(CPACK_PACKAGE_CONTACT ${KLIB_CONTACT})
  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${KLIB_DESCRIPTION_SUMMARY})
  set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
  set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
  set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
  set(CPACK_PACKAGE_VERSION
      ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}
  )
  if(PROJECT_VERSION_TWEAK)
    set(CPACK_PACKAGE_VERSION ${CPACK_PACKAGE_VERSION}.${PROJECT_VERSION_TWEAK})
  endif()
  set(CPACK_PACKAGE_RELOCATABLE
      ON
      CACHE BOOL "Build relocatable package")

  set(CPACK_GENERATOR
      "DEB"
      CACHE STRING "Semicolon separated list of generators")

  set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)

  set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS "")
  include(InstallRequiredSystemLibraries)

  include(CPack)
endif()
