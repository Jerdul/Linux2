#!/bin/bash

# add users here
# set permissions


#___________________________________________________________


# BUILD 
# copied from Lesson 7 pdf

apt-get update
apt-get install apache2
apt-get install mysql-server
apt-get install php libapache2-mod-php php-mysql
systemctl restart apache2


#__________________________________________________________


# DATABASE
# Need db-file
# Example:

mysql <db1.sql
cp mysqlconnect.php /var/www/html/


#__________________________________________________________


# add users to group
# also check if group exist, if not add also new group

$groupDev = developers
$user = ???

if grep -q $groupDev /etc/group
then
   usermod -a -G $groupDev $user
else
   sudo groupadd $groupDev 
   # adduser Kalle, Fnatte, Tjatte, Katte ??????
fi


#__________________________________________________________


# TEST
# testing here


#_________________________________________________________


# what permissions do "other-group" have?


#_________________________________________________________


# DEPLOY 
# get files from features-branch on git etc...

cd 

git clone https://github.com/me2001ru/Linux2.git featuresBranch
git checkout main
cp featuresBranch (git add; git commit; git push)


#__________________________________________________________


# BACKUPS
# - Automate scheduled backups?
# - What is important/relevant to backup?
# - Where are the backups located?
# - Who has access?
# - How do we restore from backups?
# - Encryption of the backups? 


#__________________________________________________________
