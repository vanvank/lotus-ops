#!/bin/bash

# install go
go_url=https://go.dev/dl/go1.17.6.linux-amd64.tar.gz
wget -c $go_url -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
sudo sed -i '/\/usr\/local\/go\/bin/d' /etc/profile
sudo bash -c "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/profile"
