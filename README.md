芸众商城docker部署

相关软件版本：

PHP 5.6
MySQL 5.7
Nginx 1.12
Redis 3.2

目录架构：

1.app:存放application

2.data：存放mysql、redis、backup数据

3.files:存放各个服务的dockerfiles和docker-compose.yml

4.logs:存放各个服务的日志

使用说明

1.安装Docker，Docker-compose

Docker，详见官方文档：https://docs.docker.com/engine/installation/linux/docker-ce/centos/

docker-compose，文档：https://docs.docker.com/compose/install/

2.clone相应环境的dockerfile


3.下载需要的php-module

先下载好要使用的php-module，如果编译出错要多次构建容器就可以省掉下载时间。

wget https://pecl.php.net/get/redis-3.1.6.tgz -O php/pkg/redis.tgz

4.docker-compose构建项目
进入files目录
docker-compose up

如果没问题，下次启动时可以以守护模式启用，所有容器将后台运行：

docker-compose up -d


开发者操作：
到app目录里，clone商城项目

docker已经安装composer包管理工具，可以运行该容器进行Composer操作。

docker-compose run --rm -w /data/www php-fpm composer update --optimize-autoloader

docker-compose run --rm -w /data/www php-fpm composer dump-autoload --optimize

修改项目.env为：

APP_ENV=dev

APP_KEY=base64:gkli8hs6Q9DbSR/cQw5DNaRBF0jtvf1iGaXc6ja0ZGA=

APP_DEBUG=true
