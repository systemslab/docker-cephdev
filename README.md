# Ceph Development in Docker

Generate Docker images with customized versions of Ceph. The general 
procedure is the following:

 1. Build the Ceph code base using any builder image.
 2. Pack a new `ceph-daemon` image.
 3. Deploy the image using the official 
    [`ceph-ansible`](https://github.com/ceph/ceph-ansible) playbooks.

# Builders

Every builder image is in a `builder-*` folder. By convention, a 
builder image generates an install directory on the host that is later 
used to generate an ansible-deployable image (see below). For examples 
of this, see existing builders. Currently, we have builders for:

 * [vanilla Ceph](builder-base)
 * [Mantle](builder-mantle)
 * [zlog](builder-zlog)
 * [lua-rados](builder-luarados)
 * [blkin](builder-blkin)

# Generate a Deployable Docker Image

The [`build_daemon_image`](./generate_daemon) script generates a 
deployable docker image by taking an installation folder an adding its 
contents on top of the official 
[`ceph-daemon`](https://github.com/ceph-docker/) base image:

```bash
./build_daemon_image /path/to/ceph/install/dir repo/image:tag
```

Where the files in the `install/` should be in the usual `/bin`, 
`/lib`, etc. directories. For example:

```bash
./build `pwd`/install/usr/local ivotron/ceph-daemon:jewel
```

The above produces the image `ivotron/ceph-daemon:jewel`. This image 
can be used with the official 
[`ceph-ansible`](https://github.com/ceph/ceph-ansible) playbooks.

For more details, see [this wiki 
page](https://github.com/ivotron/wiki).

# Motivation

In the context of our Popper convention, we need something that is 
end-to-end reproducible. For the same reasons, we would like to have a 
local dev environment that is _not_ based on `vstart.sh`. With the 
approach that we take to create ceph-daemon images, we can leverage 
the `ceph-demo` image to test locally.

# Example

**TODO**: show an example of how to create a new custom docker image
