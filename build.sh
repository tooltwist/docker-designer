#!/bin/bash
#
#	Start the mysql database
#
bin=`dirname $0`
. $bin/env.sh


#
#	Check we have SSH credentials on this machine
#
#
keyfile=~/.ssh/id_rsa.pub
key=`cat ${keyfile}`
if [ ! -r ${keyfile} ] ; then
	echo ""
	echo "Error: please set up SSH keys at ${keyfile}"
	echo ""
	echo "Cannot proceed."
	echo ""
	exit 1;
fi
cp ${keyfile} my_key.pub



#
#	Remove anything from the past
#
echo ''
echo '** Remove any old containers or images.'
echo "$" docker stop ${CONTAINER_NAME}
         docker stop ${CONTAINER_NAME}
echo "$" docker rm ${CONTAINER_NAME}
         docker rm ${CONTAINER_NAME}
#echo "$" docker rmi -f ${IMAGE_NAME}
#         docker rmi -f ${IMAGE_NAME}


#
#	Do the Docker build
#
#
echo ''
echo '** Build a new Docker image'
echo "$" docker build -t ${IMAGE_NAME} .
         docker build -t ${IMAGE_NAME} .
[ $? != 0 ] && exit $?



# Successful update
echo ""
echo "** Complete."
echo ""
echo "        Image: ${IMAGE_NAME}"
echo ""
exit 0
