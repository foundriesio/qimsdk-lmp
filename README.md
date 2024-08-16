# About
This repository helps developers build a container-based workflow for
developing the IMSDK GStreamer Samples Apps from [Code Linaro](https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss/-/tree/imsdk.lnx.2.0.0.r1-rel/).

The Docker container image defined in this repository includes all the
toolchain components required to compile and link the "gst-sample-apps".

## Getting Started
The whole workflow can be done done directly on your RB3Gen2 developer
board. You can SSH into this board or use the Weston UI and terminal to
do the following steps:

 * Clone this repository: `git clone https://github.com/foundriesio/qimsdk-lmp`
 * Build the container (one time only): `docker compose build`
 * Start the development environment: `docker compose up -d`

At this point the SDK container is ready to use. The Docker Compose step
from above will create a new file on the host filesystem: 
`/opt/bin/dev-shell`. Executing this script will drop you into the container
with `/opt` bind mounted into it to allow sharing files between the 
container and the host.

## Building Sample Apps
Launching `/opt/bin/dev-shell` will place you into the `gst-sample-apps`
directory. The script prints some helpful text to get CMake configured.
There is a script, `/usr/local/bin/gst-configure-env`, that will create
a `./build` directory and run CMake with the correct options enabled.

You can change into the `build` directory and run `make` to build the
apps and `sudo make install` to have them copied to `/opt` which is shared
with the host.

## Running Sample Apps
The container includes a small script that lets you run the sample apps
inside the host OS by ssh'ing into the host and running them. The script
can be invoked like:
```
  $ run-on-host.sh <command>
```

This command will run the command on host with proper environment variables
set for things like Wayland.