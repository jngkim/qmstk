# qmstk 
Quantum Materials Simulation Toolkit:
collection of utilities, libraries and applications for quantum materials
simulations (QMS).

## Working with oneAPI HPC Toolkit docker container
* [Docker Desktop for Mac](oneapi_docker_mac.md)
* [Docker on ubuntu](oneapi_docker_ubuntu.md)
* Start docker vm/daemon, open a terminal and start docker: 
    ```
    $oneapi=amr-registry.caas.intel.com/oneapi/oneapi:hpc-dev-ubuntu18.04
    $docker pull $oneapi
    $docker run -it -v ~/workspace:/workspace $oneapi /bin/bash
    ```
* Open a separate terminal and use `~/workspace` to do usual work: download and edit files.
### Building common and apps (all in docker container)
* Set environment using [setenv.sh](setenv.sh)
    ```
    $docker run -it -v ~/workspace:/workspace $oneapi /bin/bash
    root@f9deb89b0818:/# source /workspace/qmstk/setenv.sh
    root@f9deb89b0818:/# which clang++
    /opt/intel/inteloneapi/dpcpp_compiler/latest/bin/clang++
    ```
* Build common utilities and applications using the scripts in `/workspace/qmstk/build` directory.
    * [common/README.md](common/README.md) describes a method used to build cmake/hdf5/libxml2 for QMCPACK.
    * Download packages in a normal shell in ~/workspace directory. See [build/download.sh](build/download.sh)
* Build applications
    * Check the dependencies of each application and determine the build sequence
## Directory tree
- qmstk
    - build
    - common
    - apps

### build
* Directory with scripts to download, build and install software
    * env_common.sh : set common variables to build
    * download.sh 
    * build_xyz.sh : build xyz
    * cleanup.sh 
### common
* Directory where common utilities and libraries for QMS applications are installed using the scripts in `build`.
    ```
    $ls common/
    bin	doc	include	lib	share
    ```
* oneAPI HPC Toolkit container does not come with HPC utilities, such as HDF5,
  latest cmake and boost headers. 
* Use the scripts in `build` directory to build cmake/hdf5/libxml2 
### apps
* Directory where applications are installed.

## QMS applications
Selected applications from [QMCPACK Users Workshop, 2019](https://github.com/QMCPACK/qmcpack_workshop_2019).
* [QUANTUM ESPRESSO](apps/qe.md) : hdf5
* [QMCPACK](apps/qmcpack.md) : hdf5/libxml2/cmake/QE
* [PySCF](apps/pyscf.md)
