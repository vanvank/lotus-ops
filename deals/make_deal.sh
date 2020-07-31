#!/bin/bash

miner_id=$1
count=${2:-1}  

filename=`date +%m-%d-%H-%M-%S`
dd if=/dev/zero of=$filename count=$count bs=1M
CID=`lotus client import $filename|awk '{print $4}'`
echo "文件CID是： $CID"
date
echo -n "DealCID 是： "
lotus client deal $CID $miner_id 0.0000000005 622080
