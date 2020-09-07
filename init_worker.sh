#!/bin/bash
#branch=ntwk-calibration
#user=psdz
#user=muse-01
#miner_ip=192.168.11.48
#miner_ip=192.168.0.30

source /etc/filecoin-mining.config

pre1="true" 
pre2="true"
commit="true" 
gpu="false"
#gpu="true"

source /etc/profile
rm -rf /lotus_data/.lotus*
./get_api_token.sh $miner_login_name $miner_internal_ip && \
#./update_lotus.sh $branch && \
./gen_start_worker.py $pre1 $pre2 $commit $gpu
cd ~
./start_worker.sh
