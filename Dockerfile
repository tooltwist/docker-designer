#
#	Setup a blank tooltwist server, based on phusion/baseimage.
#
#FROM phusion/baseimage:0.9.13
FROM phusion/baseimage:latest

# Set correct environment variables.
ENV HOME /root

# ...put your own build instructions here...
USER root
RUN apt-get update
RUN apt-get install -q -y openjdk-7-jdk
RUN apt-get install -q -y imagemagick
RUN apt-get install -q -y nodejs npm nodejs-legacy
RUN apt-get install -q -y build-essential
RUN apt-get install -q -y git git-core
RUN apt-get install -q -y ruby1.9.1
#RUN apt-get install -q -y openjdk-7-jre-headless openjdk-7-jdk
#RUN apt-get install -y tomcat7
#RUN apt-get install -y curl vim wget

# Install ToolTwist CLI
RUN npm install -g tooltwist

## create user tooltwist
#RUN adduser --shell /bin/bash --disabled-password --gecos "ToolTwist,,," --home /home/tooltwist tooltwist

# Make Gradle run faster later by getting JARs downloaded as we can (at this stage)
ENV GRADLE_USER_HOME /gradle
ADD getjars /tmp/getjars
RUN cd /tmp/getjars && ./gradlew --version && ./gradlew assemble && rm -rf /tmp/getjars

# Install an SSH of your choice for the root user.
ADD my_key.pub /tmp/my_key.pub
RUN cat /tmp/my_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/my_key.pub

# Prepare SSH
# Note: I could not get SSH into the tooltwist account to work. We've have to be
# happy with root access, but that should be ok as it's only for rare debug purposes..
#ADD resources/authorized_keys /home/tooltwist/.ssh/
#RUN chmod 700 /home/tooltwist/.ssh
#RUN chmod 644 /home/tooltwist/.ssh/authorized_keys

## Environment variables for user tooltwist
#ADD resources/tooltwist_rc /home/tooltwist/.tooltwist_rc
#RUN echo ". ~/.tooltwist_rc" >> /home/tooltwist/.profile 
#
#RUN chown -R tooltwist:tooltwist /home/tooltwist

## Add a nice startup message for root
##RUN echo 'echo ""'
##RUN echo 'echo ""'
##RUN echo 'echo "    Please switch to the tooltwist user:"'
##RUN echo 'echo ""'
##RUN echo 'echo "    $ su - tooltwist"'
##RUN echo 'echo ""'

#RUN echo 'echo ""' >> /root/.profile
#RUN echo 'echo -n "    Switch to user tooltwist [Y/n]?"' >> /root/.profile
#RUN echo 'read ans; echo ""; [ "${ans}" == "" -o "${ans}" == "y" -o "${ans}" == "Y" ] && echo "$ su - tooltwist" && echo "" #&& exec su - tooltwist' >> /root/.profile

# Default tooltwist.js
ADD resources/default_tooltwist.js /root/default_tooltwist.js

# Add a startup script for ToolTwist
# See https://github.com/phusion/baseimage-docker#running-scripts-during-container-startup
RUN mkdir -p /etc/my_init.d
ADD resources/start_tooltwist.sh /etc/my_init.d/start_tooltwist.sh
RUN chmod +x /etc/my_init.d/start_tooltwist.sh
ADD resources/start_tooltwist.sh /root/start_tooltwist.sh
#RUN chmod +x /root/start_tooltwist.sh

# Allow access to the ToolTwist server from the outside
EXPOSE 5000

## Add a function used by DotCI to update packages for the version specified in .ci.yml
#RUN echo 'function install_packages { echo ZZZZZ install_packages "$@" ; }' >> /root/.bashrc

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Enable SSH (baseimage disables SSH by default)
RUN rm -f /etc/service/sshd/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
