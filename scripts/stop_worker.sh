#!/bin/bash
ps aux|grep lotus-worker |grep -v grep|awk '{print$2}'|xargs kill
sleep 3
ps aux|grep lotus-worker |grep -v grep|awk '{print$2}'|wc -l
