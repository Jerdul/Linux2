#!/bin/bash

# creating log file
# TODO: if not exists OR increment name with versio-nr/date-stamp
touch monitor_log.log

# printing timestamp to log file
date >> monitor_log.log


# --- APACHE ---
# checking if service is active
STATUS="$(systemctl is-active apache2)"
if [ "${STATUS}" = "active" ]; then
    printf  "\nApache is: ${STATUS} and running...\n" >> monitor_log.log
else
    printf "\nApache is: ${STATUS} and not running...\n" >> monitor_log.log
fi


# --- MYSQL ---
# checking if service active
STATUS="$(systemctl is-active mysql)"
if [ "${STATUS}" = "active" ]; then
    printf "\nMysql is: ${STATUS} and running...\n" >> monitor_log.log
else
    printf "\nMysql is: ${STATUS} and not running...\n" >> monitor_log.log
fi

# making backup of database
mysqldump -u (username) -p (password) db_name > db_backup.sql
# TODO:
#  --> if db_backup.sql exist, increment number.

# TODO:
# check for old backups


# --- AUTHENTICATION ---
printf "\nAuthentication Failures: \n" >> monitor_log.log
# printing usernames to log file
grep "authentication failure" /var/log/auth.log | cut -d '=' -f 8 >> monitor_log.log

printf "\nAccepted logins: \n" >> monitor_log.log
grep "accepted password" /var/log/auth.log | cut -d '=' -f 8 >> monitor_log.log

# --- FILE-PERMISSIONS ---


# --- PORTS ---
# example: to be continued...

# check listening ports
sudo lsof -i -P -n | grep LISTEN

# check specific port. Example port 22:
sudo lsof -i:22



# --- STORAGE ---

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output >> monitor_log.log
  if [[ $output == *"loop"* ]]; then
    printf ""
  else
    usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
    partition=$(echo $output | awk '{ print $2 }' )
    if [ $usep -ge 80 ]; then
      echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" >> monitor_log.log # |
      # mail -s "Alert: Almost out of disk space $usep%" admin@server.se
    fi
  fi
done
