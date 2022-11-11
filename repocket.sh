#!/bin/bash
#FROM https://github.com/spiritLHLS/repocket-one-click-command-installation

# 定义容器名
NAME='repocket'

# 自定义字体彩色，read 函数，安装依赖函数
red(){ echo -e "\033[31m\033[01m$1$2\033[0m"; }
green(){ echo -e "\033[32m\033[01m$1$2\033[0m"; }
yellow(){ echo -e "\033[33m\033[01m$1$2\033[0m"; }
reading(){ read -rp "$(green "$1")" "$2"; }

# 必须以root运行脚本
check_root(){
  [[ $(id -u) != 0 ]] && red " The script must be run as root, you can enter sudo -i and then download and run again." && exit 1
}

# 判断系统，并选择相应的指令集
check_operating_system(){
  CMD=("$(grep -i pretty_name /etc/os-release 2>/dev/null | cut -d \" -f2)"
       "$(hostnamectl 2>/dev/null | grep -i system | cut -d : -f2)"
       "$(lsb_release -sd 2>/dev/null)" "$(grep -i description /etc/lsb-release 2>/dev/null | cut -d \" -f2)"
       "$(grep . /etc/redhat-release 2>/dev/null)"
       "$(grep . /etc/issue 2>/dev/null | cut -d \\ -f1 | sed '/^[ ]*$/d')"
      )

  for i in "${CMD[@]}"; do SYS="$i" && [[ -n $SYS ]] && break; done

  REGEX=("debian" "ubuntu" "centos|red hat|kernel|oracle linux|amazon linux|alma|rocky")
  RELEASE=("Debian" "Ubuntu" "CentOS")
  PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update")
  PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install")
  PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove")

  for ((int = 0; int < ${#REGEX[@]}; int++)); do
    [[ $(echo "$SYS" | tr '[:upper:]' '[:lower:]') =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && break
  done

  [[ -z $SYSTEM ]] && red " ERROR: The script supports Debian, Ubuntu, CentOS or Alpine systems only.\n" && exit 1
}

# 判断宿主机的 IPv4 或双栈情况,没有拉取不了 docker
check_ipv4(){
  ! curl -s4m8 ip.sb | grep -q '\.' && red " ERROR：The host must have IPv4. " && exit 1
}

# 判断 CPU 架构
check_virt(){
  ARCHITECTURE=$(uname -m)
  case "$ARCHITECTURE" in
    aarch64 ) ARCH=arm64;;
    x64|x86_64|amd64 ) ARCH=amd64;;
    * ) red " ERROR: Unsupported architecture: $ARCHITECTURE\n" && exit 1;;
  esac
}

# 输入 repocket 的个人信息
input_token(){
  [ -z $EMAIL ] && reading " Enter your Email, if you do not find it, open https://link.repocket.co/PBaK: " EMAIL 
  [ -z $PASSWORD ] && reading " Enter your Password: " PASSWORD
}

container_build(){
  # 宿主机安装 docker
  green "\n Install docker.\n "
  if ! systemctl is-active docker >/dev/null 2>&1; then
    echo -e " \n Install docker \n " 
    if [ $SYSTEM = "CentOS" ]; then
      ${PACKAGE_INSTALL[int]} yum-utils
      yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
      ${PACKAGE_INSTALL[int]} docker-ce docker-ce-cli containerd.io
      systemctl enable --now docker
    else
      ${PACKAGE_INSTALL[int]} docker.io
    fi
  fi

  # 删除旧容器（如有）
  docker ps -a | awk '{print $NF}' | grep -qw "$NAME" && yellow " Remove the old repocket container.\n " && docker rm -f "$NAME" 

  # 创建容器
  yellow " Create the repocket container.\n "
  docker run -e RP_EMAIL="$EMAIL" -e RP_PASSWORD="$PASSWORD" -d --name "$NAME" --restart=always repocket/repocket 

  # 创建 Towerwatch
  [[ ! $(docker ps -a) =~ watchtower ]] && yellow " Create TowerWatch.\n " && docker run -d --name watchtower --restart always -p 2095:8080 -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup >/dev/null 2>&1
}

# 显示结果
result(){
  docker ps -a | grep -q "$NAME" && green " Install success.\n" || red " install fail.\n"
}

# 卸载
uninstall(){
  docker rm -f $(docker ps -a | grep -w "$NAME" | awk '{print $1}')
  docker rmi -f $(docker images | grep repocket/repocket | awk '{print $3}')
  green "\n Uninstall containers and images complete.\n"
  exit 0
}

# 传参
while getopts "UuM:m:P:p:" OPTNAME; do
  case "$OPTNAME" in
    'U'|'u' ) uninstall;;
    'M'|'m' ) EMAIL=$OPTARG;;
    'P'|'p' ) PASSWORD=$OPTARG;;
  esac
done

# 主程序
check_root
check_operating_system
check_ipv4
check_virt
input_token
container_build
result
