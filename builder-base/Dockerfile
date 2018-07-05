FROM ubuntu:xenial
# IMPORTANT: this should be the same as the one used by ceph/daemon
#            otherwise dependencies are not going to match (e.g. libboost_threads)

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV REF="kraken"

# install deps
RUN apt-get update && apt-get install -y wget lxc ccache \
      valgrind gdb python-virtualenv gdisk kpartx hdparm jq xmlstarlet && \
    wget https://raw.githubusercontent.com/ceph/ceph/$REF/install-deps.sh && \
    wget https://raw.githubusercontent.com/ceph/ceph/$REF/debian/control && \
    mkdir debian && mv control debian && \
    chmod 755 install-deps.sh && ./install-deps.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/
ADD scripts/* /root/bin/
ENV PATH=$PATH:/root/bin
ENV IMAGE_NAME="ceph/daemon:custom"
ENV GIT_URL="https://github.com/ceph/ceph.git"
ENV SHA1_OR_REF="remotes/origin/${REF}"
ENV CONFIGURE_FLAGS="-DWITH_RDMA=OFF -DWITH_TESTS=OFF -DWITH_MANPAGE=OFF -DWITH_OPENLDAP=OFF -DWITH_FUSE=OFF -DWITH_BLUESTORE=OFF -DWITH_SPDK=OFF -DWITH_LIBCEPHFS=OFF -DWITH_KVS=OFF -DWITH_RBD=OFF -DWITH_KRBD=OFF -DWITH_RADOSGW=OFF -DWITH_RADOSGW_BEAST_FRONTEND=OFF -DWITH_RADOSGW_BEAST_OPENSSL=OFF -DWITH_CEPHFS=OFF -DWITH_MGR=OFF -DWITH_LTTNG=OFF -DWITH_BABELTRACE=OFF"
ENV RECONFIGURE="true"
ENV GENERATE_DOCKER_IMAGE="false"
RUN mkdir ceph && cd ceph && \
    export BUILD_THREADS=`grep processor /proc/cpuinfo | wc -l` && \
    build-cmake && \
    rm -rf /ceph/build/bin/* && \
    rm -rf /ceph/build/install/* && \
    rm -rf /ceph/build/lib/*
