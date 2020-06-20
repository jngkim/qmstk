# QMCPACK

QMCPACK : An open source ab initio Quantum Monte Carlo package for the
electronic structure of atoms, molecules, and solids,
[J. Kim et al J. Phys.: Condens. Matter 30 195901
(2018)](https://iopscience.iop.org/article/10.1088/1361-648X/aab9c3)

https://www.qmcpack.org/

## Depedencies
* PHDF5
* libxml2
* boost
* cmake

## Building QMCPACK
* Download the source from http://www.qmcpack.org in any directory under `workspace`
* Edit `build/env_common.sh` to set QMCPACKTOP=/workspace/*where*
    * QMCPACKTOP=/workspace/src/qmcpack.main.git
* Now, `cd build; source build_qmcpack.sh`

