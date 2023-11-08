#!/bin/bash

log_roscore() {
	printf "[%-12.12s]: %s\n" "ros_setup" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}

is_nano_13=`ifconfig -a|grep "eth0: " -A1|grep "inet 192.168.123.13"|awk '{print $2}'`
is_nano_15=`ifconfig -a|grep "eth0: " -A1|grep "inet 192.168.123.15"|awk '{print $2}'`
if [ ${is_nano_13} ]; then
	export ROS_HOSTNAME=unitree_13
elif [ ${is_nano_15} ]; then
	export ROS_HOSTNAME=unitree_15
else
	log_roscore "Niether Nano 13 or 15, skipped."
fi

export ROS_IPV6=on
export ROS_MASTER_URI=http://master:11311
source ${HOME}/ice9_ws/devel/setup.bash

log_roscore "Done."
