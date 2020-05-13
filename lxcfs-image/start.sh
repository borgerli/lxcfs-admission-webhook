#!/bin/bash
#docker run -it --pid host --privileged -v /usr/local:/usr/local -v /sys/fs/cgroup:/sys/fs/cgroup -v /var/lib/lxcfs:/var/lib/lxcfs  -v /usr/lib64:/usr/lib64 lxcfs:4.0.3
# Cleanup
nsenter -m/proc/1/ns/mnt fusermount -u /var/lib/lxcfs 2> /dev/null || true
nsenter -m/proc/1/ns/mnt [ -L /etc/mtab ] || \
        sed -i "/^lxcfs \/var\/lib\/lxcfs fuse.lxcfs/d" /etc/mtab

# Prepare
mkdir -p /usr/local/lib/lxcfs /var/lib/lxcfs

# Update lxcfs
cp -f /lxcfs/lxcfs /usr/local/bin/lxcfs
cp -f /lxcfs/liblxcfs.so /usr/local/lib/lxcfs/liblxcfs.so
cp -f /lxcfs/libfuse.so.2 /lib64/libfuse.so.2
cp -f /lxcfs/libulockmgr.so.1 /lib64/libulockmgr.so.1


# Mount
exec nsenter -m/proc/1/ns/mnt /usr/local/bin/lxcfs /var/lib/lxcfs/
