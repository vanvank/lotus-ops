#!/bin/bash
# 这个脚本监控miner日志中出现的ChainNotify error这个问题。可以放到crontab中执行。
# */10 * * * * cd /opt/lotus-ops/monitor; ./chainnotifyerror.sh >> log.chainnotifyerror
set -x

echo "start******"
source /etc/profile

logfile_path="/home/xl/miner.log"
find_ChainNotify_error=$(cat $logfile_path|grep wdpost|grep "ChainNotify error:"|tail -n1)
result=$(/usr/local/bin/lotus-miner info)
if [ $? != 0 ];then
        ./send_msg.sh "ERROR!!! Miner $HOSTNAME info not ok, maybe lost connection with node. $(date)"
        echo  "ERROR!!! Miner $HOSTNAME info not ok, maybe lost connection with node. $(date)"
fi
sleep 3
find_ChainNotify_error2=$(cat $logfile_path|grep wdpost|grep "ChainNotify error:"|tail -n1)
if [ $? == 0 ];then
        if [ "$find_ChainNotify_error"x == "$find_ChainNotify_error2"x ];then
            echo $(date)
            #./send_msg.sh "OK! Miner $HOSTNAME connection with node ok"
            echo "OK! Miner $HOSTNAME connection with node ok"
        else
            echo $(date)
            echo "ERROR lotus connection"
            ./send_msg.sh "ERROR!!! Miner $HOSTNAME lost connection with node. $(date)"
        fi
fi
echo "end********"
