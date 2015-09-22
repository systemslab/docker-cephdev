This builds on top of the [teuthology-ready](../teuth) image in order 
to provide a way of instantiating containers that are ready to be used 
as [teuthology][t] targets (a.k.a. [test nodes][tn]). This is useful 
for analyzing/evaluating qualities of Ceph that don't require to 
recompile the code between executions. For an example of how this can 
be used, look at [this project][r], where the scalability of the 
system is evaluated.

The main difference with the base image is that instead of expecting 
the code to be provided by the host (in the `ceph/` folder), it has it 
pre-installed (via deb packages).

[t]: https://github.com/ceph/teuthology
[tn]: https://github.com/ceph/teuthology/blob/e5bdf368d5c802a40a8a82cae806fcc89ec12734/docs/COMPONENTS.rst
[r]: https://github.com/ivotron/ceph_osdi06
