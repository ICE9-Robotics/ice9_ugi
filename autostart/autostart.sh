#!/bin/bash

export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh
ice9_scripts=/home/unitree/ICE9/autostart
log=${ice9_scripts}/.log

mv ${log} ${log}.backup
printf "%-15.15s%s\n" "[main]:" "ICE9 autostart list started." > ${log}

gnome-terminal -- bash -c "cd ${ice9_scripts}/config_4g/; ./config_4g.sh"

printf "%-15.15s%s\n" "[main]:" "ICE9 autostart list reaches the end." >> ${log}
