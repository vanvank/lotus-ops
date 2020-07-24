#!/bin/bash
branch=ntwk-calibration
user=psdz
miner_ip=192.168.11.48
pre1="true" 
pre2="true"
commit="true" 
gpu="false"

./update_lotus.sh $branch && \
rm -rf /lotus_data/.lotus*
./get_api_token.sh $user $miner_ip
./gen_start_worker.py $pre1 $pre2 $commit $gpu
cd ~
./start_worker.sh
