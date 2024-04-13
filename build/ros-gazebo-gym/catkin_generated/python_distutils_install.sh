#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/salma/DQN_DWA-Ros-Navigation-/src/ros-gazebo-gym"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/salma/DQN_DWA-Ros-Navigation-/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/salma/DQN_DWA-Ros-Navigation-/install/lib/python3/dist-packages:/home/salma/DQN_DWA-Ros-Navigation-/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/salma/DQN_DWA-Ros-Navigation-/build" \
    "/usr/bin/python3" \
    "/home/salma/DQN_DWA-Ros-Navigation-/src/ros-gazebo-gym/setup.py" \
    egg_info --egg-base /home/salma/DQN_DWA-Ros-Navigation-/build/ros-gazebo-gym \
    build --build-base "/home/salma/DQN_DWA-Ros-Navigation-/build/ros-gazebo-gym" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/salma/DQN_DWA-Ros-Navigation-/install" --install-scripts="/home/salma/DQN_DWA-Ros-Navigation-/install/bin"
