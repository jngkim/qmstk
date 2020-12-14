alias lt='ls -lrt'
alias pd=pushd
alias po=popd
alias h=history
alias c=clear
alias rm='rm -i'

alias sth1='export OMP_NUM_THREADS=1'
alias sth2='export OMP_NUM_THREADS=2'
alias sth4='export OMP_NUM_THREADS=4'


#source /opt/intel/inteloneapi/setvars.sh
export PATH="/workspace/qmstk/common/bin:$PATH"
export CPATH="/workspace/qmstk/common/boost:/workspace/qmstk/common/include:$CPATH"
export LIBRARY_PATH="/workspace/qmstk/common/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/workspace/qmstk/common/lib:$LD_LIBRARY_PATH"

echo "docker on macOS"
echo "export SYCL_DEVICE_TYPE=CPU"
echo "export OMP_TARGET_OFFLOAD=DISABLED|MANDATORY|DEFAULT"
