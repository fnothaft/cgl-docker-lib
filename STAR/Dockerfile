FROM ubuntu

MAINTAINER Aashish Jain, 17AashishJ@students.harker.org

RUN apt-get update -y && apt-get upgrade -y && apt-get -y install git make g++ zlib1g-dev

RUN git clone https://github.com/alexdobin/STAR.git

WORKDIR STAR
WORKDIR source
RUN make