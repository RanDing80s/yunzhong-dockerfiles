#!/bin/bash

set -e
/usr/sbin/cron
/usr/local/bin/php /data/www/addons/yun_shop/artisan queue:work &
exec "$@"
