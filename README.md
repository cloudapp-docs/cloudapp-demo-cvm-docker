Hello World 应用包
=================

本应用包包含最小的应用包实现，开发者可借此理解应用包最基本的概念。

如果你对云应用还不熟悉，请先了解*云端软件部署解决方案*，以及配套的*开发指南*。

Hello World 应用包安装后，前端使用界面会显示工作负载的服务器时间，以及进程的环境变量。

## 使用方法

1. 使用 `cloudapp login` 登录自己的开发者账号
2. 在[开发者中心](https://console.cloud.tencent.com/cloudapp/developer) 创建应用，并获得应用 ID（pkg- 开头）
3. 修改 `package.yaml` 中的 `id` 为自己的应用 ID
4. 进入 server 目录，获取镜像仓库登录凭证后登录仓库并执行 `npm run release` 推送镜像
5. 修改 `.cloudapp/software/chart/values.yaml` 中，SERVER_IMAGE 的命名空间。
6. 执行 `cloudapp push ./.cloudapp` 发布到云应用仓库

## 资源栈

应用包包含以下资源栈的声明：
- 声明了安装表单，让客户选择目标安装网络；
- 声明了弹性容器集群 EKS，用于部署具体的工作负载（StatefulSet）和服务（Service）；
- 声明了容器的编排内容；
- 声明了应用接口及其后端和网关；
- 实现了一个 HTTP Server，响应服务器时间和进程环境变量；
- 实现了前端界面调用应用接口。

具体的声明方法，请参考源码结构。

## 源码结构

- [.cloudapp/](./.cloudapp/) - 应用包目录
  - [infrastructure/](./.cloudapp/infrastructure/)
    - [api.tf](./.cloudapp/infrastructure/api.tf) - 声明了应用接口及其后端和网关
    - [eks.tf](./.cloudapp/infrastructure/eks.tf) - 声明了弹性容器集群 EKS，用于部署具体的工作负载（StatefulSet）和服务（Service）
    - [helm.tf](./.cloudapp/infrastructure/helm.tf) - 声明了容器的编排内容；
    - [provider.tf](./.cloudapp/infrastructure/provider.tf) - 声明软件使用的云厂商
    - [variable.tf](./.cloudapp/infrastructure/variable.tf) - 声明软件所接受的安装参数
  - [software/](./.cloudapp/software/)
    - [software/chart/](./.cloudapp/software/chart/) - Helm Chart 编排源码
    - [software/frontend/](./cloudapp/software/frontend/) - 前端界面代码实现
  - [package.yaml](./cloudapp/package.yaml) - 应用包基本信息声明，包括应用包 ID、安装表单、前端界面入口
- [server/](./server/) - HTTP Server 源码及其配套的 Dockerfile
