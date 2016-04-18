Provides all the dependencies for building Mantle. Assuming the source 
tree for ceph is in the host machine at `/path/to/mantlesrc`, the 
following will build Mantle:

```bash
docker run -v /path/to/mantlesrc:/ceph/ michaelsevilla/mantledev-build
```
# References:

This is identical to [cephdev-build][cephdev-build], except that we explicitly
add the proper Lua libraries and linker flags for the Ceph configure.

[cephdev-build]: https://github.com/ivotron/docker-cephdev/tree/master/build

