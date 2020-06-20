# QUANTUM ESPRESSO

QE is an integrated suite of Open-Source computer codes for
electronic-structure calculations and materials modeling at the nanoscale. It
is based on density-functional theory, plane waves, and pseudopotentials.

https://www.quantum-espresso.org/

## Depedencies
* PHDF5

## Building QE
* Download the source (6.4) with patch for QMCPACK
* Use [`build_qe.sh`](../build/build_qe.sh) based on QMCPACK Users Workshop, 2019, to build QE
    * Using Intel(R) MPI and PHDF5
* `cd build; source build_qe.sh`
