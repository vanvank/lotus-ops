#!/bin/bash
version=cat /etc/issue|grep -i ubuntu|awk '{print substr($2,0,5)}'
if [[ $version == 18.04 ]];then
    ./install_lotus_18.04.sh
fi

if [[ $version == 20.04 ]];then
    ./install_lotus_20.04.sh
fi

    
