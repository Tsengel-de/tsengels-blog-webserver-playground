## Цэнгэлийн блогны тоглоомын талбарт тавтай морил, 👨🏼‍🚀

```
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
* * * * * cd /home/pi/www/grav;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1
0 0 1,15 * * sudo certbot certonly -n -a manual --manual-auth-hook /home/pi/tsengels-blog-webserver-playground/ssl-cert-renewal/authenticator.sh --manual-cleanup-hook /home/pi/tsengels-blog-webserver-playground/ssl-cert-renewal/cleanup.sh -d *.tsengel.de
*/1 * * * * /bin/bash -c "/home/pi/tsengels-blog-webserver-playground/ddns-and-webserver/check-my-ip-and-update-my-domain.sh"
```