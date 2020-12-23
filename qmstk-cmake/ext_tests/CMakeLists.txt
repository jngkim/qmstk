cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(ext_tests  LANGUAGES CXX)

find_package(HDF5 CONFIG REQUIRED)
get_property(_loc TARGET hdf5::hdf5-static PROPERTY LOCATION)
message(STATUS "Found HDF5: ${_loc} (found version ${HDF5_VERSION})")

add_executable(h5_write h5_write.cpp)

target_include_directories(h5_write
  PUBLIC
  ${HDF5_INCLUDE_DIRS}
  )
target_link_libraries(h5_write
  PRIVATE
  hdf5::hdf5-static
  )


find_package(LibXml2 REQUIRED)

add_executable(xml_read xml_read.cpp)
target_include_directories(xml_read
  PUBLIC
  ${LIBXML2_INCLUDE_DIR}
  )
target_link_libraries(xml_read
  PRIVATE
  ${LIBXML2_LIBRARIES}
  )

