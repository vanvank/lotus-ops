#!/usr/bin/env python3
import subprocess

def send_msg(msg):
    cmd="./weixin --corpid=wwd1e57d3d4a19c8fb --corpsecret=8HlOsqST-5cXns5mNHw7yD9qJO8d4EQ4pvpdII_QrNw --msg='%s' --toparty=9 --agentid=1000007" %msg
    print(cmd)
    subprocess.call(cmd, shell=True)

if __name__=="__main__":
    send_msg("hello")
