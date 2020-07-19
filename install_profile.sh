#/bin/bash
# install /etc/profile, user:root

echo -n "Is your machine in china:(y/n): "
read cn

sed -i '/EDITOR/d' /etc/profile
echo 'export EDITOR=vim' >> /etc/profile

sed -i '/FIL_PROOFS_PARAMETER_CACHE/d' /etc/profile
echo 'export FIL_PROOFS_PARAMETER_CACHE=/lotus_data/filecoin-proof-parameters' >> /etc/profile

sed -i '/RUST_LOG/d' /etc/profile
echo 'export RUST_LOG=info' >> /etc/profile

sed -i '/FIL_PROOFS_MAXIMIZE_CACHING/d' /etc/profile
echo 'export FIL_PROOFS_MAXIMIZE_CACHING=1' >> /etc/profile

sed -i '/LOTUS_STORAGE_PATH/d' /etc/profile
echo 'export LOTUS_STORAGE_PATH=/lotus_data/.lotusstorage' >> /etc/profile

sed -i '/RUSTFLAGS/d' /etc/profile
echo 'export RUSTFLAGS="-C target-cpu=native -g"' >> /etc/profile

sed -i '/FFI_BUILD_FROM_SOURCE/d' /etc/profile
echo 'export FFI_BUILD_FROM_SOURCE=1' >> /etc/profile

sed -i '/TMPDIR/d' /etc/profile
echo 'export TMPDIR=/lotus_data/tmp' >> /etc/profile

sed -i '/LOTUS_PATH/d' /etc/profile
echo 'export LOTUS_PATH=/lotus_data/.lotus' >> /etc/profile

sed -i '/WORKER_PATH/d' /etc/profile
echo 'export WORKER_PATH=/lotus_data/.lotusworker' >> /etc/profile

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
