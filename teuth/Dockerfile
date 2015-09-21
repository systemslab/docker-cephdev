FROM tutum/ubuntu:trusty

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

# install deps
RUN wget https://raw.githubusercontent.com/ceph/ceph/master/install-deps.sh && \
    wget https://raw.githubusercontent.com/ceph/ceph/master/debian/control && \
    mkdir debian && mv control debian && \
    apt-get update && apt-get install -y git && \
    chmod 755 install-deps.sh && ./install-deps.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /debian

# * modify sshd conf
# * workaround for the way ubuntu deals with env for sudo
# * add /ceph to PATH
# * create expected dirs/links
RUN sed -i "s/UsePAM.*/UsePAM yes/" /etc/ssh/sshd_config && \
    echo "PATH=/ceph/src:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" > /etc/environment && \
    echo "alias sudo='sudo env PATH=\$PATH'" >> /etc/environment && \
    sed -i "s/Defaults.*env_reset//" /etc/sudoers && \
    sed -i "s/Defaults.*secure_path.*//" /etc/sudoers && \
    mkdir /var/log/ceph && mkdir /etc/ceph && \
    mkdir /usr/local/lib/ceph && ln -s /ceph/src/.libs /usr/local/lib/ceph/erasure-code

# add our run.sh
ADD run.sh /run.sh
RUN chmod 755 /run.sh

WORKDIR /ceph
