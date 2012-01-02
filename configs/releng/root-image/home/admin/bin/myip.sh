#!/bin/sh
ip -o a l dev eth0|awk '$3=="inet"{print $4}'|head -1
