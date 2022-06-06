参考思路：
-------------
删除顽固残留 P1/P2/C2（扇区文件已丢失） 步骤：
①、随便找一台 lotus-worker 机器，sealed、unsealed 里面 touch 创建该扇区相关名称的空文件，如果一次性要清的残留扇区比较多，可以批量创建；
touch sealed/s-t0XXXXX-YYYY
touch unsealed/s-t0XXXXX-YYYY
…………
②、重启一台 lotus-worker，等待上面的文件会重新进入到调度，如果一次性要清的残留扇区比较多，可以临时将这个 lotus-worker 参数进行以下修改 ；
{
  "WorkerName": "",
  "AddPieceMax": 100,
  "PreCommit1Max": 100,
  "PreCommit2Max": 100,
  "Commit2Max": 100,
  "DiskHoldMax": 0,
  "APDiskHoldMax": 0,
  "ForceP1FromLocalAP": true,
  "ForceP2FromLocalP1": true,
  "ForceC2FromLocalP2": false,
  "IsPlanOffline": false,
  "AllowP2C2Parallel": false,
  "IgnoreOutOfSpace": true,
  "AutoPledgeDiff": 1
}
③、在 sealminer 的 sealing jobs 等待重新分配该 P1，然后 abort 该任务；
lotus-miner sealing abort 第一列的ID
④、在59秒内，进行 remove 删除，lotus-miner sectors update-state --really-do-it XX Removing，检查清理相应的 lotus-worker 文件目录
---------------

实操过程：
准备一台新的worker，将他的状态设置为："IsPlanOffline": true
比如现在想处理处于Committing状态，但是扇区文件已经不存在的顽固扇区
1. 先保存一份当前的扇区列表
lotus-miner sectors list > sectors.list

2. 过滤出Committing的扇区
cat sectors.list|grep Committing > Committing.txt

3. 将Committing扇区进一步筛选出文件存在的和不存在的两组.  
参考脚本：02-find_storage.sh,  这一步是为了慎重起见，防止把有文件的扇区给误操作了。过滤出not found的扇区，存到文件
Committing.result.final中
e.g.  
./02-find_storage.sh > Committing.result.1
cat Committing.result.1|grep "not found" > Committing.result.final

4. 将过滤出的最终扇区列表Committing.result.final拷贝到之前准备的新的worker的目录下

5. 参考tt.sh脚本， 在worker目录中批量生成扇区文件 

6. 重启wokrer

7. worker重启成功后，在miner上执行删除扇区的脚本
参考脚本：remove_sectors.sh
这一步可以多执行几次。

8. 观察扇区是否有被删除。观察lotus-miner info 或者观察具体扇区的日志：lotus-miner sectors status --log <sector_id> 
