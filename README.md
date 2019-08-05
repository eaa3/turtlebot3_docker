# Host machine requirements: setting up docker and (optional) nvidia-docker

1. Install Docker CE, see [installation instructions](https://docs.docker.com/engine/installation/).

  * Also perform the [post installation instructions](https://docs.docker.com/engine/installation/linux/linux-postinstall/), so that docker can be run without requiring root privileges by a non-root user. (this is optional, otherwise, scripts must be run as root)
2. (optional) If you have an NVIDIA graphic card, install the latest drivers.
  * Recommended method:

	```
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt update
	```

	Then, on Ubuntu from the menu / Dash, click on the "Additional Drivers" and on the tab with the same name, select the driver you want to use, and "Apply changes". Wait until the driver is downloaded and installed, and reboot.


3. (optional) If you have an NVIDIA graphics card and Ubuntu 16.04, install nvidia-docker 1.0. See [installation instructions](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-1.0)). If you are on Ubuntu 14.04, you can install nvidia-docker following the instructions [here](https://github.com/NVIDIA/nvidia-docker/tree/1.0), see "Ubuntu distributions" instructions.

  * Also install nvidia-modprobe by running `sudo apt-get install nvidia-modprobe`, a reboot may be required.

# Building this docker image

0. `mkdir ~/Projects`
1. `cd ~/Projects`
1. `git clone https://github.com/eaa3/turtlebot3_docker`
2. `cd turtlebot3_docker`
3. `docker build . -t dev:turtle`

# Setting up turtle3 packages

Outside docker (in the host machine), follow the steps:

0. `source fetch_packages.sh`

# Building turtle3 packages

0. Quick script to build packages: `./build_turtle.sh dev:turtle`

# Example usage


### Enter docker environment:

0. `./bash.sh dev:turtle`
1. Setup environment: `source ${HOME}/Projects/hp_ws/turtlebot3/turtlebot3_ws/install/setup.bash`
2. Run gazebo simulation example: `ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py`

If step 2. reports the following error:

```
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
```

Then, refer to "Troubleshooting" options below.

If everything went well you should see the following gazebo simulation:

![alt text](https://raw.githubusercontent.com/eaa3/turtlebot3_docker/master/turtlebot3_ros2_gdemo.png "Gazebo Turtlebot3 Demo")

From here onwards you should be able to run any desired node, etc.
See more things to try at: http://emanual.robotis.com/docs/en/platform/turtlebot3/ros2/

### Attach other terminals to running container:


0. `./exec_container.sh $(./get_containerId.sh)`
1. Setup environment: `source ${HOME}/Projects/hp_ws/turtlebot3/turtlebot3_ws/install/setup.bash`

From then onwards you should be able to run any desired node as well.


# Troubleshooting

If the following error was shown when running the gazebo demo:

```
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
```

Then, follow the steps:

0. Append the following lines to the Dockerfile and run 

```
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
```

This assumes you have an nvidia graphics card with appropriate drivers installed (see host machine requirements).

1. Rebuild the docker image: `docker build . -t dev:turtle`
2. You should now be able to run the gazebo demo without problems. (in fact, any graphics accelerated application too: e.g. rviz, etc)