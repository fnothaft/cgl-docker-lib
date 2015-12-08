What is this container?
===

This container builds a worker node for Hadoop 2.6.2 YARN. This node runs two services:

* A Datanode: This is an HDFS node where data is stored.
* A NodeManager: This is an executor who can run YARN jobs.

This container inherits from the computationalgenomicslab/apache-hadoop-common:2.6.2 container.

How to run
===

You can run this container with the command:

```
docker run \
  -p 50010:50010 \
  -p 50020:50020 \
  -p 50075:50075 \
  -p 50475:50475 \
  -p 8040-8042:8040-8042 \
  -p 8044:8044 \
  -p 7078:7078 \
  -p 18081:18081 \
  --net=host \
  computationalgenomicslab/apache-hadoop-worker:2.6.2 \
  <master_ip>
```

The [master node](../apache-hadoop-master/README.md) must be started before
this node. The master node IP must be passed to the worker.