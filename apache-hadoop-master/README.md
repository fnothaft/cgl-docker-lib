What is this container?
===

This container builds the "master" node for Hadoop 2.6.2 YARN. Technically, we actually build two nodes:

* The Namenode: This is the node that controls HDFS.
* The ResourceManager: This is the node that controls job scheduling for YARN.

This container inherits from the computationalgenomicslab/apache-hadoop-common:2.6.2 container.

How to run
===

You can run this container with the command:

```
docker run \
  -p 50010:50010 \
  -p 50020:50020 \
  -p 50070:50070 \
  -p 50075:50075 \
  -p 50090:50090 \
  -p 8030-8033:8030-8033 \
  -p 8040:8040 \
  -p 8042:8042 \
  -p 8088:8088 \
  --net=host \
  computationalgenomicslab/apache-hadoop-master:2.6.2
```