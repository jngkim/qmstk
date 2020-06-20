#!/bin/bash
source ./env_common.sh
pushd cmake
./configure --prefix=${INSTALLDIR}
${MAKE}
${MAKE} install
popd
