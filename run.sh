#!/bin/bash

rm /tmp/.X1-lock > /dev/null 2>&1
rm -Rf /tmp/.X11-unix > /dev/null 2>&1
/usr/bin/Xvfb :1 -screen 0 1280x800x16 &
sleep 5
/usr/bin/x11vnc -display :1.0 -usepw -forever &

while sleep 20; do
    ps aux | grep Xvfb | grep -q -v grep
    PROCESS_1_STATUS=$?

    if [ $PROCESS_1_STATUS -ne 0 ]; then
        echo "The processes has already exited."
        exit 1
    fi
done
