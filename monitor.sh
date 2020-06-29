#!/bin/bash
n=0
while true
do
sleep 3
ps aux|grep 00.py|grep -v grep > /dev/null
if [ $? != 0 ]
then
	ctime=$(date)
	echo $ctime
	echo "auto pledge is down, restart"
        /usr/bin/python3 -u /home/psdz/00.py >> /home/psdz/00.log &
	let n=n+1
else
	#echo "auto pledge is up"
	sleep 60
	let n=0
fi

echo $n
if [ $n == 3 ]
then
	echo "auto restart pledge failed"
	./weixin --corpid=wwd1e57d3d4a19c8fb --corpsecret=8HlOsqST-5cXns5mNHw7yD9qJO8d4EQ4pvpdII_QrNw --msg='auto pledge restart failed' --toparty=9 --agentid=1000007
	break
fi

done
