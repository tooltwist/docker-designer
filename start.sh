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
#	Remove any old or running container
#
echo ''
echo '** Remove any old container.'
echo "$" docker stop ${container}
         docker stop ${container}
echo "$" docker rm ${container}
         docker rm ${container}
echo ''

#
#	Start the Docker container
#
echo '** Start a new container using the new image.'

# Environment variable to identify the container to jwilder/nginx-proxy, which will update the nginx config.
# See https://github.com/jwilder/nginx-proxy
EXTRA=""
EXTRA="${EXTRA} -e VIRTUAL_HOST=${username}.${HOSTNAME} -e VIRTUAL_PORT=5000"

# If the docker container suffers from low entropy (e.g. shown by slow Tomcat startup), this next line might help.
EXTRA="${EXTRA} -v /dev/urandom:/dev/random"

# When using boot2docker, external volumes and slow you you might want to turn it off
USE_VOLUMES=Y
if [ ${USE_VOLUMES} == "Y" ] ; then
	USERDIR=${VOLUMES_DIR}/user-${username}
	LOGSDIR=${VOLUMES_DIR}/logs-${username}
	mkdir -p ${USERDIR} ${LOGSDIR}

	EXTRA="${EXTRA} -v ${USERDIR}:/tooltwist -v ${LOGSDIR}:/logs"
fi

# Start the container
echo "$" docker run --name ${container} -p :22 -p :5000 ${EXTRA} -d ${IMAGE_NAME}
	 docker run --name ${container} -p :22 -p :5000 ${EXTRA} -d ${IMAGE_NAME}


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
