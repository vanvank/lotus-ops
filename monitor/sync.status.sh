#!/bin/bash
####### */10 * * * * cd /opt/lotus-ops/monitor && ./sync.status.sh >  sync.log  2>&1

set -x
source /etc/profile
node_name=$HOSTNAME
status=`lotus sync status|grep Stage|head -n1|awk '{print $2}'`
is_done=`timeout 5 lotus sync wait|grep Done!`
diff_count=`lotus sync status|grep diff|head -n1|awk '{print $3}'`
if [ $status == complete ] || [ $is_done == Done! ] || [ $diff_count -lt 6 ]
then
        echo "$(date) $node_name sync ok"
else
        ./send_msg.sh "$(date) Warning: $node_name sync not ok, diff: $diff_count"
fi
