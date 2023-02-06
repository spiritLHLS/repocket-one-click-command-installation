# repocket-一键式命令安装

## 介绍

repocket 是一个允许用户通过分享流量来赚钱的平台。(被动收入)

您共享的 1G 流量将获得 0.10 美元，并且此脚本支持数据中心网络或家庭带宽。

这是**全网第一个**自动安装依赖并拉取安装最新docker的**一键安装脚本**，脚本会根据平台更新不断完善。

**这个平台疑似有问题，有一个服务器被标记有自动广告行为，谨慎部署，千万别在生产机器上部署！**

它具有以下特点：

1.根据系统自动安装docker，如果已经安装了docker，则不再安装。

2.根据架构自动选择和构建拉取的docker镜像，无需您手动修改官方案例安装。
    
3.使用Watchtower进行镜像自动更新，无需手动更新和重新输入参数。

(Watchtower 是一款实现自动化更新 Docker 镜像与容器的实用工具.它监控着所有正在运行的容器以及相关镜像,当检测本地镜像与镜像仓库中的镜像有差异时,会自动拉取最新镜像并使用最初部署时的参数重新启动相应的容器.)

### 信息

- 本项目已经在 AMD64和ARM64 上验证上测试通过
- 感兴趣可以尝试一下，[注册链接点我](https://link.repocket.co/PBaK), 走我链接注册你获得5刀的注册奖励。

## 安装

### 交互式安装

```shell
curl -L https://raw.githubusercontent.com/spiritLHLS/repocket-one-click-command-installation/main/repocket.sh -o repocket.sh && chmod +x repocket.sh && bash repocket.sh
```

注册链接注册后，记住邮箱和密码，运行这个脚本，粘贴邮箱和密码，回车开始安装。

### 一键安装

```shell
curl -L https://raw.githubusercontent.com/spiritLHLS/repocket-one-click-command-installation/main/repocket.sh -o repocket.sh && chmod +x repocket.sh && bash repocket.sh -m youremail -p yourpassword
```

在此命令的中更改为你的账号邮箱和密码即可

## 卸载

```shell
bash repocket.sh -u
```

卸载服务

### 经验

IP类型为家庭带宽以及欧美地区收益比较高，但依然不是很高，目前1天分享不超过100M每1台设备。

本脚本在平台适配了linux的第2天创建.

### 免责声明

本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。

使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责.
