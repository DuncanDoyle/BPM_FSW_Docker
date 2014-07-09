#!/bin/bash
#
# Created by Juergen Hoffmann ( https://github.com/juhoffma )
#

# This script builds all required docker images.
# Run this script before you run the start.sh script.

EAP_IMAGE_NAME="psteiner/eap"
BPM_IMAGE_NAME="psteiner/bpm"
FSW_IMAGE_NAME="psteiner/fsw"
HEISE_BPM_IMAGE_NAME="psteiner/heise_bpm"
HEISE_FSW_IMAGE_NAME="psteiner/heise_fsw"

EAP_ZIP="jboss-eap-6.1.1.zip"
EAP_URL="http://www.jboss.org/download-manager/file/jboss-eap-6.1.1.zip"

BPM_ZIP="jboss-bpms-6.0.1.GA-redhat-4-deployable-eap6.x.zip"
BPM_URL="https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=28913"

FSW_ZIP="jboss-fsw-installer-6.0.0.GA-redhat-4.jar"
FSW_URL="http://www.jboss.org/download-manager/file/jboss-fsw-6.0.0.GA.zip"

# Sanity checks before running the build
if [ ! -f EAP_Image/${EAP_ZIP} ]; then
  echo "ERROR: EAP_Image/${EAP_ZIP} not found"
  echo "Please put download EAP from ${EAP_URL} and place it into EAP_Image"
  exit 1
fi

if [ ! -f BPM_Image/${BPM_ZIP} ]; then
  echo "ERROR: BPM_Image/${BPM_ZIP} not found"
  echo "Please put download BPMN6 from ${BPM_URL} and place it into BPM_Image"
  exit 1
fi

if [ ! -f FSW_Image/${FSW_ZIP} ]; then
  echo "ERROR: FSW_Image/${FSW_ZIP} not found"
  echo "Please put download JBoss Fuse ServiceWorks from ${FSW_URL} and place it into FSW_Image"
  exit 1
fi

function remove_image {
  IMAGE=$1

  echo "Removing $IMAGE"

  # grab the image id hash
  IMAGE_ID=$(docker images | grep $IMAGE | awk '{ print $3; }')

  # Only try removing the images if there is a pre-built image
  if [ ! -z $IMAGE_ID ]; then

  echo "found $IMAGE_ID"

    if [ $(docker ps -a | grep $IMAGE_ID | awk '{ print $1; }' | wc -l) -gt 0 ]; then
      # remove all running and stopped containers based of the image
      docker rm -f $(docker ps -a | grep $IMAGE_ID | awk '{ print $1; }')
    fi

    if [ $(docker ps -a | grep $IMAGE | awk '{ print $1; }' | wc -l) -gt 0 ]; then
      # In case we still have the named reference
      docker rm -f $(docker ps -a | grep $IMAGE | awk '{ print $1; }')
    fi

    # finally remove the image
    docker rmi $IMAGE_ID
  fi
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
