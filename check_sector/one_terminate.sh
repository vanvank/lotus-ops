#!/bin/bash
set -x
sectorid=`cat tsectors.txt`
b=
for i in $sectorid
do
    b="$b $i"
done

echo $b
echo "./lotus-shed sectors terminate --really-do-it $b"
lotus-shed sectors terminate --really-do-it  $b
