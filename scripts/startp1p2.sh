#!/bin/bash
num=1
export CUDA_VISIBLE_DEVICES=$num
export TMPDIR=/mnt/md0/dgtest/tmp/gpu$num
export RUST_LOG=info
export FIL_PROOFS_MAXIMIZE_CACHING=1
export LOTUS_STORAGE_PATH=/mnt/md0/dgtest/lotusstorage
export LOTUS_MINER_PATH=/mnt/md0/dgtest/lotusstorage
export FIL_PROOFS_USE_GPU_TREE_BUILDER=1
export FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1
export FIL_PROOFS_USE_MULTICORE_SDR=1

CUR_IP=`/sbin/ip a | grep "state UP" -A2 | grep "inet [^ /]\+" -o  | grep -o "[0-9.]\+" `

worker_dir=/mnt/md0/dgtest/lotusworker
gpu=true
ip=$CUR_IP
port=2347

pre1=true
pre2=true
commit=false
p2max=1
p1max=5

lotus-worker --workerrepo=$worker_dir$num --enable-gpu-proving=$gpu run --listen $ip:$port --precommit1=$pre1 --precommit1max=$p1max --forcep2fromlocalp1=true  --precommit2=$pre2 --precommit2max=$p2max --commit=$commit
