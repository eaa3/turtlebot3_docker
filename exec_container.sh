#!/bin/bash

ROOT_DIR="$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd)"

# if [ $# -ne 1 ]; then
# 	echo "usage: ./exec_container.sh <container_id>"
#     echo "example: ./docker_build.sh fa11998579c"
#     echo "to get current container id, run ./get_containerId.sh script"
#   exit 1
# fi

CONTAINER_ID=$1

if [ -z "$CONTAINER_ID" ]
then
      echo "usage: ./exec_container.sh <container_id>"
      echo "example: ./docker_build.sh fa11998579c"
      echo "to get current container id, run ./get_containerId.sh script"
      CONTAINER_ID=$(docker ps -l -q)
      # exit 1
fi


shopt -s expand_aliases
source $HOME/.bashrc
source ${ROOT_DIR}/aml_aliases.sh


echo 'Entering container:' $CONTAINER_ID
xdocker exec -it $CONTAINER_ID bash
# -c "source /opt/ros/kinetic/setup.bash && /bin/bash"