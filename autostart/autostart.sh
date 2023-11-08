#!/bin/bash

kill_() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep $1 | head -1 | awk '{print $2}'`
	if [ ${pid} ]; then
		kill ${pid}
		echo "Killed $1."
	else
		echo "Can't find the process for $1."
	fi
}

if [[ $1 == "-h" ]]; then
	echo "Usage: $0"
	echo "This script is used to launch all the necessary nodes for the ICE9 project."
	echo "It is meant to be run on startup."
    echo "  -h, --help			display this help and exit"
    echo "  -l, --log			display log and exit"
	echo "  -ka, --killall		kill all processes launched by autostart"
	echo "  -k [name], --kill [name]	kill a specific process launched by autostart"
	echo "	[name] can be one of the following:"
	echo "	launch_auxiliary"
	echo "	launch_camera"
	echo "	launch_reach"
	echo "	launch_slam"
	echo "	launch_unitree_base"
	echo "	launch_roscore"
	echo "	config_4g"
	echo "  -r, --restart			restart all processes launched by autostart"
    exit 0
elif [[ $1 == "-l" || $1 == "--log" ]]; then
    cat ${HOME}/Unitree_GPS_Integration/autostart/.log
    exit 0
elif [[ $1 == "-ka" || $1 == "--killall" ]]; then
	kill_ launch_auxiliary
	kill_ launch_camera
	kill_ launch_reach
	kill_ launch_slam
	kill_ launch_unitree_base
	kill_ launch_roscore
	kill_ config_4g
	exit 0
elif [[ $1 == "-k" || $1 == "--kill" ]]; then
	if [[ $2 != "launch_auxiliary" && $2 != "launch_camera" && $2 != "launch_reach" && $2 != "launch_slam" && $2 != "launch_unitree_base" && $2 != "launch_roscore" && $2 != "config_4g" ]]; then
		echo "Error! Unknown process name."
		exit 1
	else
		kill_ $2
		exit 1
	fi
	exit 0
elif [[ $1 == "-r" || $1 == "--restart" ]]; then
	kill_auxiliary
	kill_camera
	kill_reach
	kill_slam
	kill_unitree_base
	kill_roscore
fi


log_file=${HOME}/Unitree_GPS_Integration/autostart/.log
log() {
	printf "[%-12.12s]: %s\n" "main" "$1" >> ${log_file}
	echo $1
}

export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh
ice9_scripts=${HOME}/Unitree_GPS_Integration/autostart

mv ${log_file} ${log_file}.backup
log "ICE9 autostart list started."

gnome-terminal -- bash -c "cd ${ice9_scripts}/scripts/; ./config_4g.sh"
gnome-terminal -- bash -c "cd ${ice9_scripts}/scripts/; ./launch_cam.sh"
sleep 20
gnome-terminal --title="ros core" -- bash -c "cd ${ice9_scripts}/scripts/; ./launch_roscore.sh; exec bash"
gnome-terminal --title="Unitree Launch" -- bash -c "cd ${ice9_scripts}/scripts/; ./launch_unitree.sh;"
