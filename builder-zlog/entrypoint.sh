#!/bin/bash
set -e
set -x

. build-common

if [ "$RECONFIGURE" = "true" ] || [ "$CLEAN" = "true" ] ; then
  ./autogen.sh
  autoconf || true
  ./configure --prefix=/usr $CONFIGURE_FLAGS
fi

cd src/
make -j$BUILD_THREADS libcls_zlog.la
make -j$BUILD_THREADS libcls_zlog_client.la
cd /ceph
cp --parents .libs/libcls_zlog.so install/usr/lib/rados-classes/
cp --parents .libs/libcls_zlog_client.* install/usr/lib/
cp --parents cls/zlog_bench/cls_zlog_client.h install/usr/include/rados/

export CEPH_INSTALL_PATH=/ceph/install
. generate_daemon_image

exit 0
