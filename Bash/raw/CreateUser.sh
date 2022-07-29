#!/bin/bash
#Color Varible
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'


echo "User Creation"
groupadd -g 1050 msurmach_group
if [$? -eq 0]; then 
    echo -e "${GREEN}Group created${NOCOLOR}" 
else
    echo -e "${RED}Error create group${NOCOLOR}" 
fi
mkdir /home/msurmach_home
useradd -d /home/msurmach_home -u 1040 -g msurmach_group -s /bin/bash msurmach
chown msurmach:msurmach_group /home/msurmach_home
usermod -a -G cdrom msurmach
if [$? -eq 0]; then 
    echo -e "${GREEN}User created${NOCOLOR}" 
else
    echo -e "${RED}Error create User${NOCOLOR}" 
fi
echo "enter a password"
passwd msurmach
if [$? -eq 0]; then 
    echo -e "${GREEN}Password change${NOCOLOR}" 
else
    echo -e "${RED}Error change password${NOCOLOR}" 
fi

