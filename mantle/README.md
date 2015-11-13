This image has the Lua dependencies for running Mantle. For more information,
see the [Mantle][mantle].

# Quickstart

  1. Start a container with an SSH daemon (allows you to point ceph-deploy or
     teuthology at the container):

    ```bash
    docker run -d \
      --name remote0 \
      --net=host \
      -e SSHD_PORT=2222 \
      -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" \
      -v /tmp/docker/src/mantle/ceph:/ceph \
      michaelsevilla/mantledev
    ```

  2. Log into the conatainer and start a single node Ceph instance:

    ```bash
    ssh -p 2222 root@localhost "/standalone.sh"
    ```

  3. Inject a balancing policy:
   
    ```bash
    ssh -p 2222 root@localhost "/greedy-spill.sh"
    ```

  4. Watch the magic happen:

    ```bash
    ssh -p 2222 root@localhost "tail -f /var/log/ceph/ceph-mds.0.log"
    ```

# Running experiments

To bring up a single node Mantle instance, mount the file system, and run 
metadata test, see our [infrastructure deploy tools][infra] git repo. 

[mantle]: https://systems.soe.ucsc.edu/node/731
[infra]: https://github.com/systemslab/infra.git
