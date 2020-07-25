#!/usr/bin/env python3
# 异构集群中根据core数量给AMD派发任务

import subprocess
import time
import re

def check_worker_core(host):
    cmd1="lotus-miner sealing workers|grep -A1 %s|tail -n1" %host
    line=subprocess.check_output(cmd1, shell=True).decode()
    core=re.sub("\D","", line)
    core=int(core)
    return core

def check_miner_core():
    cmd1="lotus-miner sealing workers|head -n2|tail -n1"
    line=subprocess.check_output(cmd1, shell=True).decode()
    core=re.sub("\D","", line)
    core=int(core)
    return core


def auto_pledge(max_parallel, hosts):
    print("*"*25)
    print("check workers of max_parallel=%s" %max_parallel)
    print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) )
    print("*"*25)
    for host in hosts:
        core=check_worker_core(host)
        miner_core=check_miner_core()
        if core < max_parallel and miner_core <1:
            print("%s has %s core(s)" %(host, core))
            print("worker and miner not busy, run pledge")
            run_pledge()
        elif core < max_parallel and miner_core >=1:
            print("%s has %s core(s)" %(host, core))
            print("miner has %s core(s),not add task" %miner_core)
        elif core >= max_parallel:
            print("%s has %s core(s)" %(host, core))
    print()
    time.sleep(6)

def curr_cores(hosts):
    cores=0
    for host in hosts:
        core=check_worker_core(host)
        cores=cores+core
    return cores

def run_pledge():
    cmd = "lotus-miner sectors pledge"
    subprocess.call(cmd, shell=True)
    time.sleep(60*3)

while True:
    max_core=5
    t=60
    hosts_1=["3700X-1151","3700X-1153","3900X-1152"]
    hosts_2=["3970X-1156"]
    auto_pledge(1,hosts_1)
    auto_pledge(2,hosts_2)
    current_cores=curr_cores(hosts_1) + curr_cores(hosts_2)
    miner_core=check_miner_core()
    need_core = max_core - current_cores - miner_core
    if miner_core <= 3 and need_core > 0:
        print("need core(s):%s, run pledge" %need_core)
        run_pledge()
    elif need_core <= 0:
        print("need core(s):%s, Yeah! Your workers are on full speed now!" %need_core)
    time.sleep(t)
    
