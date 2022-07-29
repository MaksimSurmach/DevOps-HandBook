#!/bin/bash
#Color Varible
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

deluser --remove-all-files delme
rm -r /home/delme
echo -e "${GREEN}delete user delme${NOCOLOR}" 