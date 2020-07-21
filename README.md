# lotus scripts
1. use pre_install.sh to prepair env for lotus
2. use install_lotus_18.04.sh or install_lotus_20.04.sh to compile lotus

## bench
nohup ~/lotus/cmd/lotus-bench/lotus-bench sealing --sector-size 32GiB --storage-dir=/lotus_data/tmp > bench.log &
