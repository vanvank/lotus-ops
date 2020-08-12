#!/usr/bin/env python3
import subprocess
import urllib.request
import re


def get_v28_list():
    url="https://proofs.filecoin.io"
    response = urllib.request.urlopen(url)
    html = response.read().decode()
    pattern = '<a href="/(.*)">'
    v28 = re.findall(pattern,html)
    #print(v28)
    v28 = v28[1:]
    #print(v28)
    #print(v28.__len__())
    return v28

def main():
    ipfs_hash = "QmQG9NGWDUMb2WbAiGWkhT1WyZzSaYQQZBUgBxSbRXoqTt"
    v28 = get_v28_list()
    for para in v28:
        cmd = 'ipfs get %s/%s' % (ipfs_hash, para)
        #print(cmd)
        subprocess.Popen(cmd, shell=True)


if __name__=="__main__":
    main()
