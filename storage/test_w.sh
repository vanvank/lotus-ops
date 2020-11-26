#!/bin/bash
set -x 
for i in {1..100}
do
  time dd if=/dev/zero of=test.bin.$i bs=1M count=32768
  echo "---------------"
  sleep 3
done
