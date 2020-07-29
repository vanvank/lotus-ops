#!/bin/bash

bootstrap=$(cat ~/lotus/build/bootstrap/bootstrappers.pi)
for i in $bootstrap
do 
lotus-miner net connect $i
done
