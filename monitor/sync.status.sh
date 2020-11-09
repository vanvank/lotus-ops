#!/bin/bash
status=`lotus sync status|grep Stage|head -n1|awk '{print $2}'`
if [ $status == complete ]
then
        echo "sync ok"
else
        ./send_msg.sh "xueyuan 3700x-1151 sync not ok"
fi
