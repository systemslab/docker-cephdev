Provides all the dependencies for building Mantle. Assuming the source 
tree for ceph is in the host machine at `/path/to/cephsrc`, the 
following will build ceph:

```bash
docker run --rm -ti /path/to/cephsrc:/ceph michaelsevilla/mantledev-build
```
# References:

This is identical to [cephdev-build][cephdev-build], except that we explicitly
add the proper Lua libraries and linker flags for the Ceph configure.

[cephdev-build]: https://github.com/ivotron/docker-cephdev/tree/master/build

