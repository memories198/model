#!/bin/bash

echo -e '正在配置系统的ip为192.168.30.30...\n'
#配置ip
cat > /etc/netplan/ens33.yaml <<EOF 2> /tmp/auto-init-system.log && netplan apply 2> /tmp/auto-init-system.log
network:
  ethernets:
    ens33:
      dhcp4: false
      addresses: [192.168.30.30/24]
      gateway4: 192.168.30.2
      nameservers:
        addresses: [114.114.114.114]
  version: 2
EOF
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '配置系统的ip为192.168.30.30成功!\n'
else
    echo -e '配置系统的ip为192.168.30.30失败。\n'
    cat /tmp/auto-init-system.log
    exit 1
fi

echo -e '正在配置系统时区为上海...\n'
timedatectl set-timezone Asia/Shanghai 2> /tmp/auto-init-system.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '配置系统时区成功!\n'
else
    echo -e '配置系统时区失败。\n'
    cat /tmp/auto-init-system.log
    exit 1
fi

echo -e '正在配置/tmp目录的保存文件时间为10天...\n'
echo -e '# 类型 路径 模式 UID  GID 最大保存时间\nd /tmp 1777 root root 10d' > /etc/tmpfiles.d/tmp.conf
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '配置/tmp目录的保存文件时间为10天成功!\n'
else
    echo -e '配置/tmp目录的保存文件时间为10天失败。\n'
    cat /tmp/auto-init-system.log
    exit 1
fi

echo -e '正在配置允许root用户登陆...\n'
sed -i '/^#PermitRootLogin.*/a PermitRootLogin yes' /etc/ssh/sshd_config 2> /tmp/auto-init-system.log \
  && systemctl restart sshd 2> /tmp/auto-init-system.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '配置允许root用户登陆成功!\n'
else
    echo -e '配置允许root用户登陆失败。\n'
    cat /tmp/auto-init-system.log
    exit 1
fi

sources=/etc/apt/sources.list
echo -e '正在配置系统软件包源(南京大学源)...\n'
cp $sources $sources.bak 2> /tmp/auto-init-system.log \
  && sed -i 's/http.*ubuntu.com/https:\/\/mirror.nju.edu.cn/' \
    $sources 2> /tmp/auto-init-system.log \
  && apt update > /dev/null 2> /tmp/auto-init-system.log && unset sources
if [ $? -eq 0 ]; then
    echo -e '配置系统软件包源(南京大学源)成功!\n'
else
    echo -e '配置系统软件包源(南京大学源)失败。\n'
    cat /tmp/auto-init-system.log
    exit 1
fi

echo -e '正在安装系统常用组件...\n'
apt install -y open-vm-tools vim wget curl bash-completion gcc net-tools > /dev/null 2> /tmp/auto-init-system.log
if [ $? -eq 0 ]; then
    echo -e '安装系统常用组件成功!\n'
else
    echo -e '安装系统常用组件失败。\n'
    cat /tmp/auto-init-system.log
    exit 1
fi