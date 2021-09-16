# zabbix

This is minimal instruction how full install ZABBIX on personal server with operation system CentOS7

use zabbixServerInstallCentOS7.sh for settings server part

Firsts step:

Install OS

Enter: yum install git -y

cd /

gti clone https://github.com/MAXPOL/zabbix.git

cd zabbix

chmod +x zabbixInstallCentOS7.sh

./zabbixInstallCentOS7.sh

Done! After reload enter in string you browser: http://ip-address-server/zabbix

Default login and password:

login: Admin

password: zabbix

Attention ! : If there is error en web GUI "zabbix server is not running" you can testing file
(/etc/zabbix/zabbix_server.conf) and (/etc/zabbix/web/zabbix.conf.php) that the data is filled in correctly.
