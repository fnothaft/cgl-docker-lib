#!/bin/bash

HADOOP_PREFIX=/opt/apache-hadoop
HADOOP_CONF_DIR=${HADOOP_PREFIX}/etc/hadoop
ln -s ${HADOOP_PREFIX} /usr/local/hadoop

# overwrite hostname in conf
if [ $# -ne 0 ]; then
    sed "s/HOSTNAME/${1}/g" $HADOOP_PREFIX/etc/hadoop/core-site.xml.template > $HADOOP_PREFIX/etc/hadoop/core-site.xml
else
    sed "s/HOSTNAME/localhost/g" $HADOOP_PREFIX/etc/hadoop/core-site.xml.template > $HADOOP_PREFIX/etc/hadoop/core-site.xml    
fi

# set up the environment
$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# start sshd
service ssh start

# format the namenode; option is the cluster name
$HADOOP_PREFIX/bin/hdfs namenode -format $1

# start the namenode daemon
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode

# start the resource manager
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager

# start the proxy server
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR

# start the job history server
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR

# follow some logs forever
tail -f /opt/apache-hadoop/logs/*