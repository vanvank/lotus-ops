#!/bin/bash
$1=user
$2=host
echo "要获取lotus的API请输入1，获取miner的API请输入2 "
read choose
mkdir /lotus_data/.lotus/
mkdir /lotus_data/.lotusstorage/
if [ $choose == 1 ];then
scp  $1@$2:/lotus_data/.lotus/api /lotus_data/.lotus/
scp  $1@$2:/lotus_data/.lotus/token /lotus_data/.lotus/
elseif [ $choose == 2 ];then
scp  $1@$2:/lotus_data/.lotusstorage/api /lotus_data/.lotusstorage/
scp  $1@$2:/lotus_data/.lotusstorage/token /lotus_data/.lotusstorage/
fi
