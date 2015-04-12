#!/bin/bash
#
#	Remove a designer container
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
echo '** Stopping container...'
echo "$" docker stop ${container}
         docker stop ${container}
echo ''
echo '** Remove container...'
echo "$" docker rm ${container}
         docker rm ${container}
echo ''

exit $?
