FROM osrf/ros:dashing-desktop
# Suggestion: dashing-desktop-full instead?

ARG DEBIAN_FRONTEND=noninteractive


# Update Ubuntu Software repository
RUN apt-get update -y
RUN apt install -y locales wget python curl gnupg gnupg2 gnupg1 lsb-release
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8
#<!--Setup Sources. -->
RUN apt update -y && apt install curl gnupg2 lsb-release

#<!--Installing tensorflow-->
RUN pip3 install tensorflow  # or tensorflow-gpu
#<!--Installing pandas-->
RUN pip3 install pandas
#<!--Installing keras-->
RUN pip3 install keras
#<!--Installing gym-->
RUN pip3 install gym
#<!--Installing Ray-->
RUN pip3 install ray[rllib]  
RUN pip3 install ray[debug]
#<!--Installing trasnforms3d--> 
RUN pip3 install transforms3d billiard psutil transformations
#<!--Installing dependencies-->
RUN apt install --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev
    
#INSTALL CARTOGRAPHER DEPENDENCIES:
RUN apt install -y \
  google-mock \
  libceres-dev \
  liblua5.3-dev \
  libboost-dev \
  libboost-iostreams-dev \
  libprotobuf-dev \
  protobuf-compiler \
  libcairo2-dev \
  libpcl-dev \
  python3-sphinx
  
  
#INSTALL GAZEBO9 (version9.10):
#<!-- Setup your cmputer to accept software from packages.osrfoundation-->
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
#<!-- You can check to see if the file was written correctly -->
RUN cat /etc/apt/sources.list.d/gazebo-stable.list
#<!-- Setup keys and update the debian database-->
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
RUN apt update -y
#<!-- Install gazebo9-->
RUN apt install -y gazebo9
RUN apt install -y libgazebo9-dev

# Install Navigation2 dependencies:
RUN apt install -y \
  libsdl-image1.2 \
  libsdl-image1.2-dev \
  libsdl1.2debian \
  libsdl1.2-dev
  
RUN apt install -y software-properties-common
RUN add-apt-repository universe
RUN apt update -y
RUN apt install -y liblog4cxx-dev

#INIT ROS 2:
#RUN rosdep init # init has already been done by the source image
RUN rosdep update

RUN /bin/bash /opt/ros/dashing/setup.bash
RUN /bin/bash /usr/share/gazebo/setup.sh

#INSTALL ROS 2 RTI-DEPENDENCIES:
RUN apt install -y libopensplice69
RUN apt install -y apt-utils
RUN apt install -y python3-argcomplete
RUN apt install -y ros-dashing-test-msgs ros-dashing-tf2-sensor-msgs sudo

#INSTALL ROS 2 RTI:
RUN RTI_NC_LICENSE_ACCEPTED=yes apt install -q -y rti-connext-dds-5.3.1 
RUN cd /opt/rti.com/rti_connext_dds-5.3.1/resource/scripts && source ./rtisetenv_x64Linux3gcc5.4.0.bash; cd -



# If you run into trouble with libGL error uncomment the following 3 lines and rebuild this docker image: 
#LABEL com.nvidia.volumes.needed="nvidia_driver"
#ENV PATH /usr/local/nvidia/bin:${PATH}
#ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# (assuming nvidia graphics): if RViz fails to build due to undefined libGL.so, uncomment these two lines and rebuild docker:
#RUN rm /usr/lib/x86_64-linux-gnu/libGL.so
#RUN ln -s /usr/local/nvidia/lib64/libGL.so.1 /usr/lib/x86_64-linux-gnu/libGL.so

# Other
#RUN rm /usr/lib/x86_64-linux-gnu/libEGL.so
#RUN ln /usr/lib/x86_64-linux-gnu/libEGL.so.1 /usr/lib/x86_64-linux-gnu/libEGL.so



#### Compile packages
#### Deprecated
#<!--Installing the packages-->
#RUN mkdir -p ~/Projects/hp_ws/turtlebot3_ws
#COPY turtlebot3_ws ~/Projects/hp_ws/turtlebot3_ws
#RUN cd ~/Projects/hp_ws/turtlebot3_ws
#RUN colcon build --symlink-install
#### Deprecated

