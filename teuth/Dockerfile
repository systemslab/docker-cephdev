FROM tutum/ubuntu:trusty

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

# install deps
RUN wget https://raw.githubusercontent.com/ceph/ceph/master/install-deps.sh && \
    wget https://raw.githubusercontent.com/ceph/ceph/master/debian/control && \
    mkdir debian && mv control debian && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y git libopenmpi-dev openmpi-bin lttng-tools libluajit-5.1-dev collectl && \
    chmod 755 install-deps.sh && ./install-deps.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /debian

RUN mkdir /mdtest && cd /mdtest  && \
    wget http://sourceforge.net/projects/mdtest/files/latest/download && tar xzvf download && \
    sed -i s/"CC = \$(CC.\$(OS))"/"CC = mpicc"/g Makefile && \ 
    make

ENV PATH /mdtest/:$PATH

# * modify sshd conf
# * workaround for the way ubuntu deals with env for sudo
# * add /ceph to PATH
# * create expected dirs/links
RUN sed -i "s/UsePAM.*/UsePAM yes/" /etc/ssh/sshd_config && \
    echo "PATH=/ceph/src:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/ceph/bin" > /etc/environment && \
    echo "alias sudo='sudo env PATH=\$PATH'" >> /etc/environment && \
    sed -i "s/Defaults.*env_reset//" /etc/sudoers && \
    sed -i "s/Defaults.*secure_path.*//" /etc/sudoers && \
    mkdir /var/log/ceph && mkdir /etc/ceph && \
    mkdir /usr/local/lib/ceph && ln -s /ceph/src/.libs /usr/local/lib/ceph/erasure-code

ENV PATH /ceph/src/:$PATH

# override tutum's run.sh with our own
ADD run.sh /run.sh
COPY standalone.sh /standalone.sh
