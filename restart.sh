#!/bin/bash
#
#	Start the mysql database
#
bin=`dirname $0`
#. $bin/../env.sh
. $bin/env.sh

# Check we were passed a username
if [ -z "${1}" ] ; then
	echo usage: $0 username
	exit 1
fi
username=$1
container=designer-${username}

#
#	Start the Docker container
#
echo '** Start the stopped container.'
# Start the container
echo "$" docker start --name ${container}
	 docker start --name ${container}


if [ $? == 0 ] ; then

	# Successful start
	echo ""
	echo ""
	echo "        http://${username}.${HOSTNAME}:${HTTP_PORT}/ttsvr/login"
	echo ""
	exit 0
else
	# Error return
	echo ""
	echo ""
	echo "Error: starting the container failed."
	echo ""
	exit 1;
fi
