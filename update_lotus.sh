#!/bin/bash
# user
branch=$1
if [ -n $branch ];then
branch=master
fi
echo '---'
echo "Update branch: $branch"
echo '---'
echo
cd ~
rm -rf lotus/
git clone --branch=$branch https://github.com/filecoin-project/lotus.git
cd lotus/
#git checkout testnet/3
#git checkout interopnet
make clean && make all
sudo make install
