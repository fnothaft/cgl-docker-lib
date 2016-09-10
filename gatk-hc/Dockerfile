FROM quay.io/ucsc_cgl/gatk:3.5--dba6dae49156168a909c43330350c6161dc7ecc2

MAINTAINER Frank Austin Nothaft, fnothaft@berkeley.edu

# Copy over jar and place in /opt/cgl-docker-lib
COPY hc.sh /opt/gatk/

ENTRYPOINT ["/bin/bash", "/opt/gatk/hc.sh"]