FROM debian:jessie

RUN apt-get update && apt-get install -y rsync lxc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/
ADD singlenode /root/
ADD entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
