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
RUN apt-get install -y ruby1.9.1
#RUN apt-get install -y curl vim wget

# Install ToolTwist CLI
RUN npm install -g tooltwist

# create user tooltwist
RUN adduser --shell /bin/bash --disabled-password --gecos "ToolTwist,,," --home /home/tooltwist tooltwist
#USER tooltwist

# Get Gradle ready, and as many JARs as we can (at this stage)
ENV GRADLE_USER_HOME /home/tooltwist/.gradle
ADD getjars /tmp/getjars
RUN cd /tmp/getjars && ./gradlew --version
RUN cd /tmp/getjars && ./gradlew assemble


#
#	BELOW HERE IS APPLICATION SPECIFIC
#
#RUN mkdir /home/tooltwist/.tooltwist
RUN mkdir -p /home/tooltwist/.tooltwist/webdesign-projects
#RUN cd /home/tooltwist/.tooltwist/webdesign-projects && git clone https://github.com/tooltwist/ttdemo.git
RUN cd /home/tooltwist/.tooltwist/webdesign-projects && git clone git://www.github.com/tooltwist/ttdemo.git

#ADD server /home/tooltwist/server
#USER root
RUN chown -R tooltwist:tooltwist /home/tooltwist

# allow login
#COPY dotssh /home/tooltwist/.ssh
#RUN chmod 700 /home/tooltwist/.ssh
#RUN chmod 644 /home/tooltwist/.ssh/authorized_keys

#CMD JAVA_HOME=/usr/lib/jvm/java-7-oracle CATALINA_BASE=/var/lib/tomcat6 CATALINA_HOME=/usr/share/tomcat6 /usr/share/tomcat6/bin/catalina.sh run
#CMD CATALINA_BASE=/var/lib/tomcat7 CATALINA_HOME=/usr/share/tomcat7 /usr/share/tomcat7/bin/catalina.sh run


# Run the start script
ADD start.sh /home/tooltwist/
RUN chmod +x /home/tooltwist/start.sh
#RUN tooltwist init
#CMD tooltwist
CMD /home/tooltwist/start.sh
EXPOSE      8080
EXPOSE      5000
