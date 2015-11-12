#!/bin/bash


echo -n "2" > /tmp/balancer_state
for WHOAMI in 0 1 2; do
    SET="ceph --admin-daemon /var/run/ceph/ceph-mds.$WHOAMI.asok config set"

    # Debugging
    $SET debug_mds 0
    $SET debug_mds_migrator 0
    $SET debug_mds_balancer 2
    $SET mds_bal_debug_dfs 10
    $SET mds_bal_debug_dfs_metaload 0.5
    $SET mds_bal_debug_dfs_depth 4
    
    # Configuration parameters (i.e. tunables)
    $SET mds_bal_lua 1
    $SET mds_log true
    $SET mds_bal_need_min 0.98
    $SET mds_bal_split_size 50000
    $SET ms_async_op_threads 0
    $SET mds_bal_frag 1
    $SET mds_cache_size 0
    $SET client_cache_size 0
    $SET mds_bal_dir "/ceph/src/mds/libmantle/"
   
    # Set balancer 
    $SET mds_bal_metaload "IWR"
    $SET mds_bal_mdsload "MDSs[i][\"all\"]"
    $SET mds_bal_when "if_MDSs[whoami][\"load\"]>.01_and_MDSs[whoami+1][\"load\"]<0.01_then"
    $SET mds_bal_where "targets[t]=MDSs[whoami][\"load\"]/2"
    $SET mds_bal_howmuch "{\"half\"}"
done
