#!/bin/bash
set -x
for i in {1..100}
do
  dd if=test.bin.$i of=/dev/null bs=1M
  echo "---------------------"
  sleep 3
done
