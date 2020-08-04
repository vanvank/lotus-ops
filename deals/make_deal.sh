#!/bin/bash

miner_id=$1
if [[ -z $miner_id ]];then
    echo -n "请输入交易对象的miner ID： "
    read miner_id

count=${2:-1}  

filename=`date +%m-%d-%H-%M-%S`
dd if=/dev/zero of=$filename count=$count bs=1M
CID=`lotus client import $filename|awk '{print $4}'`
echo "文件CID： $CID"
echo -n "交易时间："
date
echo -n "DealCID： "
lotus client deal $CID $miner_id 0.0000000005 622080
