FROM ubuntu

RUN apt-get update && apt-get install -y git build-essential zlib1g-dev

# clone snap
WORKDIR /opt/
RUN git clone https://github.com/amplab/snap.git
WORKDIR /opt/snap
RUN git checkout 48e7ae5d38145c094af1fe42a4b3abf1e72e1bb7

# build snap
WORKDIR /opt/snap/
RUN make

ENTRYPOINT ["/opt/snap/snap-aligner"]