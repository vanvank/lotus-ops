#!/bin/bash
clean_data=$1
update_version=$2

branch=ntwk-calibration
user=psdz
#user=muse-01
miner_ip=192.168.11.48
miner_ip=192.168.0.30
pre1="true" 
pre2="true"
commit="true" 
gpu="false"
#gpu="true"

if [[ $clean_data == "c" ]];then
    rm -rf $WORKER_PATH
fi

./get_api_token.sh $user $miner_ip

if [[ $update_version == "u" ]];then
  ./update_lotus.sh $branch
fi

./gen_start_worker.py $pre1 $pre2 $commit $gpu
cd ~
./start_worker.sh
