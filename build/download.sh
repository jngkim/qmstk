#!/bin/bash

###download hdf5
if [ ! -x "hdf5" ]; then
  hdf5=hdf5-1.10.5
  wget https://support.hdfgroup.org/ftp/HDF5/current/src/$hdf5.tar.gz
  tar -zxf $hdf5.tar.gz 
  mv $hdf5 ./hdf5
fi
#
#download cmake 
if [ ! -x "cmake" ]; then
  wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2.tar.gz
  tar -zxvf cmake-3.15.2.tar.gz
  mv cmake-3.15.2 cmake
fi

#dowlonad libxml2
if [ ! -x "libxml2" ]; then
  wget  http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
  tar -zxvf libxml2-2.9.8.tar.gz
  mv libxml2-2.9.8 libxml2
fi

if [ ! -x "qe-6.4.1" ]; then
  source ./download_and_patch_qe6.4.1.sh
fi

