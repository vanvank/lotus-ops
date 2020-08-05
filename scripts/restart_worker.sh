#!/bin/bash
is_clean_data=$1
is_update=$2

if [[ -z $1 ]];then
    echo -n "是否清除数据（y/n）: "
    read is_clean_data
fi

if [[ -z $2 ]];then
    echo -n "是否升级lotus（y/n）: "
    read is_update
fi

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

./stop_worker.sh

if [[ $is_clean_data == 'y' ]];then
    echo "清除$WORKER_PATH数据"
    rm -rf $WORKER_PATH
    ./get_api_token.sh $user $miner_ip
fi

if [[ $is_update == 'y' ]];then
    echo "升级lotus到最新"
    ./update_lotus.sh $branch
fi

./gen_start_worker.py $pre1 $pre2 $commit $gpu
cd ~
./start_worker.sh
