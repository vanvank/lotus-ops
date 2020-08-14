#!/bin/bash
#set -x

miner_id=$1

# 获取自己的miner_id
if [ -z $1 ];then
    miner_id=`lotus-miner info|grep Miner:|awk '{print $2}'`
fi

# 查询链上信息，是否设置了multi addr， 如果没有请手动设置lotus-miner actor set-addrs --gas-limit 5000000 /ip4/$public_ip/tcp/$port
echo "lotus state miner-info"
lotus state miner-info $miner_id

echo -n "链上是否已经设置了multi address：（y/n）:"
read is_set
if [[ $is_set == n ]];then
    echo -n "请输入你的公网ip： "
    read public_ip
    echo -n "请输入你的libp2p端口号： "
    read port
    echo "正在设置mult addr上链"
    lotus-miner actor set-addrs --gas-limit 5000000 /ip4/$public_ip/tcp/$port
fi

echo '***'
echo "lotus client query-ask miner_id, 这条命令最好在其他机器上执行"
lotus client query-ask $miner_id

echo '***'
echo "lotus-miner net peers: "
net_peers=$(lotus-miner net peers|wc -l)
echo $net_peers

if [[ $net_peers -lt 3 ]];then
    echo "连接数太少，尝试连接bootstrap"
    ./miner_net_con.sh
    sleep 3
    echo -n "现在的peers数目是："
    lotus-miner net peers|wc -l
fi
