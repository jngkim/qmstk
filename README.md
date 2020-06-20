# qmstk 
Quantum Materials Simulation Toolkit:
collection of utilities, libraries and applications for quantum materials
simulations (QMS).

## Working with oneAPI HPC Toolkit docker container
* [Intel oneAPI Toolkit Containers](https://github.com/intel/oneapi-containers)
* [Docker Desktop for Mac](oneapi_docker_mac.md)
* [Docker on ubuntu](oneapi_docker_ubuntu.md)
* Start docker vm/daemon, open a terminal and start docker: 
    ```
    $image=intel/oneapi-hpckit
    $docker pull "$image"
    $docker run -it -v ~/workspace:/workspace $image /bin/bash
    ```
* oneAPI docker image does not come with vim. By mounting a workspace
directory, one can edit and do usual work in a separate terminal. From now on,
the working directory is `/workspace/qmstk` which is `~/workspace/qmstk` on my Mac.

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
