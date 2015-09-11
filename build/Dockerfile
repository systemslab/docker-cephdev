FROM ubuntu:trusty

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

RUN wget https://raw.githubusercontent.com/ceph/ceph/master/install-deps.sh && \
    wget https://raw.githubusercontent.com/ceph/ceph/master/debian/control && \
    apt-get update && apt-get install -y git && \
    chmod 755 install-deps.sh && ./install-deps.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD build /
ENTRYPOINT ["/build"]
