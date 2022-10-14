#!/bin/bash

###Script para contrução de serviços do metricbeat/filebeat no systemd###

###Construindo servico do filebeat###

sudo echo "Construindo serviço do filebeat.." ;
sudo touch /lib/systemd/system/filebeat.service \
&& sudo echo "Construindo link simbolico.."
sudo ln -s /lib/systemd/system/filebeat.service /etc/systemd/system/filebeat.service \
&& sudo echo "[Unit]
Description=Filebeat
After=network.target auditd.service
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=ubuntu
ExecStart=/elk/filebeat-7.15.0-linux-x86_64/filebeat -e -c /elk/filebeat-7.15.0-linux-x86_64/filebeat.yml
[Install]
WantedBy=multi-user.target
Alias=filebeat.service" > /lib/systemd/system/filebeat.service \
&& echo "Servico filebeat construido!" ;

###Construindo servico do metricbeat###

sudo echo "Construindo serviço do metricbeat.." ;
sudo touch /lib/systemd/system/metricbeat.service \
&& sudo echo "Construindo link simbolico.."
sudo ln -s /lib/systemd/system/metricbeat.service /etc/systemd/system/metricbeat.service \
&& sudo echo "[Unit]
Description=Metricbeat
After=network.target auditd.service
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=ubuntu
ExecStart=/elk/metricbeat-7.15.1-linux-x86_64/metricbeat -e -c /elk/metricbeat-7.15.1-linux-x86_64/metricbeat.yml
[Install]
WantedBy=multi-user.target
Alias=metricbeat.service" > /lib/systemd/system/metricbeat.service \
&& echo "Servico metricbeat construido!";

sudo systemctl enable metricbeat.service && systemctl enable filebeat.service ;
sudo systemctl stop metricbeat.service && systemctl stop filebeat.service ;

exit 0