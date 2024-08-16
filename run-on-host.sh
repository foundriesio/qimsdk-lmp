#!/bin/sh -e

cd /opt
cp /src/models/* /opt
sshpass -p "fio" ssh -o StrictHostKeyChecking=no fio@127.0.0.1 'echo "fio" | sudo WAYLAND_USER=weston XDG_RUNTIME_DIR=/run/user/63 WAYLAND_DISPLAY=wayland-1 -S '''$@''''
