Provides all the dependencies for building ceph. Assuming the source 
tree for ceph is in the host machine at `/path/to/cephsrc`, the 
following will build ceph:

```bash
docker run --rm -ti -v /path/to/cephsrc:/ceph ivotron/cephdev-build
```

See the [Dockerfile](Dockerfile) for the commands that get invoked. 
The `BUILD_THREADS` environment variable specifies the number passed 
to `make`'s `-j` flag (defaults to 4).

# Building from a specific `SHA1` or `REF`

In the above example, the codebase is passed as a mount point from the 
host to the container. Alternatively, if the environment variable 
`SHA1_OR_REF` is given, the source code will be checked out and placed 
in the container's filesystem. For example:

```bash
docker run \
  --name infernalis-build \
  --env SHA1_OR_REF=infernalis \
  --env BUILD_THREADS=16
  ivotron/cephdev-build
```

The above clones the repo, resets it `infernalis` and compiles the 
code. A `sha1` can be given too.
