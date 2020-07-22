#!/bin/bash
# user
echo -n "pls enter the branch (enter for master): "
read branch
if [ -n $branch ];then
branch=master
fi
cd ~
rm -rf lotus/
git clone --branch=$branch https://github.com/filecoin-project/lotus.git
cd lotus/
#git checkout testnet/3
#git checkout interopnet
make clean && make all
sudo make install
