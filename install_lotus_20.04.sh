#!/bin/bash

# install go
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
sudo sed -i '/\/usr\/local\/go\/bin/d' /etc/profile
sudo bash -c "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/profile"

# install deps
sudo apt update && \
sudo apt install mesa-opencl-icd ocl-icd-opencl-dev clang -y && \
##  sudo add-apt-repository ppa:longsleep/golang-backports -y && \
sudo apt update && \
##  sudo apt install curl golang-go gcc git bzr jq pkg-config  -y && \
sudo apt install curl  gcc make git bzr jq pkg-config  -y && \
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
source $HOME/.cargo/env
source /etc/profile

# pull code and make lotus
./update_lotus.sh
