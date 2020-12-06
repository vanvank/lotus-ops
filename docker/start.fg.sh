#!/bin/bash
/root/lotus-worker --enable-gpu-proving=true run --listen $1:$2  --precommit1=false --precommit2=false --commit=true
