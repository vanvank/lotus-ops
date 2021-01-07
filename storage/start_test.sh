#!/bin/bash
set -x
nohup ./test_w.sh >> w.log 2>&1 &
sleep 1500
nohup ./test_r.sh  >> r.log 2>&1 &
