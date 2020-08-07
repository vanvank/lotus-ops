# lotus scripts

```
git clone https://github.com/vanvank/lotus-ops.git
cd lotus-ops
chmod u+x *.py
chmod u+x *.sh
```

1. use 0pre_install.sh to prepair env for lotus
2. use 1install_dep_and_lotus.sh to compile lotus

## bench
```
cd ~/lotus/cmd/lotus-bench/
go build .
cd ~
nohup ~/lotus/cmd/lotus-bench/lotus-bench sealing --sector-size 32GiB --storage-dir=/lotus_data/tmp > bench.log &
```


export BELLMAN_CUSTOM_GPU="GeForce GTX 1660 SUPER:1408"

export BELLMAN_CUSTOM_GPU="GeForce GTX 2060 SUPER:2176"

 ntwk-calibration

 master
 
 https://calibration.spacerace.filecoin.io/
