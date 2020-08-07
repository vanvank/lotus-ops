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
net_peers=$(lotus-miner net peers|wc -l)
echo $net_peers

if [[ $net_peers -lt 3 ]];then
    echo "连接数太少，尝试连接bootstrap"
    ./miner_conn.sh
fi
