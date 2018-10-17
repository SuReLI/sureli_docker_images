#!/bin/bash

# Check if there is a SUReLI docker
docker images | grep "sureli-docker " >/dev/null
if [ "$?" != "0" ]
then
  echo "No SUReLI docker found, build it first with ./build.sh"
  exit
fi

DOCKERNAME="sureli-docker"

# Run the container
docker run -it -d -p 127.0.0.1:38888:8888 -p 127.0.0.1:36006:6006 -p 127.0.0.1:32222:22 -v $(pwd)/notebooks:/notebooks $DOCKERNAME $@
export containerId=$(docker ps -l -q)
sshpass -p tutu ssh -o StrictHostKeyChecking=no -p 32222 -X root@127.0.0.1 tmux

# Stop it when we exit it
docker stop $containerId
