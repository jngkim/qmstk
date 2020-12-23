find_package(LibXml2)

IF(LibXml2_FOUND)

  #  get_property(_loc TARGET LibXml2::LibXml2 PROPERTY LOCATION)
  #   message(STATUS "Found LibXml2: ${_loc} (found version ${LIBXML2_VERSION})")
  add_library(libxml2_external INTERFACE)  # dummy

else()

  include(ExternalProject)

  message(STATUS "Suitable LIBXML2 could not be located. Downloading and building!")

  ExternalProject_Add(libxml2_external
    URL
    http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
    CONFIGURE_COMMAND
    CC=${CMAKE_C_COMPILER}
    <SOURCE_DIR>/configure
    --prefix=${STAGED_INSTALL_PREFIX}
    --without-zlib 
    --without-python 
    --without-readline 
    --without-threads 
    --without-history 
    --without-reader 
    --without-writer 
    --with-output 
    --without-ftp 
    --without-http 
    --without-pattern 
    --without-catalog 
    --without-docbook 
    --without-iconv 
    --without-schemas 
    --without-schematron 
    --without-modules 
    --without-xptr 
    --without-xinclude
    LOG_BUILD 1
    BUILD_IN_SOURCE 1
    )


  set(
    LIBXML2_DIR ${STAGED_INSTALL_PREFIX}/lib/cmake/libxml2
    CACHE PATH "Path to internally built libxml2-config.cmake"
    FORCE
    )

endif()
