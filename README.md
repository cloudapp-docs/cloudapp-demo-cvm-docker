基于 cvm + docker 实现的应用
=================

## 简介


### 目录

- .cloudapp 云应用应用包目录
  - .cloudapp/infrastructure 声明硬件资源，即云资源
  - .cloudapp/package.yaml 应用包描述文件
- sh初始化脚本，仅用于本示例演示
  - sh/infrastructure.info 配置文件，仅演示用，实际不需要
  - sh/init_config.sh 配置读取脚本
  - sh/init_db.sh 数据库初始化 shell 脚本
  - sh/init_data.sql 初始化 sql 脚本
  - sh/init_app.sh 应用初始化脚本

## 使用方法

- 使用 cloudapp login 登录自己的开发者账号
- 在开发者中心 创建应用，并获得应用 ID（pkg- 开头）
- 修改 package.yaml 中的 id 为自己的应用 ID
- 执行 cloudapp push ./.cloudapp 发布到云应用仓库

