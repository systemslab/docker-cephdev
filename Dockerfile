FROM tutum/ubuntu:trusty

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

RUN apt-get update && \
    apt-get build-dep -yq ceph && \
    apt-get install -yq \
       git libudev-dev ccache python-virtualenv xmlstarlet && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    echo "PATH=/ceph/src/:$PATH" >> /root/.bashrc && \
    echo "LD_LIBRARY_PATH=/ceph/src/.libs" >> /root/.bashrc && \
    echo "PYTHONPATH=/ceph/src/.pybind" >> /root/.bashrc && \
    echo "DYLD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /root/.bashrc && \
    echo "alias sudo='sudo env PATH=\$PATH'" >> /root/.bashrc && \
    mkdir /var/log/ceph && mkdir /etc/ceph
