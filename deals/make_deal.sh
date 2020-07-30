#!/bin/bash
filename=`date +%m-%d-%H-%M-%S`
miner_id=$1
dd if=/dev/zero of=$filename count=10 bs=1M
CID=`lotus client import $filename|awk '{print $4}'`
echo $CID
date
lotus client deal $CID $miner_id 0.0000000005 622080
