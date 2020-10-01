include(GNUInstallDirs)

set(project_config_in "${CMAKE_CURRENT_SOURCE_DIR}/cmake/klibConfig.cmake.in")
set(project_config_out "${CMAKE_CURRENT_BINARY_DIR}/klibConfig.cmake")
set(config_targets_file "klibConfigTargets.cmake")
set(version_config_file "${CMAKE_CURRENT_BINARY_DIR}/klibConfigVersion.cmake")
set(export_dest_dir "${CMAKE_INSTALL_LIBDIR}/cmake/klib")

set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib;$\{ORIGIN\}")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES
     "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
if("${isSystemDir}" STREQUAL "-1")
  set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib;$\{ORIGIN\}")
endif()

install(TARGETS ${EXECUTABLE} DESTINATION ${CMAKE_INSTALL_BINDIR})
install(TARGETS ${LIBRARY} DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(
  TARGETS ${LIBRARY}
  EXPORT ${LIBRARY}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

install(
  EXPORT ${LIBRARY}
  DESTINATION ${export_dest_dir}
  NAMESPACE ${LIBRARY}::
  FILE ${config_targets_file})

include(CMakePackageConfigHelpers)
configure_file("${project_config_in}" "${project_config_out}" @ONLY)

write_basic_package_version_file("${version_config_file}"
                                 COMPATIBILITY SameMajorVersion)
install(FILES "${project_config_out}" "${version_config_file}"
        DESTINATION "${export_dest_dir}")
