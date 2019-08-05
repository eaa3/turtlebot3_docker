
#!/bin/bash

DOCKER_IMAGE=$1
WORK_DIR="${HOME}/Projects/"

#192.168.0.9:0
#192.168.0.9:0

if [ -z "$DOCKER_IMAGE" ]
then
      echo "usage: ./bash.sh <docker-image-tag>"
      echo "example: ./bash.sh dev:indigo-cuda"
      echo "to list built docker images run: docker images"
      exit 1
fi
#sudo nvidia-modprobe -u -c=0
# Running container and giving access to X11 in a safer way


docker run -it \
       --user=$(id -u) \
       --env="DISPLAY" \
       --network="host" \
       --privileged \
       --env="QT_X11_NO_MITSHM=1" \
       --workdir="/home/$USER/Projects/hp_ws/turtlebot3/turtlebot3_ws" \
       --volume="/home/$USER:/home/$USER" \
       --volume="/etc/group:/etc/group:ro" \
       --volume="/etc/passwd:/etc/passwd:ro" \
       --volume="/etc/shadow:/etc/shadow:ro" \
       --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
       --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
       --volume="${WORK_DIR}:/home/Projects" ${extra_params} \
       $DOCKER_IMAGE \
       bash -c "pwd && ls && vcs import src < turtlebot3.repos && colcon build --symlink-install" 