#!/bin/bash
#set -x

miner_id=$1

if [ -z $1 ];then
    miner_id=`lotus-miner info|grep Miner:|awk '{print $2}'`
fi

echo "lotus state miner-info"
lotus state miner-info $miner_id

echo '***'
echo "lotus client query-ask"
lotus client query-ask $miner_id
echo '***'
echo "lotus-miner net peers: "
lotus-miner net peers|wc -l
