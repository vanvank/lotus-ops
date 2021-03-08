#!/bin/bash
# 一键执行此脚本
# curl https://raw.githubusercontent.com/vanvank/lotus-ops/master/scripts/add_to_jump.sh | bash

echo "加入跳板机"
if [ ! -f /root/.ssh/id_rsa ]
then
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
fi
sleep 3
sed -i '/root@jumpserver/d' /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChX8CES8CFN7QZvdONS517NcJxJZhUQSdLUfeR/dyp1qF5UApOyeDaVyVQID9wpLOKBu62VV21X1FKLt3DS3CTst8aLjXdae+9VshfS4yjWQCQlwodacgBtFqToWwc2if1MlnYEFl9e5dhNnxrFaUwrZSZXI1gA5DuCOxMRRvWHaWwXSfoPpnK4+18DHOmPDd4goVIexbshqWcpohIhmvTOmxlujo4nsEslwBoAVQksJqUnjsn13ALITtltlXO2dWmDtMf7qp/quH3QQEoXRpCzsUZbMBngfUM7DrqsiR7vlZr1xz8gVuVaE6RGoMO93r5Ai05ZeB0qlbNCFUGHJEx root@jumpserver' >>  /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
