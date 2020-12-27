cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

# project name and language
project(qmstk LANGUAGES CXX C Fortran)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(MPI)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/subprojects)

set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage)
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")

set(EXECUTABLE_OUTPUT_PATH ${qmstk_BINARY_DIR}/bin CACHE PATH "Binary directory")

find_package(LibXml2)

include(ExternalProject)
ExternalProject_Add(ext_tests
  SOURCE_DIR
    ${CMAKE_CURRENT_LIST_DIR}/ext_tests
  BINARY_DIR
    ${EXECUTABLE_OUTPUT_PATH}
  CMAKE_ARGS 
  -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
  -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
  -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
  -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
  -DLIBXML2_INCLUDE_DIR=${LIBXML2_INCLUDE_DIR}
  -DLIBXML2_LIBRARY=${LIBXML2_LIBRARY}
  INSTALL_COMMAND ""
  )
#  -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
#  -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS}

#  -DHDF5_DIR=${HDF5_DIR}
#  -DLibXml2_DIR=${LibXml2_DIR}
#find_package(HDF5)
#find_package(LibXml2)
#
#add_executable(xml_read ext_tests/xml_read.cpp)
#target_include_directories(xml_read
#  PUBLIC
#  ${LIBXML2_INCLUDE_DIR}
#  )
#target_link_libraries(xml_read
#  PRIVATE
#  ${LIBXML2_LIBRARIES}
#  )
