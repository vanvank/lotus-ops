#!/bin/bash
node_name="Guizhou lotus node"
status=`lotus sync status|grep Stage|head -n1|awk '{print $2}'`
if [ $status == complete ]
then
        echo "$node_name sync ok"
else
        ./send_msg.sh "Warning: $node_name sync not ok"
        sleep 300
        status=`lotus sync status|grep Stage|head -n1|awk '{print $2}'`
        if [ $status == complete ];then
                echo "$node_name sync ok"
        else
                ./send_msg.sh "Warning: $node_name sync not ok +1"
        fi
fi
