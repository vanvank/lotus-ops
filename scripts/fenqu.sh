#!/bin/bash
lsblk | grep sdb1
if [ $? == 1 ]
then
        echo "格式化，分区，挂载"
        parted -s /dev/sdb mklabel gpt  && \
        parted -s /dev/sdb mkpart primary "linux-swap(v1)" 1 256GiB  && sleep 3 && \
        parted -s /dev/sdb mkpart primary  256GiB  100% && \
        mkswap /dev/sdb1 && sleep 3 && \
        mkdir -p /lotus_data  && \
        mkfs.ext4 /dev/sdb2 && sleep 5 && \
        mount /dev/sdb2 /lotus_data/  && \
        mkdir -p /lotus_data/tmp && \
        mkdir -p /lotus_data/filecoin-proof-parameters
        chown -R xl:xl /lotus_data
fi
cat /etc/fstab |grep sdb
if [ $? == 1 ]
then
        echo "更新分区表"
        echo "/dev/sdb1 none swap sw 0 0" >> /etc/fstab
        echo "/dev/sdb2  /lotus_data  ext4 defaults 0 0" >> /etc/fstab
        sleep 2
fi
if [ ! -d "/lotus_data" ]; then
  mkdir /lotus_data
  mkdir /lotus_data/tmp
  mkdir /lotus_data/filecoin-proof-parameters
  chown -R xl:xl /lotus_data
fi
swapon -a
mount -a
cd /lotus_data/filecoin-proof-parameters
#scp psdz@192.168.11.48:/lotus_storage_data/v26/* .
scp xl@192.168.11.112:/lotus_data/filecoin-proof-parameters/* .
