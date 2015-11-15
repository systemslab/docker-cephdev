Provides all the dependencies for building Lua-RADOS bindings. Assuming 
the source tree for ceph is in the host machine at `/path/to/cephsrc`, 
the following will build the bindings.

```bash
docker run --rm -it -v /path/to/cephsrc:/ceph michaelsevilla/lua-rados-build
```
# References:

This is identical to [cephdev-build][cephdev-build], except that we explicitly
add the proper Lua libraries and linker flags for the Ceph configure.

[cephdev-build]: https://github.com/ivotron/docker-cephdev/tree/master/build

