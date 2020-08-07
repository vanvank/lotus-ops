#!/bin/bash
user=$1
host=$2
# choose: 1 for lotus api, 2 for miner api(default)
choose=${3:-2}

echo $choose

if [ $choose == 1 ];then
dir=/lotus_data/.lotus
elif [ $choose == 2 ];then
dir=/lotus_data/.lotusstorage
fi
mkdir $dir
scp  $1@$2:"$dir/{token,api}" $dir
