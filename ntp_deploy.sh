#!/bin/bash
#Dmitriy Litvin 2018

#set -x
#INSTALL NTP
apt update >> /dev/null 2>&1 && apt install -y ntp >> /dev/null 2>&1

#CONFIG NTP
sed -i '/ntp_verify.sh/d' /etc/crontab
sed -i '/ua.pool.ntp.org/d' /etc/ntp.conf
sed -i 's/^pool/#pool/g' /etc/ntp.conf
sed -i 's/^server/#server/g' /etc/ntp.conf
sed -i '/Specify one or more NTP servers/a \pool ua.pool.ntp.org iburst' /etc/ntp.conf
rm `pwd`/ntp.conf.orig >> /dev/null 2>&1
cp /etc/ntp.conf `pwd`/ntp.conf.orig

#START NTP
service ntp restart >> /dev/null 2>&1

#ADD TO CRON
echo "*/1 *	* * *   root    $(pwd)/ntp_verify.sh	# NTP Service" >> /etc/crontab

