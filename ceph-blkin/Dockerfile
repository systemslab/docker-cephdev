FROM ivotron/cephdev-build:latest

MAINTAINER Trivikram Bollempalli <tbollemp@ucsc.edu>

RUN apt-get update && \
    apt-get install -y libedit-dev && \
    sudo apt-get -y install lttng-tools && \
    sudo apt-get -y install lttng-modules-dkms && \
    sudo apt-get -y install liblttng-ust-dev && \
    git clone https://github.com/linuxbox2/blkin.git && \
    cd blkin/blkin-lib/ && \
    sudo make && sudo make install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/

ENV BLKIN_CFLAGS=-I/usr/local/include/
ENV BLKIN_LIBS=-lblkin
ENV LD_LIBRARY_PATH=/usr/local/lib

ADD build /
RUN chmod 755 /build
ENTRYPOINT ["/build"]
