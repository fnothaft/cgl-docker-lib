This image is for Apache Spark's 1.5.2 stable release. This image is built for
the worker node. The difference between this image and the [master
images](../apache-spark-master/README.md) is strictly the command that is run
on startup. This image calls the command to start a Spark standalone worker,
and should be called with the IP address of the master node.

The following ports should be opened:

* 7075: This is the port that the worker listens for commands from the master on.

How to run:
===

An example command is:

```
docker run \
       -p 7075:7075 \
       -e SPARK_MASTER_IP=<spark master IP>:7077 \ 
       -d \
       --net=host \
       computationalgenomicslab/apache-spark-worker:1.5.2 \
       <spark_master_ip>:7077
```