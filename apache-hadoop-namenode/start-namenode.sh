#!/bin/bash

HADOOP_PREFIX=/opt/apache-hadoop
HADOOP_CONF_DIR=${HADOOP_PREFIX}/etc/hadoop

# set up the environment
$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# start sshd
service sshd start

# format the namenode; option is the cluster name
$HADOOP_PREFIX/bin/hdfs namenode -format $1

# start the namenode daemon
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode

# follow some logs forever
tail -f /opt/apache-hadoop/logs/*