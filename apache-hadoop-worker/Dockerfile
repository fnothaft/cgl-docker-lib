FROM computationalgenomicslab/apache-hadoop-common:2.6.2

###
# Much of this is lifted from
# https://github.com/sequenceiq/hadoop-docker/tree/2.6.0/ and
# https://github.com/lresende/docker-yarn-cluster/ with modifications that are
# appropriate for our use case.
###
MAINTAINER Frank Austin Nothaft, fnothaft@berkeley.edu

# add script to start hadoop daemons
ADD start-worker.sh .

# expose datanode ports
EXPOSE 50010 50020 50075 50475

# expose nodemanager ports
EXPOSE 8040-8042 8044

# expose spark worker ports
EXPOSE 7078 18081

ENTRYPOINT ["bash", "+x", "start-worker.sh"]
