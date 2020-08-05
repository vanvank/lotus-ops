#!/bin/bash
is_clean_data=$1
is_update=$2

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

if [[ $is_clean_data == 'y' ]];then
    rm -rf $WORKER_PATH
    ./get_api_token.sh $user $miner_ip
fi

if [[ $is_update == 'y' ]];then
  ./update_lotus.sh $branch
fi

./gen_start_worker.py $pre1 $pre2 $commit $gpu
cd ~
./start_worker.sh
