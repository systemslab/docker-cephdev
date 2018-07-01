# TODO:
#  * add way of identifying cephbuilder image tag based on HEAD
#  * if no args given, select ivotron/cephbuilder:jewel
function dmake {
  type docker >/dev/null 2>&1 || { echo >&2 "Can't find docker command."; exit 1; }
  docker_path=""
  if [ $OSTYPE == "linux-gnu" ] ; then
    docker_path=`which docker`
    libltdl_path=`ldd $docker_path | grep libltdl | awk '{print $3}'`
      if [ -n "$libltdl_path" ] ; then
      libltdl_path="--volume $libltdl_path:/usr/lib/`basename $libltdl_path`"
      fi
  elif  [[ $OSTYPE == *"darwin"* ]]; then
    docker_path="/usr/bin/docker"
    libltdl_path=""
  else
    echo "Unrecognized OS: $OSTYPE"
    exit 1
  fi

  docker run --rm $libltdl_path \
    -v $docker_path:/usr/bin/docker \
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
