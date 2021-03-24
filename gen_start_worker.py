#!/usr/bin/env python3
import socket
import os,stat,sys
import subprocess

def get_ip():
    # 获取本机计算机名称
    hostname = socket.gethostname()
    # 获取本机ip
    ip = socket.gethostbyname(hostname)
    if ip[0:3] == "127" or ip[0:3] != "192":
        ip = input("无法取得本机ip地址，请手动输入：")
    return ip.strip()


def gen_file(pre1="true",pre2="true",commit="true", gpu="false"):
    worker_ip = get_ip()
    home_dir = os.path.expanduser('~')
    start_file = os.path.join(home_dir,"start_worker.sh")
    with open(start_file, "w") as f:
        line = "nohup lotus-worker --enable-gpu-proving=%s run --listen %s:2346  --precommit1=%s --precommit2=%s --commit=%s >> worker.log 2>&1 &" % (gpu, worker_ip, pre1, pre2,commit)
        f.write("#!/bin/bash"+"\n")
        f.write(line + "\n")
    os.chmod(start_file,stat.S_IRWXU)

def main():
    gen_file(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])

if __name__=="__main__":
    main()
