芸众商城docker部署

1.product_dockerfile为生产环境docker，没有开发相关依赖包

2.developer_dockerfile为开发环境docker，clone完项目启动docker时会下载相关依赖包

目录架构：

1.app:存放application

2.data：存放mysql、redis、backup数据

3.files:存放各个服务的dockerfiles和docker-compose.yml

4.logs:存放各个服务的日志

