#!/usr/bin/env python3
import socket
import os,stat
import subprocess

def get_ip():
    # 获取本机计算机名称
    hostname = socket.gethostname()
    # 获取本机ip
    ip = socket.gethostbyname(hostname)
    return ip


def gen_file(pre1="true",pre2="true",commit="true"):
    worker_ip = get_ip()
    home_dir = os.path.expanduser('~')
    start_file = os.path.join(home_dir,"start_worker.sh")
    with open(start_file, "w") as f:
        line = "nohup lotus-worker --enable-gpu-proving=false run --address %s:2346  --precommit1=s% --precommit2=s% --commit=s% > worker.log 2>&1 &" % (worker_ip, pre1, pre2,commit)
        f.write("#!/bin/bash"+"\n")
        f.write(line + "\n")
    os.chmod(start_file,stat.S_IRWXU)
