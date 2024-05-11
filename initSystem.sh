#!/bin/bash

timedatectl set-timezone Asia/Shanghai

awk -v ikun='hello' 'BEGIN {
         for (i = 0; i < ARGC; i++) {
             print "ARGV[" i "] =", ARGV[i]
         }
     }' tmp.txt