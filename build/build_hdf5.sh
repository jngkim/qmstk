#!/bin/bash
source ./env_common.sh
pushd hdf5

## first build serial version using gcc
#./configure --prefix=${INSTALLDIR}
#${MAKE}
#make install
#
## cleanup
#make distclean

CXX=mpiicpc CC=mpiicc ./configure --prefix=${INSTALLDIR}/impi --enable-fortran
${MAKE}
make install
popd
