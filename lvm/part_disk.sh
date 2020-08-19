#!/bin/bash
# 
nvme_disk=/dev/$1
dir=/nvme

parted -s /dev/$1 mklabel gpt
parted -s /dev/$1 mkpart primary ext4 1 100%
mkdir /nvme
mkfs.ext4 $nvme_disk"p1" && \
mount $nvme_disk"p1" $dir
echo "$nvme_disk $dir  ext4 defaults 0 0" >> /etc/fstab
