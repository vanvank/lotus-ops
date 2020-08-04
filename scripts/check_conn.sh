#!/bin/bash
#set -x

miner_id=$1
echo "lotus state miner-info"
lotus state miner-info $miner_id

echo '***'
echo "lotus client query-ask"
lotus client query-ask $miner_id
echo '***'
echo "lotus-miner net peers: "
lotus-miner net peers|wc -l
