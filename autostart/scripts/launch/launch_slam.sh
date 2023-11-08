#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_slam" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}
log "Launching slam_planner_online..."
roslaunch slam_planner slam_planner_online.launch
log "Error! slam_planner_online exited."
log "Ended."
