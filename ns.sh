#!/bin/bash

#text Designs
Bold=$(tput bold)
Norm=$(tput sgr0)

#color
Orng="\033[0;33m"
Cyan="\033[0;36m"
Red="\033[0;31m"
Nc="\033[0m"

# Code

echo -e "\t\t${Red} _________________ ${Nc}"
echo -e "\t\t${Red}|${Cyan} Net-Scanner${Red} v1.1|${Nc}"
echo -e "\t\t${Red} ----------------- ${Nc}"

        echo -e "\n${Cyan}Scanning your current ip: ${Nc}"|pv -qL 30
var1=$(ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | awk '{if(NR!=1) print $1}')
        echo -e "${Cyan}  # ${Red}$var1${Nc}"|pv -qL 30

        echo -e "\n${Cyan}Scanning routers ip: ${Nc}"|pv -qL 30
var2=$(nmap ${var1}/24 | grep "for" | awk '{if(NR==1) print $5}')
        echo -e "${Cyan}  # ${Red}$var2${Nc}"|pv -qL 30

        echo -e "\n${Cyan}Scanning active devices on this network...${Nc}"|pv -qL 30
var3=$(nmap ${var1}/24 | grep "for" | awk '{if(NR!=1) print $5}')
        echo -e "${Cyan}  # ${Red}$var1${Nc}\n"|pv -qL 30

# Repeat scan

while true;do

a=y
b=n

read -r -p "$(echo -e "${Cyan}Scan again?${Red} y/n ${Cyan}: ")" scan

        if [ $scan == $a ]
        then
        echo -e "\n${Cyan}Scanning active devices on this network...${Nc}"|pv -qL 30
        var3=$(nmap ${var1}/24 | grep "for" | awk '{if(NR!=1) print $5}')
        echo -e "${Cyan}  # ${Red}$var1${Nc}\n"|pv -qL 30
        elif [ $scan == $b ]
        then
        echo -e "\n${Cyan}Scan stopped!${Nc}\n"|pv -qL 30
        sleep 0.5
        break
        else
        echo -e "\n${Red}>>>>> Wrong command! <<<<<\n${Nc}"|pv -qL 30
        sleep 0.5
        fi
done

# Wifi jam

c=y
d=n

read -r -p "$(echo -e "${Cyan}Jam this network?${Red} y/n ${Cyan}: ")" scan

        if [ $scan == $c ]
        then
        echo -e "\n${Cyan}Targeted ip: ${Orng}$var2${Nc}"|pv -qL 30
        echo -e "\n${Cyan}Scaning available ports...${Nc}\n"|pv -qL 30
var4=$(nmap ${var2} | grep "open" | awk '{if(NR!=0) print $0}')
        echo -e "${Orng}$var4${Nc}\n"|pv -qL 30
        echo -e "${Cyan}Copy/paste the${Red} ip${Cyan} &${Red} port num${Cyan} to jam the network.${Nc}\n"|pv -qL 30
        sleep 1
        pushd /home/kali/Net-Scanner/ > /dev/null
        python2 jam.py
        elif [ $scan == $d ]
        then
        echo -e "\n${Cyan}Keeping the network alive!${Nc}\n"|pv -qL 30 > /dev/null 1>&2
        sleep 0.5
        else
        echo -e "\n${Red}>>>>> Wrong command! <<<<<\n${Nc}"|pv -qL 30
        sleep 0.5
        fi
