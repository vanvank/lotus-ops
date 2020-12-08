#!/bin/bash
#
set -x
disk=$1
vgname=$2

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
parted -s $disk toggle 1 lvm

pvcreate $partition -yff
#vgcreate $vgname $partition
