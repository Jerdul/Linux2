#!/bin/bash

# IF NOT EXIST mkdir "monitoring_logs"


# Time stamp current time
current_time=§(date "+%Y-%m.%d-%H.%M.%S")

# create cronjob


# run monitoring script
. monitoring_script.sh

# check that file-name (date-stamp) doesn't exist

# compress file and save
# file name: monitor_"$current_time".log


