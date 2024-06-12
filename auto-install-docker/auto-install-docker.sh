#!/bin/bash

echo -e '正在下载和安装必要的系统组件...\n'
sudo apt-get update > /dev/null 2> /tmp/auto-install-docker.log && sudo apt-get install -y \
  ca-certificates curl gnupg lsb-release 2> /tmp/auto-install-docker.log > /dev/null 2> /tmp/auto-install-docker.log

# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '下载和安装必要的系统组件成功!\n'
else
    echo -e '下载和安装必要的系统组件失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e '正在下载 验证docker安装包的公钥...\n'
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg 2> /tmp/auto-install-docker.log \
   | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg

# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '验证docker安装包的公钥下载成功!\n'
else
    echo -e '验证docker安装包的的公钥下载失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e '正在添加docker的软件包源...\n'
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/docker.gpg] https://mirror.nju.edu.cn/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list 2> /tmp/auto-install-docker.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '添加docker的软件包源成功!\n'
else
    echo -e '添加docker的软件包源失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e '正在识别和获取docker软件包源的信息...\n'
#sudo apt update 命令会重新同步包管理器的索引，这样系统就能识别和获取新的软件包源的信息。
sudo apt update > /dev/null 2> /tmp/auto-install-docker.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '识别和获取docker软件包源的信息成功!\n'
else
    echo -e '识别和获取docker软件包源的信息失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e '正在安装docker...\n'
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null 2> /tmp/auto-install-docker.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '安装docker成功!\n'
else
    echo -e '安装docker失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e '正在添加docker镜像仓库(网易源)...\n'
sudo mkdir -p /etc/docker && sudo cat > /etc/docker/daemon.json << 'EOF' 2> /tmp/auto-install-docker.log
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '添加docker镜像仓库(网易源)成功!\n'
else
    echo -e '添加docker镜像仓库(网易源)失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

sudo systemctl daemon-reload

echo -e '正在将docker设置为开机自启动...\n'
sudo systemctl enable docker 2> /tmp/auto-install-docker.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '设置docker为开机自启动成功!\n'
else
    echo -e '设置docker为开机自启动失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e '正在启动docker...\n'
sudo systemctl start docker 2> /tmp/auto-install-docker.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '启动docker成功!\n'
else
    echo -e '启动docker失败。\n'
    cat /tmp/auto-install-docker.log
    exit 1
fi

echo -e 'docker安装成功!\n'