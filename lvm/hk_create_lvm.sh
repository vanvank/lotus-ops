#!/bin/bash
set -x
./create_new_vg.sh /dev/nvme0n1
./create_new_vg.sh /dev/nvme1n1
vgcreate vg0 /dev/nvme0n1p1 /dev/nvme1n1p1
lvcreate -i 2 -I 64 -l 953862 -n stripe_lv vg0
mkfs.ext4 /dev/vg0/stripe_lv
mkdir /lotus_data
mount  /dev/vg0/stripe_lv /lotus_data
chown -R xl:xl /lotus_data/
echo "/dev/vg0/stripe_lv /lotus_data/ ext4 defaults 0" >> /etc/fstab
