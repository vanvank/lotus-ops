#!/bin/bash

ip=$1
port=1234


lotus daemon stop
cd $LOTUS_PATH

if [ -z $ip ];then
echo -n "请输入lotus IP地址: "
read ip
fi

sed -i "/\[API\]/aListenAddress = \"\/ip4\/$ip\/tcp\/$port\/http\""  config.toml
cd ~
./start_daemon.sh
