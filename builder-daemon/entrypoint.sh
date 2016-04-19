#!/bin/bash
#
# usage
#
#   entrypoint.sh $image_name
set -e

if [ "$#" -ne 1 ] ; then
  echo "ERROR: expecting one argument (name of image to be generated)"
  exit 1
fi

mycid=`cat /proc/self/cgroup | grep 'docker' | sed 's/^.*\///' | tail -n1`
if [ ${#mycid} != "64" ] ; then
  echo "ERROR: cannot obtain ID of container"
  exit 1
fi
cid='dmn-1234567890-foo'
function rm_container {
  docker stop $cid &> /dev/null || true
  docker rm -f $cid &> /dev/null || true
}

if [ ! -d /install ] ; then
  echo "ERROR: expecting /install folder"
  exit 1
fi

if [ -z "$REBUILD_BASE" ] ; then
  REBUILD_BASE="false"
fi

if [ ! -d /install/base ] || [ $REBUILD_BASE = "yes" ] ; then
  rm -fr /install/base

  echo "creating base image $1-base"
  rm_container
  docker run \
    --name $cid \
    --entrypoint=/bin/bash \
    --volumes-from $mycid \
    ceph/daemon -c "cp -r /install/* / && cp /root/singlenode /bin/singlenode"
  docker commit $cid $1-base &> /dev/null
  rm_container

  echo "creating base folder to obtain deltas"
  mkdir -p /install/base
  rsync -a /install/ /install/base
  rm -fr /install/base/base

  docker tag $1-base $1
  echo "created image $1"
  exit 0
fi

# get the delta
delta=`rsync -ani --exclude=base --out-format='%n' /install/ /install/base`
delta=`echo $delta | sed 's/.\///'`
if [ "$delta" = "" ]; then
  echo "Couldn't detect any files changed. Finishing"
  exit 0
fi
printf "creating image $1 with new files: \n$delta\n"
delta=`echo $delta | tr '\n' ' '`
rm_container
docker run \
  --name $cid \
  --entrypoint=/bin/bash \
  --volumes-from $mycid \
  $1-base -c "cd /install && cp --parents $delta /"
docker commit $cid $1 &> /dev/null
rm_container
echo "created image $1"
exit 0
