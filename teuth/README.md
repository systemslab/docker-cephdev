Wraps a given Ceph codebase in a container that can be seen as
a [teuthology] remote (a.k.a. [test node][framework]). This is 
basically build dependencies, plus an `sshd`, plus environment setup 
so that (1) teuthology can communicate with the container via SSH and 
(2) binaries built from source are in the `PATH`.

Quickstart:

 1. Write a file containing an entire teuthology job (tasks, targets 
    and roles in a YAML file):

    ```yaml
    sshkeys: ignore
    roles:
    - [mon.0, osd.0, osd.1, osd.2, client.0]
    tasks:
    - install.ship_utilities:
    - ceph:
        conf:
          mon:
            debug mon: 20
            debug ms: 1
            debug paxos: 20
          osd:
            debug filestore: 20
            debug journal: 20
            debug ms: 1
            debug osd: 20
    - radosbench:
        clients: [client.0]
    targets:
      'root@localhost:2222': ssh-dss ignored
    ```

    The `sshkeys` option is required and `install.ship_utilities` 
    should be the first task to execute. Also, `~/.teuthology.yaml` 
    should look like this:

    ```yaml
    lab_domain: ''
    lock_server: ''
    ```

 2. Initialize a [`cephdev`][cdev] container (the following assumes 
    `$PWD` is the folder containing the ceph code in your machine):

    ```bash
    docker run \
      --name remote0
      -p 2222:22
      -d -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" \
      -v `pwd`:/ceph \
      -v /dev:/dev \
      -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
      --cap-add=SYS_ADMIN --privileged \
      --device /dev/fuse
      ivotron/cephdev
    ```

 3. Execute teuthology using the `wip-11892-docker` branch:

    ```bash
    teuthology \
      -a ~/archive/`date +%s` \
      --suite-path /path/to/ceph-qa-suite/ \
      ~/test.yml
    ```

[teuthology]: http://github.com/ceph/teuthology
[cdev]: https://github.com/ivotron/docker-cephdev
[framework]: https://github.com/ceph/teuthology/blob/e5bdf368d5c802a40a8a82cae806fcc89ec12734/docs/COMPONENTS.rst
