#!/bin/bash

awk -v ikun='hello' 'BEGIN {
         for (i = 0; i < ARGC; i++) {
             print "ARGV[" i "] =", ARGV[i]
         }
     }' tmp.txt

file=auto_deploy_nginx && wget https://github.com/memories198/model/releases/download/v1.0.0/$file.sh \
  && sudo chmod u+x ./$file.sh && sudo ./$file.sh && sudo rm ./$file.sh && unset file
