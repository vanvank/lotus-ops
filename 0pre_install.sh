#!/bin/bash
# 用root执行次脚本
# 设置免密登录

# 免密登录的user，同时也是后面lotus_data所有者
# cn：y or n， 代表服务器是否在国内
user=$1
cn=$2
gpu=$3

logon_user=$(whoami)
if [[ $logon_user != root ]];then
    echo "请用root执行此脚本"
    exit 1
fi


if [[ -z $1 ]];then
echo -n "请输入要设置免密登录的用户名："
read user
fi

if [[ -z $2 ]];then
echo -n "服务器是否位于国内:(y/n): "
read cn
fi

if [[ -z $3 ]];then
echo -n "是否有gpu,启用gpu做p2 :(y/n): "
read gpu
fi

echo "设置免密登录"
echo "$user ALL = (root) NOPASSWD:ALL" | tee /etc/sudoers.d/$user
chmod 0440 /etc/sudoers.d/$user

# 加入跳板机
apt update
apt install python vim -y
echo "加入跳板机"
if [ ! -f /root/.ssh/id_rsa ]
then
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
fi
sleep 3
sed -i '/root@jumpserver/d' /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChX8CES8CFN7QZvdONS517NcJxJZhUQSdLUfeR/dyp1qF5UApOyeDaVyVQID9wpLOKBu62VV21X1FKLt3DS3CTst8aLjXdae+9VshfS4yjWQCQlwodacgBtFqToWwc2if1MlnYEFl9e5dhNnxrFaUwrZSZXI1gA5DuCOxMRRvWHaWwXSfoPpnK4+18DHOmPDd4goVIexbshqWcpohIhmvTOmxlujo4nsEslwBoAVQksJqUnjsn13ALITtltlXO2dWmDtMf7qp/quH3QQEoXRpCzsUZbMBngfUM7DrqsiR7vlZr1xz8gVuVaE6RGoMO93r5Ai05ZeB0qlbNCFUGHJEx root@jumpserver' >>  /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# 设置/etc/profile
echo "设置/etc/profile"
sed -i '/EDITOR/d' /etc/profile
echo 'export EDITOR=vim' >> /etc/profile

sed -i '/FIL_PROOFS_PARAMETER_CACHE/d' /etc/profile
echo 'export FIL_PROOFS_PARAMETER_CACHE=/lotus_data/filecoin-proof-parameters' >> /etc/profile

sed -i '/RUST_LOG/d' /etc/profile
echo 'export RUST_LOG=info' >> /etc/profile

sed -i '/FIL_PROOFS_MAXIMIZE_CACHING/d' /etc/profile
echo 'export FIL_PROOFS_MAXIMIZE_CACHING=1' >> /etc/profile

####  LOTUS_STORAGE_PATH  will remove
sed -i '/LOTUS_STORAGE_PATH/d' /etc/profile
echo 'export LOTUS_STORAGE_PATH=/lotus_data/.lotusstorage' >> /etc/profile

sed -i '/LOTUS_MINER_PATH/d' /etc/profile
echo 'export LOTUS_MINER_PATH=/lotus_data/.lotusstorage' >> /etc/profile

sed -i '/RUSTFLAGS/d' /etc/profile
echo 'export RUSTFLAGS="-C target-cpu=native -g"' >> /etc/profile

sed -i '/FFI_BUILD_FROM_SOURCE/d' /etc/profile
echo 'export FFI_BUILD_FROM_SOURCE=1' >> /etc/profile

sed -i '/TMPDIR/d' /etc/profile
echo 'export TMPDIR=/lotus_data/tmp' >> /etc/profile

sed -i '/LOTUS_PATH/d' /etc/profile
echo 'export LOTUS_PATH=/lotus_data/.lotus' >> /etc/profile

####  WORKER_PATH will remove 
sed -i '/WORKER_PATH/d' /etc/profile
echo 'export WORKER_PATH=/lotus_data/.lotusworker' >> /etc/profile

sed -i '/LOTUS_WORKER_PATH/d' /etc/profile
echo 'export LOTUS_WORKER_PATH=/lotus_data/.lotusworker' >> /etc/profile

if [[ $cn == 'y' ]]
then
        sed -i '/GOPROXY/d' /etc/profile
        echo 'export GOPROXY=https://mirrors.aliyun.com/goproxy/' >> /etc/profile
        sed -i '/IPFS_GATEWAY/d' /etc/profile
        echo  'export IPFS_GATEWAY="https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/"' >> /etc/profile
else
        sed -i '/GOPROXY/d' /etc/profile
        sed -i '/IPFS_GATEWAY/d' /etc/profile
fi

if [[ $gpu == "y" ]];then
    sed -i '/FIL_PROOFS_USE_GPU_TREE_BUILDER/d' /etc/profile
    echo 'export FIL_PROOFS_USE_GPU_TREE_BUILDER=1' >> /etc/profile

    sed -i '/FIL_PROOFS_USE_GPU_COLUMN_BUILDER/d' /etc/profile
    echo 'export FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1' >> /etc/profile
fi

# install ulimit.
echo "install ulimit"
ulimit -n 1048576
sed -i "/nofile/d" /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf
echo "* soft nofile 1048576" >> /etc/security/limits.conf
echo "root hard nofile 1048576" >> /etc/security/limits.conf
echo "root soft nofile 1048576" >> /etc/security/limits.conf

# setup SWAP, 128GB, swappiness=1
SWAPSIZE=`swapon --show | awk 'NR==2 {print $3}'`
if [ "$SWAPSIZE" != "128G" ]; then
  OLDSWAPFILE=`swapon --show | awk 'NR==2 {print $1}'`
  NEWSWAPFILE="/swapfile"
  if [ -n "$OLDSWAPFILE" ]; then
    swapoff -v $OLDSWAPFILE && \
    rm $OLDSWAPFILE && \
    sed -i "/swap/d" /etc/fstab
    #NEWSWAPFILE=$OLDSWAPFILE
  fi
  fallocate -l 128GiB $NEWSWAPFILE && \
  chmod 600 $NEWSWAPFILE && \
  mkswap $NEWSWAPFILE && \
  swapon $NEWSWAPFILE && \
  echo "$NEWSWAPFILE none swap sw 0 0" >> /etc/fstab
  sysctl vm.swappiness=1
  sed -i "/swappiness/d" /etc/sysctl.conf
  echo "vm.swappiness=1" >> /etc/sysctl.conf
fi

# mkdir /lotus_data
if [ ! -d "/lotus_data" ]; then
  mkdir /lotus_data
fi
if [ ! -d "/lotus_data/tmp" ]; then
  mkdir /lotus_data/tmp
fi
chown -R $user:$user /lotus_data

# time adjust
if [[ $cn == 'y' ]]
then
  echo "time adjust"
  sed -i '/NTP=ntp.aliyun.com/d' /etc/systemd/timesyncd.conf
  sed -i '/\[Time\]/a\NTP=ntp.aliyun.com' /etc/systemd/timesyncd.conf
  systemctl restart systemd-timesyncd
fi


# install GPU driver
nvidia-smi
NEEDGPU=$?
if [ $NEEDGPU -ne 0 ]; then
  ubuntu-drivers autoinstall
  echo "reboot to make the GPU to take effect!"
fi
