export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh

# Revert autostart files
autostart_dir=${HOME}/.config/autostart
mv ${autostart_dir}/ice9_autostart.sh.desktop ${autostart_dir}/ice9_autostart.sh.desktop.bak

if [ -f ${autostart_dir}/update.sh.desktop.bak ]; then
    mv ${autostart_dir}/update.sh.desktop.bak ${autostart_dir}/update.sh.desktop
fi
if [ -f ${autostart_dir}/slam_planner.sh.desktop.bak ]; then
    mv ${autostart_dir}/slam_planner.sh.desktop.bak ${autostart_dir}/slam_planner.sh.desktop
fi
if [ -f ${autostart_dir}/start.sh.desktop.bak ]; then
    mv ${autostart_dir}/start.sh.desktop.bak ${autostart_dir}/start.sh.desktop
fi
