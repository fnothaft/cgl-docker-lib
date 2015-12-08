FROM computationalgenomicslab/apache-hadoop-common:2.6.2

###
# Much of this is lifted from
# https://github.com/sequenceiq/hadoop-docker/tree/2.6.0/ and
# https://github.com/lresende/docker-yarn-cluster/ with modifications that are
# appropriate for our use case.
###
MAINTAINER Frank Austin Nothaft, fnothaft@berkeley.edu

# add script to start hadoop daemons
ADD start-master.sh .

# expose namenode ports
EXPOSE 8020 8022 50070

# expose resourcemanager ports
EXPOSE 8030-8033 8088 8090

# expose history server ports
EXPOSE 10020 10033 19888 19890

# expose spark master ports
EXPOSE 7077 18080 18088

ENTRYPOINT ["bash", "+x", "start-master.sh"]
