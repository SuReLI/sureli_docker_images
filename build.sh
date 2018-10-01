#!/bin/bash
if [ ! -f ./gym/README.rst ];
then 
  echo "Gym does not seem to be installed, use --recurse-submodules when cloning please"
  exit
fi

echo -e "#############################################\nBuilding SUReLI base image\n#############################################"
docker build -t sureli-docker-no-gym -f Dockerfile.base .
docker build -t sureli-docker -f Dockerfile.addgym .

