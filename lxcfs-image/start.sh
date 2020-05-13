#!/bin/bash
#docker run -it --privileged -v /var/lib/lxcfs:/var/lib/lxcfs:rshared --pid host lxcfs:4.0.3
#docker run -it -m 128m -v /var/lib/lxcfs/proc/meminfo:/proc/meminfo centos:7 free -m

exec /usr/local/bin/lxcfs /var/lib/lxcfs/
