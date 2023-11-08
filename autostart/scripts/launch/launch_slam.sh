#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_slam" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}
log "Launching slam_planner_online..."
while true; do
	roslaunch slam_planner slam_planner_online.launch
	log "Error! slam_planner_online exited."
	log "Restarting slam_planner_online..."
	sleep 1
done
log "Ended."
