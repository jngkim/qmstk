#!/bin/bash

source ./env_common.sh

mkdir -p qmcpack

pushd qmcpack

rm -rf *
CXX=mpiicpc CC=icc cmake ${QMCPACKTOP} \
  -DQMC_MIXED_PRECISION=1 \
  -DBOOST_ROOT=${BOOST_ROOT} \
  -DHDF5_ROOT=${INSTALLDIR} \
  -DCMAKE_INSTALL_PREFIX=${APPDIR}/qmcpack
${MAKE}
make install

#rm -rf *
#CXX=mpiicpc CC=icc cmake ${QMCPACKTOP} \
#  -DQMC_MIXED_PRECISION=1 -DQMC_COMPLEX=1\
#  -DBOOST_ROOT=${BOOST_ROOT} \
#  -DCMAKE_INSTALL_PREFIX=${APPDIR}/qmcpack/mixed-complex
#${MAKE}
#make install

popd
