#!/usr/bin/env python3
import os

miner_log_path = r'/home/xl/miner.log'
fsize = os.path.getsize(miner_log_path)
fsize_MB = fsize/1024/1024
print(fsize_MB)
if fsize_MB > 10240:
    with open(miner_log_path, 'a+') as f:
        f.truncate(0)
