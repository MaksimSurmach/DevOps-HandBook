### Linux commands

#users and groups 
cat /etc/passwd
cat /etc/group

hostname
hostname -i #ip
#set immytable
chattr +i /sbin/lilo.conf

ifconfig – configure and control TCP/IP network interfaces
ip route add 192.0.2.1 via 10.0.0.2 dev eth0

nslookup – a program to query Internet domain name servers.
netstat – Display network connections, routing tables, interface statistics, masquerade connections, netlink messages, and multicast memberships
whois – utility looks up records in the databases maintained by several Network Information Centers (NICs)

## monitoring
top - view a dynamically updating list of running processes
ps - view a list of running processes
killall -9 top

lscpu – gathers information about the CPU architecture, such as the number of CPUs, threads, cores, sockets, and NUMA nodes
mpstat – display CPU statistics of individual CPU (or) Core.
## Memory
free -h – show information about operating memory
## Disk i/o
df – show available drive space in the system
du – show disk usage information for given folder
iostat – monitors and reports on system input/output device loading.
## Logs
journalctl -u httpd
$ journalctl --since "1 hour ago"
$ journalctl --since "2 days ago"
$ journalctl --since "2015-06-26 23:15:00" --until "2015-06-26 23:20:00"