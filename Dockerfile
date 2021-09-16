# use arm64 ubuntu 18.04
FROM arm64v8/ubuntu:bionic

# install curl
RUN apt -y update && apt install -y \
  curl \
  gnupg2 \
  lsb-release \
  iputils-ping \
  net-tools \
  wget \
  screen \
  git \
  nano \
  vim \
  htop

# allow packages from packages.ros.org
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# set up keys
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# disable region prompts (i.e. tzdata setup)
ARG DEBIAN_FRONTEND=noninteractive

# install ros
RUN apt -y update && '2' | apt install -y \
  ros-melodic-joy \
  ros-melodic-teleop-twist-joy \
  ros-melodic-teleop-twist-keyboard \ 
  ros-melodic-laser-proc \
  ros-melodic-rgbd-launch \
  ros-melodic-depthimage-to-laserscan \
  ros-melodic-rosserial-arduino \ 
  ros-melodic-rosserial-python \
  ros-melodic-rosserial-server \ 
  ros-melodic-rosserial-client \ 
  ros-melodic-rosserial-msgs \
  ros-melodic-amcl \
  ros-melodic-map-server \
  ros-melodic-move-base \
  ros-melodic-urdf \
  ros-melodic-xacro \
  ros-melodic-compressed-image-transport \
  ros-melodic-rqt-image-view \
  ros-melodic-gmapping \
  ros-melodic-navigation \
  ros-melodic-interactive-markers \
  ros-melodic-turtlebot3-gazebo

# environment setup (add to .bashrc)
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash"
RUN echo "source /opt/ros/melodic/setup.sh" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
RUN echo "defshell -bash" >> ~/.screenrc
WORKDIR /root/catkin_ws/src
