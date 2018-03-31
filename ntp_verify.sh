#!/bin/bash
#Dmitriy Litvin 2018

#CHECK PROC
if [ ! -n  "$(service ntp status | grep -w active)" ]; then `service ntp restart`; echo 'NOTICE: ntp is not running'; fi


#CHECK FILE
if [ ! -f  "/etc/ntp.conf" -a ! -f  "/etc/ntp.conf.bak" ]; then echo 'NOTICE: ups...';exit 1; fi
if [ ! -f  "/etc/ntp.conf.bak" ]; then cp /etc/ntp.conf /etc/ntp.conf.bak; echo 'NOTICE: bak file restore'; fi
if [ ! -f  "/etc/ntp.conf" ]; then cp /etc/ntp.conf.bak /etc/ntp.conf; echo 'NOTICE: conf file restore'; fi

#CHEK CHANGE
if [ -n "$(diff /etc/ntp.conf.bak /etc/ntp.conf)" ]; then 
echo 'NOTICE: /etc/ntp.conf was changed. Calculated diff:'
diff -U0  /etc/ntp.conf /etc/ntp.conf.bak
cp /etc/ntp.conf.bak /etc/ntp.conf 
service ntp restart; fi
