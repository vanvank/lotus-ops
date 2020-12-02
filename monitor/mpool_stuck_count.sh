#!/bin/bash
set -x
count=`lotus mpool pending --local|grep Nonce|wc -l`
msg="lotus mpool stuck message count: $count"
./send_msg.sh "$msg"
