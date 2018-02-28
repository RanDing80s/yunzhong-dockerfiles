#!/bin/bash

set -e
/usr/sbin/cron
exec "$@"
/usr/local/bin/php /data/www/addons/yun_shop/artisan queue:work
