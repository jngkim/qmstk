find_package(HDF5 CONFIG QUIET)

if(HDF5_FOUND)
  #  get_property(_loc TARGET hdf5 PROPERTY LOCATION)
  #  message(STATUS "Found HDF5: ${_loc} (found version ${HDF5_VERSION})")
  add_library(hdf5_external INTERFACE)  # dummy
else()

  message(STATUS "Suitable HDF5 could not be located. Downloading and building!")

  include(ExternalProject)
  ExternalProject_Add(hdf5_external
    URL 
    http://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.10.5.tar.gz
    DOWNLOAD_NO_PROGRESS
      1
    UPDATE_COMMAND
      ""
    LOG_CONFIGURE
      1
    LOG_BUILD
      1
    LOG_INSTALL
      1
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
      -DBUILD_TESTS=OFF
    )

  #    CONFIGURE_COMMAND
  #      <SOURCE_DIR>/configure
  #      --prefix=${STAGED_INSTALL_PREFIX}

  include(GNUInstallDirs)

  set(
    HDF5_DIR ${STAGED_INSTALL_PREFIX}/share/cmake/hdf5
    CACHE PATH "Path to internally built HDF5Config.cmake"
    FORCE
    )
endif()
