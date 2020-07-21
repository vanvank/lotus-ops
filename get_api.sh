#!/bin/bash
$1=user
$2=host
echo "要获取lotus的API请输入1，获取miner的API请输入2 "
read choose
if [ $choose == 1 ];then
dir=/lotus_data/.lotus
elif [ $choose == 2 ];then
dir=/lotus_data/.lotusstorage
fi
mkdir $dir
scp  $1@$2:"$dir/{token,api}" $dir
