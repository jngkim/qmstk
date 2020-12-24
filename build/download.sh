#!/bin/bash

###download hdf5
mkdir -p Source
if [ ! -x "hdf5" ]; then
  v=1.10.5
  wget https://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-${v}.tar.gz
  tar -zxf hdf5-${v}.tar.gz  
  mv hdf5-${v} Source/hdf5
fi
#
#download cmake 
if [ ! -x "cmake" ]; then
  v=3.19.1
  wget https://github.com/Kitware/CMake/releases/download/v${v}/cmake-${v}.tar.gz
  tar -zxf cmake-${v}.tar.gz 
  mv cmake-${v} Source/cmake
fi

##dowlonad libxml2
if [ ! -x "libxml2" ]; then
  wget  http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
  tar -zxf libxml2-2.9.8.tar.gz 
  mv libxml2-2.9.8 Source/libxml2
fi

#if [ ! -x "qe-6.4.1" ]; then
#  source ./download_and_patch_qe6.4.1.sh
#fi
#
