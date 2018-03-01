#!/bin/bash
/usr/sbin/cron
/usr/local/bin/php /data/www/addons/yun_shop/artisan queue:work &
