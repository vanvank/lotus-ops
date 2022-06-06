#!/bin/bash
set -x
sectors=`cat Committing.result.final|awk '{print $1}'`
for i in $sectors
do
    lotus-miner storage find $i
    lotus-miner sectors remove --really-do-it $i
    sleep 1
done
