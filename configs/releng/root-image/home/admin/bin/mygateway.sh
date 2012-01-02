#!/bin/sh
ip route list default|awk '$1=="default"{print $3}'
