#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_unitree" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}

log "Started..."

is_nano_15=`ifconfig -a|grep "eth0: " -A1|grep "inet 192.168.123.15"|awk '{print $2}'`
is_nano_13=`ifconfig -a|grep "eth0: " -A1|grep "inet 192.168.123.13"|awk '{print $2}'`
launch_scripts_path=${HOME}/Unitree_GPS_Integration/autostart/scripts/launch
ros_setup=${HOME}/Unitree_GPS_Integration/autostart/scripts/ros_setup.bash

source ${ros_setup}
while [[ ! $(rostopic list) ]]; do
	sleep 1
done

log "roscore found, starting unitree launch sequence..."
if [[ ${is_nano_15} ]]; then
	gnome-terminal -- bash -c "source ${ros_setup}; cd ${launch_scripts_path}; ./launch_unitree_base.sh; exec bash"
	sleep 5
	gnome-terminal -- bash -c "source ${ros_setup}; cd ${launch_scripts_path}; ./launch_slam.sh; exec bash"
	sleep 5
	gnome-terminal -- bash -c "source ${ros_setup}; cd ${launch_scripts_path}; ./launch_reach.sh; exec bash"
	sleep 5
	gnome-terminal -- bash -c "source ${ros_setup}; cd ${launch_scripts_path}; ./launch_auxiliary.sh; exec bash"
	log "Unitree launch sequence completed..."
elif [[ ${is_nano_13} ]]; then
	gnome-terminal -- bash -c "source ${ros_setup}; cd ${launch_scripts_path}; ./launch_camera.sh"
	log "Unitree launch sequence completed..."
else
	log "Not Nano 13 or 15, skipped."
fi

log "Ended."
