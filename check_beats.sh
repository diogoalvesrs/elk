#!/bin/bash

ps -ef | grep filebeat | grep -v grep
status=$?

if [ $status -eq 0 ]; then
	pid=$(ps -ef | grep filebeat | grep -v grep | awk '{print $2}')
	echo "FileBeat em execução com o pid $pid"
else
	echo "FileBeat parado, subindo o Filebeat"
	nohup /elk/filebeat-7.15.0-linux-x86_64/filebeat -e -c /elk/filebeat-7.15.0-linux-x86_64/filebeat.yml >/dev/null 2>&1 &	
fi


ps -ef | grep metricbeat | grep -v grep
status=$?

if [ $status -eq 0 ]; then
        pid=$(ps -ef | grep metricbeat | grep -v grep | awk '{print $2}')
        echo "MetricBeat em execução com o pid $pid"
else
        echo "MetricBeat parado, subindo o Metricbeat"
        nohup /elk/metricbeat-7.15.1-linux-x86_64/metricbeat -e -c /elk/metricbeat-7.15.1-linux-x86_64/metricbeat.yml >/dev/null 2>&1 &
fi
