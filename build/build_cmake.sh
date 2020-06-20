#!/bin/bash
source ./env_common.sh
pushd cmake
./configure --prefix=${INSTALLDIR}
#disable OpenSSL
sed  -i -e  's/OPENSSL:BOOL=ON/OPENSSL:BOOL=OFF/' CMakeCache.txt 
${MAKE}
${MAKE} install
popd
