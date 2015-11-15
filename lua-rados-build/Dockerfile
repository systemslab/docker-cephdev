FROM ivotron/cephdev-build:latest

MAINTAINER Michael Sevilla <mikesevilla3@gmail.com>

# install deps
RUN apt-get update && \
    apt-get install -y lua5.1 lua5.1-dev luarocks && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/

RUN luarocks install lua-messagepack

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



COPY build /
ADD run.sh /
RUN chmod 755 /build /run.sh
ENV CXXFLAGS "-std=c++11"
ENV LD_LIBRARY_PATH "/usr/local/lib"
ENV PATH /ceph/src/:$PATH
ENTRYPOINT ["/build"]

#CPPFLAGS="-I/ceph/src/include"  LIBS="-L/ceph/src/.libs/" ./configure 

