#!/bin/bash

10.6.218.189
10.6.218.187

\
SSH Jumphost
Description:

Connect to your VM using VM1 as a jumphost/bastion: - user: deleteme

pass: pass - VM1 address : ECSC00A0CDE4.epam.com - SSH host of your VM is nsurname - Write the SSH command and/or configuration file down to ssh_jumphost_command.txt and ssh_jumphost_configuration.txt files in nsurname home directory on your VM

After:

abutsko@epam:~$ ssh abutsko

# Connect to the bastion
This system is owned by EPAM Systems.
...
acknowledge that any data traffic passing through may be monitored.

# Connect to the VM
This system is owned by EPAM Systems.
...
acknowledge that any data traffic passing through may be monitored.

Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-90-generic x86_64)
...
Last login: Wed Nov 24 13:47:50 2021 from 10.6.218.189




Host msurmachBASTION
  HostName ECSC00A0CDE4.epam.com
  User delme
  IdentityFile /home/msurmach/msurmach.pem

Host msurmach
  HostName ECSC00A0CE62.epam.com
  User msurmach
  IdentityFile /home/msurmach/msurmach.pem
  ProxyJump msurmachBASTION


  
