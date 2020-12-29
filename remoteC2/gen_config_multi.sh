#!/usr/bin/env python3
  2
  3 # sudo ./gen_config.py 120.224.xx.xx 11969 2 2395
  4 import subprocess
  5 import sys
  6
  7 def gen_config(ip,port,filename):
  8     with open(filename,'w') as f:
  9         f.writelines("""---
 10 servers:
 11     - url: "http://%s:%s/"  # Server url
 12       token: ""  # Keep empty""" %(ip,port))
 13
 14
 15 def gen_worker_start(content,filename):
 16     with open(filename,'w') as f:
 17         f.writelines(content)
 18
 19 def split_ip(s):
 20     a=s.split(".")
 21     return "%s-%s" %(a[2],a[3])
 22
 23 if __name__=="__main__":
 24     #remote_ip=input("请输入远程ip")
 25     remote_ip=sys.argv[1]
 26     #remote_port=input("请输入port：")
 27     remote_port=sys.argv[2]
 28     #tail=input("请输入配置文件后缀：")
 29     tail=sys.argv[3]
 30     tail=split_ip(remote_ip)+"-"+tail
 31     config_file="/etc/filecoin-ffi-%s.yaml" %tail
 32
 33     local_ip="192.168.11.82"
 34     #local_port=input("请输入本机监听端口：")
 35     local_port=sys.argv[4]
 36     worker_start="""#!/bin/bash
 37 worker_dir=/notnvme/lotusworker
 num=sbw%s
 39 gpu=true
 40 ip=%s
 41 port=%s
 42
 43 pre1=false
 44 pre2=false
 45 commit=true
 46
 47 export FILECOIN_FFI_CONFIG="%s"
 48
 49 nohup ./lotus-worker --workerrepo=$worker_dir$num --enable-gpu-proving=$gpu run --listen $ip:$port --addpiece=false --precommit1=$pre1 --precommit2=$pre2 --commit=$    commit >> worker.log$num 2>&1 &""" % (tail,local_ip,local_port,config_file)
 50     start_file="start%s.sh" %tail
 51     gen_config(remote_ip, remote_port, config_file)
 52     print("config生成成功")
 53     gen_worker_start(worker_start,start_file)
 54     cmd="chown -R xl:xl %s" %start_file
 55     cmd2="chmod u+x  %s" %start_file
 56     subprocess.call(cmd,shell=True)
 57     subprocess.call(cmd2,shell=True)
 58     print("./%s" %start_file)
