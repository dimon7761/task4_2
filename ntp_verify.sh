#!/bin/bash
#Dmitriy Litvin 2018
#set -x

#CHECK PROC
if [ ! -n  "$(service ntp status | grep -w active)" ]; then `service ntp restart`; echo 'NOTICE: ntp is not running'; fi

#CHECK FILE
if [ ! -f  "/etc/ntp.conf.bak" ]; then cp /etc/ntp.conf /etc/ntp.conf.bak; echo 'NOTICE: bak file corrupt'; fi

#CHEK CHANGE
if [ -n "$(diff /etc/ntp.conf.bak /etc/ntp.conf)" ]; then 
echo 'NOTICE: /etc/ntp.conf was changed. Calculated diff:'
diff -U0  /etc/ntp.conf /etc/ntp.conf.bak
cp /etc/ntp.conf.bak /etc/ntp.conf 
service ntp restart; fi
