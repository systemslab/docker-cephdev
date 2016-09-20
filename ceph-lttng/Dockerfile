FROM ceph-heads/remotes/origin/mds-reqlatency

RUN apt-get update && apt-get install -y lttng-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/
