#!/bin/bash
export RUST_LOG=info
export FIL_PROOFS_MAXIMIZE_CACHING=1
export LOTUS_STORAGE_PATH=/root/dgtest/lotusstorage
export LOTUS_MINER_PATH=/root/dgtest/lotusstorage
export FIL_PROOFS_USE_GPU_TREE_BUILDER=1
export FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1
#export FIL_PROOFS_USE_MULTICORE_SDR=1
CUR_IP=`/sbin/ip a | grep "state UP" -A2 | grep "inet [^ /]\+" -o  | grep -o "[0-9.]\+" `

worker_dir=/root/dgtest/lotusworker
num=1
gpu=true
ip=$CUR_IP
port=2346

pre1=false
pre2=false
commit=true
p2max=2
p1max=7
ap=false

lotus-worker --workerrepo=$worker_dir$num --enable-gpu-proving=$gpu run --listen $ip:$port --addpiece=$ap --precommit1=$pre1 --precommit1max=$p1max --forcep2fromlocalp1=true --precommit2=$pre2 --precommit2max=$p2max --commit=$commit
