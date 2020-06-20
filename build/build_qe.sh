#!/bin/bash
source ./env_common.sh

pushd $QE

./configure CC=mpiicc MPIF90=mpiifort F77=ifort \
  --prefix=${APPDIR}/${QE} \
  --enable-openmp \
  --with-scalapack=intel --with-hdf5=$INSTALLDIR/impi 

echo --- Make pw

make pw >&make_pw.out
echo --- Make pwall
make pwall >&make_pwall.out

popd

rm -rf ${APPDIR}/${QE}
cp -r $QE ${APPDIR}/
