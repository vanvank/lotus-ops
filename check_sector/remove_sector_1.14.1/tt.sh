miner_id=t0xxxxx
for id in `cat Committing.result.final|awk '{print $1}'`
do
touch sealed/s-$miner_id-$id
touch unsealed/s-$miner_id-$id
done
