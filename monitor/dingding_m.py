#!/usr/bin/env python3
#coding:utf-8
#钉钉发送信息，python模块
import requests,json,sys,os,datetime

def ding_msg(text):
    webhook="https://oapi.dingtalk.com/robot/send?access_token=f37603f6e3475177000376a553f6ba5d883ae77d72f5773473a60f737636114d"
    data={
        "msgtype": "text",
        "text": {
            "content": text
        },
        "at": {
            "atMobiles": [
                "user"
            ],
            "isAtAll": False
        }
    }
    headers = {'Content-Type': 'application/json'}
    x=requests.post(url=webhook,data=json.dumps(data),headers=headers)
