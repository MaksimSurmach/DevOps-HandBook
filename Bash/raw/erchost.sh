#!/bin/bash
#Color Varible
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'


echo "msurmach ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get install * , /usr/bin/apt install *" > /etc/sudoers.d/msurmach
if [$? -eq 0]; then 
    echo -e "${GREEN}Created sudoers${NOCOLOR}" 
else
    echo -e "${RED}Error sudoers${NOCOLOR}" 
fi

hostnamectl set-hostname msurmach
echo "127.0.0.1 msurmach" >> /etc/hosts
echo "${GREEN} Host renamed"

