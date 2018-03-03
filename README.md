芸众商城docker部署
==========================
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
	宿主机要求：
	linux系统的宿主机：为解决权限问题，需在宿主机创建用户:(不创建需赋予app目录、logs目录777权限)

		- 创建uid为8888的www-data用户，并赋予app目录和logs/nginx、logs/php-fpm目录www-data用户可写

		- 创建uid为999的mysql用户，并赋予logs/mysql目录权限

	windows系统的宿主机：需设置everyone用户读写权限到整个项目


    docker-composer.yml里面定义了数据库的root密码，与建立数据库和普通用户，请自行修改后再进行启动

3.下载需要的php-module

先下载好要使用的php-module，如果编译出错要多次构建容器就可以省掉下载时间。


linux：wget https://pecl.php.net/get/redis-3.1.6.tgz -O php/pkg/redis.tgz

Windows：下载：用上面网址下载redis并放发到php/pkg，重命名为redis.tgz

4.docker-compose构建项目
进入files目录
docker-compose up

如果没问题，下次启动时可以以守护模式启用，所有容器将后台运行：

docker-compose up -d

一切准备就绪后，进入app目录/data/config.php，修改相应链接数据库资料。host修改为：mysql-db,其他根据docker-compose.yml文件中内容设置。

导入项目中的we7.sql到数据库中。

运行：http://domain/p.php修改管理员密码。用户名为admin

windows宿主机需在计划任务中导入files/php/win_cronjob.xml

最后更新商城系统后，再更新微擎。才能开始使用。

开发者须知：
到app目录里，clone商城项目

docker已经安装composer包管理工具，可以运行该容器进行Composer操作。

docker-compose run --rm -w /data/www php-fpm composer update --optimize-autoloader

docker-compose run --rm -w /data/www php-fpm composer dump-autoload --optimize

迁移数据库结构：

docker-compose run --rm php-fpm php /data/www/addons/yun_shop/artisan migrate -y

docker-compose run --rm php-fpm php /data/www/addons/yun_shop/artisan db:seed -y

修改项目.env为：

APP_ENV=dev

APP_KEY=base64:gkli8hs6Q9DbSR/cQw5DNaRBF0jtvf1iGaXc6ja0ZGA=

APP_DEBUG=true



