cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

# project name and language
project(qmstk LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/subprojects)

set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage)
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")

add_subdirectory(external/hdf5)
add_subdirectory(external/libxml2)

include(ExternalProject)
ExternalProject_Add(ext_tests
  DEPENDS
    libxml2_external
    hdf5_external
  SOURCE_DIR
    ${CMAKE_CURRENT_LIST_DIR}/ext_tests
  CMAKE_ARGS 
  -DHDF5_DIR=${HDF5_DIR}
  INSTALL_COMMAND ""
  )
