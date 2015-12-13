# Ceph has bug: https://github.com/ceph/ceph/pull/6686
# * Use the infernalis branch instead of ivotron/cephdev-build:latest
FROM ceph/base:infernalis

MAINTAINER Michael Sevilla <mikesevilla3@gmail.com>

# install ceph infernalis branch
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --force-yes git wget ceph librados-dev lua5.1 liblua5.1-dev luarocks libssl-dev dh-autoreconf && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get the code
RUN luarocks install busted && \
    luarocks install luasec OPENSSL_LIBDIR=/lib/x86_64-linux-gnu/ && \
    git clone https://github.com/noahdesu/lua-rados.git && \
    git clone https://github.com/noahdesu/cls-lua-client.git && \
    cd lua-rados && \
    autoreconf -I m4 -ivf && \
    ./configure CPPFLAGS="-std=c++11" && \
    make

ENV LUA_CPATH=/lua-rados/.libs/rados.so
