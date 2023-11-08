#!/bin/bash

kill_auxiliary() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep launch_auxiliary | head -1 | awk '{print $2}'`
	kill ${pid}
}

kill_camera() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep launch_camera | head -1 | awk '{print $2}'`
	kill ${pid}
}

kill_reach() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep launch_reach | head -1 | awk '{print $2}'`
	kill ${pid}
}

kill_slam() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep launch_slam | head -1 | awk '{print $2}'`
	kill ${pid}
}

kill_unitree_base() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep launch_unitree_base | head -1 | awk '{print $2}'`
	kill ${pid}
}

kill_roscore() {
	pid=`ps ux | grep -v grep | grep "bash -c" | grep launch_roscore | head -1 | awk '{print $2}'`
	kill ${pid}
}

if [[ $1 == "-h" ]]; then
	echo "Usage: $0"
	echo "This script is used to launch all the necessary nodes for the ICE9 project."
	echo "It is meant to be run on startup."
    echo "  -h, --help			display this help and exit"
    echo "  -l, --log			display log and exit"
	echo "  -ka, --killall		kill all processes launched by autostart"
	echo "  -k [name], --kill [name]	kill a specific process launched by autostart"
	echo "  	[name] can be one of the following:"
	echo "		auxiliary, camera, reach, slam, unitree_base, roscore"
	echo "  -r, --restart		restart all processes launched by autostart"
    exit 0
elif [[ $1 == "-l" || $1 == "--log" ]]; then
    cat ${HOME}/Unitree_GPS_Integration/autostart/.log
    exit 0
elif [[ $1 == "-ka" || $1 == "--killall" ]]; then
	kill_auxiliary
	kill_camera
	kill_reach
	kill_slam
	kill_unitree_base
	kill_roscore
	exit 0
elif [[ $1 == "-k" || $1 == "--kill" ]]; then
	if [[ $2 == "auxiliary" ]]; then
		kill_auxiliary
	elif [[ $2 == "camera" ]]; then
		kill_camera
	elif [[ $2 == "reach" ]]; then
		kill_reach
	elif [[ $2 == "slam" ]]; then
		kill_slam
	elif [[ $2 == "unitree_base" ]]; then
		kill_unitree_base
	elif [[ $2 == "roscore" ]]; then
		kill_roscore
	else
		echo "Error! Unknown process name."
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
