slam-clock cuts through all the misleading and outdated tutorials, and makes 
a hardware real-time clock work on a Raspberry Pi, from early on in the boot 
process.
It requires raspbian from March 2016 or newer, because it uses systemd, and 
does not edit or replace the "hwclock" scripts (which are largely obsolete.)

To install:

1) Uncompress/tar the archive (you probably already did this, as you're reading 
this file)

2) "cd" to the directory that contains these files in a Terminal window.

3) Run "slam-clock.install.sh as root:   sudo ./slam-clock.install.sh

This should save the current clock, make necessary adjustments to boot files, 
and both enable the hardware clock for future reboots as well as enable it right 
now.

Comments can be sent to slam-clock@mindcontrol.org
