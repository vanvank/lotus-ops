#!/bin/bash

source /etc/filecoin-mining.config

rm -rf /lotus_data/.lotusstorage*
./get_api_token.sh $daemon_login_name $daemon_ip 1
#./update_lotus.sh $branch && \
cd ~
lotus-miner init --owner $( lotus wallet list | grep -m1 '^t3' ) --sector-size 32GiB
