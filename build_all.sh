#!/bin/bash

# This script builds all required docker images.
# Run this script before you run the start.sh script.

EAP_IMAGE_NAME="psteiner/eap"
BPM_IMAGE_NAME="psteiner/bpm"
FSW_IMAGE_NAME="psteiner/fsw"
HEISE_BPM_IMAGE_NAME="psteiner/heise_bpm"
HEISE_FSW_IMAGE_NAME="psteiner/heise_fsw"

function remove_image {
  IMAGE=$1

  echo "Removing $IMAGE"

  # grab the image id hash
  IMAGE_ID=$(docker images | grep $IMAGE | awk '{ print $3; }')
  echo "found $IMAGE_ID"

  # remove all running and stopped containers based of the image
  docker rm -f $(docker ps -a | grep $IMAGE_ID | awk '{ print $1; }')

  # In case we still have the named reference
  docker rm -f $(docker ps -a | grep $IMAGE | awk '{ print $1; }')

  # finally remove the image
  docker rmi $IMAGE_ID
}

remove_image $EAP_IMAGE_NAME
remove_image $BPM_IMAGE_NAME
remove_image $FSW_IMAGE_NAME
remove_image $HEISE_BPM_IMAGE_NAME
remove_image $HEISE_FSW_IMAGE_NAME

pushd ./EAP_Image
docker build --rm -t $EAP_IMAGE_NAME .
popd

pushd ./BPM_Image
docker build --rm -t $BPM_IMAGE_NAME .
popd

pushd ./FSW_Image
docker build --rm -t $FSW_IMAGE_NAME .
popd

pushd ./Heise_BPM_Image
docker build --rm -t $HEISE_BPM_IMAGE_NAME .
popd

pushd ./Heise_FSW_Image
docker build --rm -t $HEISE_FSW_IMAGE_NAME .
popd
