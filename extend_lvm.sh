#!/bin/bash
echo -n "请输入需要扩展逻辑卷的裸磁盘（如/dev/nvme0n1）： "
read disk_device
echo $disk_device
echo -n "请输入卷组名："
read vgname

parted -s $disk_device mklabel gpt
parted -s $disk_device mkpart ext4  1 100%
parted -s $disk_device toggle 1 lvm

pvcreate ${disk_divice}p1 -y
vgextend $vgname ${disk_device}p1
lvextend -l +457854 /dev/$vgname/root
resize2fs -p /dev/$vgname/root
