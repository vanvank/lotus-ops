#!/usr/bin/env python3
# coding:utf-8
# zabbix钉钉报警

import requests
import json
import sys

def ding_msg(user,title,text):
    webhook = "https://oapi.dingtalk.com/robot/send?access_token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

    data={
        "msgtype": "text",
        "text": {
            "content": text
        },
        "at": {
            "atMobiles": [
                user
            ],
            "isAtAll": False
        }
    }
    headers = {'Content-Type': 'application/json'}
    x=requests.post(url=webhook,data=json.dumps(data),headers=headers)

if __name__ == '__main__':
    user=sys.argv[1]
    text=sys.argv[3]
    title = "zabbix-alert"
    print("test")
    ding_msg(user,title,text)
    #ding_msg('a', 'b', 'xmall:test')
