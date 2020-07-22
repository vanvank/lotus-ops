#!/bin/bash
branch=ntwk-calibration
user=psdz
miner_ip=192.168.11.48

./update_lotus.sh $branch && \
rm -rf /lotus_data/.lotus*
./get_api_token.sh $user $miner_ip
./gen_start_worker.py
cd ~
./start_worker.sh
