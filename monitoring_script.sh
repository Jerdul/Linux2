#!/bin/bash

toFile="$( >> monitorLog.log)"

# creating log file
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
# --> if db_backup.sql exist, increment number.

# TODO:
# cehck for old backups


# --- AUTHENTICATION ---
printf "\nAuthentication Failures: \n" >> monitor_log.log
# printing usernames to log file
grep "authentication failure" /var/log/auth.log | cut -d '=' -f 8 >> monitor_log.log

printf "\nAccepted logins: \n" >> monitor_log.log
grep "accepted password" /var/log/auth.log | cut -d '=' -f 8 >> monitor_log.log

# --- FILE-PERMISSIONS ---


# --- PORTS ---
# example: to be continued...
grep "port 22" /var/log/auth.log

# --- STORAGE ---

