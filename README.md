# Automation_Project
First project for UpGrad

Creating automation script for web server
Tasks are as below: 

Perform an update of the package details and the package list at the start of the script.

Install the apache2 package if it is not already installed. (The dpkg and apt commands are used to check the installation of the packages.)

Ensure that the apache2 service is running. 

Ensure that the apache2 service is enabled. (The systemctl or service commands are used to check if the services are enabled and running. Enabling apache2 as a service ensures that it runs as soon as our machine reboots. It is a daemon process that runs in the background.)

Create a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and place the tar into the /tmp/ directory. Create a tar of only the .log files (for example access.log) and not any other file type (For example: .zip and .tar) that are already present in the /var/log/apache2/ directory. 

The script should run the AWS CLI command and copy the archive to the s3 bucket. 
++++++++++++++++++++++++++++++++++++++++++++++++++++

Place your script in '/root/Automation_Project/' directory.

Always run scripts with root privileges or first switch to the root user with sudo su and then run the scripts.

#Make the script executible

chmod  +x  /root/Automation_Project/automation.sh

#switch to root user with sudo su

sudo  su

./root/Automation_Project/automation.sh

#or run with sudo 

sudo ./root/Automation_Project/automation.sh
