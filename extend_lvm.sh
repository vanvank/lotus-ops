#!/bin/bash
echo -n "请输入需要扩展逻辑卷的裸磁盘（如/dev/nvme0n1）： "
read disk_device

echo -n "请输入卷组名："
read vgname

echo "要操作的磁盘名：$disk_device"
echo "卷组名: $vgname"
echo -n "即将对逻辑卷/dev/$vgname/root 进行扩展,请确认:（y/n）"
read continue
if [ $continue == 'y' ]; then
parted -s $disk_device mklabel gpt
parted -s $disk_device mkpart ext4  1 100%
parted -s $disk_device toggle 1 lvm

pvcreate ${disk_divice}p1 -y
vgextend $vgname ${disk_device}p1
lvextend -l +457854 /dev/$vgname/root
resize2fs -p /dev/$vgname/root
fi
