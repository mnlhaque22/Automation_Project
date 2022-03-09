#!/bin/bash

#variables
myname='Moinul'
s3_bucket='s3://upgrad-moinul'
timestamp=`date '+%d%m%Y-%H%M%S'`

#updating with uptodate repository 
apt update -y 2> /dev/null 1>/dev/null

#checking apache2 is installed if not then install

apache_check=`dpkg --get-selections | grep -i apache2 | grep  -E  "^apache2\s" | awk '{print $2}'`

dpkg --get-selections | grep apache > /dev/null 
com_check=$?

if [ "$com_check" -ne 0 ]
then
	apt install apache2 -y 2> /dev/null 1>/dev/null
	echo " >>>>>>>>>> Apache2 was not installed,  now installed"
elif [ "$com_check" -eq 0 -a "$apache_check" == 'deinstall' ]
then
	apt install apache2 -y 2> /dev/null 1>/dev/null
        echo " >>>>>>>>>> Apache2 was not installed,  now installed"
else
	echo " >>>>>>>>>> Apache2 is Already installed "
fi

# check if apache2 is running if not then start it
if ps ax | grep -v grep | grep apache2 > /dev/null
then
	echo " >>>>>>>>>> Service is already running"
else
	systemctl start apache2 > /dev/null
	echo " >>>>>>>>>> Service was stopped NOW STARTED "
fi

#enable apache2 service to to start automatically after reboot/restart
systemctl enable apache2.service 2> /dev/null 1>/dev/null
echo " >>>>>>>>>> Apache2 is now Enabled "

#check if aws cli is installed if not then install
dpkg --get-selections | grep awscli > /dev/null
if [ $? -ne 0 ]
then
	apt install awscli -y > /dev/null
	echo " >>>>>>>>>> awscli is now installed"
else
        echo " >>>>>>>>>> awscli is Already installed "
fi

#create log archive file 
cd /var/log/apache2
tar cfz /tmp/$myname-httpd-logs-$timestamp.tar ./*.log > /dev/null
cd - > /dev/null
echo " >>>>>>>>>> Tar backup created "

#moving tar file to S3 bucket
aws s3 cp /tmp/$myname-httpd-logs-$timestamp.tar $s3_bucket > /dev/null
echo " >>>>>>>>>> TAR backup moved to S3 "

#removing created tar file for cleanup/housekeeping
