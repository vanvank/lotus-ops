#!/bin/bash
set -x
sectors=`cat failed_sectors.txt`
for i in $sectors
do
        echo the sectors are $i
        lotus-miner storage find $i
        lotus-miner sectors remove --really-do-it $i
        #lotus-miner sectors update-state --really-do-it $i SubmitCommit
        sleep 1
done
