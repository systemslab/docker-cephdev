These Docker images run ZLog and its client. For the Ceph image, the technical
steps are:

1. installs the ceph jewel release
2. pulls zlog ceph tree and the zlog source
2. builds zlog OSD libraries against the zlog ceph tree
4. builds zlog servers and clients
5. adds zlog object interface plugins to the OSDs

===================================================
Build ZLog Ceph Image
===================================================

We assume `docker-cephdev` is in `~/docker-cephdev` and some version of Ceph is
in `/tmp/ceph-zlog`.

Create the builder image:

    . ~/docker-cephdev/aliases.sh
    docker build -t zlog-ceph ~/docker-cephdev/builder-zlog/ceph

Build the actual zlog image:

    cd /tmp/ceph-zlog
    dmake \
      -e SHA1_OR_REF=remotes/noahdesu/zlog/jewel \
      -e GIT_URL=https://github.com/noahdesu/ceph.git \
      zlog-ceph

===================================================
Build ZLog Sequencer and Client Images
===================================================

After building the ZLog Ceph image: 

    docker build -t zlog/sequencer ~/docker-cephdev/builder-zlog/sequencer
    docker build -t zlog/client ~/docker-cephdev/builder-zlog/client

===================================================
Build the ZLog Client Image
===================================================
    
Tag the images and push 'em!

    docker tag zlog-ceph piha.soe.ucsc.edu:5000/zlog/ceph:jewel
    docker tag zlog/sequencer piha.soe.ucsc.edu:5000/zlog/sequencer:jewel
    docker tag zlog/client piha.soe.ucsc.edu:5000/zlog/client:jewel
    docker push piha.soe.ucsc.edu:5000/zlog/ceph:jewel
    docker push piha.soe.ucsc.edu:5000/zlog/sequencer:jewel
    docker push piha.soe.ucsc.edu:5000/zlog/client:jewel

EOF
