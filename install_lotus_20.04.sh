#!/bin/bash
# 用普通用户执行此脚本。 比如xl

# install go
go_url=https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz
wget -c $go_url -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
sudo sed -i '/\/usr\/local\/go\/bin/d' /etc/profile
sudo bash -c "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/profile"

#change sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sourcelist.aliyun.ubuntu20.04 /etc/apt/sources.list


# install deps
sudo apt update && \
sudo apt install mesa-opencl-icd ocl-icd-opencl-dev clang -y && \
##  sudo add-apt-repository ppa:longsleep/golang-backports -y && \
sudo apt update && \
##  sudo apt install curl golang-go gcc git bzr jq pkg-config  -y && \
sudo apt install curl  gcc make git bzr jq pkg-config libhwloc-dev hwloc -y && \
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \

cp cargo_config ~/.cargo/config
source $HOME/.cargo/env
source /etc/profile

# pull code and make lotus
#./update_lotus.sh
