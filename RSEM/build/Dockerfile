FROM ubuntu:14.04

MAINTAINER Aashish Jain, 17AashishJ@students.harker.org

RUN apt-get update -y && apt-get -y install build-essential perl r-base wget unzip make git
RUN gcc -v 
RUN make -v

RUN wget "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.5/bowtie2-2.2.5-source.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2F&ts=1436215864&use_mirror=iweb" -O bowtie.zip
RUN unzip bowtie.zip

WORKDIR /bowtie2-2.2.5
RUN make
WORKDIR /
RUN git clone https://github.com/deweylab/RSEM.git
WORKDIR RSEM
RUN make
WORKDIR /

#Cleaning up
RUN rm -rf bowtie.zip bowtie2-2.2.5



