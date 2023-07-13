# Color console

Add variable with color at the beggining of the line. And fish with no color at the end of the line.


```bash
#!/bin/bash
#Color Varible
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'


echo -e "${GREEN}Group created${NOCOLOR}" 
```