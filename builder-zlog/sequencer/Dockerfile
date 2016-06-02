FROM ivotron/cephbuilder:jewel

ARG DEBIAN_FRONTEND=noninteractive
RUN echo deb http://gitbuilder.ceph.com/ceph-deb-$(lsb_release -sc)-x86_64-basic/ref/jewel $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list && \
    apt-get update && \
    apt-get install --force-yes -y \
      protobuf-compiler \
      libprotobuf-dev \
      librados-dev \
      g++ \
      libboost-system-dev \
      libboost-program-options-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
