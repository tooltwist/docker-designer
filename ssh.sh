#!/bin/bash
#
#	Use SSH to log into the Mysql Docker container.
#
bin=`dirname $0`
. $bin/env.sh

# Check we were passed a username
if [ -z "${1}" ] ; then
	echo usage: $0 username
	exit 1
fi
username=$1
container=designer-${username}

# Login using ssh
#OPTION="-o StrictHostKeyChecking=no"
#echo ssh ${OPTION} root@${DOCKER_IP} -p ${SSH_PORT} "$@"
#     ssh ${OPTION} root@${DOCKER_IP} -p ${SSH_PORT} "$@"

# Login using docker exec
echo "$ docker exec -i -t ${container} /bin/bash"
        docker exec -i -t ${container} /bin/bash
