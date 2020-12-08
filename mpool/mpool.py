#!/usr/bin/env python3
import subprocess
import re
import sys


def get_premium():
    nonce_cmd="lotus mpool pending --local|grep Nonce|head -n 1|awk '{print $2}'|tr -d ,"
    nonce=subprocess.check_output(nonce_cmd, shell=True).decode().strip()
    feecap="5200000000"
    premium="1"
    gas_limit="76104935"
    clear_pool_cmd="lotus mpool replace --gas-feecap %s --gas-premium %s --gas-limit %s %s %s" %(feecap, premium, gas_limit, wallet, nonce)
    try:
        subprocess.check_output(clear_pool_cmd,shell=True,stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        string_err=e.output.decode()
    reg = re.compile('increase GasPremium to (.*?) from (.*?) to trigger replace by fee')
    reg_match = re.findall(reg, string_err)
    new_premium=reg_match[0][0]
    return new_premium

if __name__=="__main__":
    wallet=sys.argv[1]
    print(get_premium())
