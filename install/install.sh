export SUDO_ASKPASS=${HOME}/Unitree/autostart/passwd.sh

# Install and deactivate autostart files
autostart_dir=${HOME}/.config/autostart
cp files/ice9_autostart.sh ${autostart_dir}/ice9_autostart.sh.desktop

mv ${autostart_dir}/update.sh.desktop ${autostart_dir}/upate.sh.desktop.bak
if [ -f ${autostart_dir}/slam_planner.sh.desktop ]; then
    mv ${autostart_dir}/slam_planner.sh.desktop ${autostart_dir}/slam_planner.sh.desktop.bak
fi
if [ -f ${autostart_dir}/start.sh.desktop ]; then
    mv ${autostart_dir}/start.sh.desktop ${autostart_dir}/start.sh.desktop.bak
fi

# Pull submodules
cd ..
git submodule update --init -f
cd ice9_ws/src/unitree_legged_sdk/
git fetch --tag
git checkout tags/v3.8.0

# Build ros packages
cd ../..
rosdep install --from-paths src --ignore-src -r -y
catkin_make

# Install Husarnet
if [ -f /etc/apt/sources.list.d/husarnet.list ]; then
    echo "Husarnet already installed."
else
    sudo -A apt-get install ca-certificates -y
    curl https://install.husarnet.com/install.sh | sudo -A bash
fi
# TODO add husarnet join command

# Complete
echo "Installation complete."

exit 0
