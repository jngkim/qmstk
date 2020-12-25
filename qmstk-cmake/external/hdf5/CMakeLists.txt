find_package(HDF5 CONFIG QUIET)

if(HDF5_FOUND)
  #  get_property(_loc TARGET hdf5 PROPERTY LOCATION)
  #  message(STATUS "Found HDF5: ${_loc} (found version ${HDF5_VERSION})")
  add_library(hdf5_external INTERFACE)  # dummy
else()

  message(STATUS "Suitable HDF5 could not be located. Downloading and building!")

  include(ExternalProject)

  IF(NOT EXISTS ${CMAKE_BINARY_DIR}/Source/hdf5)
    ExternalProject_Add(hdf5_download
      URL 
      http://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.10.5.tar.gz
      SOURCE_DIR ${CMAKE_BINARY_DIR}/Source/hdf5
      UPDATE_COMMAND ""
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND ""
      )
  else()
    add_library(hdf5_download INTERFACE)  # dummy
  endif()

  ExternalProject_Add(hdf5_external
    DEPENDS hdf5_download
    SOURCE_DIR ${CMAKE_BINARY_DIR}/Source/hdf5
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    LOG_CONFIGURE 1
    LOG_BUILD 1
    LOG_INSTALL 1

    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
    -DBUILD_TESTS=OFF
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
    -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
    -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
    -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS}
    -DHDF5_ENABLE_PARALLEL=${HAVE_MPI}
    )

  # CONFIGURE_COMMAND
  #       <SOURCE_DIR>/configure
  #       --prefix=${STAGED_INSTALL_PREFIX}

  include(GNUInstallDirs)

  set(
    HDF5_DIR ${STAGED_INSTALL_PREFIX}/share/cmake/hdf5
    CACHE PATH "Path to internally built HDF5Config.cmake"
    FORCE
    )
endif()
