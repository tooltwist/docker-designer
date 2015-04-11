#!/bin/sh
#
#	Set varibles used by the database accessing commands.
#	This is not normally calle directly.
#
#!/bin/bash
#
#	Set varibles for Docker containers
#

#export PROJECT=curia

USE_BOOT2DOCKER=Y

if [ ${USE_BOOT2DOCKER} == "Y" ] ; then
	export DOCKER_IP=$(boot2docker ip 2>/dev/null)
fi
#export DOCKER_IP=127.0.0.1

# Settings for Docker
if [ ${USE_BOOT2DOCKER} == "Y" ] ; then
	if [ "${DOCKER_IP}" == "" ] ; then
		if [ "${DOCKER_HOST}" != "" ] ; then
			DOCKER_IP=$(echo $DOCKER_HOST | sed "s/^.*\/\(.*\):.*$/\1/")
			echo Setting DOCKER_IP=${DOCKER_IP}
		fi
	fi
	if [ "${DOCKER_HOST}" == "" ] ; then
		export DOCKER_HOST=tcp://${DOCKER_IP}:2375
		echo Setting DOCKER_HOST=${DOCKER_HOST}
	fi
fi

# Settings for our Container
SSH_PORT=59160
HTTP_PORT=59161
IMAGE_NAME=docker-designer
CONTAINER_NAME=docker-designer-test
