Provides all the dependencies for building ceph. Assuming the source 
tree for ceph is in the host machine at `/path/to/cephsrc`, the 
following will build ceph:

```bash
docker run --rm -ti -v /path/to/cephsrc:/ceph ivotron/cephdev-build
```

See the [build](build) entry point script for a list of the commands 
that get invoked.

# Variables

## Make threads

The `BUILD_THREADS` environment variable specifies the number passed 
to `make`'s `-j` flag (defaults to 4).

## Configure options

The `CEPH_PKGS` environment variable specifies extra packages that 
Ceph should be compiled with. For example, `CEPH_PKGS="--with-lttng"`
compiles Ceph with LTTnG. To see a list of options, go to a Ceph repo 
and run `./configure --help`. 

## Building from a specific `SHA1` or `REF`

If the environment variable `SHA1_OR_REF` is given, the source code 
will be checked out and placed in the container's filesystem. For 
example:

```bash
docker run \
  --name infernalis-build \
  --env SHA1_OR_REF="infernalis" \
  --env CEPH_PKGS="--with-lttng" \
  --env BUILD_THREADS=16 \
  ivotron/cephdev-build
```

The above clones the repo, resets it `infernalis` and compiles the 
code. A `sha1` can be given too. As mentioned, the above will place 
the source code inside the container. Alternatively, if the `/ceph` 
folder is mounted in the container, the `build` script assumes it is 
holding a ceph's git working directory and doesn't clone it, it just 
checks out the version specified in `$SHA_OR_REF` (**WARNING**: in 
order to avoid issues, the script executes `git clean -fd`)

## Custom git URL

The `GIT_URL` variable specifies the repo where the ceph codebase is 
pulled from. The default value is `https://github.com/ceph/ceph`.
