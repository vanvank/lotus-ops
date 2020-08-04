#!/bin/bash
ps aux|grep lotus-worker |grep -v grep|awk '{print$2}'|xargs kill >  /dev/null 2>&1
sleep 3
ps aux|grep lotus-worker |grep -v grep|awk '{print$2}'|wc -l
