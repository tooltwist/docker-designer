FROM dockerfile/nodejs
MAINTAINER Philip Callender <philip.callender@tooltwist.com>

# install some packages
RUN apt-get update && apt-get install -y openssh-server
#RUN apt-get install -q -y openjdk-7-jre-headless openjdk-7-jdk
#RUN apt-get install -q -y openjdk-7-jre-headless openjdk-7-jdk
RUN apt-get install -q -y openjdk-7-jdk
RUN apt-get install -y imagemagick
RUN apt-get install -y tomcat7
RUN apt-get install -y nodejs npm
RUN apt-get install -y git git-core
#RUN apt-get install -y curl vim wget

# Install ToolTwist CLI
RUN npm install -g tooltwist

# Get Gradle ready, and as many JARs as we can (at this stage)
ADD getjars /tmp/getjars
RUN cd /tmp/getjars && ./gradlew


#
#	BELOW HERE IS APPLICATION SPECIFIC
#
RUN echo 5
# create user tooltwist
RUN adduser --shell /bin/bash --disabled-password --gecos "ToolTwist,,," --home /home/tooltwist tooltwist
USER tooltwist

RUN mkdir /tmp/zeTmp
RUN ls -la /tmp
#RUN pwd
#RUN mkdir xyz
#RUN ls -la
#RUN mkdir /home/tooltwist/.tooltwist
RUN mkdir -p /home/tooltwist/.tooltwist/webdesign-projects
RUN cd /home/tooltwist/.tooltwist/webdesign-projects && git clone https://github.com/tooltwist/ttdemo.git

#RUN find /home -type f

#USER tooltwist

#ADD server /home/tooltwist/server
RUN chown -R tooltwist:tooltwist /home/tooltwist

# allow login
#COPY dotssh /home/tooltwist/.ssh
#RUN chmod 700 /home/tooltwist/.ssh
#RUN chmod 644 /home/tooltwist/.ssh/authorized_keys

#CMD JAVA_HOME=/usr/lib/jvm/java-7-oracle CATALINA_BASE=/var/lib/tomcat6 CATALINA_HOME=/usr/share/tomcat6 /usr/share/tomcat6/bin/catalina.sh run
#CMD CATALINA_BASE=/var/lib/tomcat7 CATALINA_HOME=/usr/share/tomcat7 /usr/share/tomcat7/bin/catalina.sh run


# Run the start script
USER root
ADD start.sh /home/tooltwist/
RUN chmod +x /home/tooltwist/start.sh
#RUN tooltwist init
#CMD tooltwist
CMD /home/tooltwist/start.sh
EXPOSE      8080
