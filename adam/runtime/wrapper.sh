#!/bin/bash

HADOOP_PREFIX=/opt/apache-hadoop
HADOOP_CONF_DIR=${HADOOP_PREFIX}/etc/hadoop
ln -s ${HADOOP_PREFIX} /usr/local/hadoop

# overwrite hostname in conf
sed "s/HOSTNAME/${YARN_MASTER:-localhost}/g" $HADOOP_PREFIX/etc/hadoop/core-site.xml.template > $HADOOP_PREFIX/etc/hadoop/core-site.xml
sed -e "s/yarn.nodemanager.aux-services/yarn.resourcemanager.hostname/g" \
    -e "s/mapreduce_shuffle/${YARN_MASTER:-localhost}/g" \
    $HADOOP_PREFIX/etc/hadoop/yarn-site.xml.template > $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

/opt/cgl-docker-lib/adam/bin/adam-submit $@