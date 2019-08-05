#!/bin/bash

mkdir -p ~/Projects/hp_ws/turtlebot3/turtlebot3_ws/src >/dev/null 2>&1
cd ~/Projects/hp_ws/turtlebot3/turtlebot3_ws
rm -rf turtlebot3.repos >/dev/null 2>&1
wget https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/ros2/turtlebot3.repos
cd -
