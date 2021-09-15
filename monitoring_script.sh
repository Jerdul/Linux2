#!/bin/bash


# format for time stamp in file-names
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

to_file="monitor_$current_time.log
"
# printing timestamp to log file
date > $to_file


printf '\n\n\n======================================= \nAPACHE\n=======================================\n' >> $to_file



####################
#      APACHE      #
####################

# checking if service is active
STATUS="$(systemctl is-active apache2)"
if [ "${STATUS}" = "active" ]; then
    printf  "\nApache is: ${STATUS} and running...\n" >> $to_file
else
    printf "\nApache is: ${STATUS} and not running...\n" >> $to_file
fi

printf '\n\n\n======================================= \nDATABASE MYSQL\n=======================================\n' >> $to_file



############################
#      DATABASE MYSQL      #
############################

# checking if service active
STATUS="$(systemctl is-active mysql)"
if [ "${STATUS}" = "active" ]; then
    printf "\nMysql is: ${STATUS} and running...\n" >> $to_file
else
    printf "\nMysql is: ${STATUS} and not running...\n" >> $to_file
fi

# making backup of database
# OLD COMMAND af LUDVIG: mysqldump -u "<username>" -p "<password>" "<db_name>" > db_backup_"$current_time".sql
mysql --user root --password [db_name] > [db_name].sql
# Would it be out of place to compress this backup file??

# check for backups older than 5 days
old_backups=$(find <location> -name "*.sql" -type f -mtime +5)
printf "\n OLD BACKUPS:\n" >> $to_file
echo $old_backups >> $to_file
# delete old backup
$old_backup -delete
printf "\n DELETED BACKUPS:\n" >> $to_file
echo $old_backups >> $to_file


printf '\n\n\n======================================= \nAUTHENTICATION\n=======================================\n' >> $to_file




############################
#      AUTHENTICATION      #
############################

printf "\nAuthentication Failures: \n" >> $to_file
# printing usernames to log file
grep "authentication failure" /var/log/auth.log | cut -d '=' -f 8 >> $to_file

printf "\nAccepted logins: \n" >> $to_file
grep "accepted password" /var/log/auth.log | cut -d '=' -f 8 >> $to_file

printf '\n\n\n======================================= \nFILE PERMISSIONS\n=======================================\n' >> $to_file



##############################
#      FILE-PERMISSIONS      # Where should we check permissions? What files?
##############################
find /var/log -printf "\nFile name: %f | Groups: %m | ID: %i | Permissions: (%M) \n" >> $to_file


printf '\n\n\n======================================= \nPORTS\n=======================================\n' >> $to_file



###################
#      PORTS      #
###################

printf "\nLISTENING ON PORTS:\n" >> $to_file

# check listening ports
sudo lsof -i -P -n | grep LISTEN >> $to_file

# IF WANTED: check specific port. Example port 22:
sudo lsof -i:22 >> $to_file

printf '\n\n\n======================================= \nSTORAGE\n=======================================\n' >> $to_file



#####################
#      STORAGE      #
#####################

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output >> $to_file
  if [[ $output == *"loop"* ]]; then
    printf "" >> $to_file
  else
    usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
    partition=$(echo $output | awk '{ print $2 }' )
    if [ $usep -ge 80 ]; then
      echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" >> $to_file
      mail -s 'Alert: Almost out of disk space' mehsum_rupani@live.se <<< 'You are running out of disk space: $usep%.'
    fi
  fi
done



