#!/bin/sh
#SCRIPT OFICIAL ChuKK-SCRIPT|Plus

clear&&clear

fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /bin/ejecutar/trojanports.txt && cat /bin/ejecutar/trojanports.txt`;
troport=$(cat /bin/ejecutar/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
portFTP=$(lsof -V -i tcp -P -n | grep apache2 | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | cut -d: -f2 | cut -d' ' -f1 | uniq)
portFTP=$(echo ${portFTP} | sed 's/\s\+/,/g' | cut -d , -f1)
}

#FUN_BAR
fun_bar () { 
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
echo ;tput cuu1 && tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
} 

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
msg -bar3
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
msg -bar3
#bc
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || apt-get install golang-go -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install golang-go............ $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
msg -bar3
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
msg -bar3
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
echo -ne "\033[97m Deseas agregar Menu Clash Rapido [s/n]: "
read insta
[[ $insta = @(s|S|y|Y) ]] && enttrada
}


fun_insta(){
fun_ip
install_ini
msg -bar3
killall clash 1> /dev/null 2> /dev/null
echo -e " ➣ Creando Directorios y Archivos"
msg -bar3 
[[ -d /root/.config ]] && rm -rf /root/.config/* || mkdir /root/.config 
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
last_version=$(curl -Ls "https://api.github.com/repos/emirjorge/clash-core/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
arch=$(arch)
if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64"
else
  arch="amd64"
fi
wget -N --no-check-certificate -O /root/.config/clash/clash.gz https://github.com/emirjorge/clash-core/releases/download/${last_version}/clash-linux-${arch}-${last_version}.gz
gzip -d /root/.config/clash/clash.gz
chmod +x /root/.config/clash/clash
echo -e " ➣ Clonando Repositorio Original Dreamacro "
go get -u -v github.com/emirjorge/clash-core
clear
}



[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/CuervoCool/chukkmod/main/msg-bar/msg)
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')
[[ ! -d /bin/ejecutar/clashFiles ]] && mkdir /bin/ejecutar/clashFiles
clashFiles='/bin/ejecutar/clashFiles/'

INITClash(){
msg -bar
conFIN
read -p "Ingrese Nombre del Poster WEB de la configuracion: " cocolon
[[ -e /root/.config/clash/config.yaml ]] && sed -i "s%_dAtE%${fecha}%g" /root/.config/clash/config.yaml
[[ -e /root/.config/clash/config.yaml ]] && sed -i "s/_h0rA/${hora}/g" /root/.config/clash/config.yaml
cp /root/.config/clash/config.yaml /var/www/html/$cocolon.yaml && chmod +x /var/www/html/$cocolon.yaml
service apache2 restart
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "-------------------------------------------------------"
echo -e "		\033[4;31mNOTA importante\033[0m"
echo -e "Recuerda Descargar el Fichero, o cargarlo como URL!!"
echo -e "-------------------------------------------------------"
echo -e " \033[0;31mSi Usas Clash For Android, Ultima Version  "
echo -e "  Para luego usar el Link del Fichero, y puedas ."
echo -e " Descargarlo desde cualquier sitio con acceso WEB"
echo -e "        Link Clash Valido por 30 minutos "
echo -e "    Link : \033[1;42m  http://$IP:${portFTP}/$cocolon.yaml\033[0m"
echo -e "-------------------------------------------------------"
#read -p "PRESIONA ENTER PARA CARGAR ONLINE"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
scr=$(echo $(($RANDOM*3))|head -c 3)
unset yesno
echo -e " ENLACE VALIDO POR 30 MINUTOS? " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
killall clash > /dev/null &1>&2
screen -dmS clashse_$cocolon /root/.config/clash/clash
echo '#!/bin/bash -e' > /root/.config/clash/$cocolon.sh
echo "sleep 1800s" >> /root/.config/clash/$cocolon.sh && echo -e " ACTIVO POR 30 MINUTOS "  || echo " Validacion Incorrecta "
echo "mv /var/www/html/$cocolon.yaml ${clashFiles}$cocolon.yaml" >> /root/.config/clash/$cocolon.sh
echo 'echo "Fichero removido a ${clashFiles}$cocolon.yaml"' >> /root/.config/clash/$cocolon.sh
echo "service apache2 restart" >> /root/.config/clash/$cocolon.sh
echo "rm -f /root/.config/clash/$cocolon.sh" >> /root/.config/clash/$cocolon.sh
echo 'exit' >> /root/.config/clash/$cocolon.sh && screen -dmS clash${scr} bash /root/.config/clash/$cocolon.sh
} 
echo -e "Proceso Finalizado"

}

configINIT_rule () {
mode=$1
[[ -z ${mode} ]] && exit
unset tropass
echo '#SCRIPT OFICIAL ChuKK-SCRIPT|Plus
# Formato Creado por @drowkid01 | +593987072611 Whatsapp Personal
# Creado el _dAtE - _h0rA
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: rule
log-level: info
external-controller: "0.0.0.0:9090"
secret: ""

dns:
  enable: true
  listen: :53
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 223.5.5.5
    - 8.8.8.8
    - 45.71.185.100
    - 204.199.156.138
    - 1.1.1.1
  fallback: []
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP    
tun:
  enable: true
  stack: gvisor
  auto-route: true
  auto-detect-interface: true
  dns-hijack:
    - any:53

# Clash for Windows
cfw-bypass:
  - qq.com
  - music.163.com
  - "*.music.126.net"
  - localhost
  - 127.*
  - 10.*
  - 172.16.*
  - 172.17.*
  - 172.18.*
  - 172.19.*
  - 172.20.*
  - 172.21.*
  - 172.22.*
  - 172.23.*
  - 172.24.*
  - 172.25.*
  - 172.26.*
  - 172.27.*
  - 172.28.*
  - 172.29.*
  - 172.30.*
  - 172.31.*
  - 192.168.*
  - <local>
cfw-latency-timeout: 5000
    
proxy-groups:
- name: "ChuKK-SCRIPT"
  type: select
  proxies:    ' > /root/.config/clash/config.yaml
#sed -i "s/+/'/g"  /root/.config/clash/config.yaml
foc=1
[[ -e /usr/local/etc/trojan/config.json ]] && ConfTrojINI
unset yesno
foc=1
[[ -e /etc/v2ray/config.json ]] && ConfV2RINI
unset yesno
foc=1								
[[ -e /etc/xray/config.json ]] && ConfXRINI
}

configINIT_global () {
mode=$1
[[ -z ${mode} ]] && exit
unset tropass
echo '#SCRIPT OFICIAL ChuKK-SCRIPT|Plus
# Formato Creado por @drowkid01 | +593987072611 Whatsapp Personal
# Creado el _dAtE - _h0rA
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: global
log-level: info
external-controller: "0.0.0.0:9090"
secret: ""
dns:
  enable: true
  listen: :53
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 223.5.5.5
    - 8.8.8.8
    - 45.71.185.100
    - 204.199.156.138
    - 1.1.1.1
  fallback: []
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP    
tun:
  enable: true
  stack: gvisor
  auto-route: true
  auto-detect-interface: true
  dns-hijack:
    - any:53

# Clash for Windows
cfw-bypass:
  - qq.com
  - music.163.com
  - "*.music.126.net"
  - localhost
  - 127.*
  - 10.*
  - 172.16.*
  - 172.17.*
  - 172.18.*
  - 172.19.*
  - 172.20.*
  - 172.21.*
  - 172.22.*
  - 172.23.*
  - 172.24.*
  - 172.25.*
  - 172.26.*
  - 172.27.*
  - 172.28.*
  - 172.29.*
  - 172.30.*
  - 172.31.*
  - 192.168.*
  - <local>
cfw-latency-timeout: 5000   
 ' > /root/.config/clash/config.yaml
#sed -i "s/+/'/g"  /root/.config/clash/config.yaml
foc=1
[[ -e /usr/local/etc/trojan/config.json ]] && ConfTrojINI
unset yesno
foc=1
[[ -e /etc/v2ray/config.json ]] && ConfV2RINI
unset yesno
foc=1								
[[ -e /etc/xray/config.json ]] && ConfXRINI
}

proxyTRO() {
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proTRO+="- name: $1\n  type: trojan\n  server: ${IP}\n  port: ${troport}\n  password: "$2"\n  udp: true\n  sni: $3\n  alpn:\n  - h2\n  - http/1.1\n  skip-cert-verify: true\n\n" 
  }

ConfTrojINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG TROJAN " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p " [S/N]: " yesno

tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL TROJAN CLASH "
read -p ": " nameperfil
msg -bar3
[[ -z ${UUID} ]] && view_usert || { 
echo -e " USER ${Usr} : ${UUID}"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar3
proxyTRO ${nameperfil} ${UUID} ${trosni}
ConfTrojINI
								}
}

proxyV2R() {
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  udp: true\n  tls: true\n  skip-cert-verify: true\n  servername: $2\n  network: $5\n  ws-opts:  \n       path: $6\n       headers:\n         Host: $2\n  \n\n" 
  }
  
proxyV2Rgprc() {
#config=/usr/local/x-ui/bin/config.json
#cat $config | jq .inbounds[].settings.clients | grep id
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="
- name: $1\n  server: ${IP}\n  port: $7\n  type: vmess\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  tls: true\n  skip-cert-verify: true\n  network: grpc\n  servername: $2\n  grpc-opts:\n    grpc-mode: gun\n    grpc-service-name: $6\n  udp: true \n\n"
  }
proxyXR() {
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proXR+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  udp: true\n  tls: true\n  skip-cert-verify: true\n  servername: $2\n  network: $5\n  ws-opts:  \n       path: $6\n       headers:\n         Host: $2\n  \n\n" 
  }
  
proxyXRgprc() {
#config=/usr/local/x-ui/bin/config.json
#cat $config | jq .inbounds[].settings.clients | grep id
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proXR+="
- name: $1\n  server: ${IP}\n  port: $7\n  type: vmess\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  tls: true\n  skip-cert-verify: true\n  network: grpc\n  servername: $2\n  grpc-opts:\n    grpc-mode: gun\n    grpc-service-name: $6\n  udp: true \n\n"
  }

ConfV2RINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG V2RAY " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL V2RAY CLASH "
read -p ": " nameperfil
msg -bar3
[[ -z ${uid} ]] && view_user || { 
echo -e " USER ${ps}"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar3

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)

[[ $net = '"grpc"' ]] && {
proxyV2Rgprc ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${path} ${v2port}
} || {
proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
}

ConfV2RINI
	} 
}

ConfXRINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG XRAY " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL XRAY CLASH "
read -p ": " nameperfilX
msg -bar3
[[ -z ${uidX} ]] && _view_userXR || { 
echo -e " USER ${ps} XRAY"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosniX
msg -bar3
		psX=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uidX=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiidX=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		addX=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && addX=$(wget -qO- ipv4.icanhazip.com)
		hostX=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		netX=$(jq '.inbounds[].streamSettings.network' $config)
		parcheX=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $pathX = null ]] && parcheX='' 
		v2portX=$(jq '.inbounds[].port' $config)
		tlsX=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $netX = '"grpc"' ]] && pathX=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || pathX=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)

[[ $netX = '"grpc"' ]] && {
proxyXRgprc ${nameperfilX} ${trosniX} ${uidX} ${aluuiidX} ${netX} ${pathX} ${v2portX}
} || {
proxyXR ${nameperfilX} ${trosniX} ${uidX} ${aluuiidX} ${netX} ${parcheX} ${v2portX}
}

ConfXRINI
							}
}

confRULE() {
[[ $mode = 1 ]] && echo -e '
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# ChuKK-SCRIPT

# By ChuKK-SCRIPT By CGH
- name: "【 ✵ 𝚂𝚎𝚛𝚟𝚎𝚛-𝙿𝚁𝙴𝙼𝙸𝚄𝙼 ✵ 】"
  type: select
  proxies: 
    - "ChuKK-SCRIPT"

#- name: "【 📱 +593987072611 】"
#  type: select
#  proxies:
#    - "ChuKK-SCRIPT"

Rule:
# Unbreak
# > Google
- DOMAIN-SUFFIX,googletraveladservices.com,ChuKK-SCRIPT
- DOMAIN,dl.google.com,ChuKK-SCRIPT
- DOMAIN,mtalk.google.com,ChuKK-SCRIPT

# Internet Service Providers ChuKK-SCRIPT 运营商劫持
- DOMAIN-SUFFIX,17gouwuba.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,186078.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,189zj.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,285680.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,3721zh.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,4336wang.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,51chumoping.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,51mld.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,51mypc.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,58mingri.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,58mingtian.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,5vl58stm.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,6d63d3.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,7gg.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,91veg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,9s6q.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,adsame.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aiclk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,akuai.top,ChuKK-SCRIPT
- DOMAIN-SUFFIX,atplay.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,baiwanchuangyi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,beerto.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,beilamusi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,benshiw.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bianxianmao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bryonypie.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cishantao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cszlks.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cudaojia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dafapromo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,daitdai.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dsaeerf.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dugesheying.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dv8c1t.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,echatu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,erdoscs.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fan-yong.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,feih.com.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fjlqqc.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fkku194.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,freedrive.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gclick.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,goufanli100.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,goupaoerdai.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gouwubang.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gzxnlk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,haoshengtoys.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hyunke.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ichaosheng.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ishop789.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jdkic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jiubuhua.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jsncke.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,junkucm.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jwg365.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kawo77.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kualianyingxiao.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kumihua.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ltheanine.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,maipinshangmao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,minisplat.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mkitgfs.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mlnbike.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mobjump.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nbkbgd.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,newapi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pinzhitmall.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,poppyta.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qianchuanghr.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qichexin.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qinchugudao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,quanliyouxi.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qutaobi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ry51w.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sg536.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifubo.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuce.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuda.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifufu.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuge.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifugu.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuhe.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuhu.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuji.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sifuka.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,smgru.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,taoggou.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tcxshop.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tjqonline.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,topitme.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tt3sm4.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tuia.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tuipenguin.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tuitiger.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,websd8.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wsgblw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wx16999.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xchmai.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xiaohuau.xyz,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ygyzx.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yinmong.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yitaopt.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yjqiqi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yukhj.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhaozecheng.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhenxinet.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zlne800.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zunmi.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zzd6.com,ChuKK-SCRIPT
- IP-CIDR,39.107.15.115/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,47.89.59.182/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,103.49.209.27/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,123.56.152.96/32,ChuKK-SCRIPT,no-resolve
# > ChinaTelecom
- IP-CIDR,61.160.200.223/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,61.160.200.242/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,61.160.200.252/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,61.174.50.214/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,111.175.220.163/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,111.175.220.164/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,122.229.8.47/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,122.229.29.89/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,124.232.160.178/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,175.6.223.15/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,183.59.53.237/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,218.93.127.37/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,221.228.17.152/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,221.231.6.79/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,222.186.61.91/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,222.186.61.95/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,222.186.61.96/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,222.186.61.97/32,ChuKK-SCRIPT,no-resolve
# > ChinaUnicom
- IP-CIDR,106.75.231.48/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,119.4.249.166/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,220.196.52.141/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,221.6.4.148/32,ChuKK-SCRIPT,no-resolve
# > ChinaMobile
- IP-CIDR,114.247.28.96/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,221.179.131.72/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,221.179.140.145/32,ChuKK-SCRIPT,no-resolve
# > Dr.Peng
# - IP-CIDR,10.72.25.0/24,ChuKK-SCRIPT,no-resolve
- IP-CIDR,115.182.16.79/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,118.144.88.126/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,118.144.88.215/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,118.144.88.216/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,120.76.189.132/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,124.14.21.147/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,124.14.21.151/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,180.166.52.24/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,211.161.101.106/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,220.115.251.25/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,222.73.156.235/32,ChuKK-SCRIPT,no-resolve

# Malware 恶意网站
# > 快压
# https://zhuanlan.zhihu.com/p/39534279
- DOMAIN-SUFFIX,kuaizip.com,ChuKK-SCRIPT
# > MacKeeper
# https://www.lizhi.io/blog/40002904
- DOMAIN-SUFFIX,mackeeper.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zryydi.com,ChuKK-SCRIPT
# > Adobe Flash China Special Edition
# https://www.zhihu.com/question/281163698/answer/441388130
- DOMAIN-SUFFIX,flash.cn,ChuKK-SCRIPT
- DOMAIN,geo2.adobe.com,ChuKK-SCRIPT
# > C&J Marketing 思杰马克丁软件
# https://www.zhihu.com/question/46746200
- DOMAIN-SUFFIX,4009997658.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abbyychina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bartender.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,betterzip.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,betterzipcn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,beyondcompare.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bingdianhuanyuan.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chemdraw.com.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cjmakeding.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cjmkt.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,codesoftchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,coreldrawchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,crossoverchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dongmansoft.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,earmasterchina.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,easyrecoverychina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ediuschina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,flstudiochina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,formysql.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,guitarpro.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,huishenghuiying.com.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hypersnap.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iconworkshop.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,imindmap.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jihehuaban.com.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,keyshot.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kingdeecn.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,logoshejishi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,luping.net.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mairuan.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mairuan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mairuan.com.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mairuan.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mairuanwang.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,makeding.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mathtype.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mindmanager.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mindmanager.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mindmapper.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mycleanmymac.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nicelabel.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ntfsformac.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ntfsformac.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,overturechina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,passwordrecovery.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pdfexpert.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,photozoomchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,shankejingling.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ultraiso.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vegaschina.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xmindchina.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xshellcn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yihuifu.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yuanchengxiezuo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zbrushcn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhzzx.com,ChuKK-SCRIPT

# Global Area Network
# (ChuKK-SCRIPT)
# (Music)
# > Deezer
# USER-AGENT,Deezer*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,deezer.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dzcdn.net,ChuKK-SCRIPT
# > KKBOX
- DOMAIN-SUFFIX,kkbox.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kkbox.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kfs.io,ChuKK-SCRIPT
# > JOOX
# USER-AGENT,WeMusic*,ChuKK-SCRIPT
# USER-AGENT,JOOX*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,joox.com,ChuKK-SCRIPT
# > Pandora
# USER-AGENT,Pandora*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pandora.com,ChuKK-SCRIPT
# > SoundCloud
# USER-AGENT,SoundCloud*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,p-cdn.us,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sndcdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,soundcloud.com,ChuKK-SCRIPT
# > Spotify
# USER-AGENT,Spotify*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pscdn.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,scdn.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,spotify.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,spoti.fi,ChuKK-SCRIPT
- DOMAIN-KEYWORD,spotify.com,ChuKK-SCRIPT
- DOMAIN-KEYWORD,-spotify-com,ChuKK-SCRIPT
# > TIDAL
# USER-AGENT,TIDAL*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tidal.com,ChuKK-SCRIPT
# > YouTubeMusic
# USER-AGENT,com.google.ios.youtubemusic*,ChuKK-SCRIPT
# USER-AGENT,YouTubeMusic*,ChuKK-SCRIPT
# (Video)
# > All4
# USER-AGENT,All4*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,c4assets.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,channel4.com,ChuKK-SCRIPT
# > AbemaTV
# USER-AGENT,AbemaTV*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abema.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ameba.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abema.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hayabusa.io,ChuKK-SCRIPT
- DOMAIN,abematv.akamaized.net,ChuKK-SCRIPT
- DOMAIN,ds-linear-abematv.akamaized.net,ChuKK-SCRIPT
- DOMAIN,ds-vod-abematv.akamaized.net,ChuKK-SCRIPT
- DOMAIN,linear-abematv.akamaized.net,ChuKK-SCRIPT
# > Amazon Prime Video
# USER-AGENT,InstantVideo.US*,ChuKK-SCRIPT
# USER-AGENT,Prime%20Video*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aiv-cdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aiv-delivery.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,amazonvideo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,primevideo.com,ChuKK-SCRIPT
- DOMAIN,avodmp4s3ww-a.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,d25xi40x97liuc.cloudfront.net,ChuKK-SCRIPT
- DOMAIN,dmqdd6hw24ucf.cloudfront.net,ChuKK-SCRIPT
- DOMAIN,d22qjgkvxw22r6.cloudfront.net,ChuKK-SCRIPT
- DOMAIN,d1v5ir2lpwr8os.cloudfront.net,ChuKK-SCRIPT
- DOMAIN-KEYWORD,avoddashs,ChuKK-SCRIPT
# > Bahamut
# USER-AGENT,Anime*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bahamut.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gamer.com.tw,ChuKK-SCRIPT
- DOMAIN,gamer-cds.cdn.hinet.net,ChuKK-SCRIPT
- DOMAIN,gamer2-cds.cdn.hinet.net,ChuKK-SCRIPT
# > BBC iPlayer
# USER-AGENT,BBCiPlayer*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bbc.co.uk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bbci.co.uk,ChuKK-SCRIPT
- DOMAIN-KEYWORD,bbcfmt,ChuKK-SCRIPT
- DOMAIN-KEYWORD,uk-live,ChuKK-SCRIPT
# > DAZN
# USER-AGENT,DAZN*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dazn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dazn-api.com,ChuKK-SCRIPT
- DOMAIN,d151l6v8er5bdm.cloudfront.net,ChuKK-SCRIPT
- DOMAIN-KEYWORD,voddazn,ChuKK-SCRIPT
# > Disney+
# USER-AGENT,Disney+*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bamgrid.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,disney-plus.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,disneyplus.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dssott.com,ChuKK-SCRIPT
- DOMAIN,cdn.registerdisney.go.com,ChuKK-SCRIPT
# > encoreTVB
# USER-AGENT,encoreTVB*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,encoretvb.com,ChuKK-SCRIPT
- DOMAIN,edge.api.brightcove.com,ChuKK-SCRIPT
- DOMAIN,bcbolt446c5271-a.akamaihd.net,ChuKK-SCRIPT
# > FOX NOW
# USER-AGENT,FOX%20NOW*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fox.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,foxdcg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,theplatform.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,uplynk.com,ChuKK-SCRIPT
# > HBO NOW
# USER-AGENT,HBO%20NOW*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hbo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hbogo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hbonow.com,ChuKK-SCRIPT
# > HBO GO HKG
# USER-AGENT,HBO%20GO%20PROD%20HKG*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hbogoasia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hbogoasia.hk,ChuKK-SCRIPT
- DOMAIN,bcbolthboa-a.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,players.brightcove.net,ChuKK-SCRIPT
- DOMAIN,s3-ap-southeast-1.amazonaws.com,ChuKK-SCRIPT
- DOMAIN,dai3fd1oh325y.cloudfront.net,ChuKK-SCRIPT
- DOMAIN,44wilhpljf.execute-api.ap-southeast-1.amazonaws.com,ChuKK-SCRIPT
- DOMAIN,hboasia1-i.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,hboasia2-i.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,hboasia3-i.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,hboasia4-i.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,hboasia5-i.akamaihd.net,ChuKK-SCRIPT
- DOMAIN,cf-images.ap-southeast-1.prod.boltdns.net,ChuKK-SCRIPT
# > 华文电视
# USER-AGENT,HWTVMobile*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,5itv.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ocnttv.com,ChuKK-SCRIPT
# > Hulu
- DOMAIN-SUFFIX,hulu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,huluim.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hulustream.com,ChuKK-SCRIPT
# > Hulu(フールー)
- DOMAIN-SUFFIX,happyon.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hulu.jp,ChuKK-SCRIPT
# > ITV
# USER-AGENT,ITV_Player*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,itv.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,itvstatic.com,ChuKK-SCRIPT
- DOMAIN,itvpnpmobile-a.akamaihd.net,ChuKK-SCRIPT
# > KKTV
# USER-AGENT,KKTV*,ChuKK-SCRIPT
# USER-AGENT,com.kktv.ios.kktv*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kktv.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kktv.me,ChuKK-SCRIPT
- DOMAIN,kktv-theater.kk.stream,ChuKK-SCRIPT
# > Line TV
# USER-AGENT,LINE%20TV*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,linetv.tw,ChuKK-SCRIPT
- DOMAIN,d3c7rimkq79yfu.cloudfront.net,ChuKK-SCRIPT
# > LiTV
- DOMAIN-SUFFIX,litv.tv,ChuKK-SCRIPT
- DOMAIN,litvfreemobile-hichannel.cdn.hinet.net,ChuKK-SCRIPT
# > My5
# USER-AGENT,My5*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,channel5.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,my5.tv,ChuKK-SCRIPT
- DOMAIN,d349g9zuie06uo.cloudfront.net,ChuKK-SCRIPT
# > myTV SUPER
# USER-AGENT,mytv*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mytvsuper.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tvb.com,ChuKK-SCRIPT
# > Netflix
# USER-AGENT,Argo*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflix.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflix.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nflxext.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nflximg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nflximg.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nflxso.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nflxvideo.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest0.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest1.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest2.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest3.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest4.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest5.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest6.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest7.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest8.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netflixdnstest9.com,ChuKK-SCRIPT
- IP-CIDR,23.246.0.0/18,ChuKK-SCRIPT,no-resolve
- IP-CIDR,37.77.184.0/21,ChuKK-SCRIPT,no-resolve
- IP-CIDR,45.57.0.0/17,ChuKK-SCRIPT,no-resolve
- IP-CIDR,64.120.128.0/17,ChuKK-SCRIPT,no-resolve
- IP-CIDR,66.197.128.0/17,ChuKK-SCRIPT,no-resolve
- IP-CIDR,108.175.32.0/20,ChuKK-SCRIPT,no-resolve
- IP-CIDR,192.173.64.0/18,ChuKK-SCRIPT,no-resolve
- IP-CIDR,198.38.96.0/19,ChuKK-SCRIPT,no-resolve
- IP-CIDR,198.45.48.0/20,ChuKK-SCRIPT,no-resolve
# > niconico
# USER-AGENT,Niconico*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dmc.nico,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nicovideo.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nimg.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,socdm.com,ChuKK-SCRIPT
# > PBS
# USER-AGENT,PBS*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pbs.org,ChuKK-SCRIPT
# > Pornhub
- DOMAIN-SUFFIX,phncdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pornhub.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pornhubpremium.com,ChuKK-SCRIPT
# > 台湾好
# USER-AGENT,TaiwanGood*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,skyking.com.tw,ChuKK-SCRIPT
- DOMAIN,hamifans.emome.net,ChuKK-SCRIPT
# > Twitch
- DOMAIN-SUFFIX,twitch.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,twitchcdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ttvnw.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jtvnw.net,ChuKK-SCRIPT
# > ViuTV
# USER-AGENT,Viu*,ChuKK-SCRIPT
# USER-AGENT,ViuTV*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,viu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,viu.tv,ChuKK-SCRIPT
- DOMAIN,api.viu.now.com,ChuKK-SCRIPT
- DOMAIN,d1k2us671qcoau.cloudfront.net,ChuKK-SCRIPT
- DOMAIN,d2anahhhmp1ffz.cloudfront.net,ChuKK-SCRIPT
- DOMAIN,dfp6rglgjqszk.cloudfront.net,ChuKK-SCRIPT
# > YouTube
# USER-AGENT,com.google.ios.youtube*,ChuKK-SCRIPT
# USER-AGENT,YouTube*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,googlevideo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,youtube.com,ChuKK-SCRIPT
- DOMAIN,youtubei.googleapis.com,ChuKK-SCRIPT

# (ChuKK-SCRIPT)
# > 愛奇藝台灣站
- DOMAIN,cache.video.iqiyi.com,ChuKK-SCRIPT
# > bilibili
- DOMAIN-SUFFIX,bilibili.com,ChuKK-SCRIPT
- DOMAIN,upos-hz-mirrorakam.akamaized.net,ChuKK-SCRIPT

# (DNS Cache Pollution Protection)
# > Google
- DOMAIN-SUFFIX,ampproject.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,appspot.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,blogger.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,getoutline.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gvt0.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gvt1.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gvt3.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xn--ngstr-lra8j.com,ChuKK-SCRIPT
- DOMAIN-KEYWORD,google,ChuKK-SCRIPT
- DOMAIN-KEYWORD,blogspot,ChuKK-SCRIPT
# > Microsoft
- DOMAIN-SUFFIX,onedrive.live.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xboxlive.com,ChuKK-SCRIPT
# > Facebook
- DOMAIN-SUFFIX,cdninstagram.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fb.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fb.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fbaddins.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fbcdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fbsbx.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fbworkmail.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,instagram.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,m.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,messenger.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oculus.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oculuscdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,rocksdb.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,whatsapp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,whatsapp.net,ChuKK-SCRIPT
- DOMAIN-KEYWORD,facebook,ChuKK-SCRIPT
- IP-CIDR,3.123.36.126/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,35.157.215.84/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,35.157.217.255/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,52.58.209.134/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,54.93.124.31/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,54.162.243.80/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,54.173.34.141/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,54.235.23.242/32,ChuKK-SCRIPT,no-resolve
- IP-CIDR,169.45.248.118/32,ChuKK-SCRIPT,no-resolve
# > Twitter
- DOMAIN-SUFFIX,pscp.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,periscope.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,t.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,twimg.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,twimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,twitpic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vine.co,ChuKK-SCRIPT
- DOMAIN-KEYWORD,twitter,ChuKK-SCRIPT
# > Telegram
- DOMAIN-SUFFIX,t.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tdesktop.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,telegra.ph,ChuKK-SCRIPT
- DOMAIN-SUFFIX,telegram.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,telegram.org,ChuKK-SCRIPT
- IP-CIDR,91.108.4.0/22,ChuKK-SCRIPT,no-resolve
- IP-CIDR,91.108.8.0/22,ChuKK-SCRIPT,no-resolve
- IP-CIDR,91.108.12.0/22,ChuKK-SCRIPT,no-resolve
- IP-CIDR,91.108.16.0/22,ChuKK-SCRIPT,no-resolve
- IP-CIDR,91.108.56.0/22,ChuKK-SCRIPT,no-resolve
- IP-CIDR,149.154.160.0/20,ChuKK-SCRIPT,no-resolve
# > Line
- DOMAIN-SUFFIX,line.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,line-apps.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,line-scdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,naver.jp,ChuKK-SCRIPT
- IP-CIDR,103.2.30.0/23,ChuKK-SCRIPT,no-resolve
- IP-CIDR,125.209.208.0/20,ChuKK-SCRIPT,no-resolve
- IP-CIDR,147.92.128.0/17,ChuKK-SCRIPT,no-resolve
- IP-CIDR,203.104.144.0/21,ChuKK-SCRIPT,no-resolve
# > Other
- DOMAIN-SUFFIX,4shared.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,520cc.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,881903.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,9cache.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,9gag.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abc.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abc.net.au,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abebooks.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,amazon.co.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apigee.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apk-dl.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apkfind.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apkmirror.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apkmonk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apkpure.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aptoide.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,archive.is,ChuKK-SCRIPT
- DOMAIN-SUFFIX,archive.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,arte.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,artstation.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,arukas.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ask.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,avg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,avgle.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,badoo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bandwagonhost.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bbc.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,behance.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bibox.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,biggo.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,binance.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bitcointalk.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bitfinex.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bitmex.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bit-z.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bloglovin.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bloomberg.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bloomberg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,blubrry.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,book.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,booklive.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,books.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,boslife.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,box.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,businessinsider.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bwh1.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,castbox.fm,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cbc.ca,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cdw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,change.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,channelnewsasia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ck101.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,clarionproject.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,clyp.it,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cna.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,comparitech.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,conoha.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,crucial.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cts.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cw.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cyberctm.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dailymotion.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dailyview.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,daum.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,daumcdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dcard.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,deepdiscount.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,depositphotos.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,deviantart.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,disconnect.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,discordapp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,discordapp.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,disqus.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dlercloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dns2go.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dowjones.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dropbox.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dropboxusercontent.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,duckduckgo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dynu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,earthcam.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ebookservice.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,economist.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,edgecastcdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,edu,ChuKK-SCRIPT
- DOMAIN-SUFFIX,elpais.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,enanyang.my,ChuKK-SCRIPT
- DOMAIN-SUFFIX,encyclopedia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,esoir.be,ChuKK-SCRIPT
- DOMAIN-SUFFIX,etherscan.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,euronews.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,evozi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,feedly.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,firech.at,ChuKK-SCRIPT
- DOMAIN-SUFFIX,flickr.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,flitto.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,foreignpolicy.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,freebrowser.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,freewechat.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,freeweibo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,friday.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ftchinese.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ftimg.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gate.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,getlantern.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,getsync.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,globalvoices.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,goo.ne.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,goodreads.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gov,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gov.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,greatfire.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gumroad.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hbg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,heroku.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hightail.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hk01.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hkbf.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hkbookcity.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hkej.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hket.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hkgolden.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hootsuite.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hudson.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hyread.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ibtimes.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,i-cable.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,icij.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,icoco.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,imgur.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,initiummall.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,insecam.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ipfs.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,issuu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,istockphoto.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,japantimes.co.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jiji.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jinx.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jkforum.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,joinmastodon.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,justmysocks.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,justpaste.it,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kakao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kakaocorp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kik.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kobo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kobobooks.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kodingen.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,lemonde.fr,ChuKK-SCRIPT
- DOMAIN-SUFFIX,lepoint.fr,ChuKK-SCRIPT
- DOMAIN-SUFFIX,lihkg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,listennotes.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,livestream.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,logmein.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mail.ru,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mailchimp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,marc.info,ChuKK-SCRIPT
- DOMAIN-SUFFIX,matters.news,ChuKK-SCRIPT
- DOMAIN-SUFFIX,maying.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,medium.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mega.nz,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mil,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mingpao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mobile01.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myspace.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myspacecdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nanyang.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,naver.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,neowin.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,newstapa.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nexitally.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nhk.or.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nicovideo.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nii.ac.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nikkei.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nofile.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,now.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nrk.no,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nyt.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytcn.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytco.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytimes.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytlog.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nytstyle.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ok.ru,ChuKK-SCRIPT
- DOMAIN-SUFFIX,okex.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,on.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,orientaldaily.com.my,ChuKK-SCRIPT
- DOMAIN-SUFFIX,overcast.fm,ChuKK-SCRIPT
- DOMAIN-SUFFIX,paltalk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pao-pao.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,parsevideo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pbxes.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pcdvd.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pchome.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pcloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,picacomic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pinimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pixiv.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,player.fm,ChuKK-SCRIPT
- DOMAIN-SUFFIX,plurk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,po18.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,potato.im,ChuKK-SCRIPT
- DOMAIN-SUFFIX,potatso.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,prism-break.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,proxifier.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pt.im,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pts.org.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pubu.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pubu.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pureapk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,quora.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,quoracdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,rakuten.co.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,readingtimes.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,readmoo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,redbubble.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,reddit.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,redditmedia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,resilio.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,reuters.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,reutersmedia.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,rfi.fr,ChuKK-SCRIPT
- DOMAIN-SUFFIX,rixcloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,roadshow.hk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,scmp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,scribd.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,seatguru.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,shadowsocks.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,shopee.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,slideshare.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,softfamous.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,soundcloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ssrcloud.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,startpage.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamcommunity.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steemit.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steemitwallet.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,t66y.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tapatalk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,teco-hk.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,teco-mo.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,teddysun.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,textnow.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,theguardian.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,theinitium.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,thetvdb.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tineye.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,torproject.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tumblr.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,turbobit.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tutanota.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tvboxnow.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,udn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,unseen.is,ChuKK-SCRIPT
- DOMAIN-SUFFIX,upmedia.mg,ChuKK-SCRIPT
- DOMAIN-SUFFIX,uptodown.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,urbandictionary.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ustream.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,uwants.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,v2ray.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,viber.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,videopress.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vimeo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,voachinese.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,voanews.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,voxer.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vzw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,w3schools.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,washingtonpost.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wattpad.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,whoer.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wikimapia.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wikipedia.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wikiquote.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wikiwand.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,winudf.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wire.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wordpress.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,workflow.is,ChuKK-SCRIPT
- DOMAIN-SUFFIX,worldcat.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wsj.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wsj.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xhamster.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xn--90wwvt03e.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xn--i2ru8q2qg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xnxx.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xvideos.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yahoo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yandex.ru,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ycombinator.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yesasia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yes-news.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yomiuri.co.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,you-get.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zaobao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zb.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zello.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zeronet.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zoom.us,ChuKK-SCRIPT
- DOMAIN-KEYWORD,github,ChuKK-SCRIPT
- DOMAIN-KEYWORD,jav,ChuKK-SCRIPT
- DOMAIN-KEYWORD,pinterest,ChuKK-SCRIPT
- DOMAIN-KEYWORD,porn,ChuKK-SCRIPT
- DOMAIN-KEYWORD,wikileaks,ChuKK-SCRIPT

# (Region-Restricted Access Denied)
- DOMAIN-SUFFIX,apartmentratings.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apartments.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bankmobilevibe.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bing.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,booktopia.com.au,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cccat.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,centauro.com.br,ChuKK-SCRIPT
- DOMAIN-SUFFIX,clearsurance.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,costco.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,crackle.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,depositphotos.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dish.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dmm.co.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dmm.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dnvod.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,esurance.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,extmatrix.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fastpic.ru,ChuKK-SCRIPT
- DOMAIN-SUFFIX,flipboard.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fnac.be,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fnac.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,funkyimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fxnetworks.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gettyimages.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,go.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,here.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jcpenney.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jiehua.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mailfence.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nationwide.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nbc.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nexon.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nordstrom.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nordstromimage.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nordstromrack.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,superpages.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,target.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,thinkgeek.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tracfone.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,unity3d.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,uploader.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vevo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,viu.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vsco.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xfinity.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zattoo.com,ChuKK-SCRIPT
# USER-AGENT,Roam*,ChuKK-SCRIPT

# (The Most Popular Sites)
# > ChuKK-SCRIPT
# >> TestFlight
- DOMAIN,testflight.apple.com,ChuKK-SCRIPT
# >> ChuKK-SCRIPT URL Shortener
- DOMAIN-SUFFIX,appsto.re,ChuKK-SCRIPT
# >> iBooks Store download
- DOMAIN,books.itunes.apple.com,ChuKK-SCRIPT
# >> iTunes Store Moveis Trailers
- DOMAIN,hls.itunes.apple.com,ChuKK-SCRIPT
# >> App Store Preview
- DOMAIN,apps.apple.com,ChuKK-SCRIPT
- DOMAIN,itunes.apple.com,ChuKK-SCRIPT
# >> Spotlight
- DOMAIN,api-glb-sea.smoot.apple.com,ChuKK-SCRIPT
# >> Dictionary
- DOMAIN,lookup-api.apple.com,ChuKK-SCRIPT
# > Google
- DOMAIN-SUFFIX,abc.xyz,ChuKK-SCRIPT
- DOMAIN-SUFFIX,android.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,androidify.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dialogflow.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,autodraw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,capitalg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,certificate-transparency.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chrome.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chromeexperiments.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chromestatus.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chromium.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,creativelab5.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,debug.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,deepmind.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,firebaseio.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,getmdl.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ggpht.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gmail.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gmodules.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,godoc.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,golang.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gstatic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gv.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gwtproject.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,itasoftware.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,madewithcode.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,material.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,polymer-project.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,admin.recaptcha.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,recaptcha.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,shattered.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,synergyse.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tensorflow.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tfhub.dev,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tiltbrush.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,waveprotocol.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,waymo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,webmproject.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,webrtc.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,whatbrowser.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,widevine.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,x.company,ChuKK-SCRIPT
- DOMAIN-SUFFIX,youtu.be,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yt.be,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ytimg.com,ChuKK-SCRIPT
# > Microsoft
# >> Microsoft OneDrive
- DOMAIN-SUFFIX,1drv.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,1drv.ms,ChuKK-SCRIPT
- DOMAIN-SUFFIX,blob.core.windows.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,livefilestore.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,onedrive.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,storage.live.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,storage.msn.com,ChuKK-SCRIPT
- DOMAIN,oneclient.sfx.ms,ChuKK-SCRIPT
# > Other
- DOMAIN-SUFFIX,0rz.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,4bluestones.biz,ChuKK-SCRIPT
- DOMAIN-SUFFIX,9bis.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,allconnected.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aol.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bcc.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bit.ly,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bitshare.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,blog.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,blogimg.jp,ChuKK-SCRIPT
- DOMAIN-SUFFIX,blogtd.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,broadcast.co.nz,ChuKK-SCRIPT
- DOMAIN-SUFFIX,camfrog.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cfos.de,ChuKK-SCRIPT
- DOMAIN-SUFFIX,citypopulation.de,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cloudfront.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ctitv.com.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cuhk.edu.hk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cusu.hk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,discord.gg,ChuKK-SCRIPT
- DOMAIN-SUFFIX,discuss.com.hk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dropboxapi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,duolingo.cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,edditstatic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,flickriver.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,focustaiwan.tw,ChuKK-SCRIPT
- DOMAIN-SUFFIX,free.fr,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gigacircle.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hk-pub.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hosting.co.uk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hwcdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ifixit.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iphone4hongkong.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iphonetaiwan.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iptvbin.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,linksalpha.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,manyvids.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myactimes.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,newsblur.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,now.im,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nowe.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,redditlist.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,s3.amazonaws.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,signal.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,smartmailcloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sparknotes.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,streetvoice.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,supertop.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tv.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,typepad.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,udnbkk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,urbanairship.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,whispersystems.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wikia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wolframalpha.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,x-art.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yimg.com,ChuKK-SCRIPT
- DOMAIN,api.steampowered.com,ChuKK-SCRIPT
- DOMAIN,store.steampowered.com,ChuKK-SCRIPT

# China Area Network
# > 360
- DOMAIN-SUFFIX,qhres.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qhimg.com,ChuKK-SCRIPT
# > Akamai
- DOMAIN-SUFFIX,akadns.net,ChuKK-SCRIPT
# - DOMAIN-SUFFIX,akamai.net,ChuKK-SCRIPT
# - DOMAIN-SUFFIX,akamaiedge.net,ChuKK-SCRIPT
# - DOMAIN-SUFFIX,akamaihd.net,ChuKK-SCRIPT
# - DOMAIN-SUFFIX,akamaistream.net,ChuKK-SCRIPT
# - DOMAIN-SUFFIX,akamaized.net,ChuKK-SCRIPT
# > Alibaba
# USER-AGENT,%E4%BC%98%E9%85%B7*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,alibaba.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,alicdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,alikunlun.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,alipay.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,amap.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,autonavi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dingtalk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mxhichina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,soku.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,taobao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tmall.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tmall.hk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ykimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,youku.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xiami.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xiami.net,ChuKK-SCRIPT
# > Baidu
- DOMAIN-SUFFIX,baidu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,baidubcr.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bdstatic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yunjiasu-cdn.net,ChuKK-SCRIPT
# > bilibili
- DOMAIN-SUFFIX,acgvideo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,biliapi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,biliapi.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bilibili.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bilibili.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hdslb.com,ChuKK-SCRIPT
# > Blizzard
- DOMAIN-SUFFIX,blizzard.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,battle.net,ChuKK-SCRIPT
- DOMAIN,blzddist1-a.akamaihd.net,ChuKK-SCRIPT
# > ByteDance
- DOMAIN-SUFFIX,feiliao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pstatp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,snssdk.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iesdouyin.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,toutiao.com,ChuKK-SCRIPT
# > CCTV
- DOMAIN-SUFFIX,cctv.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cctvpic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,livechina.com,ChuKK-SCRIPT
# > DiDi
- DOMAIN-SUFFIX,didialift.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,didiglobal.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,udache.com,ChuKK-SCRIPT
# > 蛋蛋赞
- DOMAIN-SUFFIX,343480.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,baduziyuan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,com-hs-hkdy.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,czybjz.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dandanzan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fjhps.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kuyunbo.club,ChuKK-SCRIPT
# > ChinaNet
- DOMAIN-SUFFIX,21cn.com,ChuKK-SCRIPT
# > HunanTV
- DOMAIN-SUFFIX,hitv.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mgtv.com,ChuKK-SCRIPT
# > iQiyi
- DOMAIN-SUFFIX,iqiyi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iqiyipic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,71.am.com,ChuKK-SCRIPT
# > JD
- DOMAIN-SUFFIX,jd.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jd.hk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jdpay.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,360buyimg.com,ChuKK-SCRIPT
# > Kingsoft
- DOMAIN-SUFFIX,iciba.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ksosoft.com,ChuKK-SCRIPT
# > Meitu
- DOMAIN-SUFFIX,meitu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,meitudata.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,meitustat.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,meipai.com,ChuKK-SCRIPT
# > MI
- DOMAIN-SUFFIX,duokan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mi-img.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,miui.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,miwifi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xiaomi.com,ChuKK-SCRIPT
# > Microsoft
- DOMAIN-SUFFIX,microsoft.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,msecnd.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,office365.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,outlook.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,s-microsoft.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,visualstudio.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,windows.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,windowsupdate.com,ChuKK-SCRIPT
- DOMAIN,officecdn-microsoft-com.akamaized.net,ChuKK-SCRIPT
# > NetEase
# USER-AGENT,NeteaseMusic*,ChuKK-SCRIPT
# USER-AGENT,%E7%BD%91%E6%98%93%E4%BA%91%E9%9F%B3%E4%B9%90*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,163.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,126.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,127.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,163yun.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,lofter.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netease.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ydstatic.com,ChuKK-SCRIPT
# > Sina
- DOMAIN-SUFFIX,sina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,weibo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,weibocdn.com,ChuKK-SCRIPT
# > Sohu
- DOMAIN-SUFFIX,sohu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sohucs.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sohu-inc.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,v-56.com,ChuKK-SCRIPT
# > Sogo
- DOMAIN-SUFFIX,sogo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sogou.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sogoucdn.com,ChuKK-SCRIPT
# > Steam
- DOMAIN-SUFFIX,steampowered.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steam-chat.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamgames.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamusercontent.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamcontent.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamstatic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamcdn-a.akamaihd.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,steamstat.us,ChuKK-SCRIPT
# > Tencent
# USER-AGENT,MicroMessenger%20Client,ChuKK-SCRIPT
# USER-AGENT,WeChat*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gtimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,idqqimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,igamecj.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myapp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myqcloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qq.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tencent.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tencent-cloud.net,ChuKK-SCRIPT
# > YYeTs
# USER-AGENT,YYeTs*,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jstucdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zimuzu.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zimuzu.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zmz2019.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zmzapi.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zmzapi.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zmzfile.com,ChuKK-SCRIPT
# > Content Delivery Network
- DOMAIN-SUFFIX,ccgslb.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ccgslb.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chinanetcenter.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,meixincdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ourdvs.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,staticdn.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wangsu.com,ChuKK-SCRIPT
# > IP Query
- DOMAIN-SUFFIX,ipip.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ip.la,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ip-cdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ipv6-test.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,test-ipv6.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,whatismyip.com,ChuKK-SCRIPT
# > Speed Test
# - DOMAIN-SUFFIX,speedtest.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,netspeedtestmaster.com,ChuKK-SCRIPT
- DOMAIN,speedtest.macpaw.com,ChuKK-SCRIPT
# > Private Tracker
- DOMAIN-SUFFIX,awesome-hd.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,broadcasthe.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chdbits.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,classix-unlimited.co.uk,ChuKK-SCRIPT
- DOMAIN-SUFFIX,empornium.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gazellegames.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hdchina.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hdsky.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,icetorrent.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jpopsuki.eu,ChuKK-SCRIPT
- DOMAIN-SUFFIX,keepfrds.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,madsrevolution.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,m-team.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nanyangpt.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ncore.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,open.cd,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ourbits.club,ChuKK-SCRIPT
- DOMAIN-SUFFIX,passthepopcorn.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,privatehd.to,ChuKK-SCRIPT
- DOMAIN-SUFFIX,redacted.ch,ChuKK-SCRIPT
- DOMAIN-SUFFIX,springsunday.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tjupt.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,totheglory.im,ChuKK-SCRIPT
# > Scholar
- DOMAIN-SUFFIX,acm.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,acs.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aip.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ams.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,annualreviews.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aps.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ascelibrary.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,asm.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,asme.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,astm.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bmj.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cambridge.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cas.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,clarivate.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ebscohost.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,emerald.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,engineeringvillage.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,icevirtuallibrary.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ieee.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,imf.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,iop.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jamanetwork.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jhu.edu,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jstor.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,karger.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,libguides.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,madsrevolution.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mpg.de,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myilibrary.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nature.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oecd-ilibrary.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,osapublishing.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oup.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ovid.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oxfordartonline.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oxfordbibliographies.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oxfordmusiconline.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,pnas.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,proquest.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,rsc.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sagepub.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sciencedirect.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sciencemag.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,scopus.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,siam.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,spiedigitallibrary.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,springer.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,springerlink.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tandfonline.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,un.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,uni-bielefeld.de,ChuKK-SCRIPT
- DOMAIN-SUFFIX,webofknowledge.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,westlaw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,wiley.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,worldbank.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,worldscientific.com,ChuKK-SCRIPT
# > Plex Media Server
- DOMAIN-SUFFIX,plex.tv,ChuKK-SCRIPT
# > Other
- DOMAIN-SUFFIX,cn,ChuKK-SCRIPT
- DOMAIN-SUFFIX,360in.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,51ym.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,8686c.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,abchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,accuweather.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aicoinstorge.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,air-matters.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,air-matters.io,ChuKK-SCRIPT
- DOMAIN-SUFFIX,aixifan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,amd.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,b612.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bdatu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,beitaichufang.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bjango.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,booking.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,bstatic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cailianpress.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,camera360.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chinaso.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chua.pro,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chuimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chunyu.mobi,ChuKK-SCRIPT
- DOMAIN-SUFFIX,chushou.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cmbchina.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cmbimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ctrip.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dfcfw.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,docschina.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,douban.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,doubanio.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,douyu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dxycdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,dytt8.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,eastmoney.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,eudic.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,feng.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,fengkongcloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,frdic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,futu5.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,futunn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gandi.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,geilicdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,getpricetag.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,gifshow.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,godic.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hicloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hongxiu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,hostbuf.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,huxiucdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,huya.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,infinitynewtab.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ithome.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,java.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,jidian.im,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kaiyanapp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kaspersky-labs.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,keepcdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,kkmh.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,licdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,linkedin.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,loli.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,luojilab.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,maoyan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,maoyun.tv,ChuKK-SCRIPT
- DOMAIN-SUFFIX,meituan.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,meituan.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mobike.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,moke.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mubu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,myzaker.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nim-lang-cn.org,ChuKK-SCRIPT
- DOMAIN-SUFFIX,nvidia.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,oracle.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,paypal.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,paypalobjects.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qdaily.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qidian.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qyer.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,qyerstatic.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,raychase.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ronghub.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ruguoapp.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,s-reader.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sankuai.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,scomper.me,ChuKK-SCRIPT
- DOMAIN-SUFFIX,seafile.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sm.ms,ChuKK-SCRIPT
- DOMAIN-SUFFIX,smzdm.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,snapdrop.net,ChuKK-SCRIPT
- DOMAIN-SUFFIX,snwx.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,sspai.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,takungpao.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,teamviewer.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,tianyancha.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,udacity.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,uning.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,vmware.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,weather.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,weico.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,weidian.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xiachufang.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,ximalaya.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xinhuanet.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,xmcdn.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,yangkeduo.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhangzishi.cc,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhihu.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,zhuihd.com,ChuKK-SCRIPT
- DOMAIN,download.jetbrains.com,ChuKK-SCRIPT
- DOMAIN,images-cn.ssl-images-amazon.com,ChuKK-SCRIPT

# > ChuKK-SCRIPT
- DOMAIN-SUFFIX,aaplimg.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apple.co,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apple.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,apple-cloudkit.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,appstore.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,cdn-apple.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,crashlytics.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,icloud.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,icloud-content.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,me.com,ChuKK-SCRIPT
- DOMAIN-SUFFIX,mzstatic.com,ChuKK-SCRIPT
- DOMAIN,www-cdn.icloud.com.akadns.net,ChuKK-SCRIPT
- DOMAIN,clash.razord.top,ChuKK-SCRIPT
- DOMAIN,v2ex.com,ChuKK-SCRIPT
- IP-CIDR,17.0.0.0/8,ChuKK-SCRIPT,no-resolve

# Local Area Network
- IP-CIDR,192.168.0.0/16,ChuKK-SCRIPT
- IP-CIDR,10.0.0.0/8,ChuKK-SCRIPT
- IP-CIDR,172.16.0.0/12,ChuKK-SCRIPT
- IP-CIDR,127.0.0.0/8,ChuKK-SCRIPT
- IP-CIDR,100.64.0.0/10,ChuKK-SCRIPT

# DNSPod Public DNS+
- IP-CIDR,119.28.28.28/32,ChuKK-SCRIPT,no-resolve
# GeoIP China
- GEOIP,CN,ChuKK-SCRIPT

- MATCH,ChuKK-SCRIPT

proxies:' >> /root/.config/clash/config.yaml 
[[ $mode = 2 ]] && echo -e '
proxies:' >> /root/.config/clash/config.yaml 
}

conFIN() {
confRULE
[[ ! -z ${proTRO} ]] && echo -e "${proTRO}" >> /root/.config/clash/config.yaml
[[ ! -z ${proV2R} ]] && echo -e "${proV2R}" >> /root/.config/clash/config.yaml
[[ ! -z ${proXR} ]] && echo -e "${proXR}" >> /root/.config/clash/config.yaml

#echo ''

echo "#POWER BY @drowkid01" >> /root/.config/clash/config.yaml
}

enon(){
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * clash.sh * !!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}
enoff(){
rm -f /bin/clash.sh
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de clash.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}

enttrada () {
echo 'source <(curl -sSL https://raw.githubusercontent.com/CuervoCool/chukkmod/main/Recursos/ClashForAndroidGLOBAL.sh)' > /bin/clash.sh && chmod +x /bin/clash.sh
}

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}
title(){
	msg -bar3
	blanco "$1"
	msg -bar3
}
col(){
	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}
col2(){
	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}
vacio(){
blanco "\n no se puede ingresar campos vacios..."
}
cancelar(){
echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}
continuar(){
echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}
userDat(){
	blanco "	NÂ°    Usuarios 		  fech exp   dias"
	msg -bar3
}
view_usert(){
configt="/usr/local/etc/trojan/config.json"
tempt="/etc/trojan/temp.json"
trojdirt="/etc/trojan" 
user_conf="/etc/trojan/user"
backdirt="/etc/trojan/back" 
tmpdirt="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
	nick="$(cat $configt | grep ',"')"
	users="$(cat $configt | jq -r .password[])"
		title "	ESCOJE USUARIO TROJAN"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = chukkscript ]] && {
				Usr="Admin"
				DateExp=" Ilimitado"
			} || {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}
			col "$n)" "${Usr}" "$DateExp" "$exp"
			let n++
		done
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "SELECCIONA USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && tropass="user_null" && break
		n=1
		unset i
		for i in $users
		do
		[[ $n = $opcion ]] && tropass=$i
			let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		host=$(cat $configt | jq -r .ssl.sni)
		trojanport=$(cat $configt | jq -r .local_port)
		UUID=$(cat $configt | jq -r .password[$opcion])
		Usr="$(cat ${user_conf}|grep -w "${UUID}"|cut -d'|' -f1)"
		echo "USER ${Usr} : $UUID " 
		break
	done
}

view_user(){
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO V2RAY REGISTRADO"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "Escoje Tu Usuario : " 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && break
		let opcion--
		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)
		echo "Usuario $ps Seleccionado" 
		break
	done
}

_view_userXR(){
config="/etc/xray/config.json"
temp="/etc/xray/temp.json"
v2rdir="/etc/xr" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/xr/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/xr/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO XRAY REGISTRADO"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "Escoje Tu Usuario : " 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && break
		let opcion--
		psX=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $psX = null ]] && ps="default"
		uidX=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiidX=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		addX=$(jq '.inbounds[].domain' $config) && [[ $addX = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		hostX=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $hostX = null ]] && hostX=''
		netX=$(jq '.inbounds[].streamSettings.network' $config)
		parcheX=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $pathX = null ]] && parcheX='' 
		v2portX=$(jq '.inbounds[].port' $config)
		tlsX=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $netX = '"grpc"' ]] && pathX=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || pathX=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addipX=$(wget -qO- ifconfig.me)
		echo "Usuario XRAY SERA  $psX Seleccionado" 
		break
	done
}

[[ ! -d /root/.config/clash ]] && fun_insta || fun_ip
clear
[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New ChuKK-SCRIPTðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
fileon=$(ls -la /var/www/html | grep "yaml" | wc -l)
filelo=$(ls -la /root/.config/clash | grep "yaml" | wc -l)
cd
msg -bar3
echo -e "\033[1;37m ✬  Linux Dist: $(less /etc/issue.net)\033[0m"
msg -bar3
echo -e "\033[1;37m ✬ Ficheros Online:	$fileon  ✬ Ficheros Locales: $filelo\033[0m"
msg -bar3
echo -e "\033[1;37m - Menu Iterativo Clash for Android - ChuKK-SCRIPT \033[0m"
msg -bar3
echo -e "\033[1;37mSeleccione :    Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
unset yesno
echo -e " DESEAS CONTINUAR CON LA CARGA DE CONFIG CLASH?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno numwt
#[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New ChuKK-SCRIPTðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa tu Whatsapp junto a tu codigo de Pais"
read -p " Ejemplo: +593987072611 : " numwt
if [[ -z $numwt ]]; then
numwt='+593987072611'
fi
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa Clase de Servidor ( Gratis - PREMIUM )"
read -p " Ejemplo: PREMIUM : " srvip
if [[ -z $srvip ]]; then
srvip="NewADM"
fi
	while :
	do
	[[ -z ${opcion} ]] || break
		clear
		echo -e " ESCOJE TU METODO DE SELECCION "
		echo -e "  "
		echo -e " SINO CONOCES DE ESTO, ESCOJE 2 "
		echo -e "  "
		msg -bar
		echo -e "1 - SELECTOR RULES"
		echo -e "2 - SELECTOR GLOBAL"
		msg -bar
		echo -e " 0) CANCELAR"
		msg -bar
		read -p " ESCOJE : " opcion
		case $opcion in
			1)configINIT_rule "$opcion"
			break;;
			2)configINIT_global "$opcion"
			break;;
			0) break;;
			*) echo -e "\n selecione una opcion del 0 al 2" && sleep 0.3s;;
		esac
	done
INITClash
fi
