#!/bin/bash
if [ ! -f ./gym/README.rst ];
then 
  echo "Gym does not seem to be installed, use --recurse-submodules when cloning please"
  exit
fi

echo -e "#############################################\nBuilding SUReLI base image\n#############################################"
for i in `seq 1 10`
do
  docker build -t sureli-docker-no-gym -f Dockerfile.base .
  if [ "$?" == "0" ]; then break; fi
done
echo -e "#############################################\nBuilding SUReLI complete\n#############################################"
for i in `seq 1 10`
do
  docker build -t sureli-docker -f Dockerfile.addgym .
  if [ "$?" == "0" ]; then break; fi
done 

