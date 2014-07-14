#!/bin/bash

images=(`docker ps -a | cut -c1-15`)
for ((i=${#images[@]}-1; i>=0; i--)); do

  if [ ${#images[$i]} -eq 12 ]; then
    docker rm ${images[$i]}
  fi
done


images=(`docker images | grep none | cut -c40-52`)
for ((i=${#images[@]}-1; i>=0; i--)); do
  if [ ${#images[$i]} -eq 12 ]; then
    docker rmi ${images[$i]}
  fi
done
