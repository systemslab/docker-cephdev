FROM tutum/ubuntu:trusty

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

RUN apt-get update && \
    apt-get build-dep -yq ceph && \
    apt-get install -yq \
       git libudev-dev ccache python-virtualenv xmlstarlet && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "PATH=/ceph/src:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" > /etc/environment && \
    echo "alias sudo='sudo env PATH=\$PATH'" >> /etc/environment && \
    mkdir /var/log/ceph && mkdir /etc/ceph && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config && \
    sed -i "s/Defaults.*env_reset//g" /etc/sudoers && \
    sed -i "s/Defaults.*secure_path.*//g" /etc/sudoers && \
    mkdir /usr/local/lib/ceph && ln -s /ceph/src/.libs /usr/local/lib/ceph/erasure-code
