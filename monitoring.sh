#!/bin/bash
info=$(uname -a)
cpu=$()
vcpu=$()
fmem=$()
umem=$()
fspace=$()
uspace=$()
pspace=$()
lcpu=$()
last_boot=$(last | xargs)
lvm_counter=$()
lvmu=$()
ctcp=$()
ulog=$()
ip=$()
mac_address=$()
su=$()
wall " #Architecture: $info
           #CPU physical:
           #vCPU:
           #Memory Usage:
           #Disk Usage:
           #CPU load:
           #Last reboot:
           #Connexions TCP:
           #User log:
           #Network:
           #Sudo: "
