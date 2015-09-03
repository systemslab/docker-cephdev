FROM ubuntu:trusty

MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

RUN sudo apt-get update && \
    sudo apt-get build-dep -yq ceph && \
    sudo apt-get install -yq \
       libudev-dev ccache python-virtualenv xmlstarlet && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
