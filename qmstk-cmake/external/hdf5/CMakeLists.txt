find_package(HDF5 QUIET)

if(HDF5_FOUND AND HDF5_IS_PARALLEL)
  #  get_property(_loc TARGET hdf5 PROPERTY LOCATION)
  #  message(STATUS "Found HDF5: ${_loc} (found version ${HDF5_VERSION})")
  add_library(phdf5 INTERFACE)  # dummy
else()

  message(STATUS "Suitable HDF5 could not be located. Downloading and building!")

  include(ExternalProject)

  #  IF(NOT EXISTS ${CMAKE_PROJECT_DIR}/Source/hdf5)
  #    ExternalProject_Add(hdf5_download
  #      URL 
  #      http://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.10.5.tar.gz
  #      SOURCE_DIR ${CMAKE_PROJECT_DIR}/Source/hdf5
  #      UPDATE_COMMAND ""
  #      CONFIGURE_COMMAND ""
  #      BUILD_COMMAND ""
  #      INSTALL_COMMAND ""
  #      )
  #  else()
  #    add_library(hdf5_download INTERFACE)  # dummy
  #  endif()

  ExternalProject_Add(phdf5
    SOURCE_DIR ${PROJECT_SOURCE_DIR}/Source/hdf5
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    LOG_CONFIGURE 1
    LOG_BUILD 1
    LOG_INSTALL 1
   CONFIGURE_COMMAND
         <SOURCE_DIR>/configure
         CC=${CMAKE_C_COMPILER}
         CXX=${CMAKE_CXX_COMPILER}
         FC=${CMAKE_Fortran_COMPILER}
         --prefix=${STAGED_INSTALL_PREFIX}
         --enable-parallel
         --enable-fortran
    )

  #CMAKE_ARGS
  #    -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
  #    -DBUILD_TESTS=OFF
  #    -DHDF5_ENABLE_PARALLEL=${HAVE_MPI}
  #    -DHDF5_ENABLE_FORTRAN=ON
  #    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
  #    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
  #    -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
  #    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}"
  #    -DCMAKE_C_FLAGS="${CMAKE_C_FLAGS}"
  #    -DCMAKE_Fortran_FLAGS="${CMAKE_Fortran_FLAGS}"
  #  include(GNUInstallDirs)

  set(
    HDF5_DIR ${STAGED_INSTALL_PREFIX}/share/cmake/hdf5
    CACHE PATH "Path to internally built HDF5Config.cmake"
    FORCE
    )

  set(
    HDF5_ROOT ${STAGED_INSTALL_PREFIX}
    CACHE PATH "Path to internally built HDF5Config.cmake"
    FORCE
    )
endif()
