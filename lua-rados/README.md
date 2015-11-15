Wraps a given zlog codebase in a container. When launched, it brings up Ceph with zlog. We also use the same image for the client by changing the entrypoint. The technical steps for this image are:

1. installs the ceph master branch
2. pulls zlog ceph tree and the zlog source
2. builds zlog OSD libraries against the zlog ceph tree
4. builds zlog servers and clients
5. adds zlog object interface plugins to the OSDs

===================================================
Quickstart
===================================================

Build zlog, launch Ceph with zlog, start a sequencer:

    docker run -d \
        --name=zlogdev-build \
        --net=host \
        --volume=/etc/ceph:/etc/ceph \
        -e CEPH_NETWORK=127.0.0.1/24 \
        -e MON_IP=127.0.0.1 \
        michaelsevilla/zlogdev-build
    
Run the zlog tests:

    docker run --rm \
        --name=zlog-client \
        --net=host \
        --volume /etc/ceph:/etc/ceph \
        --entrypoint=/src/zlog/src/test \
        michaelsevilla/zlogdev-build
