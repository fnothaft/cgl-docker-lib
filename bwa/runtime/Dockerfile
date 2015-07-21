FROM ubuntu

MAINTAINER Parth Pendurkar, 17parthp@students.harker.org

# zlib1g-dev needed to build the bwa binary
RUN apt-get update && apt-get install -y zlib1g-dev

# copy executable file and place in /opt/bwaexec
RUN mkdir /opt/cgl-docker-lib
ADD bwa /
RUN cp bwa /opt/cgl-docker-lib

# Set WORKDIR to /data -- predefined mount location.
RUN mkdir /data
WORKDIR /data

ENV PATH /opt/cgl-docker-lib:${PATH}

ENTRYPOINT ["bwa"]
