#!/bin/bash

$cn=$1
$gpu=$2

if [[ -z $1 ]];then
echo -n "服务器是否位于国内:(y/n): "
read cn
fi

if [[ -z $2 ]];then
echo -n "是否有gpu,启用gpu做p2 :(y/n): "
read gpu
fi

# 设置/etc/bashrc
echo "设置/etc/bashrc"
sed -i '/EDITOR/d' /etc/bashrc
echo 'export EDITOR=vim' >> /etc/bashrc

sed -i '/FIL_PROOFS_PARAMETER_CACHE/d' /etc/bashrc
echo 'export FIL_PROOFS_PARAMETER_CACHE=/lotus_data/filecoin-proof-parameters' >> /etc/bashrc

sed -i '/RUST_LOG/d' /etc/bashrc
echo 'export RUST_LOG=info' >> /etc/bashrc

sed -i '/FIL_PROOFS_MAXIMIZE_CACHING/d' /etc/bashrc
echo 'export FIL_PROOFS_MAXIMIZE_CACHING=1' >> /etc/bashrc

####  LOTUS_STORAGE_PATH  will remove
sed -i '/LOTUS_STORAGE_PATH/d' /etc/bashrc
echo 'export LOTUS_STORAGE_PATH=/lotus_data/.lotusstorage' >> /etc/bashrc

sed -i '/LOTUS_MINER_PATH/d' /etc/bashrc
echo 'export LOTUS_MINER_PATH=/lotus_data/.lotusstorage' >> /etc/bashrc

sed -i '/RUSTFLAGS/d' /etc/bashrc
echo 'export RUSTFLAGS="-C target-cpu=native -g"' >> /etc/bashrc

sed -i '/FFI_BUILD_FROM_SOURCE/d' /etc/bashrc
echo 'export FFI_BUILD_FROM_SOURCE=1' >> /etc/bashrc

sed -i '/TMPDIR/d' /etc/bashrc
echo 'export TMPDIR=/lotus_data/tmp' >> /etc/bashrc

sed -i '/LOTUS_PATH/d' /etc/bashrc
echo 'export LOTUS_PATH=/lotus_data/.lotus' >> /etc/bashrc

####  WORKER_PATH will remove 
sed -i '/WORKER_PATH/d' /etc/bashrc
echo 'export WORKER_PATH=/lotus_data/.lotusworker' >> /etc/bashrc

sed -i '/LOTUS_WORKER_PATH/d' /etc/bashrc
echo 'export LOTUS_WORKER_PATH=/lotus_data/.lotusworker' >> /etc/bashrc

if [[ $cn == 'y' ]]
then
        sed -i '/GOPROXY/d' /etc/bashrc
        echo 'export GOPROXY=https://goproxy.cn' >> /etc/bashrc
        sed -i '/IPFS_GATEWAY/d' /etc/bashrc
        echo  'export IPFS_GATEWAY="https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/"' >> /etc/bashrc
else
        sed -i '/GOPROXY/d' /etc/bashrc
        sed -i '/IPFS_GATEWAY/d' /etc/bashrc
fi

if [[ $gpu == "y" ]];then
    sed -i '/FIL_PROOFS_USE_GPU_TREE_BUILDER/d' /etc/bashrc
    echo 'export FIL_PROOFS_USE_GPU_TREE_BUILDER=1' >> /etc/bashrc

    sed -i '/FIL_PROOFS_USE_GPU_COLUMN_BUILDER/d' /etc/bashrc
    echo 'export FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1' >> /etc/bashrc
fi
