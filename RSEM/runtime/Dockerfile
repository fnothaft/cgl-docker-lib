FROM ubuntu:14.04

MAINTAINER Aashish Jain, 17AashishJ@students.harker.org

# perl needed to run rsem 
RUN apt-get -y update && apt-get -y install perl

# Copy over files and place in /opt/cgl-docker-lib
RUN mkdir /RSEM
RUN mkdir /opt/cgl-docker-lib 
ADD RSEM /RSEM

RUN mv RSEM /opt/cgl-docker-lib

RUN mkdir /data
WORKDIR /data

ENV PATH /opt/cgl-docker-lib/RSEM:${PATH}

ENTRYPOINT ["rsem-calculate-expression"]