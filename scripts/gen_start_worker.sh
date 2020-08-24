#!/bin/bash
cpu1=0-5
cpu2=32-38
worker_dir=/lotus_data/lotusworker
num=1
gpu=true
ip=192.168.11.161
port=2346

pre1=true
pre2=false
commit=false

nohup numactl --physcpubind=$cpu1,$cpu2 lotus-worker --workerrepo=$worker_dir$num --enable-gpu-proving=$gpu run --listen $ip:$port  --precommit1=$pre1 --precommit2=$pre2 --commit=$commit >> worker.log$num 2>&1 &
