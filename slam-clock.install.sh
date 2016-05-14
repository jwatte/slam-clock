#!/bin/sh

if [ `whoami` != 'root' ]; then
    echo "This script must be run as root."
    echo "Please re-run it using:   sudo ./slam-clock.install.sh"
    exit 1
fi

# make sure boot/config.txt turns on I2C
sed -i -e '/i2c_arm/ d' /boot/config.txt
sed -i -e '/i2c1/ d' /boot/config.txt
echo "dtparam=i2c_arm=on" >> /boot/config.txt
echo "dtparam=i2c1=on" >> /boot/config.txt

# make sure i2c modules are loaded
if [ -f /etc/modprobe.d/raspi-blacklist.conf ]; then
    sed -i -e '/i2c-bcm2708/ d' /etc/modprobe.d/raspi-blacklist.conf
    sed -i -e '/i2c-dev/ d' /etc/modprobe.d/raspi-blacklist.conf
    sed -i -e '/rtc-ds1307/ d' /etc/modprobe.d/raspi-blacklist.conf
fi
sed -i -e '/i2c-bcm2708/ d' /etc/modules
sed -i -e '/i2c-dev/ d' /etc/modules
sed -i -e '/rtc-ds1307/ d' /etc/modules
echo "i2c-bcm2708" >> /etc/modules
echo "i2c-dev" >> /etc/modules
echo "rtc-ds1307" >> /etc/modules

# install the systemd scripts
cat slam-clock.tar.gz | (cd / && tar xvfz -)

# save current time to hardware so we don't get some junk when starting the service
/usr/local/sbin/slam-clock.sh stop

# enable the systemd service goop
systemctl disable fake-hwclock
systemctl disable hwclock
systemctl enable slam-clock
systemctl start slam-clock
