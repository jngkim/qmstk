# oneAPI HPC Toolkit docker on macOS

Jeongnim Kim, DCG/E&G/ECO/NTET, 2019-08-17

Before start, visit these sites and get familiar with oneAPI/Docker.
* https://docs.docker.com/docker-for-mac/
* https://gitlab.devtools.intel.com/sip-oneapi/oneapi-containers

## Getting started 

### Install Docker Desktop for Mac (DD4M) 
* Download DD4M at https://docs.docker.com/docker-for-mac/
* Start DD4M: all captured of getting started page

### Working with DD4M and oneAPI HPC Toolkit
Once DD4M installation is successful, open a terminal to use docker. From now
on, we are working on a terminal and *$* is prepended for commands.
*  Check docker installation
```
  $ docker --version
  Docker version 19.03.1, build 74b1e89
```
* Download oneAPI HPC Toolkit: https://gitlab.devtools.intel.com/sip-oneapi/oneapi-containers
```
  $oneapi=intel/oneapi-hpckit
  $docker pull $oneapi
```
* Start oneAPI HPC Toolkit
```
  $docker run -it -v ~/workspace:/workspace $oneapi /bin/bash
  root@3b8985c493e5:/# ls
  bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var workspace
```
`~/workspace` is mounted as /workspace and its subdirectories are accessible.
```
  root@d57af0fb9441:/workspace/qmstk# df
Filesystem     1K-blocks      Used Available Use% Mounted on
overlay         61255492  17691732  40422436  31% /
tmpfs              65536         0     65536   0% /dev
tmpfs            1023420         0   1023420   0% /sys/fs/cgroup
shm                65536         0     65536   0% /dev/shm
osxfs          488245288 352836116 129464480  74% /workspace
/dev/sda1       61255492  17691732  40422436  31% /etc/hosts
tmpfs            1023420         0   1023420   0% /proc/acpi
tmpfs            1023420         0   1023420   0% /sys/firmware
```

> oneAPI docker image does not come with any editor. By mounting a workspace
directory, one can edit and do usual work in a separate terminal. From now on,
the working directory is `/workspace/qmstk` which is `~/workspace/qmstk` on my Mac.

## Running oneAPI in the container
* Setup environments: `source /opt/intel/inteloneapi/setvars.sh` 
```
root@d57af0fb9441:/workspace/qmstk# env | grep LIBRARY_PATH
LD_LIBRARY_PATH=/opt/intel/inteloneapi/mpi/2021.1-alpha01//libfabric/lib:/opt/intel/inteloneapi/mpi/2021.1-alpha01//lib/release:/opt/intel/inteloneapi/mpi/2021.1-alpha01//lib:/opt/intel/inteloneapi/mkl/2021.1-alpha01/lib/intel64:/opt/intel/inteloneapi/itac/2021.1-alpha01/slib:/opt/intel/inteloneapi/intelpython/latest/lib/libfabric:/opt/intel/inteloneapi/intelpython/latest/lib:/opt/intel/inteloneapi/compiler/latest/lib/oclfpga/host/linux64/lib:/opt/intel/inteloneapi/compiler/latest/lib/oclfpga/linux64/lib:/opt/intel/inteloneapi/compiler/latest/lib/oclgpu:/opt/intel/inteloneapi/compiler/latest/lib/oclcpu/x64:/opt/intel/inteloneapi/compiler/latest/lib:/opt/intel/inteloneapi/compiler/latest/compiler/lib/intel64_lin:/opt/intel/inteloneapi/compiler/latest/lib:/opt/intel/inteloneapi/compiler/latest/linux/compiler/lib/intel64_lin:/opt/intel/inteloneapi/compiler/latest/linux/lib
LIBRARY_PATH=/opt/intel/inteloneapi/mpi/2021.1-alpha01//libfabric/lib:/opt/intel/inteloneapi/mpi/2021.1-alpha01//lib/release:/opt/intel/inteloneapi/mpi/2021.1-alpha01//lib:/opt/intel/inteloneapi/mkl/2021.1-alpha01/lib/intel64:/opt/intel/inteloneapi/intelpython/latest/lib/libfabric:/opt/intel/inteloneapi/compiler/latest/lib:/opt/intel/inteloneapi/clck/2021.1-alpha01/lib/intel64
root@d57af0fb9441:/workspace/qmstk# which icpx
/opt/intel/inteloneapi/compiler/latest/linux/bin/icpx
root@d57af0fb9441:/workspace/qmstk# which clang++
/opt/intel/inteloneapi/dpcpp_compiler/latest/bin/clang++
```
### Compilers
* icpc/icc : classical Intel C/C++ compilers
* clang++ : oneAPI Sycl compilers
* icpx/icx : oneAPI C/C++ compilers for OpenMP offloads
 
### Basic
* First OpenMP test: OK
```
root@d57af0fb9441:/workspace/qmstk# cat test.cpp
#include <iostream>
#include <omp.h>
int main(int argc, char** argv)
{
  auto np=omp_get_max_threads();
  std::cout << "Maximum number of threads " << np << std::endl;
  return 0;
}

root@d57af0fb9441:/workspace/qmstk# icpx -fopenmp test.cpp
root@d57af0fb9441:/workspace/qmstk# ./a.out 
Maximum number of threads 4
```
* Building miniqmc with icpc: OK
```
root@e208039d8a75:/workspace/qmstk/miniqmc $which icpc
/opt/intel/inteloneapi/compiler/latest/linux/bin/intel64/icpc
root@e208039d8a75:/workspace/qmstk/miniqmc# env | grep MKL
MKLROOT=/opt/intel/inteloneapi/mkl/2021.1-alpha01
root@e208039d8a75:/workspace/qmstk/miniqmc# CXX=icpc CC=icc cmake /workspace/repos/miniqmc.intel -DQMC_MIXED_PRECISION=1
$make -j4
Scanning dependencies of target qmcutil
Scanning dependencies of target qmcbase
Scanning dependencies of target qmcwfs
[  4%] Building CXX object src/CMakeFiles/qmcutil.dir/Utilities/SpeciesSet.cpp.o
[  4%] Building CXX object src/CMakeFiles/qmcutil.dir/Utilities/InfoStream.cpp.o
[  6%] Building CXX object src/CMakeFiles/qmcbase.dir/Particle/VirtualParticleSet.cpp.o
[  8%] Building CXX object src/QMCWaveFunctions/CMakeFiles/qmcwfs.dir/WaveFunction.cpp.o
[ 10%] Building CXX object src/CMakeFiles/qmcutil.dir/Utilities/OutputManager.cpp.o
...
root@e208039d8a75:/workspace/qmstk/miniqmc# make miniqmc
root@e208039d8a75:/workspace/qmstk/miniqmc# bin/miniqmc
miniqmc not built from git repository

Number of orbitals/splines = 192
Tile size = 192
Number of tiles = 1
Number of electrons = 384
Rmax = 1.7
AcceptanceRatio = 0.5
Iterations = 5
OpenMP threads = 4
Number of walkers per rank = 4

SPO coefficients size = 49152000 bytes (46.875 MB)
delayed update rank = 32
Using SoA distance table, Jastrow + einspline,
and determinant update.

```

* Building miniqmc with icpx/icx: OK
    * MKL is detected automatically. 
```
miniqmc# CXX=icpx CC=icx cmake /workspace/repos/miniqmc.intel -DQMC_MIXED_PRECISION=1
miniqmc# make -j4
miniqmc# bin/miniqmc

```
* Building miniqmc with clang++ without OpenMP: OK 
    * Requires `-DENABLE_MKL=1 -DQMC_OMP=0`. This disables OpenMP and uses MKL running serially on host.
    ```
    miniqmc# CXX=clang++ CC=icx cmake /workspace/repos/miniqmc.intel -DQMC_MIXED_PRECISION=1 -DENABLE_MKL=1 -DQMC_OMP=0
    ```
* Building miniqmc with clang++ with OpenMP (default of miniqmc): OK with workarounds
    * cmake step: missing libomp.so
    ```
    miniqmc# CXX=clang++ CC=icx cmake /workspace/repos/miniqmc.intel -DQMC_MIXED_PRECISION=1 -DENABLE_MKL=1
    /usr/bin/make -f CMakeFiles/cmTC_e540a.dir/build.make CMakeFiles/cmTC_e540a.dir/build
    make[1]: Entering directory '/workspace/qmstk/miniqmc/CMakeFiles/CMakeTmp'
    Building CXX object CMakeFiles/cmTC_e540a.dir/src_mkl.cxx.o
    /opt/intel/inteloneapi/dpcpp_compiler/latest/bin/clang++   -I/opt/intel/inteloneapi/mkl/2021.1-alpha01/include  -fopenmp -fomit-frame-pointer -fstrict-aliasing -D__forceinline=inline -Wno-deprecated -Wno-unused-value -Wno-undefined-var-template -march=native    -o CMakeFiles/cmTC_e540a.dir/src_mkl.cxx.o -c /workspace/oneapi/miniqmc/CMakeFiles/CMakeTmp/src_mkl.cxx
    Linking CXX executable cmTC_e540a
    /usr/bin/cmake -E cmake_link_script CMakeFiles/cmTC_e540a.dir/link.txt --verbose=1
    /opt/intel/inteloneapi/dpcpp_compiler/latest/bin/clang++   -fopenmp -fomit-frame-pointer -fstrict-aliasing -D__forceinline=inline -Wno-deprecated -Wno-unused-value -Wno-undefined-var-template -march=native     CMakeFiles/cmTC_e540a.dir/src_mkl.cxx.o  -o cmTC_e540a -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl
    /usr/bin/ld: cannot find -lomp
    clang++: error: linker command failed with exit code 1 (use -v to see invocation)
    ```
    * make step: missing omp.h
    * Solution: set CPATH and LIBRARY_PATH
    ```
    export CPATH="/opt/intel/inteloneapi/compiler/2021.1-alpha01/linux/compiler/include:$CPATH"
    export LIBRARY_PATH="/opt/intel/inteloneapi/compiler/2021.1-alpha01/lib/oclfpga/llvm/lib:$LIBRARY_PATH"
    CXX=clang++ CC=icx cmake /workspace/repos/miniqmc.intel -DQMC_MIXED_PRECISION=1 -DENABLE_MKL=1
    ```
### Enabling MPI

* Building miniqmc with mpiicpc: OK
```
miniqmc# CXX=mpicpc CC=icc cmake /workspace/repos/miniqmc.intel/ -DQMC_MIXED_PRECISION=1 
```

* Building miniqmc with mpicxx + icpx: Failed
```
miniqmc# CXX=mpicxx CC=icx cmake /workspace/repos/miniqmc.intel/ -DCMAKE_CXX_FLAGS="-cxx=icpx" -DQMC_MIXED_PRECISION=1 -DENABLE_MKL=1 -DQMC_OMP=0
CMake Error at /usr/share/cmake-3.10/Modules/CMakeTestCXXCompiler.cmake:45 (message):
  The C++ compiler

    "/opt/intel/inteloneapi/mpi/2021.1-alpha01/bin/mpicxx"

  is not able to compile a simple test program.

  It fails with the following output:

    Change Dir: /workspace/qmstk/miniqmc/CMakeFiles/CMakeTmp

    Run Build Command:"/usr/bin/make" "cmTC_69aea/fast"
    /usr/bin/make -f CMakeFiles/cmTC_69aea.dir/build.make CMakeFiles/cmTC_69aea.dir/build
    make[1]: Entering directory '/workspace/qmstk/miniqmc/CMakeFiles/CMakeTmp'
    Building CXX object CMakeFiles/cmTC_69aea.dir/testCXXCompiler.cxx.o
    /opt/intel/inteloneapi/mpi/2021.1-alpha01/bin/mpicxx    -cxx=icpx    -o CMakeFiles/cmTC_69aea.dir/testCXXCompiler.cxx.o -c /workspace/oneapi/miniqmc/CMakeFiles/CMakeTmp/testCXXCompiler.cxx
    Error: unsupported compiler name 'icpx'.
    Check -cxx=<compiler_name> command line option and I_MPI_CXX='' and MPICH_CXX='' variables.
    CMakeFiles/cmTC_69aea.dir/build.make:65: recipe for target 'CMakeFiles/cmTC_69aea.dir/testCXXCompiler.cxx.o' failed
    make[1]: *** [CMakeFiles/cmTC_69aea.dir/testCXXCompiler.cxx.o] Error 1
    make[1]: Leaving directory '/workspace/qmstk/miniqmc/CMakeFiles/CMakeTmp'
    Makefile:126: recipe for target 'cmTC_69aea/fast' failed
    make: *** [cmTC_69aea/fast] Error 2

```
* Building miniqmc with mpicxx+clang++: OK without OpenMP by passing `-DQMC_OMP=0`
```
miniqmc# CXX=mpicxx CC=clang cmake /workspace/repos/miniqmc.intel/ -DCMAKE_CXX_FLAGS="-cxx=clang++" -DQMC_MIXED_PRECISION=1 -DENABLE_MKL=1 -DQMC_OMP=0
miniqmc# make -j4
```

## Using vtune: start docker
```
docker run --cap-add=SYS_ADMIN --cap-add=SYS_PTRACE -it $oneapi
```
Then, all is set to use vtune. Note that `vtune` replaces `amplxe-cl`.

> GUI is not available in docker (don't know how to use it)  and Parallel Studio 2019 Vtune does not recognize the file format.

## Notes
* `-DENABLE_MKL=1` is required with new compilers. Automatic detections of MKL libraries do not work with cmake.
* Ignore cmake/catch error. Execute cmake multiple times to circumvent git error.

```
CMake Error at src/CMakeLists.txt:147 (ADD_LIBRARY):
  Cannot find source file:

    /workspace/qmstk/miniqmc/src/git-rev-tmp.h

  Tried extensions .c .C .c++ .cc .cpp .cxx .m .M .mm .h .hh .h++ .hm .hpp
  .hxx .in .txx
```

