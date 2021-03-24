#!/usr/bin/env python3
import subprocess

def calc_fee_cap():
    basefee_cmd=r"lotus chain getblock `lotus chain head` | grep BaseFee|awk '{print $2}'| tr -d [,\"]"
    result=subprocess.check_output(basefee_cmd, shell=True).decode().strip()
    basefee=int(result)
    if isinstance(basefee,int) and basefee < 9000000000:
        feecap=int(basefee*1.05)
    else:
        feecap=5200000000
    return feecap


if __name__=="__main__":
    feecap=calc_fee_cap()
    print(feecap)
