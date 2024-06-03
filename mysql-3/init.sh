#!/bin/bash

chmod 0444 ./mysql{1..3}/conf/mysql.cnf
chmod 0777 ./mysql{1..3}/data
chmod 0777 ./mysql{1..3}/log