export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh

# Revert autostart files
autostart_dir=${HOME}/.config/autostart
if [ -f ${autostart_dir}/update.sh.desktop.bak ]; then
    mv ${autostart_dir}/ice9_autostart.sh.desktop.bak ${autostart_dir}/ice9_autostart.sh.desktop
fi
if [ -f ${autostart_dir}/slam_planner.sh.desktop.bak ]; then
    mv ${autostart_dir}/slam_planner.sh.desktop.bak ${autostart_dir}/slam_planner.sh.desktop
fi
if [ -f ${autostart_dir}/start.sh.desktop.bak ]; then
    mv ${autostart_dir}/start.sh.desktop.bak ${autostart_dir}/start.sh.desktop
fi

# Remove ros packages
rm -rf ../ice9_ws/build
rm -rf ../ice9_ws/devel

# Uninstall Husarnet
sudo -A apt remove husarnet -y
sudo -A rm -rf /var/lib/husarnet

# Complete
echo "Uninstallation complete."