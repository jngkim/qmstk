cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(ext_tests  LANGUAGES CXX C)

find_package(MPI)

IF(MPI_FOUND)
  SET(HDF5_PREFER_PARALLEL TRUE CACHE BOOL "Request parallel/serial HDF5 library")
ELSE()
  SET(HDF5_PREFER_PARALLEL FALSE CACHE BOOL "Request parallel/serial HDF5 library")
ENDIF()

find_package(HDF5 COMPONENTS C REQUIRED)
find_package(LibXml2 REQUIRED)

add_executable(h5_write h5_write.cpp)

target_include_directories(h5_write
  PUBLIC
  ${HDF5_INCLUDE_DIRS}
  )
target_link_libraries(h5_write
  PRIVATE
  hdf5::hdf5
  )

add_executable(xml_read xml_read.cpp)

target_include_directories(xml_read
  PUBLIC
  ${LIBXML2_INCLUDE_DIRS}
  )
target_link_libraries(xml_read
  PRIVATE
  ${LIBXML2_LIBRARIES}
  )
