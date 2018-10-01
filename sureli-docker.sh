#!/bin/bash

# Check if help is requested
if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
  echo "Usage : $0 [no-gym]"
  exit
fi

# Check if there is a SUReLI docker
docker images | grep sureli-docker >/dev/null
if [ "$?" != "0" ]
then
  echo "No SUReLI docker found, build it first with ./build.sh"
  exit
fi

# Check which image should be run 
docker images | grep -v sureli-docker-no-gym | grep sureli-docker >/dev/null
if [ "$1" == "no-gym" ] || [ "$?" != "0" ]
then
  DOCKERNAME = "sureli-docker-no-gym"
else
  DOCKERNAME = "sureli-docker"
fi

# Run it
docker run -it --rm -d -p 127.0.0.1:8888:8888 -p 127.0.0.1:6060:6666 -p 127.0.0.1:2222:22 -v $(pwd)/notebooks:/notebooks $DOCKERNAME $@
export containerId=$(docker ps -l -q)
sshpass -p tutu ssh -o StrictHostKeyChecking=no -p 2222 -X root@127.0.0.1

# Stop it when we exit it
docker stop $containerId
