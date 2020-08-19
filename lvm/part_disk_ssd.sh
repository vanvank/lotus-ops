#!/bin/bash
#
nvme_disk=/dev/$1
dir=/ssd

parted -s /dev/$1 mklabel gpt
parted -s /dev/$1 mkpart primary ext4 1 100%
mkdir $dir
mkfs.ext4 $nvme_disk"1" && \
mount $nvme_disk"1" $dir
echo "$nvme_disk $dir  ext4 defaults 0 0" >> /etc/fstab
