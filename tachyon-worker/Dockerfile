FROM ubuntu

MAINTAINER Frank Austin Nothaft, fnothaft@berkeley.edu

RUN apt-get update && \
  apt-get install -y python libnss3 openjdk-7-jdk wget ssh

# download and unpack archive
RUN wget http://tachyon-project.org/downloads/files/0.8.2/tachyon-0.8.2-bin.tar.gz
RUN tar xzvf tachyon-0.8.2-bin.tar.gz
RUN mv tachyon-0.8.2 /opt/tachyon

# set java home
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

# copy setup script
COPY start-tachyon-worker.sh .

# set entrypoint
ENTRYPOINT ["bash", "-x", "./start-tachyon-worker.sh"]