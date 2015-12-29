FROM computationalgenomicslab/spark-and-maven:1.5.2.3.3.3-build

MAINTAINER Frank Austin Nothaft, fnothaft@berkeley.edu

WORKDIR /home

# git: i ain't got time for this shit
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"

# clone adam
RUN git clone https://github.com/bigdatagenomics/adam.git

# build adam
WORKDIR /home/adam
RUN git pull --commit https://github.com/fnothaft/adam.git ssf-plus-599
RUN /opt/apache-maven-3.3.3/bin/mvn package -DskipTests
