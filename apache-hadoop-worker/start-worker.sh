#!/bin/bash

HADOOP_PREFIX=/opt/apache-hadoop
HADOOP_CONF_DIR=${HADOOP_PREFIX}/etc/hadoop

# set up the environment
$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# start sshd
service sshd start

# start the datanode daemon
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start datanode

# start the nodemanager daemon
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start nodemanager

# follow some logs forever
tail -f /opt/apache-hadoop/logs/*