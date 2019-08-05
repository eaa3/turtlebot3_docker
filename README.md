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


3. (optional) If you have an NVIDIA graphic card and Ubuntu 16.04, install nvidia-docker 1.0. See [installation instructions](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-1.0)). If you are on Ubuntu 14.04, you can install nvidia-docker following the instructions [here](https://github.com/NVIDIA/nvidia-docker/tree/1.0), see "Ubuntu distributions" instructions.

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


TODO
