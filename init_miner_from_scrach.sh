#!/bin/bash
#branch=ntwk-calibration
#user=xl
#daemon_ip=192.168.11.102
source /etc/filecoin-mining.config

rm -rf /lotus_data/.lotus*
./get_api_token.sh $daemon_login_name $daemon_ip 1
./update_lotus.sh $branch && \
cd ~
lotus-miner init --owner $( lotus wallet list | grep -m1 '^t3' ) --sector-size 32GiB
