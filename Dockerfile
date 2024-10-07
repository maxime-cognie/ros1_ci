# Base image
FROM osrf/ros:noetic-desktop-full-focal

# Install Gazebo 11 and other dependencies
RUN apt-get update && apt-get install -y \
    git \
    gazebo11 \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control \
    ros-noetic-ros-control \
    ros-noetic-ros-controllers \
    ros-noetic-joint-state-publisher \
    ros-noetic-joint-state-controller \
    ros-noetic-robot-state-publisher \
    ros-noetic-robot-localization \
    ros-noetic-xacro \
    ros-noetic-tf2-ros \
    ros-noetic-tf2-tools \
    ros-noetic-gmapping \
    ros-noetic-amcl \
    ros-noetic-map-server \
    ros-noetic-move-base \
    ros-noetic-urdf \
    ros-noetic-rqt-image-view \
    ros-noetic-navigation \
    ros-noetic-slam-gmapping \
    ros-noetic-dwa-local-planner \
    && rm -rf /var/lib/apt/lists/*

# make workspace
WORKDIR /
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src

# Copy the files in the current directory into the container
RUN git clone --recursive https://github.com/rigbetellabs/tortoisebot.git
RUN git clone https://github.com/maxime-cognie/tortoisebot_waypoints.git

RUN sed -i 's|<param name="goal_x" value="0.0" />|<param name="goal_x" value="0.5" />|g' tortoisebot_waypoints/test/waypoints_test.test
RUN sed -i 's|<param name="goal_y" value="0.0" />|<param name="goal_y" value="0.5" />|g' tortoisebot_waypoints/test/waypoints_test.test

WORKDIR /catkin_ws

# Source ros noetic and build workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Source the setup.bash file before executing further commands
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

COPY ros_entrypoint.sh .
RUN chmod +x ros_entrypoint.sh
ENTRYPOINT ["./ros_entrypoint.sh"]