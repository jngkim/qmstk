alias lt='ls -lrt'
alias pd=pushd
alias po=popd
alias h=history
alias c=clear
alias rm='rm -i'

#source /opt/intel/inteloneapi/setvars.sh
export PATH="/workspace/qmstk/common/bin:$PATH"
export CPATH="/workspace/qmstk/common/include:$CPATH"
export LIBRARY_PATH="/workspace/qmstk/common/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/workspace/qmstk/common/lib:$LD_LIBRARY_PATH"

#use host OpenMP with Sycl
export CPATH="/opt/intel/inteloneapi/compiler/latest/linux/compiler/include:$CPATH"
#export LIBRARY_PATH="/opt/intel/inteloneapi/compiler/2021.1-alpha01/lib/oclfpga/llvm/lib:$LIBRARY_PATH"
