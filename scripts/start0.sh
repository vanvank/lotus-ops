#!/bin/bash
num=0
export CUDA_VISIBLE_DEVICES=$num
export TMPDIR=/lotus_data/tmp/gpu$num
export RUST_LOG=info
#export FIL_PROOFS_USE_MULTICORE_SDR=1
if [ ! -d $TMPDIR ]; then
  mkdir -p $TMPDIR
fi

CUR_IP=`/sbin/ip a | grep "state UP" -A2 | grep "inet [^ /]\+" -o  | grep -o "[0-9.]\+" `

worker_dir=/notnvme/lotusworker
gpu=true
ip=$CUR_IP
port=2346

pre1=true
pre2=true
commit=false
p2max=1
p1max=5

nohup lotus-worker --workerrepo=$worker_dir$num --enable-gpu-proving=$gpu run --listen $ip:$port --precommit1=$pre1 --precommit1max=$p1max --forcep2fromlocalp1=true  --precommit2=$pre2 --precommit2max=$p2max --commit=$commit >> worker.log$num 2>&1 &
