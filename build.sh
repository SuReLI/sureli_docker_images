#!/bin/bash
if [ ! -f ./gym/README.rst ];
then 
  echo "Gym does not seem to be installed, use --recurse-submodules when cloning please"
  exit
fi

echo -e "#############################################\nBuilding SUReLI base image\n#############################################"
docker build --no-cache -t sureli-docker-no-gym -f Dockerfile.base .
if [ "$?" != 0 ]
then
  echo "Could not build first image, exiting..."
  exit
fi
echo -e "#############################################\nBuilding SUReLI gym image\n#############################################"
docker build --no-cache -t sureli-docker -f Dockerfile.addgym .
docker rmi sureli-docker-no-gym

