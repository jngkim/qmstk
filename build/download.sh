#!/bin/bash

dest=Source

###download hdf5
mkdir -p $dest

if [ ! -x "$dest/hdf5" ]; then
  v=1.10.5
  file=hdf5-${v}.tar.gz 
  if [ ! -f "$file" ]; then
    wget https://support.hdfgroup.org/ftp/HDF5/current/src/$file
  fi
  tar -zxf $file 
  mv hdf5-${v} $dest/hdf5
fi

##
##download cmake 
if [ ! -x "$dest/cmake" ]; then
  v=3.19.2
  file=cmake-${v}.tar.gz
  if [ ! -f "$file" ]; then
    wget https://github.com/Kitware/CMake/releases/download/v${v}/$file
  fi
  tar -zxf $file 
  mv cmake-${v} Source/cmake
fi

###dowlonad libxml2
if [ ! -x "$dest/libxml2" ]; then
  v=2.9.8
  file=libxml2-${v}.tar.gz
  if [ ! -f "$file" ]; then
    wget  http://xmlsoft.org/sources/$file
  fi
  tar -zxf $file 
  mv libxml2-2.9.8 Source/libxml2
fi

#if [ ! -x "qe-6.4.1" ]; then
#  source ./download_and_patch_qe6.4.1.sh
#fi
#
