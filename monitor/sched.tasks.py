#!/usr/bin/env python3
import time
import subprocess as sp

last_hour = time.strftime("%m-%dT%H", time.localtime(time.time()-3600))
# cat miner.log |grep -i succ|grep seal/v0/precommit/2|grep 05-30T13|wc -l
# cat miner.log |grep -i succ|grep seal/v0/precommit/1|grep 05-30T13|wc -l
# cat miner.log |grep -i succ|grep seal/v0/commit/1|grep 05-30T13|wc -l
# cat miner.log |grep -i succ|grep seal/v0/commit/2|grep 05-30T13|wc -l
log_path = "~/miner.log"

p1 = "seal/v0/precommit/1"
p2 = "seal/v0/precommit/2"
c1 = "seal/v0/commit/1"
c2 = "seal/v0/commit/2"

def task_count(task_type, search_time):
    cmd = "cat %s|grep -i succ|grep %s|grep %s|wc -l" %(log_path, task_type, search_time)
    #print(cmd)
    count = sp.check_output(cmd, shell=True).strip().decode("utf-8")
    print("%s %s count is %s" %(search_time, task_type, count))

def last_hour(n=1):
    return time.strftime("%m-%dT%H", time.localtime(time.time()-3600*n))

def main():
    h = int(input("查看最近几个小时的分配情况，请输入2-10: "))
    for i in [ p1,p2,c1,c2 ]:
        print("-"*30)
        print(i)
        print("-"*30)
        for j in range(h):
            task_count(i, last_hour(j))
    #task_count(p1, last_hour())
    #task_count(p2, last_hour())
    #task_count(c1, last_hour())
    #task_count(c2, last_hour())

if __name__=="__main__":
    main()
