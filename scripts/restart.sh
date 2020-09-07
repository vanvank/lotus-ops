#!/bin/bash
ps aux|grep lotus-worker |grep -v grep|awk '{print$2}'|xargs kill >  /dev/null 2>&1
sleep 3
process_count=$(ps aux|grep lotus-worker |grep -v grep|awk '{print$2}'|wc -l)
if [ $process_count == 0 ];then
        echo "stop worker successful"
        ./start.sh && echo "start worker successful"
else
        exit 1
fi
