#!/bin/bash
#
set -x
disk=$1
echo $1 |grep nvme
if [ $? == 0 ];then
    dir=/nvme
    partition=$1"p1"
else
    dir=/notnvme
    partition=$1"1"
fi

parted -s $disk mklabel gpt
parted -s $disk  mkpart primary ext4 1 100%
mkdir $dir
mkfs.ext4 $partition && \
mount $partition $dir
echo "$partition $dir  ext4 defaults 0 0" >> /etc/fstab
