find_package(LibXml2)
#
IF(LibXml2_FOUND)

  #get_property(_loc TARGET LibXml2::LibXml2 PROPERTY LOCATION)
  message(STATUS "Found LibXml2: ${LIBXML2_INCLUDE_DIR}")
  add_library(libxml2_external INTERFACE)  # dummy

else()

  set(libxml2_source  ${PROJECT_SOURCE_DIR}/Source/libxml2)
  IF(NOT EXISTS ${libxml2_source})
    message(STATUS "Suitable LIBXML2 could not be located. Downloading and building!")
    ExternalProject_Add(libxml2_download
      URL 
      http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
      SOURCE_DIR ${libxml2_source}
      UPDATE_COMMAND ""
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND ""
      )
  else()
    add_library(libxml2_download INTERFACE)  # dummy
  endif()
  #    DEPENDS libxml2_download
  #CCFLAGS=${CMAKE_C_FLAGS}

  ExternalProject_Add(libxml2_external
    SOURCE_DIR ${PROJECT_SOURCE_DIR}/Source/libxml2
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    LOG_CONFIGURE 1
    LOG_BUILD 1
    LOG_INSTALL 1
    CONFIGURE_COMMAND
      <SOURCE_DIR>/configure
      CC=${CMAKE_C_COMPILER}
      --prefix=${STAGED_INSTALL_PREFIX}
      --without-python 
      --without-readline 
      --without-threads 
      --without-history 
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
    )

  #  find_path(LIBXML2_INCLUDE_DIR NAME libxml/xpath.h PATHS ${STAGED_INSTALL_PREFIX}/include/libxml2)
  #  find_library(LIBXML2_LIBRARY NAMES xml2 PATHS ${STAGED_INSTALL_PREFIX}/lib) 

endif()
