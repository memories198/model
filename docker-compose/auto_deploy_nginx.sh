#!/bin/bash

file=docker-compose-nginx
echo -e '正在拉取配置文件...\n'
wget https://github.com/memories198/model/releases/download/v1.0.0/$file.tar > /dev/null \
  2> /tmp/$file.log && tar -xf $file.tar -C ~ 2> /tmp/$file.log \
  && rm $file.tar 2> /tmp/$file.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '拉取配置文件成功!\n'

else
    echo -e '拉取配置文件失败。\n'
    cat /tmp/$file.log
    exit 1
fi

cd ~/docker-compose

chmod 0777 ./nginx

echo -e '正在启动容器中...\n'
docker compose -f ./$file.yaml up -d 2> /tmp/$file.log
# 检查上一个命令的退出状态
if [ $? -eq 0 ]; then
    echo -e '启动容器成功!\n'
else
    echo -e '启动容器失败。\n'
    cat /tmp/$file.log
    exit 1
fi