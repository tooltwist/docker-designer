#!/bin/bash
#
#	Start ToolTwist Designer.
#
#	In a Docker image based on phusion/baseimage, this command is run during 
#	system startup. The Dockerfile copies it into /etc/my_init.d, where it
#	gets run by /sbin/my_init, the start point for the container.
#

# Check we have a directory for our files.
# This will normally be a user-specific volume mounted from outside the container.
mkdir -p /logs
mkdir -p /tooltwist
cd /tooltwist

# If we haven't already initialized the CLI, do so now
if [ ! -r tooltwist.js ] ; then
	echo "$ cp /root/default_tooltwist.js /tooltwist/tooltwist.js"
	        cp /root/default_tooltwist.js /tooltwist/tooltwist.js
fi

# Now run the Designer
(tooltwist -i designer 2>&1 | tee /logs/tooltwist-cli.output) &
