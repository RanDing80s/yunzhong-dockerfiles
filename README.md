芸众商城docker部署

相关软件版本：

PHP 5.6
MySQL 5.7
Nginx 1.12
Redis 3.2

1.product_dockerfile为生产环境docker，没有开发相关依赖包

2.developer_dockerfile为开发环境docker，clone完项目启动docker时会下载相关依赖包

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


