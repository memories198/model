#!/bin/bash

chmod 0777 ./mysql
chmod 0777 ./redis

chmod 0444 ./mysql/conf/mysql.cnf
chmod 0444 ./redis/conf/redis.conf
