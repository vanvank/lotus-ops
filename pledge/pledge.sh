#!/usr/bin/env bash
set -x
inter=600
old_proving_count=$(lotus-miner info|grep Proving|tail -n1|awk '{print $2}')
#old_proving_count=1
sleep 5
while true
do
current_proving_count=$(lotus-miner info|grep Proving|tail -n1|awk '{print $2}')
need_ap_count=$(( $current_proving_count-$old_proving_count))

if [ $need_ap_count -gt 0 ];then
  for i in $(seq 1 $need_ap_count);
      do
      echo "pledge"
      #lotus-miner sectors pledge
      sleep 3
  done
  old_proving_count=$current_proving_count
fi
sleep $inter
done
