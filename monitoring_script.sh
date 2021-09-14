#!/bin/bash

# creating log file

# TODO: 
# if not exists OR increment name with versio-nr/date-stamp
touch monitor_log.log

# format for time stamp in file-names
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

# printing timestamp to log file
date


# --- APACHE ---
# checking if service is active
STATUS="$(systemctl is-active apache2)"
if [ "${STATUS}" = "active" ]; then
    printf  "\nApache is: ${STATUS} and running...\n"
else
    printf "\nApache is: ${STATUS} and not running...\n"
fi


# --- DATABASE MYSQL ---
# checking if service active
STATUS="$(systemctl is-active mysql)"
if [ "${STATUS}" = "active" ]; then
    printf "\nMysql is: ${STATUS} and running...\n"
else
    printf "\nMysql is: ${STATUS} and not running...\n"
fi

# making backup of database
mysqldump -u "<username>" -p "<password>" "<db_name>" > db_backup_"$current_time".sql

# TODO:
# if not exist -> mkdir db_backups

# check for backups older than 5 days
old_backups=$(find <location> -name "*.sql" -type f -mtime +5)

# delete old backup
$old_backup -delete


# --- AUTHENTICATION ---
printf "\nAuthentication Failures: \n"
# printing usernames to log file
grep "authentication failure" /var/log/auth.log | cut -d '=' -f 8

printf "\nAccepted logins: \n" >> monitor_log.log
grep "accepted password" /var/log/auth.log | cut -d '=' -f 8

# --- FILE-PERMISSIONS ---
find /var/log -printf "\nFile name: %f | Groups: %m | ID: %i | Permissions: (%M) \n_____________________________________________________________\n"


# --- PORTS ---
# check listening ports
sudo lsof -i -P -n | grep LISTEN

# check specific port. Example port 22:
sudo lsof -i:22


# --- STORAGE ---

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  if [[ $output == *"loop"* ]]; then
    printf ""
  else
    usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
    partition=$(echo $output | awk '{ print $2 }' )
    if [ $usep -ge 80 ]; then
      echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" # |
      # mail -s "Alert: Almost out of disk space $usep%" admin@server.se
    fi
  fi
done
