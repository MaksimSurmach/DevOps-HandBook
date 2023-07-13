docker build [options] .
  -t "app/container_name"    # name
  --build-arg APP_HOME=$APP_HOME    # Set build-time variables
  -f ./ #dockerfile path

docker exec -it {container} bash
-d, --detach        # run in background
  -i, --interactive   # stdin
  -t, --tty           # interactive

docker ps
docker ps -a
docker kill $ID


docker logs $ID
docker logs $ID 2>&1 | less
docker logs -f $ID # Follow log output

docker ps -q | xargs -F docker rm  -f #delete all containers


docker system prune     #clean

# Stop all running containers
docker stop $(docker ps -a -q)

# Delete stopped containers
docker container prune

docker volume prune #Delete all the volumes

docker image prune [-a] #Delete all the images


#docker-compose

docker-compose start
docker-compose stop
docker-compose pause
docker-compose unpause
docker-compose ps
docker-compose up
docker-compose down

Lifecycle:
docker create - creates a container but does not start it
docker rename - allows the container to be renamed
docker run - creates and starts a container in one operation
docker rm - deletes a container
docker update - updates a container’s resource limits
Starting and Stopping:
docker start - starts a container so it is running
docker stop - stops a running container
docker restart - stops and starts a container
docker pause - pauses a running container, “freezing” it in place
docker unpause - will unpause a running container
docker wait - blocks until running container stops
docker kill - sends a SIGKILL to a running container
docker attach - will connect to a running container
Info:
docker ps - shows running containers
docker ps -a - shows running and stopped containers
docker logs - gets logs from container
docker inspect - looks at all the info on a container
docker events - gets events from container
docker port - shows public facing port of container
docker top - shows running processes in container
docker stats - shows containers’ resource usage statistics
docker diff - shows changed files in the container’s FS
Import / Export:
docker cp - copies files or folders between a container and the local filesystem
docker export - turns container filesystem into tarball archive stream to STDOUT
Executing Commands:
docker exec - to execute a command in container

#Running Contianers

  docker run --user 1000:0 jenkins id
  docker run --group-add 123 jenkins id
  docker run --workdir /var/jenkins_home jenkins pwd
  docker run -it -e MYVAR="My Variable" centos env | grep MYVAR
  docker run -d --label app=web1 nginx
  docker run -d myhttpd:1.0
  docker run -P -d myhttpd:1.0
  docker run -d -p 8081:80 --name h8081 myhttpd:1.0
  docker run -d --restart=always --name sleeper centos sleep 5
  docker run -d --restart=unless-stopped --name sleeper centos sleep 5
  docker run centos cat /etc/redhat-release
  docker run -it centos bash
  docker run -dit centos
  docker run -dit busybox

#Stopping and Removing Contianers

  docker stop h8082
  docker rm 014e5efa5ca9
  docker rm $(docker stop $(docker ps -a -q))
  docker ps -qa | xargs -r docker rm

#Working with logs

  docker logs container_name 
  docker logs container_id
  docker logs -f ...

  docker run -dt --log-driver=journald --name httpd httpd
  journalctl -ab CONTAINER_NAME=httpd


#Docker volume

  docker run -d -p 80:80 -v /usr/share/nginx/html nginx
docker run -d -p 80:80 -v nginx_data:/usr/share/nginx/html nginx

docker run -d --name html_data -v /usr/share/nginx/html busybox sleep infinity
docker run -d --volumes-from html_data -p 81:80 nginx

docker volume create --name http-custom-data
docker volume ls
docker volume inspect http-custom-data

#docker network

docker network connect - Connect a container to a network;
docker network create - Create a network;
docker network disconnect - Disconnect a container from a network;
docker network inspect - Display detailed information on one or more networks;
docker network ls - List networks;
docker network prune - Remove all unused networks;
docker network rm - Remove one or more networks.

docker network ls
docker network inspect bridge

docker run --net=none -d --name inNoneContainer busybox
docker run -d --network=host --name=nginx nginx

docker run -d -it --name=my_container_1 busybox
docker run -d -it --name=my_container_2 busybox
docker network inspect bridge | jq '.[].Containers'

docker network create < network_name >
docker network create <options> <network>
docker network create --help

docker run -d --name=inmybridge1 --net=my_bridge_network centos sleep infinity


# 

docker run --name tomcat -d --memory=100Mb --memory-swap -1 --memory-reservation=50Mb  tomcat:jdk8-openjdk-slim

docker run --name cpu-stress -d --cpu-quota=20000 alpine md5sum /dev/urandom

docker run -d --pid container:nginx_pid --rm --name busy_sleep_inf busybox sleep infinity

docker run --rm --pid=container:web-conatiner centos ps
docker run -d -it --net=container:nginx sbeliakou/net-tools
docker run --rm --uts=host busybox hostname
docker run -d -m 300M --memory-reservation 100M centos sleep infinity
docker run -it -d --cpu-quota=25000 --name cpu0.25_1 alpine md5sum /dev/urandom
docker run -it -d --cpus=0.25 --name cpu0.25_2 alpine md5sum /dev/urandom


#Docker compose 

docker-compose up -d
docker-compose ps

docker-compose exec mariadb mysqladmin -ppassword version

docker-compose images

docker-compose logs mariadb

docker-compose restart mariadb
docker-compose stop mariadb

docker-compose down
docker-compose down --volumes

docker-compose build
docker-compose up -d
docker-compose up -d --build
docker-compose up -d --no-build
docker-compose up -d --no-cache


REMOTE docker
https://github.com/sbeliakou/docker-training/blob/master/daemon/https/Readme.md