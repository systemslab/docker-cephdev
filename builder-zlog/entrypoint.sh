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
mkdir --parents /ceph/install/usr/lib/rados-classes/
mkdir --parents /ceph/install/usr/include/rados
cp .libs/libcls_zlog.so /ceph/install/usr/lib/rados-classes/
cp .libs/libcls_zlog_client.* /ceph/install/usr/lib/
cp cls/zlog/cls_zlog_client.h /ceph/install/usr/include/rados/

cd /ceph
export CEPH_INSTALL_PATH=/ceph/install
. generate_daemon_image

exit 0
