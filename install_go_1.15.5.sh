#!/bin/bash

# install go
go_url=https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz
wget -c $go_url -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
sudo sed -i '/\/usr\/local\/go\/bin/d' /etc/profile
sudo bash -c "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/profile"

# install deps
sudo apt update && \
sudo apt install libhwloc-dev hwloc -y
