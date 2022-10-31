#!/bin/bash
#
set -x
disk=$1
dir=/data
partition=$disk1
parted -s $disk mklabel gpt
parted -s $disk  mkpart primary ext4 1 100%
mkdir $dir
mkfs.ext4 $partition && \
mount $partition $dir
echo "$partition $dir  ext4 defaults 0 0" >> /etc/fstab
