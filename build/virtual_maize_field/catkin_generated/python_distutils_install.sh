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

echo_and_run cd "/home/salma/workspace/src/virtual_maize_field"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/salma/workspace/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/salma/workspace/install/lib/python3/dist-packages:/home/salma/workspace/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/salma/workspace/build" \
    "/usr/bin/python3" \
    "/home/salma/workspace/src/virtual_maize_field/setup.py" \
     \
    build --build-base "/home/salma/workspace/build/virtual_maize_field" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/salma/workspace/install" --install-scripts="/home/salma/workspace/install/bin"
