芸众商城docker部署
=================
相关软件版本：

PHP 5.6<br>
MySQL 5.7<br>
Nginx 1.12<br>
Redis 3.2<br>

目录架构：
-----------------

1.app:存放application<br>
2.data：存放mysql、redis、backup数据<br>
3.files:存放各个服务的dockerfiles和docker-compose.yml<br>
4.logs:存放各个服务的日志<br>

使用说明
-----------------

1.安装Docker，Docker-compose

>>Docker，详见官方文档：https://docs.docker.com/engine/installation/linux/docker-ce/centos/

>>docker-compose，文档：https://docs.docker.com/compose/install/

2.clone相应环境的dockerfile（windows的必须将项目放到d盘，不可改名！注意）
>>宿主机要求：
>>>linux系统的宿主机：为解决权限问题，需在宿主机创建用户:(不创建需赋予app目录、logs目录777权限)

>>>>- 创建uid为8888的www-data用户，并赋予app目录和logs/nginx、logs/php-fpm目录www-data用户可写

>>>>- 创建uid为999的mysql用户，并赋予logs/mysql目录权限

>>>windows系统的宿主机：需设置everyone用户读写权限到整个项目


 >>`files/docker-composer.yml里面定义了数据库的root密码，与建立数据库和普通用户，请自行修改后再进行启动`

3.下载需要的php-module

>>先下载好要使用的php-module，如果编译出错要多次构建容器就可以省掉下载时间。


>>linux：```wget https://pecl.php.net/get/redis-3.1.6.tgz -O php/pkg/redis.tgz```

>>Windows：下载：用上面网址下载redis并放发到php/pkg，重命名为redis.tgz

4.docker-compose构建项目
>>进入files目录<br>
>>命令行执行：```docker-compose up```(Note：windows中docker模式必须是linux，否则报错no matching mainfest for windows/amd64)

>>如果没问题，下次启动时可以以守护模式启用，所有容器将后台运行：

>>```docker-compose up -d```(先别执行)<br>
下载微擎与商城包：https://downloads.yunzshop.com/wq.tgz 解压并放到app目录里面<br>
现在可以去运行docker-compose up -d<br>


>>一切准备就绪后，进入app目录/data/config.php，修改相应链接数据库资料。host修改为：mysql-db,其他根据docker-compose.yml文件中内容设置,<br>
修改app/dbm/libraries/config.default.php，修改为$cfg['Servers'][$i]['host'] = 'mysql-db'<br>


>>导入项目中的we7.sql到数据库中.(使用http://localhost/dbm 或mysql的client均可）<br>

>>运行：http://domain/p.php 修改管理员密码。用户名为admin<br>

>>windows宿主机需在计划任务中导入files/php/win_cronjob.xml<br>

>>最后更新商城系统后，再更新微擎。才能开始使用。

开发者须知
======================
到app/addons/yun_shop/目录里，删除所有文件。clone商城项目（因商城模型为前后端分离，商城项目不带前端),

修改项目.env为：（没有则新建.env文件）

APP_ENV=dev

APP_KEY=base64:gkli8hs6Q9DbSR/cQw5DNaRBF0jtvf1iGaXc6ja0ZGA=

APP_DEBUG=true

docker已经安装composer包管理工具，可以运行该容器进行Composer操作。
```
docker-compose run --rm -w /data/www php-fpm composer --dev

docker-compose run --rm -w /data/www php-fpm composer update --optimize-autoloader

docker-compose run --rm -w /data/www php-fpm composer dump-autoload --optimize
```
迁移数据库结构：
```
docker-compose run --rm php-fpm php /data/www/addons/yun_shop/artisan migrate -y

docker-compose run --rm php-fpm php /data/www/addons/yun_shop/artisan db:seed -y
```




