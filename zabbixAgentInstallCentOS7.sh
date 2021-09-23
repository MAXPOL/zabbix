#!/bin/bash

serveraddress=''

echo "Enter ip address you zabbix server:"
read serveraddress

yum update -y

rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm

yum install -y zabbix-agent

sed -i 's/Server=127.0.0.1/Server='$serveraddress'/g' /etc/zabbix/zabbix_agent.conf
sed -i 's/# ListenPort=10050/ListenPort=10050/g' /etc/zabbix/zabbix_agent.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive='$serveraddress'/g' /etc/zabbix/zabbix_agent.conf
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

systemctl enable zabbix-agent

firewall-cmd --permanent --zone=public --add-port=10050/tcp

echo "Done! After reload enter zabbix agent run"

sleep 10

reboot
