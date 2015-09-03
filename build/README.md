Provides all the dependencies for building ceph. Assuming the source 
tree for ceph is in the host machine at `/path/to/cephsrc`:

```bash
docker run --rm -ti -v /path/to/cephsrc:/cephsrc ivotron/cephdev-build
```

Inside the container:

```bash
cd /cephsrc
./autogen.sh
./configure \
  --disable-static --with-debug \
  CC='ccache gcc' CFLAGS="-Wall -g" \
  CXX='ccache g++' CXXFLAGS="-Wall -g"
make -j4
make check
```

