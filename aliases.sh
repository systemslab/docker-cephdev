
build_ceph='docker run --rm -v `pwd`:/ceph'

function build_daemon {
  docker run --rm --privileged \
    -v `which docker`:/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /root/ \
    -v $1:/install \
    ivotron/cephbuilder-daemon $2
}

function run_daemon {
  docker run -d \
    --name ceph \
    --net=host \
    --entrypoint=singlenode \
    -v `pwd`/conf:/etc/ceph \
    -e MON_IP=$1 \
    -e CEPH_NETWORK=$2 \
    $3
}
