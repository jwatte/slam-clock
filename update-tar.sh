#!/bin/sh
(cd / && tar cvfz - usr/local/sbin/slam-clock.sh lib/systemd/system/slam-clock.service) > slam-clock.tar.gz
