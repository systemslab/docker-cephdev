# TODO:
#  * add way of identifying cephbuilder image tag based on HEAD
#  * if no args given, select ivotron/cephbuilder:jewel
function dmake {
  docker_path=$(which docker)
  libltdl_path=$(ldd /usr/bin/docker | grep libltdl | awk '{print $3}')

  if [ -n "$libltdl_path" ] ; then
    libltdl_path="--volume $libltdl_path:/usr/lib/$(basename $libltdl_path)"
  fi

  docker run --rm $libtdl_path \
    -v `which docker`:/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v `pwd`:/ceph "$@"
}

# TODO: figure out how to get networking stuff
function dstart {
  docker run -d \
    --name ceph \
    --net=host \
    --entrypoint=singlenode \
    -v `pwd`/conf:/etc/ceph \
    -e MON_IP=$1 \
    -e CEPH_NETWORK=$2 \
    $3
}
