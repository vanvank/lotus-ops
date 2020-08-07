#!/bin/bash
if [[ ! -f /etc/filecoin-mining.config ]];then
    echo "generate /etc/filecoin-mining.config"
    sudo cp filecoin-mining.config.sample /etc/filecoin-mining.config
fi
