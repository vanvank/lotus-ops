#!/bin/bash
#####crontab    */10 * * * * bash -c "cd /opt/lotus-ops/monitor && ./sync.status.sh >  sync.log  2>&1"
set -x
source /etc/profile
source ~/.bashrc
export PATH=$PATH:/usr/local/bin

sync_not_ok=false
process=yes
node_name=$HOSTNAME
ps aux|grep lotus|grep daemon
if [ $? !=0 ];then
        sync_not_ok=true
        process=no
        ./send_msg.sh "ERROR!!! $(date) $node_name sync not ok, process: $process"
fi

status=`lotus sync status|grep Stage|head -n1|awk '{print $2}'`
diff_count=`lotus sync status|grep diff|head -n1|awk '{print $3}'`

timeout 30 lotus sync wait
if [ $? != 0 ];then
        sync_not_ok=true
        t=yes
fi

if [ $diff_count -gt 5 ] && [ -n $diff_count ]
then
        sync_not_ok=true
fi

if [ $status == error ];then
        sync_not_ok=true
fi

if [ $sync_not_ok == true ];then
        ./send_msg.sh "ERROR!!! $(date) $node_name sync not ok, diff: $diff_count, status: $status, timeout: $t, process: $process"
fi
