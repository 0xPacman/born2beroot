#!/bin/bash
info=$(uname -a)
cpu=$(lscpu | grep '^CPU(s)' | xargs | sed 's/CPU(s): //g')
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
tmem=$(free -m | grep "Mem:" | xargs | cut -d " " -f 2)
umem=$(free -m | grep "Mem:" | xargs | cut -d " " -f 3)
pmem=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
fspace=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{countf += $2} END {print countf}')
uspace=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{countu += $3} END {print countu}')
pspace=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{countu += $3} {countf += $2} END {printf("%d"), countu/countf*100}')
lcpu=$(top -bn1 | grep '^%Cpu(s)' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
last_boot=$(last | tail -n 1)
lvm_counter=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvm_counter -eq 0 ]; then echo no; else echo yes; fi)
ctcp=$(cat /proc/net/sockstat | grep TCP | cut -d " " -f 3)
ulog=$(users | sed 's/ /\n/g' | wc -l)
ip=$(hostname -I)
mac_address=$(ip link show | grep "link/ether" | xargs | cut -d " " -f 2)
sulogs=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "	#Architecture: 	${info}
           #CPU physical:	${cpu}
           #vCPU: 		${vcpu}
           #Memory Usage:	${umem}/${fmem}MB (${pmem}%)
           #Disk Usage:		${uspace}/${fspace} (${pspace}%)
           #CPU load:		${lcpu}
           #Last reboot:	${last_boot}
	#LVM use:		${lvmu}
           #Connexions TCP:	${ctcp}
           #User log:		${ulog}
           #Network:		IP ${ip} (${mac_address}) 
           #Sudo: ${sulogs} cmd"
