#!/bin/bash
#set -x
sectors=`cat Committing.txt|awk '{print $1}'`
for i in $sectors
do
    path=`lotus-miner storage find $i|grep -i seal`
    result=$?
    if [ $result != 0 ];then
            echo "$i not found"
    fi
    if [ $result == 0 ];then
            echo "$i ok"
    fi
done
