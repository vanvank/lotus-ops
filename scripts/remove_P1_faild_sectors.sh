#!/bin/bash
set -x
lotus-miner sectors list |grep SealPreCommit1Failed|awk '{print $1}' > failed_sectors.txt

sectors=`cat failed_sectors.txt`
for i in $sectors
do
        echo the sectors are $i
        lotus-miner storage find $i
        lotus-miner sectors remove --really-do-it $i
        sleep 1
done
