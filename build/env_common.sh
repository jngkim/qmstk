#!/bin/bash

INSTALLDIR=/workspace/qmstk/common
APPDIR=/workspace/qmstk/apps

QE=qe-6.4.1
QMCPACKTOP=/workspace/src/qmcpack.main.git
BOOST_ROOT=/workspace/qmstk/build/boost 

#Using 4 threas on a Macbook Pro. 
MAKE="make -j4"
#MAKE="make -j 32"
