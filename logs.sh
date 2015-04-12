#!/bin/sh
#
#	Display log files for the user
#

# Check we were passed a username
if [ -z "${1}" ] ; then
	echo usage: $0 username
	exit 1
fi
username=$1
container=designer-${username}

# Display the docker logs
docker logs -f ${container}
