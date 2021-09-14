#!/bin/bash


# Time stamp current time
current_time=$(date "+%Y-%m.%d-%H.%M.%S")



# IF NOT EXIST mkdir "monitoring_logs"
dir_name="monitor_logs"
if [[ ! -d "$dir_name" ]]
then
    mkdir $dir_name
fi         



# TODO: create cronjob 
# run monitoring script, compress and save to log file
. monitor_script.sh | gzip > /$dir_name/"monitor_$current_time.log"



