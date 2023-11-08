#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_camera" "$1" >> ${HOME}/ICE9/autostart/.log
	echo $1
}

log "Unlocking face camera ..."
gnome-terminal -- bash -c "cd ${HOME}/Unitree/sdk/UnitreeCameraSdk/bins; ./example_getRawFrame 1"
sleep 10
pid=`ps ux | grep ./example_getRawFrame | grep bash | grep -v grep | head -1 | awk '{print $2}'`
if [ ${pid} ]; then
	kill ${pid}
	log "Camera should be unlocked."
else
	log "Error! Unable to unlock camera."
	log "Exit with error."
	exit
fi

log "Launching mjpeg_cam..."
roslaunch ice9_unitree mjpeg_cam.launch device_name:=/dev/video1
log "Error! mjpeg_cam exited."
log "Ended."
