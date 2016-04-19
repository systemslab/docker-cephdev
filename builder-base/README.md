Provides all the dependencies for building ceph. Assuming the source 
tree for Ceph is in the host machine at `/path/to/cephsrc`, the 
following will build Ceph:

```bash
cd /path/to/cephsrc
docker run --rm -v `pwd`:/ceph ivotron/cephbuilder:jewel build-cmake
```

Our goal is to have multiple images, one for each stable version of 
Ceph: `hammer`, `infernalis` and `jewel`.

The [`scripts`](scripts) folder contains convenience bash scripts 
(inspired by the 
[`autobuild-ceph`](https://github.com/ceph/autobuild-ceph) repo) to 
ceph in multiple ways.
