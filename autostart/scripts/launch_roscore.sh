#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_roscore" "$1" >> ${HOME}/ice9_ugi/autostart/.log
	echo $1
}

log "Started..."

is_nano_15=`ifconfig -a|grep "eth0: " -A1|grep "inet 192.168.123.15"|awk '{print $2}'`

if [ ${is_nano_15} ]; then
	while [ "no" == $(husarnet status | grep "Is ready to join" | awk '{print $6}') ]; do
		sleep 1
	done
	log "Husarnet ready, starting roscore..."
	sleep 1

	source ${HOME}/ice9_ugi/autostart/scripts/ros_setup.bash
	while true; do
		roscore
		log "Error! roscore exited."
		log "Restarting roscore..."
		sleep 1
	done
else
	log "Not Nano 15, skipped."
fi

log "Ended."
