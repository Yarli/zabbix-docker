#!/bin/bash

# prerequisite, remove the old docker image
docker rm oom-test
docker rmi -f rpsedlak/memkiller

# first, build our special docker image
docker build --tag="rpsedlak/memkiller" .

# next, start some standard stuff
docker run --name="httpd-1" httpd
docker run --name="httpd-2-pause" httpd
docker run --name="httpd-3-kill" httpd
docker run --name="redis-1" redis:2.8
docker run --name="redis-2-pause" redis:2.8
docker run --name="redis-3-kill" redis:2.8

# next, pause a container
docker pause httpd-2-pause
docker pause redis-2-pause

# next, kill a container
docker kill httpd-3-kill
docker kill redis-3-kill

# last, run the memkiller image
docker run --memory=4M --name="oom-test" rpsedlak/memkiller

