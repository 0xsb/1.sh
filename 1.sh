#!/bin/bash
function shellhead() {
	rm -rf $0
	yum install curl -y >/dev/null 2>&1
    loginlogo='
==================================================================
                                                                         
                                         
                                         
                      All Rights NOT Reserved                                
                                                                         
                               
==================================================================';
    XBMLLogo='
==================================================================
                                                                                  
                                         
                                         
                      All Rights NOT Reserved                                
                                                                         
                               
==================================================================';
	errorlogo='
==================================================================
                                                                         
                                                                                     
                                         
                                         
                      All Rights NOT Reserved                                
                                                                         
                               
==================================================================';
	keyerrorlogo='
==================================================================
                                                                                             
                                         
                                         
                      All Rights NOT Reserved                                
                                                                         
                               
==================================================================';
	http="http://"; 
	sq=squid.conf;
	mp=udp.c;
	RSA=EasyRSA-2.2.2.tar.gz;
	Host='xbml.openvpn-vpn.xbml.vip';
	IP=`curl -s http://members.3322.org/dyndns/getip`;
	squser=auth_user;
	key='xbml.vip';
	sysctl=sysctl.conf;
	peizhifile=peizhi.zip;
	upload=transfer.sh;
	jiankongfile=jiankong.zip
	udpjiankongfile=udpjiankong.zip
	lnmpfile='lnmp.zip';
	webfile='12-19-web.zip';
	Vpnfile='xbc'
	phpfile='myadmin.tar.gz';
	uploadfile=xbml-openvpn.tar.gz;
	export uploadfile=$uploadfile
	return 1
}
function authentication() {
	echo -e "\033[36m $XBMLLogo \033[0m"
	echo -e '\033[32m请回车继续\033'
   
    read PASSWD
    readkey=$key
    if [[ ${readkey%%\ *} == $key ]]
    then
        echo 
		echo -e '\033[0m即将开始搭建...'
		sleep 3
    else
        echo
		echo -e '\033[31m验证失败 ，请重新尝试！  \033[0m'
		sleep 3
echo -e "\033[36m $keyerrorlogo \033[0m"
exit
fi
echo "正在检测您的IP是否正确加载..."

	if [[ "$IP" == '' ]]; then
		echo '无法检测您的IP,可能会影响到您接下来的搭建工作';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] && 
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
						 echo -e "您的IP是：\033[34m$IP \033[0m"
						 echo 
						 echo
	sleep 1
return 1
}
function vpnportseetings() {

 echo
 echo -e "\033[31m 请设置免流端口：\033[0m"
 echo 
 echo -n -e "\033[36m输入VPN端口（默认443）：\033[0m\033[33m【温馨提示:回车默认443】\033[0m:" 
 read vpnport 
 if [[ -z $vpnport ]] 
 then 
 echo -e "\033[34m已设置VPN端口：443\033[0m"
 vpnport=443 
 else 
 echo -e "\033[34m已设置VPN端口：$vpnport\033[0m"
 fi 
 echo
 echo -n -e "\033[36m输入HTTP转接端口（默认8080）：\033[0m\033[33m【温馨提示：回车默认为8080】\033[0m:"
 read mpport
 if [[ -z $mpport ]] 
 then 
 echo -e  "\033[34m已设置HTTP转接端口： 8080\033[0m" 
 mpport=8080 
 else 
 echo -e  "\033[34m已设置HTTP转接端口：$mpport\033[0m" 
 fi 
 echo 
 echo -n -e "\033[36m输入常规代理端口（默认80）：\033[0m\033[33m【温馨提示:建议保留80，已经防扫】\033[0m:" 
 read sqport 
 if [[ -z $sqport ]] 
 then 
 echo -e "\033[34m已设置常规代理端口：80\033[0m"
 sqport=80
 else 
 echo -e "\033[34m已设置常规代理端口：$sqport\033[0m"
 fi 
 echo
 echo -e "\033[31m请设置Web流控端口号(默认 1234)  \033[0m"
 echo
 echo -n -e "\033[36m请输入Web流控端口号\033[0m \033[33m【温馨提示:建议使用默认端口】\033[0m :"
 read port
 if [[ -z $port ]]
 then
 port=1234
 fi
 echo
 echo -e "\033[34m已设置WEB流控端口号为：$port\033[0m"
 echo
 echo -e "\033[31m请设置您的数据库密码(默认密码:123456) \033[0m"
 echo
 echo -n -e "\033[36m请输入密码\033[0m \033[33m【温馨提示:不建议使用默认密码】\033[0m："
 read sqlpass
 if [[ -z $sqlpass ]]
 then
 sqlpass=123456
 fi
 echo -e "\033[34m已设置数据库密码完为：$sqlpass \033[0m"
 echo
 echo -e "\033[34m请设置WEB面板管理员账号(默认admin) \033[0m"
 echo
 echo -n -e "\033[36m请输入WEB面板管理员账号\033[0m \033[33m【温馨提示:建议修改】\033[0m :"
 read id
 if [[ -z $id ]]
 then
 id=admin
 fi
 echo -e "\033[34m已设置后台管理员用户名为：$id\033[0m"
 echo
 echo -e "\033[34m请设置WEB面板管理员密码(默认 123456)  \033[0m"
 echo
 echo -n -e "\033[36m请输入WEB面板管理员密码\033[0m \033[33m【温馨提示:建议修改！】\033[0m :"
 read ml
 if [[ -z $ml ]]
 then
 ml=123456
 fi
 echo -e "\033[34m已设置后台管理员密码为：$ml\033[0m"
 echo
 echo -e "\033[31m请设置监控秒数(回车默认30秒) \033[0m"
 echo
 echo -n -e "\033[36m请输入数字(单位/秒):\033[0m \033[33m【温馨提示:建议默认30秒】\033[0m :"
 read jiankongs
 if [[ -z $jiankongs ]]
 then
 jiankongs=30
 echo -e "\033[34m已设置监控秒数为：$jiankongs\033[0m"
 fi
 echo 
 clear
 echo
 echo
return 1
}
function readytoinstall() {
	echo 
	echo -e "\033[35m开始整理安装环境...\033[0m"
	echo -e "\033[35m可能需要1分钟左右...\033[0m"
	sleep 1
	echo -e "\033[35m开始整理残留环境...\033[0m"
	systemctl stop openvpn@server.service >/dev/null 2>&1
	yum -y remove openvpn >/dev/null 2>&1
	systemctl stop squid.service >/dev/null 2>&1
	yum -y remove squid >/dev/null 2>&1
	killall udp >/dev/null 2>&1
	rm -rf /etc/openvpn/*
	rm -rf /root/*
	rm -rf /home/*
	sleep 2 
	systemctl stop httpd.service >/dev/null 2>&1
	systemctl stop mariadb.service >/dev/null 2>&1
	systemctl stop mysqld.service >/dev/null 2>&1
	/etc/init.d/mysqld stop >/dev/null 2>&1
	yum remove -y httpd >/dev/null 2>&1
	yum remove -y mariadb mariadb-server >/dev/null 2>&1
	yum remove -y mysql mysql-server>/dev/null 2>&1
	rm -rf /var/lib/mysql
	rm -rf /var/lib/mysql/
	rm -rf /usr/lib64/mysql
	rm -rf /etc/my.cnf
	rm -rf /var/log/mysql/
	rm -rf
	yum remove -y nginx php-fpm >/dev/null 2>&1
	yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm >/dev/null 2>&1
	echo -e "\033[36m整理完毕\033[0m"
	echo
	
	clear
	echo -e "\033[35m请注意：系统正在后台更新软件以及源，请耐心等待15分钟左右！\033[0m"
	echo -e "\033[31m服务器正在后台运行搭建，并非卡住请耐心等待！！！\033[0m"
	sleep 3
	#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup 
	#wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
	rpm -ivh ${http}${Host}/${Vpnfile}/epel-release-latest-7.noarch.rpm >/dev/null 2>&1
	yum clean all >/dev/null 2>&1
	yum makecache >/dev/null 2>&1
	yum update -y >/dev/null 2>&1
	yum install unzip curl tar expect -y >/dev/null 2>&1
	yum install -y gcc >/dev/null 2>&1
	echo -e "\033[36m更新完成\033[0m"	
	echo
	echo -e "\033[35m正在配置网络环境...\033[0m"
	sleep 3
	systemctl stop firewalld.service >/dev/null 2>&1
	systemctl disable firewalld.service >/dev/null 2>&1
	systemctl restart iptables.service >/dev/null 2>&1
	yum install iptables-services -y >/dev/null 2>&1
	yum -y install vim vim-runtime ctags >/dev/null 2>&1
	setenforce 0 >/dev/null 2>&1 
	echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
	echo -e "\033[36m配置完成\033[0m"
	sleep 1

	
	
	echo
	echo -e "\033[35m正在配置网速优化...\033[0m"
	cd /etc/
	rm -rf ./${sysctl}
	wget ${http}${Host}/${Vpnfile}/${sysctl} >/dev/null 2>&1
	sleep 1
	chmod 0777 ./${sysctl}
	sysctl -p >/dev/null 2>&1
	echo -e "\033[36m优化完成\033[0m"
	sleep 1
	
	echo
	echo -e "\033[35m正在配置防火墙...\033[0m"
	systemctl start iptables >/dev/null 2>&1
	systemctl restart iptables >/dev/null 2>&1
	iptables -F >/dev/null 2>&1
	sleep 3
	iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
	iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
	iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -j MASQUERADE
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport $mpport -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport $port -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 136 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 137 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 138 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 139 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 366 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 351 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 265 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 524 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 440 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 1026 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3389 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 28080 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 8081 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 180 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 53 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport $sqport -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport $vpnport -j ACCEPT
	iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
	iptables -A INPUT -p udp --dport 138 -j ACCEPT
	iptables -A INPUT -p udp --dport 137 -j ACCEPT
	#iptables -A INPUT -p udp --destination-port 138 -j ACCEPT
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	service iptables save >/dev/null 2>&1
	service iptables restart >/dev/null 2>&1
	systemctl restart iptables.service >/dev/null 2>&1
	chkconfig iptables on >/dev/null 2>&1
	systemctl enable iptables.service >/dev/null 2>&1
	setenforce 0 >/dev/null 2>&1
	echo -e "\033[36m配置完成\033[0m"
	sleep 1

	return 1
}
function newvpn() {
echo -e "\033[35m正在安装主程序...\033[0m"
yum install -y openvpn telnet >/dev/null 2>&1
sleep 1
yum install -y openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig expect >/dev/null 2>&1
cd /etc/openvpn/ 
rm -rf /etc/openvpn/server.conf >/dev/null 2>&1

clear
echo "##################################
#       OpenVPN - xbml.vip       #
#           2016.10.19           #
##################################
port 137
proto udp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 192.168.5.0 255.255.255.0
ifconfig-pool-persist /etc/openvpn/ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 114.114.114.114"
push "dhcp-option DNS 114.114.115.115"
client-to-client
management localhost 7788
keepalive 10 120
tls-auth /etc/openvpn/easy-rsa/ta.key 0
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/udp137/udp137.txt
log /etc/openvpn/openvpn137.log
log-append /etc/openvpn/openvpn137.log
verb 3" >/etc/openvpn/udp137.conf


echo "##################################
#       OpenVPN - xbml.vip       #
#           2016.10.19           #
##################################
port 138
proto udp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist /etc/openvpn/ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 114.114.114.114"
push "dhcp-option DNS 114.114.115.115"
client-to-client
management localhost 7506
keepalive 10 120
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/udp138/udp138.txt
log /etc/openvpn/openvpn.log
log-append /etc/openvpn/openvpn.log
verb 3" >/etc/openvpn/udp138.conf

echo "##################################
#       OpenVPN - xbml.vip       #
#           2016.10.19           #
##################################

port $vpnport
proto tcp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 192.1.0.0 255.255.0.0
ifconfig-pool-persist /etc/openvpn/ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 114.114.114.114"
push "dhcp-option DNS 114.114.115.115"
;client-to-client
;duplicate-cn
management localhost 7505
keepalive 10 120
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/res/openvpn-status.txt
log /etc/openvpn/openvpn.log
log-append /etc/openvpn/openvpn.log" >/etc/openvpn/server.conf

echo "##################################
#       OpenVPN - xbml.vip       #
#           2016.10.19           #
##################################

port 440
proto tcp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 192.1.0.0 255.255.0.0
ifconfig-pool-persist /etc/openvpn/ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 114.114.114.114"
push "dhcp-option DNS 114.114.115.115"
;client-to-client
;duplicate-cn
management localhost 7505
keepalive 10 120
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/res/openvpn-status.txt
log /etc/openvpn/openvpn.log
log-append /etc/openvpn/openvpn.log" >/etc/openvpn/server2.conf

   wget ${http}${Host}/${Vpnfile}/${RSA} >/dev/null 2>&1
   tar -zxvf ${RSA} >/dev/null 2>&1
   rm -rf /etc/openvpn/${RSA}>/dev/null 2>&1
   chmod -R 0777 /etc/openvpn
   cd /etc/openvpn/easy-rsa/
   sleep 1
   source vars >/dev/null 2>&1
   ./clean-all
   clear
echo -e "\033[36m正在生成CA/服务端证书...\033[0m"
echo 
./ca >/dev/null 2>&1 && ./centos centos >/dev/null 2>&1
echo 
echo -e "\033[36m证书创建完成\033[0m"
echo 
sleep 2
echo -e "\033[36m正在生成TLS密钥...\033[0m"
openvpn --genkey --secret ta.key
echo -e "\033[36m生成完毕！\033[0m"
clear
echo -e '\033[33m即将开始生产SSL加密证书\033[0m'
echo -e '\033[33m这里必须注意:生成证书期间请勿在移动鼠标进行任何操作\033[0m'
echo -e "\033[36m正在开始生产加密证书..."
./build-dh
echo
echo -e "\033[36m生成完毕！\033[0m"
cd /etc/
chmod 777 -R openvpn
cd openvpn
systemctl enable openvpn@server.service >/dev/null 2>&1
sleep 1
cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
echo -e "\033[36m创建vpn启动命令...\033[0m"
echo "echo -e '\033[33m正在重启openvpn服务...\033[0m'
killall openvpn >/dev/null 2>&1
systemctl restart openvpn@server.service
killall udp >/dev/null 2>&1
udp -l 8080 -d >/dev/null 2>&1
udp -l 136 -d >/dev/null 2>&1
udp -l 137 -d >/dev/null 2>&1
udp -l 138 -d >/dev/null 2>&1
udp -l 139 -d >/dev/null 2>&1
udp -l 440 -d >/dev/null 2>&1
udp -l 53 -d >/dev/null 2>&1
udp -l 3389 -d >/dev/null 2>&1
udp -l 1126 -d >/dev/null 2>&1
udp -l 351 -d >/dev/null 2>&1
udp -l 524 -d >/dev/null 2>&1
udp -l 265 -d >/dev/null 2>&1
udp -l 180 -d >/dev/null 2>&1
udp -l 366 -d >/dev/null 2>&1
udp -l 28080 -d >/dev/null 2>&1
udp -l 8081 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart squid.service >/dev/null 2>&1
lnmp >/dev/null 2>&1
openvpn --config /etc/openvpn/udp137.conf &  >/dev/null 2>&1
openvpn --config /etc/openvpn/udp138.conf &  >/dev/null 2>&1
killall jiankong >/dev/null 2>&1
/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/jiankong.log 2>&1 &
/home/wwwroot/default/udp137/jiankong >>/home/jiankong.log 2>&1 &
/home/wwwroot/default/udp138/jiankong >>/home/jiankong.log 2>&1 &
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/vpn
chmod 777 /bin/vpn
chmod +x /etc/rc.d/rc.local
echo "sh /bin/vpn" >>/etc/rc.d/rc.local
echo -e "\033[36m命令创建成功！\033[0m"
sleep 1
clear
echo -e "\033[35m正在安装设置HTTP代理端口...\033[0m"
sleep 2
yum -y install squid >/dev/null 2>&1
cd /etc/squid/
rm -rf ./squid.conf
killall squid >/dev/null 2>&1
sleep 1
curl -O ${http}${Host}/${Vpnfile}/${sq} >/dev/null 2>&1
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
sleep 1
chmod 0755 ./${sq} >/dev/null 2>&1
echo 
echo -e "\033[36m正在加密常规代理... \033[0m"
sleep 2
curl -O ${http}${Host}/${Vpnfile}/${squser} >/dev/null 2>&1
chmod 0755 ./${squser} >/dev/null 2>&1
echo 
echo -e "\033[36m正在启动常规代理并设置开机自启... \033[0m"
cd /etc/
chmod 777 -R squid
cd squid
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1

echo -e "\033[36m常规代理安装完成 \033[0m"
clear
echo -e "\033[35m正在安装HTTP转发模式...\033[0m"

cd /usr/bin/
curl -O ${http}${Host}/${Vpnfile}/${mp} >/dev/null 2>&1
        sed -i "23s/8080/$mpport/" udp.c
        sed -i "184s/443/$vpnport/" udp.c
		gcc -o udp udp.c
		rm -rf ${mp} >/dev/null 2>&1
chmod 0777 ./udp >/dev/null 2>&1
echo -e "\033[36mHTTP转接模式安装完成 \033[0m"
return 1
}
function installlnmp(){
clear
echo -e "\033[35m正在安装LNMP\033[0m"
echo
echo -e "\033[33m注意：安装过程中如果有卡住或者停住请耐心等待\033[0m"
echo
mkdir -p /home/wwwroot/default >/dev/null 2>&1
cd /root/
wget https://github.com/fanyuanqi/lnmmp2/archive/lnmp.zip >/dev/null 2>&1
unzip lnmp.zip >/dev/null 2>&1
mv lnmmp2-lnmp lnmp 
rm -rf ${lnmpfile} >/dev/null 2>&1
chmod 777 -R /root/lnmp >/dev/null 2>&1
chmod 777 -R lnmp >/dev/null 2>&1
cd lnmp
#########################################################################################bug
./install.sh #>/dev/null 2>&1
rm -rf /root/lnmp >/dev/null 2>&1
rm -rf /root/lnmp/ >/dev/null 2>&1
########################################################################################

echo "#!/bin/bash
echo '正在重启lnmp...'
############################################################################################
systemctl restart mariadb
systemctl restart nginx.service
systemctl restart php-fpm.service
systemctl restart crond.service
#############################################################################################
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/lnmp
chmod 777 /bin/lnmp >/dev/null 2>&1
lnmp 
#error code
echo -e "\033[31m安装完成！\033[0m"
echo -e "\033[31m环境：LNMP系统 - Centos7版\033[0m"
 return 1
}
function webml(){
clear
echo -e "\033[36m开始搭建流量控制程序\033[0m"
echo -e "\033[33m请不要进行任何操作 程序自动完成...\033[0m"
cd /root/
wget ${http}${Host}/${Vpnfile}/${webfile} >/dev/null 2>&1
unzip -q ${webfile} >/dev/null 2>&1
clear

mysqladmin -u root password "${sqlpass}"
echo
echo -e "正在自动加入流控数据库表：\033[31m ov \033[0m"
echo
sed -i 's/www.qyun.ren/'${IP}:${port}'/g' /root/qyun/web/install.sql >/dev/null 2>&1
create_db_sql="create database IF NOT EXISTS ov"
mysql -hlocalhost -uroot -p$sqlpass -e "${create_db_sql}"
mysql -hlocalhost -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use ov;
source /root/qyun/web/install.sql;
EOF
echo -e "\033[34m设置数据库完成\033[0m"
if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到HTTP端口和流控端口有冲突，系统默认流控为1234端口"
port=1234
fi
fi
echo -e "\033[34m已设置WEB流控端口号为：$port\033[0m"
sed -i 's/123456/'$sqlpass'/g' ./qyun/sh/login.sh >/dev/null 2>&1
sed -i 's/123456/'$sqlpass'/g' ./qyun/sh/disconnect.sh >/dev/null 2>&1
sleep 1
sed -i 's/80/'$port'/g' /usr/local/nginx/conf/nginx.conf >/dev/null 2>&1
sed -i 's/80/'$port'/g' /etc/nginx/conf.d/default.conf >/dev/null 2>&1
#sed -i 's/ServerName www.example.com:1234/ServerName www.example.com:'$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
#sed -i 's/Listen 1234/Listen '$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
sleep 1

mv -f ./qyun/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./qyun/sh/crontab  /etc/ >/dev/null 2>&1
mv -f ./qyun/sh/sql.sh   /home/ >/dev/null 2>&1
mv -f ./qyun/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./qyun/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
sed -i 's/xbml/'$sqlpass'/g' /home/sql.sh >/dev/null 2>&1
sed -i 's/192.168.1.1:8888/'$IP:$port'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
chmod 777 /etc/crontab
chmod 777 /home/sql.sh
chmod +x /etc/openvpn/*.sh >/dev/null 2>&1
chmod 777 -R ./qyun/web/* >/dev/null 2>&1
sleep 1
sed -i 's/qysql/'$sqlpass'/g' ./qyun/web/config.php >/dev/null 2>&1
sed -i 's/qysql/'$sqlpass'/g' ./qyun/web/down/config.php >/dev/null 2>&1
sed -i 's/qysql/'$sqlpass'/g' ./qyun/web/app_api/config.php >/dev/null 2>&1
sed -i 's/qyadmin/'$id'/g' ./qyun/web/config.php >/dev/null 2>&1
sed -i 's/qypass/'$ml'/g' ./qyun/web/config.php >/dev/null 2>&1
rm -rf /home/wwwroot/default/html/index* >/dev/null 2>&1
mv -f ./qyun/web/* /home/wwwroot/default/ >/dev/null 2>&1
cd /home/wwwroot/default/
mv phpMyAdmin-4.6.2-all-languages phpmyadmin >/dev/null 2>&1
rm -rf /root/qyun/ >/dev/null 2>&1
rm -rf /root/lnmp >/dev/null 2>&1
rm -rf /root/${webfile} >/dev/null 2>&1
sleep 1
yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
chmod 777 /home/wwwroot/default/cron.php >/dev/null 2>&1
echo
echo -e "\033[35m...\033[0m"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root >/dev/null 2>&1

systemctl restart crond.service  >/dev/null 2>&1   
systemctl enable crond.service >/dev/null 2>&1 
cd /home/wwwroot/default/res/
curl -O ${http}${Host}/${Vpnfile}/${jiankongfile} >/dev/null 2>&1
unzip ${jiankongfile} >/dev/null 2>&1
rm -rf ${jiankongfile}
chmod 777 jiankong >/dev/null 2>&1
chmod 777 sha >/dev/null 2>&1
cd /home/wwwroot/default/
chmod 777 /home/wwwroot/default/udp >/dev/null 2>&1
chmod 777 -R /home/wwwroot/default/res/
chmod 777 -R /home/wwwroot/default/udp137/
chmod 777 -R /home/wwwroot/default/udp138/
cd /home/wwwroot/default/udp
curl -O ${http}${Host}/${Vpnfile}/${udpjiankongfile} >/dev/null 2>&1
unzip ${udpjiankongfile} >/dev/null 2>&1
rm -rf ${udpjiankongfile}
chmod 777 jiankong >/dev/null 2>&1
chmod 777 sha >/dev/null 2>&1
sleep 1
cd /etc/openvpn/
curl -O ${http}${Host}/${Vpnfile}/${peizhifile} >/dev/null 2>&1
unzip ${peizhifile} >/dev/null 2>&1
rm -rf ${peizhifile}
chmod 777 /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/shijian=30/'shijian=$jiankongs'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/mima=123456/'mima=$sqlpass'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1


echo "/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local >/dev/null 2>&1
echo "/home/wwwroot/default/udp/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local >/dev/null 2>&1
echo "/home/wwwroot/default/udp137/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local 
echo "/home/wwwroot/default/udp138/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local
vpn >/dev/null 2>&1
lnmp
echo -e "\033[35m正在置为开机启动...\033[0m"
systemctl enable openvpn@server.service >/dev/null 2>&1
echo 
# echo "正在进行流控网速优化..."
# echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
echo 
echo -e "\033[35mWeb流量控制程序安装完成...\033[0m"
return 1
}
function ovpn(){
echo 
echo -e "\033[36m开始生成配置文件... \033[0m"
sleep 3
cd /home/
echo "#  移动常规类型
# 本文件由系统自动生成
# 类型：常规
client
dev tun
proto tcp
remote $IP $vpnport
########免流代码########
http-proxy $IP $sqport">yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn"
########免流代码########
<http-proxy-user-pass>
xbml
xbml
</http-proxy-user-pass>
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">yd-quanguo3.ovpn
cat yd-quanguo1.ovpn yd-quanguo2.ovpn yd-quanguo3.ovpn>xbml-yd-old.ovpn

echo "#  移动全国137UDP
# 本文件由系统自动生成
# 类型：UDP
client
dev tun
proto udp
remote $IP 137">http-yd-quanguo1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-udp137.ovpn


echo "#  移动全国138UDP
# 本文件由系统自动生成
# 类型：UDP
client
dev tun
proto udp
remote $IP 138">http-yd-quanguo1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-udp138.ovpn


echo "#  浙江移动 1
# 本文件由系统自动生成
# 类型：HTTP转接
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17" 
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
client
dev tun
proto tcp
########免流代码########
remote / 80
http-proxy 10.0.0.172 80
http-proxy-option EXT1  Host:$IP:443
http-proxy-option EXT1 Host:wap.zj.10086.cn
########免流代码########">http-yd-quanguo1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
auth-user-pass
ns-cert-type server
redirect-gateway
keepalive 10 120
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-zj①.ovpn


echo "#  移动全国137
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP 137">http-yd1-quanguo-1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 POST http://wap.10086.cn
http-proxy-option EXT1 Host wap.10086.cn
http-proxy-option EXT1 Host: wap.10086.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd1-quanguo-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd1-quanguo-3.ovpn
cat http-yd1-quanguo-1.ovpn http-yd1-quanguo-2.ovpn http-yd1-quanguo-3.ovpn>xbml-yd-137.ovpn

echo "# 移动全国136  
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
http-proxy $IP 136">http-yd-1361.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
remote dlsdown.mll.migu.cn 80 tcp-client
http-proxy-option EXT1 POST http://dlsdown.mll.migu.cn / HTTP/1.1
http-proxy-option EXT1 Host: dlsdown.mll.migu.cn
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-1362.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-1363.ovpn
cat http-yd-1361.ovpn http-yd-1362.ovpn http-yd-1363.ovpn>xbml-yd-136.ovpn


echo "# 移动全国139
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP 139">http-yd-1391.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 POST http://wap.10086.cn
http-proxy-option EXT1 Host wap.10086.cn
http-proxy-option EXT1 Host: wap.10086.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-1392.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-1393.ovpn
cat http-yd-1391.ovpn http-yd-1392.ovpn http-yd-1393.ovpn>xbml-yd-139.ovpn


echo "# 移动全国138
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP 138">http-yd1-quanguo-1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 POST http://wap.10086.cn
http-proxy-option EXT1 Host wap.10086.cn
http-proxy-option EXT1 Host: wap.10086.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd1-quanguo-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd1-quanguo-3.ovpn
cat http-yd1-quanguo-1.ovpn http-yd1-quanguo-2.ovpn http-yd1-quanguo-3.ovpn>xbml-yd-138.ovpn

echo "#  移动咪咕138
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
http-proxy $IP 138">http-yd1-migu138-1.ovpn
echo '
remote a.mll.migu.cn 3389 tcp-client
http-proxy-option EXT1 POST http://a.mll.migu.cn
http-proxy-option EXT1 VPN 127.0.0.1:443
http-proxy-option EXT1 Host: a.mll.migu.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd1-migu138-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd1-migu138-3.ovpn
cat http-yd1-migu138-1.ovpn http-yd1-migu138-2.ovpn http-yd1-migu138-3.ovpn>xbml-yd-mg138.ovpn


echo "# 移动366类型
# 本文件由系统自动生成
# 类型：常规
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17" 
machine-readable-output
client
dev tun
connect-retry-max 5
connect-retry 5
resolv-retry 60
remote $IP $vpnport tcp-client
########免流代码########
http-proxy $IP 366">yd-quanguo1366.ovpn
echo 'http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn"
########免流代码########
<http-proxy-user-pass>
xbml
xbml
</http-proxy-user-pass>

resolv-retry infinite
nobind
persist-key
persist-tun
'>yd-quanguo2366.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
">yd-quanguo3366.ovpn
cat yd-quanguo1366.ovpn yd-quanguo2366.ovpn yd-quanguo3366.ovpn>xbml-yd-old-366.ovpn


echo "#  移动351类型
# 本文件由系统自动生成
# 类型：常规
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17" 
machine-readable-output
client
dev tun
connect-retry-max 5
connect-retry 5
resolv-retry 60
remote $IP $vpnport tcp-client
########免流代码########
http-proxy $IP 351">yd-quanguo1351.ovpn
echo 'http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn"
########免流代码########
<http-proxy-user-pass>
xbml
xbml
</http-proxy-user-pass>

resolv-retry infinite
nobind
persist-key
persist-tun
'>yd-quanguo2351.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
">yd-quanguo3351.ovpn
cat yd-quanguo1351.ovpn yd-quanguo2351.ovpn yd-quanguo3351.ovpn>xbml-yd-old-351.ovpn


echo "# 安徽移动
# 本文件由系统自动生成
# 类型：UDP
client
dev tun
proto udp
remote $IP 138">http-yd-quanguo1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-ah.ovpn


echo "#  福建移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote www.baidu.com 138
########免流代码########
http-proxy $IP 138">http-yd-fujian1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 POST http://www.baidu.com
http-proxy-option EXT1 Host www.baidu.com
http-proxy-option EXT1 Host: www.baidu.com / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-fujian2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-fujian3.ovpn
cat http-yd-fujian1.ovpn http-yd-fujian2.ovpn http-yd-fujian3.ovpn>xbml-yd-fj.ovpn


echo "#  甘肃移动 1 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote $IP:443/\rX-Online-Host:wap.10086.cn ">http-yd-gansu1.ovpn
echo '
http-proxy 10.0.0.172 80
http-proxy-option EXT1 Host: wap.10086.cn
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gansu2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gansu3.ovpn
cat http-yd-gansu1.ovpn http-yd-gansu2.ovpn http-yd-gansu3.ovpn>xbml-yd-gs.ovpn


echo "#  甘肃移动 2 12-6更新
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote $IP:443">http-yd-gansu21.ovpn
echo '
http-proxy-option EXT1 "GET /monitor/impress?sid=1480984600508-a45f0e22-60dc-4b1d-b679-2602aaca6973~AB5808A4E5B3BF336E2E0CAA7AD90B58~5529 HTTP/1.1" 
http-proxy-option EXT1 "CONNECT dspserver.ad.cmvideo.cn" 
http-proxy-option EXT1 "Host: dspserver.ad.cmvideo.cn" 
http-proxy-option EXT1 "Connection: keep-alive" 
http-proxy-option EXT1 "Referer: http://wap.cmread.com/rbc/p/huiyuan.jsp?ln=972_459603_93052339_12_L10&t1=17141&cm=M2790013&vt=3&timestamp=1480984518093" 
http-proxy-option EXT1 "VPN 127.0.0.1:443" 
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gansu22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gansu23.ovpn
cat http-yd-gansu21.ovpn http-yd-gansu22.ovpn http-yd-gansu23.ovpn>xbml-yd-gs2.ovpn



echo "# 开源云免配置 甘肃移动 3  WAP接入点
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote wap.gx.10086.cn 80
########免流代码########
http-proxy $IP 443">http-yd-gs31.ovpn
echo '
http-proxy-option EXT1 GET /monitor/impress?sid=1480984600508-a45f0e22-60dc-4b1d-b679-2602aaca6973~AB5808A4E5B3BF336E2E0CAA7AD90B58~5529 HTTP/1.1 
http-proxy-option EXT1 CONNECT dspserver.ad.cmvideo.cn 
http-proxy-option EXT1 Host: dspserver.ad.cmvideo.cn 
http-proxy-option EXT1 Connection: keep-alive 
http-proxy-option EXT1 Referer: http://wap.cmread.com/rbc/p/huiyuan.jsp?ln=972_459603_93052339_12_L10&t1=17141&cm=M2790013&vt=3&timestamp=1480984518093
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gs32.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gs33.ovpn
cat http-yd-gs31.ovpn http-yd-gs32.ovpn http-yd-gs33.ovpn>xbml-yd-gs3.ovpn



echo "# 开源云免配置 甘肃移动 4 8080端口
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote migumovie.lovev.com 80
http-proxy $IP 8080">http-yd-gs41.ovpn
echo '
http-proxy-option EXT1 X-Online-Host: migumovie.lovev.com 
http-proxy-option EXT1 Host: migumovie.lovev.com 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gs42.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gs43.ovpn
cat http-yd-gs41.ovpn http-yd-gs42.ovpn http-yd-gs43.ovpn>xbml-yd-gs4.ovpn



echo "# 开源云免配置 广西移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote wap.gx.10086.cn 80
########免流代码########
http-proxy $IP 137">http-yd-guangx1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 POST http://wap.gx.10086.cn
http-proxy-option EXT1 Host wap.gx.10086.cn
http-proxy-option EXT1 Host: wap.gx.10086.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-guangx2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-guangx3.ovpn
cat http-yd-guangx1.ovpn http-yd-guangx2.ovpn http-yd-guangx3.ovpn>xbml-yd-gx.ovpn


echo "# 开源云免配置 河北移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote wap.10086.cn 80
########免流代码########
http-proxy $IP 138">http-yd-hebei1.ovpn
echo 'http-proxy-option EXT1 "GET http://gslb.miguvod.lovev.com/rdp2/v5.5/migu/token_login.do?&ua=Android_sst&version=4.2350 HTTP/1.1"
http-proxy-option EXT1 "Host: gslb.miguvod.lovev.com"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-hebei2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-hebei3.ovpn
cat http-yd-hebei1.ovpn http-yd-hebei2.ovpn http-yd-hebei3.ovpn>xbml-yd-hebei.ovpn


echo "# 开源云免配置 山东移动 1  12-27更新
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 138">http-yd-shand1.ovpn
echo 'http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://wap.sd.10086.cn"
http-proxy-option EXT1 "Host: wap.sd.10086.cn HTTP/1.1"
remote wap.sd.10086.cn 3389 tcp-client
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-shand2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-shand3.ovpn
cat http-yd-shand1.ovpn http-yd-shand2.ovpn http-yd-shand3.ovpn>xbml-yd-sd.ovpn


echo "# 开源云免配置 山东移动 2
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote wap.gd.chinamobile.com 80
########免流代码########
http-proxy $IP 8080">http-yd-shand21.ovpn
echo 'http-proxy-option EXT1 POST http://wap.gd.chinamobile.com
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 Host wap.gd.chinamobile.com
http-proxy-option EXT1 Host: wap.gd.chinamobile.com / HTTP/1.1 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-shand22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-shand23.ovpn
cat http-yd-shand21.ovpn http-yd-shand22.ovpn http-yd-shand23.ovpn>xbml-yd-sd2.ovpn


echo "# 开源云免配置 陕西移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 138">http-yd-shanxi1.ovpn
echo 'http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://wap.sn.10086.cn"
http-proxy-option EXT1 "Host: wap.sn.10086.cn HTTP/1.1"
remote wap.sn.10086.cn 3389 tcp-client
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-shanxi2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-shanxi3.ovpn
cat http-yd-shanxi1.ovpn http-yd-shanxi2.ovpn http-yd-shanxi3.ovpn>xbml-yd-sx.ovpn



echo "# 开源云免配置 江西移动 WAP接入点
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote / 80
http-proxy-option EXT1 "Host：wap.cmvideo.cn"
http-proxy-option EXT1 "wap.cmvideo.cn "
http-proxy-option EXT1  Host:$IP:443” 
http-proxy 10.0.0.172 80 ">http-yd-jx1.ovpn
echo '
http-proxy-option EXT1 Host:wap	.jx.10086.cn
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-jx2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-jx3.ovpn
cat http-yd-jx1.ovpn http-yd-jx2.ovpn http-yd-jx3.ovpn>xbml-yd-jx.ovpn

echo "# 开源云免配置 陕西移动 1
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote / 80
;http-proxy-retry
;http-proxy [proxy server] [proxy port]
http-proxy 10.0.0.172 80
http-proxy-option EXT1  Host:$IP:443">http-yd-shanxi11.ovpn
echo '
http-proxy-option EXT1 Host:wap.sn.10086.cn
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-shanxi12.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-shanxi13.ovpn
cat http-yd-shanxi11.ovpn http-yd-shanxi12.ovpn http-yd-shanxi13.ovpn>xbml-yd-sx1.ovpn


echo "# 开源云免配置 陕西移动 3
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote / 80
;http-proxy-retry
;http-proxy [proxy server] [proxy port] [proxy xcap]
http-proxy 10.0.0.172 80
http-proxy-option EXT1 " "Host:$IP:440">http-yd-shanxi131.ovpn
echo '
http-proxy-option EXT1 Host:wap.10086.cn
"Host,X-Online-Host";"[method] [uri] HTTP/1.1
Host: wap.10086.cn
X-Online-Host.: wap.10086.cn
X-Online-Host : [host]
";
"Host,X-Online-Host";"CONNECT [host] [version]
CONNECT rd.go.10086.cn:443 HTTP/1.1
X-Online-Host: rd.go.10086.cn:443
";

########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-shanxi132.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-shanxi133.ovpn
cat http-yd-shanxi131.ovpn http-yd-shanxi132.ovpn http-yd-shanxi133.ovpn>xbml-yd-sx3.ovpn


echo "# 开源云免配置 全国移动138 ②
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote migumovie.lovev.com 3389 tcp-client
########免流代码########
http-proxy $IP 138">http-yd-qg1381.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://migumovie.lovev.com"
http-proxy-option EXT1 "Host http://migumovie.lovev.com/ HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qg1382.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qg1383.ovpn
cat http-yd-qg1381.ovpn http-yd-qg1382.ovpn http-yd-qg1383.ovpn>xbml-yd-138②.ovpn


echo "# 开源云免配置 四川 1  
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote / 80
;http-proxy-retry
;http-proxy [proxy server] [proxy port]
http-proxy 10.0.0.172 80
http-proxy-option EXT1 " "Host:$IP:3389">http-yd-scfh1.ovpn
echo 'http-proxy-option EXT1 Host:wap.sc.10086.cn
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-scfh2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-scfh3.ovpn
cat http-yd-scfh1.ovpn http-yd-scfh2.ovpn http-yd-scfh3.ovpn>xbml-yd-sc1.ovpn


echo "# 开源云免配置 四川 11-25 更新
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote / 80
http-proxy-option EXT1 " "Host:$IP:440
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 Host:wap.sc.10086.cn 
http-proxy 10.0.0.172 80
http-proxy $IP 137">http-yd-scfh21.ovpn
echo 'http-proxy-option EXT1 “Open”
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-scfh22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-scfh23.ovpn
cat http-yd-scfh21.ovpn http-yd-scfh22.ovpn http-yd-scfh23.ovpn>xbml-yd-sc2.ovpn


echo "# 开源云免配置 移动广东茂名 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote app.free.migudm.cn 80
########免流代码########
http-proxy $IP 8080">http-yd-maom1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "GET http://app.free.migudm.cn/? HTTP/1.1"
http-proxy-option EXT1 "Host: app.free.migudm.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-maom2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-maom3.ovpn
cat http-yd-maom1.ovpn http-yd-maom2.ovpn http-yd-maom3.ovpn>xbml-yd-maom.ovpn


echo "# 开源云免配置 移动浙江不限速②
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote app.free.migudm.cn 80
########免流代码########
http-proxy $IP 8080">http-yd-zj②1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "GET http://app.free.migudm.cn/? HTTP/1.1"
http-proxy-option EXT1 "Host: app.free.migudm.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj②2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj②3.ovpn
cat http-yd-zj②1.ovpn http-yd-zj②2.ovpn http-yd-zj②3.ovpn>xbml-yd-zj②.ovpn

echo "# 开源云免配置 移动浙江不限速③
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote dlsdown.mll.migu.cn 80
########免流代码########
http-proxy $IP 136">http-yd-zj③1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://dlsdown.mll.migu.cn / HTTP/1.1"
http-proxy-option EXT1 "Host: dlsdown.mll.migu.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj③2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj③3.ovpn
cat http-yd-zj③1.ovpn http-yd-zj③2.ovpn http-yd-zj③3.ovpn>xbml-yd-zj③.ovpn


echo "# 开源云免配置 广东深圳 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote wap.gd.10086.cn 80
http-proxy $IP 8080">http-yd-gdsz1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 X-Online-Host: wap.gd.10086.cn 
http-proxy-option EXT1 Host: wap.gd.10086.cn 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gdsz2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gdsz3.ovpn
cat http-yd-gdsz1.ovpn http-yd-gdsz2.ovpn http-yd-gdsz3.ovpn>xbml-yd-gdsz.ovpn


echo "# 开源云免配置 广东移动②
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 138">http-yd-gd31.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 POST http://adxserver.ad.cmvideo.cn
http-proxy-option EXT1 Host adxserver.ad.cmvideo.cn
http-proxy-option EXT1 Host: adxserver.ad.cmvideo.cn / HTTP/1.1
http-proxy-option CUSTOM-HEADER CONNECT/HTTP/1.1 
http-proxy-option EXT1 "cache-Control:no-store"
http-proxy-option EXT1 "cache-Control:no-store"
http-proxy-option EXT1 POST http://adxserver.ad.cmvideo.cn
http-proxy-option VERSION 1.1
http-proxy-option EXT1 "Proxy-Connection: keep-alive"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd32.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd33.ovpn
cat http-yd-gd31.ovpn http-yd-gd32.ovpn http-yd-gd33.ovpn>xbml-yd-gd2.ovpn

echo "# 开源云免配置 河南不限速① 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote / 80
;http-proxy-retry
;http-proxy [proxy server] [proxy port]
http-proxy-option EXT1  Host:$IP:443">http-yd-hn1.ovpn
echo '
http-proxy-option EXT1 Host:wap.ha.10086.cn 
http-proxy 10.0.0.172 80
########免流代码########

resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-hn2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-hn3.ovpn
cat http-yd-hn1.ovpn http-yd-hn2.ovpn http-yd-hn3.ovpn>xbml-yd-hn.ovpn


echo "# 开源云免配置 广东移动 1
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 138">http-yd-gd31.ovpn
echo '
remote wap.gd.chinamobile.com 80
http-proxy-option EXT1 CONNECT http://wap.gd.chinamobile.com / HTTP/1.1
http-proxy-option EXT1 POST http://wap.gd.chinamobile.com
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 Host: 642749159wap.gd.chinamobile.com
http-proxy-option EXT1 Host: /33/58/94/1388335894003000.mp3?mb=15380197563&fs=10104163&s=800&n=&iwap.gd.chinamobile.com / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd32.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd33.ovpn
cat http-yd-gd31.ovpn http-yd-gd32.ovpn http-yd-gd33.ovpn>xbml-yd-gd1.ovpn



echo "# 开源云免配置 广东移动 4
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080">http-yd-gd41.ovpn
echo '
########免流代码########
remote freetyst.mll.migu.cn 3389 tcp-client
http-proxy-option EXT1 GET http://freetyst.mll.migu.cn/public/ringmaker01/dailyring03/vsftp/ywq/public/ringmaker01/dailyring03/2015/11/2015%E5%B9%B411%E6%9C%8826%E6%97%A514%E7%82%B943%E5%88%86%E7%B4%A7%E6%80%A5%E5%86%85%E5%AE%B9%E5%87%86%E5%85%A5%E5%8C%97%E4%BA%AC%E5%B0%91%E5%9F%8E2%E9%A6%96/%E5%85%A8%E6%9B%B2%E8%AF%95%E5%90%AC/Mp3_128_44_16/%E6%88%91%E7%9A%84%E6%A2%A6-%E5%BC%A0%E9%9D%93%E9%A2%96.mp3?channelid=03&k=4fbe3340861916f5&t=1479837104 / HTTP/1.1 
http-proxy-option EXT1 X-Online-Host: freetyst.mll.migu.cn
http-proxy-option EXT1 Host: freetyst.mll.migu.cn 
http-proxy-option EXT1 xbml 127.0.0.1:443
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd42.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd43.ovpn
cat http-yd-gd41.ovpn http-yd-gd42.ovpn http-yd-gd43.ovpn>xbml-yd-gd4.ovpn


echo "# 开源云免配置 广东移动 5  清远中山深圳广州 以免 11-27更新
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote wap.gd.10086.cn 80
http-proxy $IP 8080">http-yd-gd51.ovpn
echo 'http-proxy-option EXT1  Host 127.0.0.1:443
http-proxy-option EXT1 "X-Online-Host: wap.gd.10086.cn" 
http-proxy-option EXT1 "Host: wap.gd.10086.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd52.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd53.ovpn
cat http-yd-gd51.ovpn http-yd-gd52.ovpn http-yd-gd53.ovpn>xbml-yd-gd5.ovpn


echo "# 开源云免配置 广东移动 6  珠海 以免 11-27更新
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080">http-yd-gd61.ovpn
echo 'http-proxy-option EXT1 "POST http://migumovie.lovev.com/HTTP/1.1"
http-proxy-option EXT1 "Host: migumovie.lovev.com"
http-proxy-option EXT1 xbml 127.0.0.1:443
remote migumovie.lovev.com 3389 tcp-client
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd62.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd63.ovpn
cat http-yd-gd61.ovpn http-yd-gd62.ovpn http-yd-gd63.ovpn>xbml-yd-gd6.ovpn




echo "# 开源云免配置 广东移动 7
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080">http-yd-gd71.ovpn
echo 'http-proxy-option CUSTOM-HEADER "Host wap.cmvideo.cn"
http-proxy-option EXT1 "Host X-Online-Host"
http-proxy-option EXT1 "Host" 
http-proxy-option CUSTOM-HEADER "CONNECT/HTTP/1.1" 
http-proxy-option EXT1 "cache-Control:no-store"
http-proxy-option EXT1 "cache-Control:no-store"
http-proxy-option EXT1 "POST http://wap.cmvideo.cn"
http-proxy-option VERSION 1.1
http-proxy-option EXT1 "Proxy-Connection: keep-alive"
http-proxy-option EXT1 xbml 127.0.0.1:443
remote wap.cmvideo.cn 3389 tcp-client
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd72.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd73.ovpn
cat http-yd-gd71.ovpn http-yd-gd72.ovpn http-yd-gd73.ovpn>xbml-yd-gd7.ovpn



echo "# 开源云免配置 重庆移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 138">http-yd-cq1.ovpn
echo 'http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://wap.cq.10086.cn"
http-proxy-option EXT1 "Host: wap.cq.10086.cn HTTP/1.1"
remote wap.cq.10086.cn 3389 tcp-client
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-cq2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-cq3.ovpn
cat http-yd-cq1.ovpn http-yd-cq2.ovpn http-yd-cq3.ovpn>xbml-yd-cq.ovpn


echo "# 开源云免配置 广东移动 3
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080">http-yd-gd341.ovpn
echo '
remote a.mll.migu.cn 80
http-proxy-option EXT1 POST http://a.mll.migu.cn
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "migu-x-up-calling-line-id: null"
http-proxy-option EXT1 "X-Requested-With: cmccwm.mobilemusic"
http-proxy-option EXT1 "Host: a.mll.migu.cn / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd342.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd343.ovpn
cat http-yd-gd341.ovpn http-yd-gd342.ovpn http-yd-gd343.ovpn>xbml-yd-gd3.ovpn



echo "# 开源云免配置 全国移动MM
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 138">http-yd-mm1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "GET http//:hf.mm.10086.cn / HTTP/1.1"
http-proxy-option EXT1 "Host: hf.mm.10086.cn "
http-proxy-option EXT1 "X-Online-Host: hf.mm.10086.cn "
remote hf.mm.10086.cn 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-mm2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-mm3.ovpn
cat http-yd-mm1.ovpn http-yd-mm2.ovpn http-yd-mm3.ovpn>xbml-yd-mm.ovpn



echo "# 开源云免配置 联通-大王卡②
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
remote mob.10010.com 80
########免流代码########
http-proxy  $IP 8080 ">http-lt-dwk21.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://mp.weixin.qq.com"
http-proxy-option EXT1 "Host: http://mp.weixin.qq.com / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-dwk22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-dwk23.ovpn
cat http-lt-dwk21.ovpn http-lt-dwk22.ovpn http-lt-dwk23.ovpn>xbml-lt-dwk2.ovpn

 
echo "# 开源云免配置 联通-天津  特殊代码
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy  $IP 8080 ">http-lt-tj1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 GET http://m.client.10010.com 
http-proxy-option EXT1 host: m.client.10010.com/HTTP/1.1 
http-proxy-option EXT1 Host: m.client.10010.com 
http-proxy-option EXT1 Connection: Keep-Alive 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-tj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-tj3.ovpn
cat http-lt-tj1.ovpn http-lt-tj2.ovpn http-lt-tj3.ovpn>xbml-lt-tj.ovpn

echo "# 开源云免配置 电信世纪龙
# 本文件由系统自动生成
# 类型：HTTP转接
# 必须开通 世纪龙业务  
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080 ">http-dx-sjl1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
remote 118.123.170.20/flowfreecontent 80
#############免流代码#############
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx-sjl2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx-sjl3.ovpn
cat http-dx-sjl1.ovpn http-dx-sjl2.ovpn http-dx-sjl3.ovpn>xbml-dx-sjl.ovpn

echo "# 开源云免配置 湖北 浙江 联通
# 本文件由系统自动生成
# 类型：HTTP转接
# 手机接入点必须是Wap接入点
client
dev tun
proto tcp	
########免流代码########
remote uac.10010.com/index.asp&from=http://$IP:443?uac.10010.com/index.asp&from=uac.10155.com/index.asp&& 443 ">http-lt-hb1.ovpn
echo '
http-proxy-option EXT1 "POST http://m.client.10010.com"
http-proxy-option EXT1 "GET http://m.client.10010.com"
http-proxy-option EXT1 ": http://uac.10010.com/"
http-proxy-option EXT1 "Referer: http://uac.10010.com/oauth2/new_auth?display=wap&page_type=05&app_code=ECS-YH-WAP&redirect_uri=http://wap.10010.com/t/loginCallBack.htm&state=http://wap.10010.com/t/home.htm&channel_code=113000001&real_ip=113.57.255.1"
http-proxy-option EXT1 VPN
http-proxy 10.0.0.172 80 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-hb2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-hb3.ovpn
cat http-lt-hb1.ovpn http-lt-hb2.ovpn http-lt-hb3.ovpn>xbml-lt-hb.ovpn


echo "# 开源云免配置 北京联通
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080 ">http-lt-bj1.ovpn
echo '
remote utv.bbn.com.cn 
http-proxy-option EXT1 GET /upload/2016/10/09/wasu/1015730836_1.jpg HTTP/1.1
http-proxy-option EXT1 Host: utv.bbn.com.cn
http-proxy-option EXT1 Host: 1utv.bbn.com.cn
http-proxy-option EXT1 Connection: Keep utv.bbn.com.cn-Alive
http-proxy-option EXT1 VPN
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-bj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-bj3.ovpn
cat http-lt-bj1.ovpn http-lt-bj2.ovpn http-lt-bj3.ovpn>xbml-lt-bj.ovpn

echo "# 开源云免配置 UAC联通②
# 支持地区 广东，湖北 ，河南，四川，重庆 其他待测试
# 本文件由系统自动生成
# 类型：HTTP转接
# 手机接入点必须是Wap接入点
client
dev tun
proto tcp	
########免流代码########
remote $IP:443?uac.10010.com/index.asp&from=uac.10155.com/index.asp&& 443 ">http-lt-uac21.ovpn
echo '
http-proxy-option EXT1 "Proxy-Authorization: Basic ZG1nbWxsOmRtZ21sbA=="
http-proxy-option EXT1 "CONNECT uac.10010.com"
http-proxy-option EXT1 ": http://uac.10010.com/"
http-proxy-option EXT1 "Referer: http://uac.10010.com/oauth2/new_auth?display=wap&page_type=05&app_code=ECS-YH-WAP&redirect_uri=http://wap.10010.com/t/loginCallBack.htm&state=http://wap.10010.com/t/home.htm&channel_code=113000001&real_ip=IP"
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-uac22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-uac23.ovpn
cat http-lt-uac21.ovpn http-lt-uac22.ovpn http-lt-uac23.ovpn>xbml-lt-uac2.ovpn


echo "# 开源云免配置 UAC联通3  最新联通（甘肃河南山东河北广西湖南湖北吉林联通）12-18更新
# 本文件由系统自动生成
# 类型：HTTP转接
# 手机接入点必须是Wap接入点
client
dev tun
proto tcp	
########免流代码########
remote uac.10010.com/index.asp&from=http://$IP:440?uac.10010.com/index.asp&from=uac.10155.com/index.asp&& 440 ">http-lt-uac231.ovpn
echo '
http-proxy-option EXT1 "CONNECT uac.10010.com" 
http-proxy-option EXT1 ": http://uac.10010.com/" 
http-proxy-option EXT1 "Referer: http://uac.10010.com/oauth2/new_auth?display=wap&page_type=05&app_code=ECS-YH-WAP&redirect_uri=http://wap.10010.com/t/loginCallBack.htm&state=http://wap.10010.com/t/home.htm&channel_code=113000001&real_ip=IP" 
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-uac232.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-uac233.ovpn
cat http-lt-uac231.ovpn http-lt-uac232.ovpn http-lt-uac233.ovpn>xbml-lt-uac3.ovpn


echo "# 开源云免配置 重庆电信  特殊代码
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080 ">http-dx-cq1.ovpn
echo '
remote 222.180.175.36 8182
http-proxy-option EXT1 "GET http://wapcq.189.cn"
http-proxy-option EXT1 "POST http://wapcq.189.cn"
http-proxy-option EXT1 "CONNECT wapcq.189.cn"
http-proxy-option EXT1 "VPNS 127.0.0.1 443"
http-proxy-option EXT1 "X-Online-Host: wapcq.189.cn"
http-proxy-option EXT1 "Host: wapcq.189.cn / HTTP/1.1" 
http-proxy-option EXT1 "Connection: keep-alive"
http-proxy-option EXT1 "GET http://dl.music.189.cn:9495/res/V/2044/mp3/00/03/90/2044000390010800.mp3?mb=18092737826&fs=2182582&s=800&n=ctnet&id=63831906&M=online&sid=240133273 HTTP/1.1"
http-proxy-option EXT1 "Host: dl.music.189.cn:9495"
http-proxy-option EXT1 "POST http://iting.music.189.cn:9101/iting2/imusic/V2 HTTP/1.1"
http-proxy-option EXT1 "Host: iting.music.189.cn:9101"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx-cq2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx-cq3.ovpn
cat http-dx-cq1.ovpn http-dx-cq2.ovpn http-dx-cq3.ovpn>xbml-dx-cq.ovpn

echo "# 开源云免配置 全国电信 特殊代码
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
http-proxy $IP 8080 ">http-dx-qg11.ovpn
echo '
remote ltetptv.189.com 80
http-proxy-option EXT1 "GET http://dl.music.189.cn:9495/res/V/1388/mp3/33/58/94/1388335894003000.mp3?mb=15380197563&fs=10104163&s=800&n=&id=63696337&M=online&sid=240387514 HTTP/1.1"
http-proxy-option EXT1 "Host dl.music.189.cn:9495"
http-proxy-option EXT1 "POST http://iting.music.189.cn:9101/iting2/imusic/V2 HTTP/1.1"
http-proxy-option EXT1 xbml 127.0.0.1:443
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx-qg12.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx-qg13.ovpn
cat http-dx-qg11.ovpn http-dx-qg12.ovpn http-dx-qg13.ovpn>xbml-dx-qg1.ovpn

echo "# 开源云免配置 宁夏移动 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote  $IP 138 ">http-yd-nx1.ovpn
echo '
http-proxy-option EXT1 POST http://migumovie.lovev.com
http-proxy-option EXT1 "X-Online-Host:migumovie.lovev.com"
http-proxy-option EXT1 xbml 127.0.0.1:443
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-nx2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-nx3.ovpn
cat http-yd-nx1.ovpn http-yd-nx2.ovpn http-yd-nx3.ovpn>xbml-yd-nx.ovpn


echo "# 开源云免配置 湖南移动  12-18
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote  $IP 8080 ">http-yd-hun1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
remote imusic.wo.com.cn 80
http-proxy-option EXT1 POST http://imusic.wo.com.cn
http-proxy-option EXT1 Host imusic.wo.com.cn
http-proxy-option EXT1 Host: imusic.wo.com.cn / HTTP/1.1
########免流代码########

########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-hun2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-hun3.ovpn
cat http-yd-hun1.ovpn http-yd-hun2.ovpn http-yd-hun3.ovpn>xbml-yd-hun.ovpn

echo "# 开源云免配置 贵州移动 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote  $IP 138 ">http-yd-gz1.ovpn
echo '
remote gslb.miguvod.lovev.com 80
http-proxy-option EXT1 POST gslb.miguvod.lovev.com
http-proxy-option EXT1 Host gslb.miguvod.lovev.com
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gz2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gz3.ovpn
cat http-yd-gz1.ovpn http-yd-gz2.ovpn http-yd-gz3.ovpn>xbml-yd-gz.ovpn
 

echo "# 开源云免配置 江苏  理论全国
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote $IP:443?uac.10010.com/index.asp&from=uac.10155.com/index.asp&& 440 TCP ">http-yd-js1.ovpn
echo '
http-proxy-option EXT1 "Referer: http://uac.10010.com/oauth2/new_auth?display=wap&page_type=05&app_code=ECS-YH-WAP&redirect_uri=http://wap.10010.com/t/loginCallBack.htm&state=http://wap.10010.com/t/home.htm&channel_code=113000001&real_ip=ip" 
http-proxy-option EXT1 "CONNECT uac.10010.com" 
http-proxy-option EXT1 ": http://uac.10010.com/" 
http-proxy 172.16.0.0 138
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-js2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-js3.ovpn
cat http-yd-js1.ovpn http-yd-js2.ovpn http-yd-js3.ovpn>xbml-yd-js.ovpn
 

echo "# 开源云免配置 全国联通 11-4更新  
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp	
########免流代码########
remote  $IP  443  ">http-lt-qglt1.ovpn
echo '
http-proxy-option EXT1 "Host m.wo.cn"
http-proxy-option EXT1 "Connection: keep-alive"
http-proxy-option EXT1 "GET w2ol.wo.cn/online/page/flow HTTP/1.1 "
http-proxy-option EXT1 "Host w2ol.wo.cn"
http-proxy-option EXT1 "GET /sso/services/sso003?head.cfg=47&foot.cfg=0&channel=f64b10f722&inDto.url=http%3A%2F%2Fw2ol.wo.cn%2Fonline%2Fpage%2Fflow%3Fhead.cfg%3D47%26foot.cfg%3D0%26channel%3Df64b10f722 HTTP/1.1" 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-qglt2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-qglt3.ovpn
cat http-lt-qglt1.ovpn http-lt-qglt2.ovpn http-lt-qglt3.ovpn>xbml-lt-qglt.ovpn

echo "
# 开源云免配置  开源菜自用 证券模式 12-4更新
# 本文件由系统自动生成
# 类型：HTTP转接
# 端口 （136.137.138.139）等
# 已测试成功地区浙江 广东广西 安徽江西 湖北湖南 黑龙江辽宁天津，贵州，福建。。。
# 但不代表一个省份全部通用，就是我有可以测试的地方都测试了
# 重要说明 开通证券之后才可以用
# 开通地址：https://store.gf.com.cn/mobile/other/whitelist  
# 次活动12:31结束 结束后配置就不免了
client
dev tun
proto tcp	
remote ws.gf.com.cn 80
########免流代码########
remote  $IP 8080 ">http-yd-qgzq1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://ws.gf.com.cn" 
http-proxy-option EXT1 "GET http://ws.gf.com.cn" 
http-proxy-option EXT1 "X-Online-Host: ws.gf.com.cn" 
http-proxy-option EXT1 "POST http://ws.gf.com.cn" 
http-proxy-option EXT1 "X-Online-Host: ws.gf.com.cn" 
http-proxy-option EXT1 "POST http://ws.gf.com.cn" 
http-proxy-option EXT1 "Host: ws.gf.com.cn" 
http-proxy-option EXT1 "GET http://ws.gf.com.cn" 
http-proxy-option EXT1 "Host: ws.gf.com.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qgzq2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qgzq3.ovpn
cat http-yd-qgzq1.ovpn http-yd-qgzq2.ovpn http-yd-qgzq3.ovpn>xbml-yd-qgzq.ovpn


echo "# 开源云免配置 内蒙古移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote zjw.mmarket.com 3389 tcp-client
########免流代码########
http-proxy-option EXT1 "POST zjw.mmarket.com"
http-proxy-option EXT1 "GET zjw.mmarket.com"
http-proxy-option EXT1 "X-Online-Host:zjw.mmarket.com"
http-proxy $IP $mpport">http-yd1-neimenggu-1.ovpn
echo '
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd1-neimenggu-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd1-neimenggu-3.ovpn
cat http-yd1-neimenggu-1.ovpn http-yd1-neimenggu-2.ovpn http-yd1-neimenggu-3.ovpn>xbml-yd-neimenggu.ovpn


echo "# 开源云免配置 全国移动1
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.cmvideo.cn 80
########免流代码########
http-proxy $IP 8080">http-yd-gx-quang11.ovpn
echo '
remote wap.cmvideo.cn 3389 tcp-clientn
http-proxy-option CUSTOM-HEADER Host wap.cmvideo.cn
http-proxy-option EXT1 Host X-Online-Host
http-proxy-option EXT1 Host 
http-proxy-option CUSTOM-HEADER CONNECT/HTTP/1.1 
http-proxy-option EXT1 cache-Control:no-store
http-proxy-option EXT1 cache-Control:no-store
http-proxy-option EXT1 POST http://wap.cmvideo.cn
http-proxy-option VERSION 1.1
http-proxy-option EXT1 Proxy-Connection: keep-alive
http-proxy-option EXT1 VPN 127.0.0.1:443
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gx-quang12.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gx-quang13.ovpn
cat http-yd-gx-quang11.ovpn http-yd-gx-quang12.ovpn http-yd-gx-quang13.ovpn>xbml-yd-migu1.ovpn



echo "# 开源云免配置 全国移动2
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.cmvideo.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://wap.cmvideo.cn"">http-yd-gx-quanguo1.ovpn
echo 'http-proxy-option EXT1 "Host: wap.cmvideo.cn / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gx-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gx-quanguo3.ovpn
cat http-yd-gx-quanguo1.ovpn http-yd-gx-quanguo2.ovpn http-yd-gx-quanguo3.ovpn>xbml-yd-migu.ovpn



echo "# 开源云免配置 全国移动3
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote vod.gslb.cmvideo.cn 80
########免流代码########
http-proxy $IP $mpport">http-yd-migu2-1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "X-Online-Host: vod.gslb.cmvideo.cn" 
http-proxy-option EXT1 "Host: vod.gslb.cmvideo.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-migu2-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-migu2-3.ovpn
cat http-yd-migu2-1.ovpn http-yd-migu2-2.ovpn http-yd-migu2-3.ovpn>xbml-yd-migu2.ovpn



echo "# 开源云免配置 全国移动4
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote migumovie.lovev.com 80
########免流代码########
http-proxy $IP $mpport">http-yd-migu3-1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "X-Online-Host: migumovie.lovev.com" 
http-proxy-option EXT1 "Host: migumovie.lovev.com"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-migu3-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-migu3-3.ovpn
cat http-yd-migu3-1.ovpn http-yd-migu3-2.ovpn http-yd-migu3-3.ovpn>xbml-yd-migu3.ovpn


echo "# 开源云免配置 全国移动5
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote migumovie.lovev.com 80
########免流代码########
http-proxy $IP 137">http-yd-137migu-1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "X-Online-Host: migumovie.lovev.com" 
http-proxy-option EXT1 "Host: migumovie.lovev.com"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-137migu-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-137migu-3.ovpn
cat http-yd-137migu-1.ovpn http-yd-137migu-2.ovpn http-yd-137migu-3.ovpn>xbml-yd-migu2-137.ovpn

echo "# 开源云免配置 全国移动6
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote dlsdown.mll.migu.cn 80
########免流代码########
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option EXT1 "POST http://dlsdown.mll.migu.cnv"
http-proxy-option EXT1 "GET /wlansst?pars=CI=6005660A0KZ2600902000009442296/F=020007/T=30142258647901/S=47be953c93/FN=filename.mp3 HTTP/1.1"
http-proxy $IP 137">http-yd-qg11.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qg22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qg33.ovpn
cat http-yd-qg11.ovpn http-yd-qg22.ovpn http-yd-qg33.ovpn>xbml-yd-migu-137.ovpn


echo "# 开源云免配置 全国移动7  四川测试以免 理论全国 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
remote / 80
http-proxy 10.0.0.172 80
http-proxy-option EXT1  Host:$IP:443
http-proxy-option EXT1 Host: a.mll.migu.cn">http-yd-qg71.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qg72.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qg73.ovpn
cat http-yd-qg71.ovpn http-yd-qg72.ovpn http-yd-qg73.ovpn>xbml-yd-qg7.ovpn


echo "# 开源云免配置 全国移动8   理论全国 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
remote $IP:443/
Host:strms.free.migudm.cn
http-proxy-option EXT1 CONNECT strms.free.migudm.cn
http-proxy-option EXT1 X-Online-Host: strms.free.migudm.cn
http-proxy 10.0.0.172 80">http-yd-qg81.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qg82.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qg83.ovpn
cat http-yd-qg81.ovpn http-yd-qg82.ovpn http-yd-qg83.ovpn>xbml-yd-qg8.ovpn



echo "# 开源云免配置 全国移动9   理论全国 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
remote $IP:443/
Host:a.mll.migu.cn
http-proxy-option EXT1 CONNECT a.mll.migu.cn
http-proxy-option EXT1 X-Online-Host: a.mll.migu.cn
http-proxy 10.0.0.172 80">http-yd-qg91.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qg92.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qg93.ovpn
cat http-yd-qg91.ovpn http-yd-qg92.ovpn http-yd-qg93.ovpn>xbml-yd-qg9.ovpn



echo "# 开源云免配置 全国移动A  四川 陕西 广东 已免 理论全国 
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
remote / 80
;http-proxy-retry
;http-proxy [proxy server] [proxy port]
http-proxy 10.0.0.172 80
http-proxy-option EXT1 " "Host:$IP:440
http-proxy-option EXT1 Host:wap.10086.cn">http-yd-qga1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-qga2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-qga3.ovpn
cat http-yd-qga1.ovpn http-yd-qga2.ovpn http-yd-qga3.ovpn>xbml-yd-qgA.ovpn


echo "# 开源云免配置 UAC联通①
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote uac.10010.com 443
########免流代码########
http-proxy $IP 8080">http-lt-uac-1.ovpn
echo '
http-proxy-option EXT1 "POST http://k.10010.com"
http-proxy-option EXT1 "Host k.10010.com"
http-proxy-option EXT1 "Host: k.10010.com / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-uac-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-uac-3.ovpn
cat http-lt-uac-1.ovpn http-lt-uac-2.ovpn http-lt-uac-3.ovpn>xbml-lt-uac.ovpn

echo "# 开源云免配置   全国联通1
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
http-proxy $IP 8080">http-lt-28080-1.ovpn
echo '
remote res.mall.10010.cn 3389
http-proxy-option EXT1 xbml 127.0.0.1:443
http-proxy-option VERSION 1.1
http-proxy-option EXT1 Host: sales.wostore.cn:8081 /HTTP/1.1
http-proxy-option EXT1 Proxy-Connection: keep-alive
http-proxy-option EXT1 POST http://m.iread.wo.com.cn
http-proxy-option EXT1 Host: m.iread.wo.com.cn /HTTP/1.1
http-proxy-option EXT1 GET /mall/res/uploader/index/20160928174353294871760.jpg HTTP/1.1
http-proxy-option EXT1 Host: res.mall.10010.cn
http-proxy-option EXT1 X-Online-Host: wap.10010.com
'>http-lt-28080-2.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun'>http-lt-28080-3.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
">http-lt-28080-4.ovpn
cat http-lt-28080-1.ovpn http-lt-28080-2.ovpn http-lt-28080-3.ovpn http-lt-28080-4.ovpn>xbml-lt-qg1.ovpn


echo "# 开源云免配置 联通空中卡53
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote k.10010.com 80
########免流代码########
http-proxy $IP 53">http-lt-53-1.ovpn
echo 'http-proxy-option EXT1 "POST http://k.10010.com"
http-proxy-option EXT1 "Host k.10010.com"
http-proxy-option EXT1 "Host: k.10010.com / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-53-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-53-3.ovpn
cat http-lt-53-1.ovpn http-lt-53-2.ovpn http-lt-53-3.ovpn>xbml-lt-53.ovpn

echo "# 开源云免配置 联通全国1
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote mob.10010.com 80
########免流代码########
http-proxy $IP $mpport">lt-quanguo123.ovpn
echo 'http-proxy-option EXT1 "POST http://m.client.10010.com" 
http-proxy-option EXT1 "Host: http://m.client.10010.com / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>lt-quanguo223.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">lt-quanguo323.ovpn
cat lt-quanguo123.ovpn lt-quanguo223.ovpn lt-quanguo323.ovpn>xbml-lt-1.ovpn



echo "# 开源云免配置 联通全国2
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote $IP 80
########免流代码########
http-proxy $IP 8080">lt-quanguo123.ovpn
echo '
remote uac.10010.com 443 tcp-client
http-proxy-option EXT1 POST https://uac.10010.com
http-proxy-option EXT1 Host uac.10010.com
http-proxy-option EXT1 CONNECT uac.10010.com:443 HTTP/1.1
http-proxy-option EXT1 Conneection：keep-alive
http-proxy-option EXT1 Proxy-Conneection：keep-alive
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>lt-quanguo223.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">lt-quanguo323.ovpn
cat lt-quanguo123.ovpn lt-quanguo223.ovpn lt-quanguo323.ovpn>xbml-lt-2.ovpn


echo "# 开源云免配置 联通广东
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote u.3gtv.net 80
########免流代码########
http-proxy $IP $mpport">http-lt-gd-1.ovpn
echo '
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-gd-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-gd-3.ovpn
cat http-lt-gd-1.ovpn http-lt-gd-2.ovpn http-lt-gd-3.ovpn>xbml-lt-gd.ovpn


echo "# 开源云免配置 联通全国3
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote mob.10010.com 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 "POST http://m.client.10010.com"
http-proxy-option EXT1 "Host: m.client.10010.com"">http-lt-quanguo11.ovpn
echo '
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-quanguo22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-quanguo33.ovpn
cat http-lt-quanguo11.ovpn http-lt-quanguo22.ovpn http-lt-quanguo33.ovpn>xbml-lt-3.ovpn



echo "# 开源云免配置 联通全国4
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
http-proxy $IP $mpport">http-lt-qglt41.ovpn
echo '
remote wap.10010.com 80
http-proxy-option EXT1 POST http://uac.10010.com
http-proxy-option EXT1 Host: uac.10010.com / HTTP/1.1
http-proxy-option EXT1 [V]
[p_host1]X-Online-Host:uac.10010.com [H];
http-proxy-option EXT1 HTTPS:CONNECT /HTTP/1.1 HOST:443
http-proxy-option EXT1 Host: uac.10010.com
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-qglt42.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-qglt43.ovpn
cat http-lt-qglt41.ovpn http-lt-qglt42.ovpn http-lt-qglt43.ovpn>xbml-lt-4.ovpn



echo "# 开源云免配置 5
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
remote $IP?uac.10010.com 443">http-lt-qglt51.ovpn
echo '
http-proxy-option EXT1 GET /oauth2/images/deskico.png HTTP/1.1
http-proxy-option EXT1 Host: uac.10010.com
http-proxy-option EXT1 Connection: keep-alive
http-proxy-option EXT1 Referer: https://uac.10010.com/oauth2/new_auth?display=wap&page_type=05&app_code=ECS-YH-WAP&redirect_uri=http://wap.10010.com/t/loginCallBack.htm&state=http://wap.10010.com/t/myunicom.htm&channel_code=113000001&real_ip=120.27.235.149
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-qglt52.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-qglt53.ovpn
cat http-lt-qglt51.ovpn http-lt-qglt52.ovpn http-lt-qglt53.ovpn>xbml-lt-5.ovpn


echo "# 开源云免配置 联通WAP线路
# 本文件由系统自动生成
client
dev tun
proto tcp
remote $IP:$vpnport?wap.10010.com $vpnport
http-proxy-option VERSION 1.1
http-proxy 10.0.0.172 80">http-lt-wap-1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-wap-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-wap-3.ovpn
cat http-lt-wap-1.ovpn http-lt-wap-2.ovpn http-lt-wap-3.ovpn>xbml-lt-wap.ovpn

echo "# 开源云免配置 联通大王卡线路
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
http-proxy $IP $mpport">http-lt-dwk-1.ovpn
echo 'remote szextshort.weixin.qq.com 80
http-proxy-option EXT1 "POST http://szextshort.weixin.qq.com/mmtls/2181af9c HTTP/1.1" 
http-proxy-option EXT1 "Host:  szextshort.weixin.qq.com" 
http-proxy-option EXT1 "Host: szextshort.weixin.qq.com" 
http-proxy-option EXT1 "Host: szextshort.weixin.qq.com" 
http-proxy-option EXT1 "Upgrade: mmtls" 
http-proxy-option EXT1 "User-Agent: MicroMessenger Client"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-dwk-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-dwk-3.ovpn
cat http-lt-dwk-1.ovpn http-lt-dwk-2.ovpn http-lt-dwk-3.ovpn>xbml-lt-dwk.ovpn

echo "# 开源云免配置 电信爱看
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote ltetptv.189.com 80
########免流代码########
http-proxy $IP $mpport">111dx1.ovpn
echo '
http-proxy-option EXT1 xbml 127.0.0.1:443 
http-proxy-option EXT1 "GET http://ltetp.tv189.com "
http-proxy-option EXT1 "POST http://ltetp.tv189.com "
http-proxy-option EXT1 "X-Online-Host: ltetp.tv189.com "
http-proxy-option EXT1 "Host: ltetp.tv189.com " 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx3.ovpn
cat 111dx1.ovpn http-dx2.ovpn http-dx3.ovpn>xbml-dx-1.ovpn


echo "# 开源云免配置 全国电信音乐
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote dl.music.189.cn 80
########免流代码########
http-proxy-option EXT1 xbml 127.0.0.1:443 
http-proxy-option EXT1 "GET http://dl.music.189.cn "
http-proxy-option EXT1 "POST http://dl.music.189.cn "
http-proxy-option EXT1 "X-Online-Host: dl.music.189.cn "
http-proxy-option EXT1 "Host: dl.music.189.cn " 
http-proxy $IP $mpport ">http-dx-quanguo1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx-quanguo3.ovpn
cat http-dx-quanguo1.ovpn http-dx-quanguo2.ovpn http-dx-quanguo3.ovpn>xbml-dx-yinyue.ovpn
rm -rf ./{http-dx-quanguo1.ovpn,http-dx-quanguo2.ovpn,http-dx-quanguo3.ovpn}


echo "# 云免配置 电信常规-测试免广东
# 本文件由系统自动生成
# 类型：2-常规类型
client
dev tun
proto tcp
remote $IP $vpnport
########免流代码########
http-proxy $IP $mpport">http-dx31.ovpn
echo 'http-proxy-option EXT1 "POST http://cdn.4g.play.cn" 
http-proxy-option EXT1 "GET http://cdn.4g.play.cn" 
http-proxy-option EXT1 "X-Online-Host: cdn.4g.play.cn" 
http-proxy-option EXT1 "POST http://cdn.4g.play.cn" 
http-proxy-option EXT1 "X-Online-Host: cdn.4g.play.cn" 
http-proxy-option EXT1 "POST http://cdn.4g.play.cn" 
http-proxy-option EXT1 "Host: cdn.4g.play.cn" 
http-proxy-option EXT1 "GET http://cdn.4g.play.cn" 
http-proxy-option EXT1 "Host: cdn.4g.play.cn" 
########免流代码########
<http-proxy-user-pass>
xbml
xbml
</http-proxy-user-pass>

resolv-retry infinite
nobind
persist-key
persist-tun
'>http-dx322.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
">http-dx43.ovpn
cat http-dx31.ovpn http-dx322.ovpn http-dx43.ovpn>xbml-dx-gd.ovpn


echo
echo -e "\033[36m配置文件制作完毕 \033[0m"
myi="正版授权";
yum install -y java >/dev/null 2>&1
curl -O ${http}${Host}/${Vpnfile}/android.zip >/dev/null 2>&1
unzip android.zip >/dev/null 2>&1 && rm -f android.zip
\cp -rf xbml-yd-old.ovpn       ./android/assets/移动常规类型.ovpn
\cp -rf xbml-yd-udp138.ovpn    ./android/assets/移动全国138UDP.ovpn
\cp -rf xbml-yd-udp137.ovpn    ./android/assets/移动全国137UDP.ovpn
\cp -rf xbml-yd-136.ovpn       ./android/assets/移动全国136.ovpn
\cp -rf xbml-yd-137.ovpn       ./android/assets/移动全国137.ovpn
\cp -rf xbml-yd-138.ovpn       ./android/assets/移动全国138.ovpn
\cp -rf xbml-yd-138②.ovpn     ./android/assets/移动全国138②.ovpn
\cp -rf xbml-yd-mg138.ovpn     ./android/assets/移动咪咕138.ovpn
\cp -rf xbml-yd-139.ovpn       ./android/assets/移动全国139.ovpn
\cp -rf xbml-yd-mm.ovpn        ./android/assets/移动全国MM.ovpn
\cp -rf xbml-yd-zj①.ovpn      ./android/assets/浙江移动1.ovpn
\cp -rf xbml-yd-zj②.ovpn      ./android/assets/浙江移动2.ovpn
\cp -rf xbml-yd-zj③.ovpn      ./android/assets/浙江移动3.ovpn
\cp -rf xbml-yd-js.ovpn        ./android/assets/江苏移动.ovpn
\cp -rf xbml-yd-old-366.ovpn   ./android/assets/移动366类型.ovpn
\cp -rf xbml-yd-old-351.ovpn   ./android/assets/移动351类型.ovpn
\cp -rf xbml-yd-fj.ovpn        ./android/assets/福建移动.ovpn
\cp -rf xbml-yd-gs.ovpn        ./android/assets/甘肃移动1.ovpn
\cp -rf xbml-yd-gs2.ovpn       ./android/assets/甘肃移动2.ovpn
\cp -rf xbml-yd-gs3.ovpn       ./android/assets/甘肃移动3.ovpn
\cp -rf xbml-yd-gs4.ovpn       ./android/assets/甘肃移动4.ovpn
\cp -rf xbml-yd-hn.ovpn        ./android/assets/河南移动.ovpn
\cp -rf xbml-yd-gdsz.ovpn      ./android/assets/广东深圳.ovpn
\cp -rf xbml-yd-gd1.ovpn       ./android/assets/广东移动1.ovp
\cp -rf xbml-yd-gd2.ovpn       ./android/assets/广东移动2.ovpn
\cp -rf xbml-yd-gd3.ovpn       ./android/assets/广东移动3.ovpn
\cp -rf xbml-yd-gd4.ovpn       ./android/assets/广东移动4.ovpn
\cp -rf xbml-yd-gd5.ovpn       ./android/assets/广东移动5.ovpn
\cp -rf xbml-yd-gd6.ovpn       ./android/assets/广东移动6.ovpn
\cp -rf xbml-yd-gd7.ovpn       ./android/assets/广东移动7.ovpn
\cp -rf xbml-yd-cq.ovpn        ./android/assets/重庆移动.ovpn
\cp -rf xbml-yd-qgzq.ovpn      ./android/assets/全国证券.ovpn
\cp -rf xbml-yd-maom.ovpn      ./android/assets/广东茂名移动.ovpn
\cp -rf xbml-yd-gx.ovpn        ./android/assets/广西移动.ovpn
\cp -rf xbml-yd-hebei.ovpn     ./android/assets/河北移动.ovpn
\cp -rf xbml-yd-sd.ovpn        ./android/assets/山东移动1.ovpn
\cp -rf xbml-yd-sd2.ovpn        ./android/assets/山东移动2.ovpn
\cp -rf xbml-yd-jx.ovpn        ./android/assets/江西移动1.ovpn
\cp -rf xbml-yd-sx.ovpn        ./android/assets/陕西移动1.ovpn
\cp -rf xbml-yd-sx1.ovpn       ./android/assets/陕西移动2.ovpn
\cp -rf xbml-yd-sx3.ovpn       ./android/assets/陕西移动3.ovpn
\cp -rf xbml-yd-nx.ovpn        ./android/assets/宁夏移动.ovpn
\cp -rf xbml-yd-hun.ovpn       ./android/assets/湖南移动.ovpn
\cp -rf xbml-yd-gz.ovpn        ./android/assets/贵州移动.ovpn
\cp -rf xbml-yd-sc1.ovpn       ./android/assets/四川移动1.ovpn
\cp -rf xbml-yd-sc2.ovpn       ./android/assets/四川移动2.ovpn
\cp -rf xbml-yd-ah.ovpn        ./android/assets/安徽移动.ovpn
\cp -rf xbml-yd-neimenggu.ovpn ./android/assets/内蒙古移动.ovpn
\cp -rf xbml-yd-migu1.ovpn     ./android/assets/全国移动1.ovpn
\cp -rf xbml-yd-migu.ovpn      ./android/assets/全国移动2.ovpn
\cp -rf xbml-yd-migu2.ovpn     ./android/assets/全国移动3.ovpn
\cp -rf xbml-yd-migu3.ovpn     ./android/assets/全国移动4.ovpn
\cp -rf xbml-yd-migu2-137.ovpn ./android/assets/全国移动5.ovpn
\cp -rf xbml-yd-migu-137.ovpn  ./android/assets/全国移动6.ovpn
\cp -rf xbml-yd-qg7.ovpn       ./android/assets/全国移动7.ovpn
\cp -rf xbml-yd-qg8.ovpn       ./android/assets/全国移动8.ovpn
\cp -rf xbml-yd-qg9.ovpn       ./android/assets/全国移动9.ovpn
\cp -rf xbml-yd-qgA.ovpn       ./android/assets/全国移动A.ovpn
\cp -rf xbml-lt-uac.ovpn       ./android/assets/UAC联通1.ovpn
\cp -rf xbml-lt-uac2.ovpn      ./android/assets/UAC联通2.ovpn
\cp -rf xbml-lt-uac3.ovpn      ./android/assets/UAC联通3.ovpn
\cp -rf xbml-lt-53.ovpn        ./android/assets/联通空中卡53.ovpn
\cp -rf xbml-lt-gd.ovpn        ./android/assets/联通广东.ovpn
\cp -rf xbml-lt-5.ovpn         ./android/assets/联通全国5.ovpn
\cp -rf xbml-lt-4.ovpn         ./android/assets/联通全国4.ovpn
\cp -rf xbml-lt-3.ovpn         ./android/assets/联通全国3.ovpn
\cp -rf xbml-lt-2.ovpn         ./android/assets/联通全国2.ovpn
\cp -rf xbml-lt-1.ovpn         ./android/assets/联通全国1.ovpn
\cp -rf xbml-lt-qglt.ovpn      ./android/assets/联通全国A.ovpn
\cp -rf xbml-lt-tj.ovpn        ./android/assets/联通天津.ovpn
\cp -rf xbml-lt-hb.ovpn        ./android/assets/湖北联通.ovpn
\cp -rf xbml-lt-bj.ovpn        ./android/assets/北京联通.ovpn
\cp -rf xbml-lt-qg1.ovpn       ./android/assets/联通全国.ovpn
\cp -rf xbml-lt-wap.ovpn       ./android/assets/联通WAP线路.ovpn
\cp -rf xbml-lt-dwk.ovpn       ./android/assets/联通大王卡线路①.ovpn
\cp -rf xbml-lt-dwk2.ovpn      ./android/assets/联通大王卡线路②.ovpn
\cp -rf xbml-dx-1.ovpn         ./android/assets/电信爱看.ovpn
\cp -rf xbml-dx-cq.ovpn        ./android/assets/重庆电信.ovpn
\cp -rf xbml-dx-qg1.ovpn       ./android/assets/全国电信.ovpn
\cp -rf xbml-dx-sjl.ovpn       ./android/assets/电信世纪龙.ovpn
\cp -rf xbml-dx-gd.ovpn        ./android/assets/电信常规-测试免广东.ovpn
\cp -rf xbml-dx-yinyue.ovpn    ./android/assets/全国电信音乐.ovpn
yum install -y zip >/dev/null 2>&1
cd android && chmod -R 777 ./* &&  wget ${http}${Host}/${Vpnfile}/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz && java -jar signapk.jar testkey.x509.pem testkey.pk8
cd /home && rm -rf android
echo		

sleep 2
echo
echo
cd /home
tar -zcvf ${uploadfile} ./{xbml-yd-old.ovpn,xbml-yd-udp138.ovpn,xbml-yd-udp137.ovpn,xbml-yd-138.ovpn,xbml-yd-138②.ovpn,xbml-yd-mg138.ovpn,xbml-yd-zj①.ovpn,xbml-lt-2.ovpn,xbml-yd-137.ovpn,xbml-yd-old-366.ovpn,xbml-yd-old-351.ovpn,xbml-yd-fj.ovpn,xbml-yd-gs.ovpn,xbml-yd-gs2.ovpn,xbml-yd-gs3.ovpn,xbml-yd-gs4.ovpn,xbml-yd-gd2.ovpn,xbml-yd-gdsz.ovpn,xbml-yd-gd1.ovpn,xbml-yd-gd4.ovpn,xbml-yd-gd5.ovpn,xbml-yd-gd6.ovpn,xbml-yd-gd7.ovpn,xbml-yd-gd3.ovpn,xbml-yd-gx.ovpn,xbml-yd-hebei.ovpn,xbml-yd-sd.ovpn,xbml-yd-sd2.ovpn,xbml-yd-sx.ovpn,xbml-yd-sx1.ovpn,xbml-yd-sx3.ovpn,xbml-yd-jx.ovpn,xbml-yd-sc①.ovpn,xbml-yd-sc1.ovpn,xbml-yd-sc2.ovpn,xbml-yd-sc2.ovpn,xbml-yd-maom.ovpn,xbml-yd-zj②.ovpn,xbml-yd-zj③.ovpn,xbml-yd-hn.ovpn,xbml-lt-dwk2.ovpn,xbml-lt-tj.ovpn,xbml-dx-sjl.ovpn,xbml-yd-qgzq.ovpn,xbml-lt-hb.ovpn,xbml-lt-zj.ovpn,xbml-lt-bj.ovpn,xbml-lt-uac2.ovpn,xbml-lt-uac3.ovpn,xbml-dx-cq.ovpn,xbml-dx-qg1.ovpn,xbml-yd-nx.ovpn,xbml-yd-hun.ovpn,xbml-yd-gz.ovpn,xbml-yd-136.ovpn,xbml-yd-139.ovpn,xbml-yd-mm.ovpn,xbml-yd-js.ovpn,xbml-yd-ah.ovpn,xbml-yd-neimenggu.ovpn,xbml-yd-migu1.ovpn,xbml-yd-migu.ovpn,xbml-yd-migu2.ovpn,xbml-yd-migu3.ovpn,xbml-yd-migu2-137.ovpn,xbml-yd-migu-137.ovpn,xbml-yd-qg7.ovpn,xbml-yd-qg8.ovpn,xbml-yd-qgA.ovpn,xbml-yd-qg9.ovpn,xbml-lt-uac.ovpn,xbml-lt-53.ovpn,xbml-lt-1.ovpn,xbml-lt-qglt.ovpn,xbml-lt-gd.ovpn,xbml-lt-3.ovpn,xbml-lt-4.ovpn,xbml-lt-5.ovpn,xbml-lt-qg1.ovpn,xbml-lt-wap.ovpn,xbml-lt-dwk.ovpn,xbml-dx-1.ovpn,xbml-dx-gd.ovpn,xbml-dx-yinyue.ovpn,ca.crt,ta.key,info.txt} >/dev/null 2>&1
echo
echo
echo
echo -e "\033[36m正在上传文件中...\033[0m"
echo -e "\033[36m温馨提示：\033[0m"
echo -e "\033[36m上传需要几分钟具体时间看你服务器配置\033[0m"
echo -e "\033[36m再此期间请耐心等待！\033[0m"
sleep 2
echo
echo -e "\033[36m上传文件完毕...\033[0m"
clear
rm -rf android
sleep 3
return 1
}
function webmlpass() {
cd /home
echo
echo -e '\033[36m欢迎使用OpenVPN快速安装脚本\033[0m' >>info.txt
echo -e "\033[36m
---------------------------------------------------------
前台/用户中心：http://${IP}:${port}
后台管理系统： http://${IP}:${port}/admin
代理中心：     http://${IP}:${port}/daili
---------------------------------------------------------
---------------------------------------------------------
云免使用教程 http://xbml.vip/pg/
您的数据库用户名：root 数据库密码：${sqlpass}
后台管理员用户名：$id 管理密码：$ml

---------------------------------------------------------
---------------------------------------------------------
免流配置下载链接：http://${IP}:${port}/openvpn.tar.gz
---------------------------------------------------------
---------------------------------------------------------
修改管理员账号密码文件:/home/wwwroot/default/config.php
---------------------------------------------------------

---------------------------------------------------------
文件名格式：xbml-yd  移动  xbml-lt  联通  xbml-dx  电信
不免请自行更换免流Host代码
---------------------------------------------------------

 \033[0m">>info.txt
return 1
}
function pkgovpn() {
clear
echo
echo -e "\033[34m进行打包文件...\033[0m"
echo
sleep 2
cd /home/
clear
rm -rf *.ovpn
rm -rf /root/ShakaApktool
echo -e "\033[34m进配置文件已经上传完毕！正在加载您的配置信息...\033[0m"
cat info.txt
echo -e "\033[33m下载链接：http://${IP}:${port}/openvpn.tar.gz \033[0m"
echo 
\cp -rf /home/xbml-openvpn.tar.gz /home/wwwroot/default/openvpn.tar.gz
cd /home/wwwroot/default/
mv  gl       admin
echo 
echo -e "\033[31m您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）\033[0m"
return 1
}
function main(){
clear
echo -e "\033[31m\033[05m程序正在检查环境中，请稍后... \033[0m"
if [ -f /etc/os-release ];then
	OS_VERSION=`cat /etc/os-release |awk -F'[="]+' '/^VERSION_ID=/ {print $2}'`
	if [ $OS_VERSION != "7" ];then
		echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n"
		echo "暂不支持该系统安装"
		echo "请更换 CentOS 7.0-7.2 系统进行安装"
		echo "$errorlogo";
		exit 0;
	fi
elif [ -f /etc/redhat-release ];then
	OS_VERSION=`cat /etc/redhat-release |grep -Eos '\b[0-9]+\S*\b' |cut -d'.' -f1`
	if [ $OS_VERSION != "7" ];then
		echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n"
		echo "暂不支持该系统安装"
		echo "请更换 CentOS 7.0-7.2 系统进行安装"
		echo "$errorlogo";
		exit 0;
	fi
else
	echo -e "当前系统版本为：\033[31m未知\033[0m\n"
	echo "暂不支持该系统安装"
	echo "请更换 CentOS 7.0-7.2 系统进行安装"
	echo -e "\033[36m $errorlogo \033[0m"
	exit 0；
fi
if [ ! -e "/dev/net/tun" ];
    then
        echo
        echo -e "  安装出错 [原因：\033[31m TUN/TAP虚拟网卡不存在 \033[0m]"
        echo "  网易蜂巢容器官方已不支持安装使用"
		exit 0;
fi
shellhead
clear
authentication
sleep 3
clear
echo -e "\033[31m \033[05m > 选择安装模式 \033[0m"
echo -e "\033[36m1 - 安装.\033[0m"
echo -e "\033[36mx - 卸载.\033[0m"
echo
echo -n -e "\033[31m请输入对应数字:\033[0m"
read installslect
if [[ "$installslect" == "x" ]]
	then
	clear
	echo
	echo -e "\033[36m正在移除系统OpenVPN服务/配置文件...  \033[0m"
	echo
	echo -e "\033[36m正在停止服务... \033[0m"
	systemctl stop openvpn@server.service >/dev/null 2>&1
	systemctl stop squid.service >/dev/null 2>&1
	killall udp >/dev/null 2>&1
	systemctl stop httpd.service >/dev/null 2>&1
	systemctl stop mariadb.service >/dev/null 2>&1
	systemctl stop mysqld.service >/dev/null 2>&1
		/etc/init.d/mysqld stop >/dev/null 2>&1
	sleep 2
	echo -e "\033[36m正在卸载程序...   \033[0m"
	yum remove openvpn squid -y
	echo -e "\033[36m正在清理残留文件...  \033[0m"
	rm -rf /etc/squid /etc/openvpn /bin/dup /home/* /lib/systemd/system/vpn.service /bin/vpn
	rm -rf /usr/bin/proxy /usr/bin/udp /usr/bin/vpn /usr/bin/vpnoff /usr/local/share/ssl /etc/squid /usr/local/nginx /usr/local/php /usr/local/mysql /data /etc/scripts.conf /lib/systemd/system/vpn.service
	rm -rf /etc/init.d/nginx /etc/init.d/php-fpm /etc/init.d/mysql /etc/python/cert-python.conf /etc/openvpn/connect.sh /etc/openvpn/disconnect.sh /etc/openvpn/login.sh
	rm -rf /etc/openvpn/*
	rm -rf /root/*
	rm -rf /home/*
	sleep 2 
	rm -rf /var/lib/mysql
	rm -rf /var/lib/mysql/
	rm -rf /usr/lib64/mysql
	rm -rf /etc/my.cnf
	rm -rf /var/log/mysql/
	rm -rf
	echo -e "\033[36m卸载完成，感谢使用！  \033[0m"
	exit 0;
else
clear
echo -e "\033[36m $loginlogo \033[0m"
echo
echo -e "\033[36m本脚本已经破解。已经移除大部分商用代码，后台网站可以登录，安卓苹果手机用户一律使用openvpn进行免流。  \033[0m"
sleep 3
zb="正版授权"; 
myi=`wget http://xbml.openvpn-vpn.xbml.vip/include/rz.php?url=$IP -O - -q;`
myi="正版授权"; 
if [[ $myi == ${zb} ]] ;then
echo			
clear
vpnportseetings
readytoinstall
newvpn
installlnmp
webml
ovpn
webmlpass
echo -e "\033[35m正在为您开启所有服务...\033[0m"
chmod 777 /home/wwwroot/default/res/*
sleep 3
chmod 0777 /usr/bin/udp
udp -l 8080 -d >/dev/null 2>&1
udp -l 136 -d >/dev/null 2>&1
udp -l 137 -d >/dev/null 2>&1
udp -l 138 -d >/dev/null 2>&1
udp -l 139 -d >/dev/null 2>&1
udp -l 440 -d >/dev/null 2>&1
udp -l 53 -d >/dev/null 2>&1
udp -l 3389 -d >/dev/null 2>&1
udp -l 1126 -d >/dev/null 2>&1
udp -l 351 -d >/dev/null 2>&1
udp -l 524 -d >/dev/null 2>&1
udp -l 265 -d >/dev/null 2>&1
udp -l 180 -d >/dev/null 2>&1
udp -l 366 -d >/dev/null 2>&1
udp -l 28080 -d >/dev/null 2>&1
udp -l 8081 -d >/dev/null 2>&1
sleep 5
pkgovpn
rm -rf url >/dev/null 2>&1
rm -rf /etc/openvpn/ca >/dev/null 2>&1
exit 0;
else
echo
exit 0;
fi
fi
return 1
}
main
exit 0;


