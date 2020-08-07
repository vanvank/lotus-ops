#!/bin/bash
###适用于两张2TB的nvme，其中1张是系统盘，做了lvm， 另外一张用下面的命令进行扩展

# root用户执行脚本
logon_user=$(whoami)
if [[ logon_user != root ]];then
    echo "请用root执行此脚本"
    exit 1
fi

echo -n "请输入需要扩展逻辑卷的裸磁盘（如/dev/nvme0n1）： "
read disk_device

vgscan
echo -n "请输入卷组名(默认vgubuntu)："
read vgname

if [[ -z $vgname ]];then
        vgname=vgubuntu
fi

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

free_pe=$(vgdisplay|grep Free|awk '{print $5}')
lvextend -l +$free_pe /dev/$vgname/root
resize2fs -p /dev/$vgname/root
fi
