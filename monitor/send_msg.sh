#!/bin/bash
# send msg to qiye weixin
# 给企业微信发信息

msg=$1

./weixin --corpid=wwd1e57d3d4a19c8fb --corpsecret=8HlOsqST-5cXns5mNHw7yD9qJO8d4EQ4pvpdII_QrNw --msg="$msg" --toparty=9 --agentid=1000007
