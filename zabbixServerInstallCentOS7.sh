#!/bin/bash

passwoddb=''

echo "Enter new password database:"
read passworddb

yum update -y
yum install -y epel-release
yum install -y httpd mariadb-server mariadb wget nano yum-utils
yum install -y php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json


systemctl enable httpd
systemctl start httpd
systemctl enable mariadb
systemctl start mariadb

mysql_secure_installation <<EOF

y
$passworddb
$passworddb
y
n
y
y
EOF

rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm

yum install -y zabbix-server-mysql zabbix-web-mysql zabbix-get

mysql -u root -p$passworddb -e "create database zabbix character set UTF8 collate = utf8_bin;"
mysql -u root -p$passworddb -e "create user 'zabbix'@'%' identified BY '$passworddb';"
mysql -u root -p$passworddb -e "grant all privileges on zabbix.* to 'zabbix'@'%';"
mysql -u root -p$passworddb -e "flush privileges;"

zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -u zabbix -p$passworddb zabbix

sed -i 's/# DBPassword=/DBPassword=$passworddb/g' /etc/zabbix/zabbix_server.conf
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sed -i 's/# php_value date.timezone Europe\/Riga/php_value date.timezone Europe\/Moscow/g' /etc/httpd/conf.d/zabbix.conf

systemctl enable zabbix-server

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-port=3306/tcp
firewall-cmd --permanent --zone=public --add-port=10051/tcp
firewall-cmd --permanent --zone=public --add-port=10050/tcp

echo "Done! After reload enter in string you browser: http://ip-address-server/zabbix"

sleep 10

reboot
