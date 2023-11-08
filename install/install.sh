# Copy autostart files
autostart_dir=${HOME}/.config/autostart
cp files/ice9_autostart.sh.desktop ${autostart_dir}/ice9_autostart.sh.desktop
if [ -f ${autostart_dir}/slam_planner.sh.desktop ]; then
    cp files/slam_planner.sh.desktop ${autostart_dir}/slam_planner.sh.desktop
fi
if [ -f ${autostart_dir}/start.sh.desktop ]; then
    cp files/start.sh.desktop ${autostart_dir}/start.sh.desktop
fi

# Pull submodules
cd ..
git submodule update --init
cd ice9_ws/src/unitree_legged_sdk/
git fetch --tag
git checkout tags/v3.8.0

# Build ros packages
cd ../..
rosdep install --from-paths src --ignore-src -r -y
catkin_make

# Complete
echo "Installation complete."