#!/bin/bash
set -x
logfile_path="/home/xl/miner.log"
find_ChainNotify_error=$(cat $logfile_path|grep wdpost|grep "ChainNotify error:"|tail -n1)
sleep 3
find_ChainNotify_error2=$(cat $logfile_path|grep wdpost|grep "ChainNotify error:"|tail -n1)
if [ $? == 0 ];then
        if [ "$find_ChainNotify_error"x == "$find_ChainNotify_error2"x ];then
            echo "OK! Miner $HOSTNAME connection with node ok"
        else
            echo "ERROR lotus connection"
            ./send_msg.sh "ERROR!!! Miner $HOSTNAME lost connection with node"
        fi
fi
