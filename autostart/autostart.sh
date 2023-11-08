#!/bin/bash

log_file=${HOME}/ICE9/autostart/.log
log() {
	printf "[%-12.12s]: %s\n" "main" "$1" >> ${log_file}
	echo $1
}

export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh
ice9_scripts=/home/unitree/ICE9/autostart

mv ${log_file} ${log_file}.backup
log "ICE9 autostart list started."

gnome-terminal -- bash -c "cd ${ice9_scripts}/scripts/; ./config_4g.sh"
gnome-terminal -- bash -c "cd ${ice9_scripts}/scripts/; ./launch_cam.sh"
sleep 20
gnome-terminal --title="ros core" -- bash -c "cd ${ice9_scripts}/scripts/; ./launch_roscore.sh; exec bash"
gnome-terminal --title="Unitree Launch" -- bash -c "cd ${ice9_scripts}/scripts/; ./launch_unitree.sh;"
