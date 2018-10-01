#!/bin/bash
echo -e "#############################################\nBuilding SUReLI base image\n#############################################"
docker build -t sureli-docker-no-gym -f Dockerfile.base .
if [ ! -f ./gym/README.rst ];
then 
  echo "Gym does not seem to be installed stopping here"
  exit
else
  echo -e "#############################################\nBuilding SUReLI Gym image\n#############################################"
  docker build -t sureli-docker -f Dockerfile.addgym .
fi

