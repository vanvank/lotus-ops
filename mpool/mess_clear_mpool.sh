#!/bin/bash
set -x 
# 3364
#wallet=f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba

# 天津64G
#wallet=f3vu6tn6dcoof5y4psmh2n7tzcsyvjc6d5rf6245cdzzaun33xqpqytpjmyunqyzmk2f5er7bgcraj5wizriwq
#wallet=f3so5s6uwhd4iy3xsc25uv35f72segrx5aoiua6dhnwcx5gdpl2agxvhfsgmp2swoyfi544j7kpryuoqwm3r3a
count=`lotus mpool pending --local|grep Nonce|wc -l`
echo "总共卡住的消息条数为: $count"
lotus mpool pending --local > pending.txt
wallet=`cat pending.txt |grep -i From|head -n1|awk '{print $2}'|tr -d '",'`
#nonces=`lotus mpool pending --local|grep Nonce|head -n 1|awk '{print $2}'|tr -d ,`
nonce=`cat pending.txt |grep Nonce|head -n 1|awk '{print $2}'|tr -d ,`
premium=$(./mpool.py $wallet $nonce)
feecap=$(./calc_feecap.py)
lotus mpool replace --gas-feecap $feecap --gas-premium $premium  $wallet $nonce
date
