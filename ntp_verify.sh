#!/bin/bash
#Dmitriy Litvin 2018
#set -x

#CHECK PROC
if [ ! -n  "$(service ntp status | grep running)" ]; then `service ntp restart`;echo 'NOTICE: ntp is not running';  fi

#CHECK FILE
if [ ! -f  "$(pwd)/ntp.conf.orig" ]; then cp /etc/ntp.conf $(pwd)/ntp.conf.orig; fi

#CHEK CHANGE
if [ -n "$(diff $PWD/ntp.conf.orig /etc/ntp.conf)" ]; then 

echo 'NOTICE: /etc/ntp.conf was changed. Calculated diff:'
diff -U0  /etc/ntp.conf $(pwd)/ntp.conf.orig
cp $(pwd)/ntp.conf.orig /etc/ntp.conf; service ntp restart; fi
