FROM debian:jessie

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV REF="jewel"

# install deps
RUN apt-get update && apt-get install -y wget && \
    wget https://raw.githubusercontent.com/ceph/ceph/$REF/install-deps.sh && \
    wget https://raw.githubusercontent.com/ceph/ceph/$REF/debian/control && \
    mkdir debian && mv control debian && \
    apt-get update && \
    apt-get install -y git ccache && \
    chmod 755 install-deps.sh && ./install-deps.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/
ADD scripts/* /usr/bin/
WORKDIR /ceph
