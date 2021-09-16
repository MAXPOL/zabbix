# zabbix

This is minimal instruction how full install ZABBIX on personal server with operation system CentOS7

use zabbixInstallCentOS7.sh

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
