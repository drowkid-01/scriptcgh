#!/bin/bash
# Zivpn UDP Module installer
# Creator Zahid Islam mod PowerMX
# edit @drowkid01

function msg(){
declare -A kol=( [0]="ngr" [1]="r" [2]="verd" [3]="ama" [4]="azu" [5]="p" [6]="c" [7]="bra" )
declare -A color=( [sc]='\e[0m' )
        for(( col=0;col<7;col++ )); do
             color[$col]+="\e[1;3${col}m"
             color[${kol[$col]}]+="${color[$col]}"
        done
                case $1 in
                  "-bar")echo -e "${color[0]}======================================${color[sc]}";;
                   "-ne")echo -ne "${color[0]}[\e[38;5;52m•\e[1;30m] \e[93m$2${color[2]} "&&read $3;;
                    "-e")echo -e "${color[e]}$2${color[sc]}";;
                       *)x=`echo $1|tr -d "-"`
                        echo -e "${color[$x]}$2";;
                esac

}

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

fun_tit(){
  [[ ! -e /bin/ejecutar/tittle ]] && {
        cat << eof > /bin/ejecutar/tittle
┏━╸╻ ╻╻ ╻╻┏ ╻┏    ┏━┓┏━╸┏━┓╻┏━┓╺┳╸
┃  ┣━┫┃ ┃┣┻┓┣┻┓╺━╸┗━┓┃  ┣┳┛┃┣━┛ ┃   ${vlog}
┗━╸╹ ╹┗━┛╹ ╹╹ ╹   ┗━┛┗━╸╹┗╸╹╹   ╹
eof
}
cat /bin/ejecutar/tittle|lolcat
msg -bar
}

[[ $(cat ${sfile[log]}|grep "zipvpn") == "" ]] && {
#echo -e "Updating server"
printf "%8s $(msg -ama 'ACTUALIZANDO PAQUETES')\n"
fun_bar "sudo apt-get update && apt-get upgrade -y"
systemctl stop zivpn.service 1> /dev/null 2> /dev/null
printf "%8s $(msg -ama 'DESCARGANDO RECURSOS UDP-Service')\n"
wget https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-amd64 -O /usr/local/bin/zivpn 1> /dev/null 2> /dev/null
chmod +x /usr/local/bin/zivpn
mkdir /etc/zivpn 1> /dev/null 2> /dev/null
wget https://raw.githubusercontent.com/zahidbd2/udp-zivpn/main/config.json -O /etc/zivpn/config.json 1> /dev/null 2> /dev/null

#echo -e "Generating cert files:"
msg -ama "
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=California/L=Los Angeles/O=Example Corp/OU=IT Department/CN=zivpn" -keyout "/etc/zivpn/zivpn.key" -out "/etc/zivpn/zivpn.crt" 1> /dev/null 2> /dev/null
sysctl -w net.core.rmem_max=16777216 1> /dev/null 2> /dev/null
sysctl -w net.core.wmem_max=16777216 1> /dev/null 2> /dev/null
cat <<EOF > /etc/systemd/system/zivpn.service
[Unit]
Description=zivpn VPN Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/etc/zivpn
ExecStart=/usr/local/bin/zivpn server -c /etc/zivpn/config.json
Restart=always
RestartSec=3
Environment=ZIVPN_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF

echo -e "ZIPUDP Contraseñas."
#read -p "Enter passwords separated by commas, example: pass1,pass2 (Press enter for Default 'zi'): " input_config
read -p "Ingrese las contraseñas separadas por comas, ejemplo: drowkid,chukk,donpato,xddd,popocatepetl: " input_config

if [ -n "$input_config" ]; then
    IFS=',' read -r -a config <<< "$input_config"
    if [ ${#config[@]} -eq 1 ]; then
        config+=(${config[0]})
    fi
else
    config=("zi")
fi

new_config_str="\"config\": [$(printf "\"%s\"," "${config[@]}" | sed 's/,$//')]"

sed -i -E "s/\"config\": ?\[[[:space:]]*\"zi\"[[:space:]]*\]/${new_config_str}/g" /etc/zivpn/config.json


systemctl enable zivpn.service
systemctl start zivpn.service
iptables -t nat -A PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 6000:19999 -j DNAT --to-destination :5667
ufw allow 6000:19999/udp
ufw allow 5667/udp
rm ziinstaller.* 1> /dev/null 2> /dev/null

msg -v "ZIPVPN INSTALADO CORRECTAMENTE"
echo 'zipvpn' >> ${sfile[log]}
bash $(pwd)/$0
} || {
	IP=`curl -4 icanhazip.com`;
	distribution=`( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1`;
	Network=`ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1`;
	ports=`netstat -tunlp | grep zivpn | grep ::: | awk '{print substr($4,4); }' > /tmp/udpzivpn.txt && echo | cat /tmp/udpzivpn.txt | tr '\n' ' ' > /tmp/udpzivpnports.txt && cat /tmp/udpzivpnports.txt`;
	RED='\033[1;31m'&&GREEN='\033[1;32m'&&YELLOW='\033[1;33m'&&BLUE='\033[1;34m'&&PURPLE='\033[1;35m'&&CYAN='\033[1;36m'&&GRAY='\033[1;37m'&&WHITE='\033[1;37m'&&RESET='\033[0m'

while true; do
  if [ $(id -u) -eq 0 ]; then
    clear
  else
    echo -e "\e[91m[x] necesitas ser usuario root para usar este script [x]"
    rm $HOME/.bash_history $(pwd)/$0 
    exit 
  fi
#installv1
function installv1(){
msg -bar
echo -e "${YELLOW}This option will install ZIVPN version 1, UDP port range will be 20000:50000 redirected to 5666"
echo -e "${YELLOW}Continue?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${YELLOW}INSTALLING.."
bash <(curl -fsSL https://raw.githubusercontent.com/zahidbd2/udp-zivpn/main/zi.sh)
fi
}
#installv2
function installv2(){
echo -e "${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}This option will install ZIVPN version 2, UDP port range will be 6000:19999 redirected to 5667"
echo -e "${YELLOW}Continue?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${YELLOW}INSTALLING.."
bash <(curl -fsSL https://raw.githubusercontent.com/zahidbd2/udp-zivpn/main/zi2.sh)
fi
}
#uninstall
function uninstall(){
echo -e "${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}This option will uninstall the ZIVPN server in any of its versions"
echo -e "${YELLOW}Continue?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${YELLOW}UNINSTALLING.."
bash <(curl -fsSL https://raw.githubusercontent.com/zahidbd2/udp-zivpn/main/uninstall.sh)
fi
}
#start
function startzivpn(){
echo -e "${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}This option will start the ZiVPN server"
echo -e "${YELLOW}Continue?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${YELLOW}STARTING.."
    if [[ ${yesno} = @(s|S|y|Y) ]]; then
        echo -e "${YELLOW}Checking for ZiVPN services..."
        
        if [[ -f /etc/systemd/system/zivpn.service ]]; then
            echo -e "${YELLOW}Starting ZiVPN service..."
            sudo systemctl start zivpn.service
        fi
        if [[ -f /etc/systemd/system/zivpn_backfill.service ]]; then
            echo -e "${YELLOW}Starting ZiVPN Backfill service..."
            sudo systemctl start zivpn_backfill.service
        fi
        
        echo -e "${YELLOW}DONE!"
    fi
fi
}
#stop
function stopzivpn(){
echo -e "${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}This option will stop the ZiVPN server"
echo -e "${YELLOW}Continue?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${YELLOW}STOPPING.."
    if [[ ${yesno} = @(s|S|y|Y) ]]; then
        echo -e "${YELLOW}Checking for ZiVPN services..."
        
        if [[ -f /etc/systemd/system/zivpn.service ]]; then
            echo -e "${YELLOW}Starting ZiVPN service..."
            sudo systemctl stop zivpn.service
        fi
        if [[ -f /etc/systemd/system/zivpn_backfill.service ]]; then
            echo -e "${YELLOW}Starting ZiVPN Backfill service..."
            sudo systemctl stop zivpn_backfill.service
        fi
        
        echo -e "${YELLOW}DONE!"
    fi
fi
}
#restart
function restartzivpn(){
echo -e "${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}This option will restart the ZiVPN server"
echo -e "${YELLOW}Continue?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${YELLOW}RESTARTING.."
    if [[ ${yesno} = @(s|S|y|Y) ]]; then
        echo -e "${YELLOW}Checking for ZiVPN services..."
        
        if [[ -f /etc/systemd/system/zivpn.service ]]; then
            echo -e "${YELLOW}Starting ZiVPN service..."
            sudo systemctl restart zivpn.service
        fi
        if [[ -f /etc/systemd/system/zivpn_backfill.service ]]; then
            echo -e "${YELLOW}Starting ZiVPN Backfill service..."
            sudo systemctl restart zivpn_backfill.service
        fi
        
        echo -e "${YELLOW}DONE!"
    fi
fi
}
  if [[ $1 == "" ]]; then
    clear && printf '\e[3J'
echo -e "${GRAY}[${RED}-${GRAY}]${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}   【          ${RED}ZIVPN            ${YELLOW}】 "
echo -e "${YELLOW} › ${WHITE}Linux Dist:${GREEN} $distribution "
echo -e "${YELLOW} › ${WHITE}IP:${GREEN} $IP "
echo -e "${YELLOW} › ${WHITE}Network:${GREEN} $Network "
echo -e "${YELLOW} › ${WHITE}Running:${GREEN} $ports "
echo -e "${GRAY}[${RED}-${GRAY}]${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW}[${GREEN}1${YELLOW}] ${RED} › ${WHITE} INSTALL ZIVPN V1 (5666)
${YELLOW}[${GREEN}2${YELLOW}] ${RED} › ${WHITE} INSTALL ZIVPN V2 (5667)
${YELLOW}[${GREEN}3${YELLOW}] ${RED} › ${WHITE} UNINSTALL ZIVPN
${YELLOW}[${GREEN} ${YELLOW}] ${RED} › ${WHITE} ────────
${YELLOW}[${GREEN}4${YELLOW}] ${RED} › ${WHITE} START ZIVPN
${YELLOW}[${GREEN}5${YELLOW}] ${RED} › ${WHITE} STOP ZIVPN
${YELLOW}[${GREEN}6${YELLOW}] ${RED} › ${WHITE} RESTART ZIVPN
${YELLOW}[${GREEN}0${YELLOW}] ${RED} › ${WHITE} EXIT
${GRAY}[${RED}-${GRAY}]${RED} ────────────── /// ─────────────── "
echo -e "${YELLOW} Δ CHOOSE AN OPTION:      ${YELLOW}"
read -p " : " option
tput cuu1 >&2 && tput dl1 >&2
else
option=$1
fi
case $option in
  1 | 01 )
   installv1;;
  2 | 02 )
   installv2;;
  3 | 03)
   uninstall;;
  4 | 04)
   startzivpn;;
  5 | 05)
   stopzivpn;;
  6 | 06)
   restartzivpn;;
  0)
  exit;;
  *)
  continue;;
  esac
  break
  done
}
