#!/bin/bash

# IF NOT EXIST mkdir "monitoring_logs"
mkdir monitoring_logs
cd monitoring_logs

# Time stamp current time
current_time=$(date "+%Y-%m.%d-%H.%M.%S")

# create cronjob 
# run monitoring script
. monitoring_script.sh > "monitor_$current_time.log"

# check that file-name (date-stamp) doesn't exist

# compress file and save


