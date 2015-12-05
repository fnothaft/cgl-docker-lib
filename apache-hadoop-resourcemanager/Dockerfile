FROM computationalgenomicslab/apache-hadoop-common:2.6.2

###
# Much of this is lifted from
# https://github.com/sequenceiq/hadoop-docker/tree/2.6.0/ and
# https://github.com/lresende/docker-yarn-cluster/ with modifications that are
# appropriate for our use case.
###
MAINTAINER Frank Austin Nothaft, fnothaft@berkeley.edu

# add script to start hadoop daemons
ADD start-resourcemanager.sh .

# expose yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088

ENTRYPOINT ["bash", "+x", "start-resourcemanager.sh"]
