# sort ip addr
`sort -t . -k 3,3n -k 4,4n`

# add cron job
`crontab -e`
`* * * * * /path/to/script.sh`
`echo "*/10 * * * 4-6  sudo cp /etc/nginx/nginx.conf /etc/nginx/conf.d/nginx-$(date +'\%s').conf.bak" >> /var/spool/cron/crontabs/msurmach`