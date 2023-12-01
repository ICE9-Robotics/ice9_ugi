#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "config_4g" "$1" >> ${HOME}/ice9_ugi/autostart/.log
	echo $1
}

log "Started..."

export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh

is_nano_15=`ifconfig -a|grep "eth0: " -A1|grep "inet 192.168.123.15"|awk '{print $2}'`

if [ ${is_nano_15} ]; then
	sudo -A iptables -F
	sudo -A iptables -t nat -F
	sudo -A iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	sudo -A iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
	sudo -A iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
	sudo -A iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
	log "Ip tables added"
else
	sudo -A route add default gw 192.168.123.15 eth0
	log "Gateway 192.168.123.15 added."
fi

while true; do
	gw=`route -n | grep 192.168.123.161 | awk '{print $1}'`
	if [[ ${gw} == "0.0.0.0" ]]; then
		sudo -A route delete default gw 192.168.123.161
		log "Deleted default gateway 192.168.123.161"
		break
	fi
	sleep 1
done

log "Ended."
