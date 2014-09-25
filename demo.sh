#!/usr/bin/env bash
#
# Created by Juergen Hoffmann <buddy@redhat.com>
#

# This script builds all required docker images.
# Run this script before you run the start.sh script.

set -e
NAME=$(basename $0)
declare -A DOCKER_IMAGE

DOCKER_IMAGE["EAP:IMAGE_NAME"]="psteiner/eap"
DOCKER_IMAGE["EAP:ZIP"]="jboss-eap-6.1.1.zip"
DOCKER_IMAGE["EAP:URL"]="http://www.jboss.org/download-manager/file/jboss-eap-6.1.1.zip"

DOCKER_IMAGE["BPM:IMAGE_NAME"]="psteiner/bpm"
DOCKER_IMAGE["BPM:ZIP"]="jboss-bpms-6.0.3.GA-redhat-1-deployable-eap6.x.zip"
DOCKER_IMAGE["BPM:URL"]="https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=30853&product=bpm.suite"

DOCKER_IMAGE["FSW:IMAGE_NAME"]="psteiner/fsw"
DOCKER_IMAGE["FSW:ZIP"]="jboss-fsw-installer-6.0.0.GA-redhat-4.jar"
DOCKER_IMAGE["FSW:URL"]="http://www.jboss.org/download-manager/file/jboss-fsw-6.0.0.GA.zip"

DOCKER_IMAGE["POSTGRES:IMAGE_NAME"]="psteiner/postgres"

DOCKER_IMAGE["HEISE_BPM:IMAGE_NAME"]="psteiner/heise_bpm"
DOCKER_IMAGE["HEISE_BPM:ZIP"]="postgresql-8.4-703.jdbc4.jar"
DOCKER_IMAGE["HEISE_BPM:URL"]="http://jdbc.postgresql.org/download/postgresql-8.4-703.jdbc4.jar"

DOCKER_IMAGE["HEISE_FSW:IMAGE_NAME"]="psteiner/heise_fsw"

function sanity_check {
  IMAGE=$1

  # Sanity checks before running the build
  if [ ! -f ${IMAGE}_Image/${DOCKER_IMAGE["${IMAGE}:ZIP"]} ]; then
    echo "ERROR: ${IMAGE}_Image/${DOCKER_IMAGE["${IMAGE}:ZIP"]} not found"
    echo "Please put download ${IMAGE} from ${DOCKER_IMAGE["${IMAGE}:URL"]} and place it into ${IMAGE}_Image"
    exit 1
  fi
}

function remove_image {
  IMAGE=$1

  echo "Removing $IMAGE"

  # grab the image id hash
  IMAGE_ID=$(docker images | grep -w $IMAGE | awk '{ print $3; }')

  # Only try removing the images if there is a pre-built image
  if [ ! -z "$IMAGE_ID" ]; then

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


function remove_all_images {
  remove_image ${DOCKER_IMAGE["EAP:IMAGE_NAME"]}
  remove_image ${DOCKER_IMAGE["BPM:IMAGE_NAME"]}
  remove_image ${DOCKER_IMAGE["FSW:IMAGE_NAME"]}
  remove_image ${DOCKER_IMAGE["POSTGRES:IMAGE_NAME"]}
  remove_image ${DOCKER_IMAGE["HEISE_BPM:IMAGE_NAME"]}
  remove_image ${DOCKER_IMAGE["HEISE_FSW:IMAGE_NAME"]}
}

function build_image {
  IMAGE=$1
  pushd ./${IMAGE}_Image >/dev/null
  echo "Building ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]}"
  docker build -q --rm -t ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]} .
  popd > /dev/null

}

function stop_image {
  IMAGE=$1
  if [ $(docker ps | grep ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]} | wc -l) -gt 0 ]; then
    echo "Stopping all Images matching ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]}"
    docker stop $(docker ps | grep ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]} | awk '{ print $1; }')

    if [ ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]} == ${DOCKER_IMAGE["HEISE_FSW:IMAGE_NAME"]} ]; then
	echo "Removing ${DOCKER_IMAGE["HEISE_FSW:IMAGE_NAME"]}"
	docker rm $(docker ps -a | grep ${DOCKER_IMAGE["${IMAGE}:IMAGE_NAME"]} | awk '{ print $1; }')
    fi 

  fi
}

sanity_check "EAP"
sanity_check "BPM"
sanity_check "FSW"
sanity_check "HEISE_BPM"

case "$1" in
remove)
  case "$2" in
    bpm)
      echo "Removing BPM Image(s)"
      remove_image ${DOCKER_IMAGE["BPM:IMAGE_NAME"]}
      ;;
    fsw)
      echo "Removing FSW Image(s)"
      remove_image ${DOCKER_IMAGE["FSW:IMAGE_NAME"]}
      ;;
    eap)
      echo "Removing EAP Image(s)"
      remove_image ${DOCKER_IMAGE["EAP:IMAGE_NAME"]}
      ;;
    postgres)
      echo "Removing Postgres Image(s)"
      remove_image ${DOCKER_IMAGE["POSTGRES:IMAGE_NAME"]}
      ;;
    heise_bpm)
      echo "Removing Heise_BPM Image(s)"
      remove_image ${DOCKER_IMAGE["HEISE_BPM:IMAGE_NAME"]}
      ;;
    heise_fsw)
      echo "Removing Heise_FSW Image(s)"
      remove_image ${DOCKER_IMAGE["HEISE_FSW:IMAGE_NAME"]}
      ;;
    all)
      echo "Removing All Images"
      remove_all_images
      ;;
    *)
      echo "usage: ${NAME} remove (bpm|fsw|eap|postgres|heise_bpm|heise_fsw|all)"
      exit 1
    esac
    ;;
start)
  # If there is no fsw image running
  if [ ! $( docker ps | grep fsw | wc -l ) -gt 0 ]; then 
    # If there isn't a stopped image
    if [ ! $( docker ps -a | grep fsw | wc -l ) -gt 0 ]; then
      # Create a new FSW Container
      docker run -P -h fsw --name fsw -d ${DOCKER_IMAGE["HEISE_FSW:IMAGE_NAME"]}
    else
      # Start the existing container
      docker start fsw
    fi
  fi

  # If there is no postgres image running
  if [ ! $( docker ps | grep postgres | wc -l ) -gt 0 ]; then 
    # If there isn't a stopped image
    if [ ! $( docker ps -a | grep postgres | wc -l ) -gt 0 ]; then
      # Create a new FSW Container
      docker run -P -h postgres --name postgres -d ${DOCKER_IMAGE["POSTGRES:IMAGE_NAME"]}
    else
      # Start the existing container
      docker start postgres
    fi
  fi

  case "$2" in
    attached)
      # Start the Image and link all exposed ports
      # After the Image is stopped it is automatically removed
      docker run -P --rm --link fsw:fsw ${DOCKER_IMAGE["HEISE_BPM:IMAGE_NAME"]}
      ;;
    *)
      # By default we start the bpm in detached mode with fixed ports
      docker run -p 49160:8080 -p 49170:9990 --link fsw:fsw --link postgres:postgres -d ${DOCKER_IMAGE["HEISE_BPM:IMAGE_NAME"]}
    esac
    ;;
build)
  case "$2" in
    bpm)
      echo "Building BPM Image"
      build_image "BPM"
      ;;
    fsw)
      echo "Building FSW Image"
      build_image "FSW"
      ;;
    eap)
      echo "Building EAP Image"
      build_image "EAP"
      ;;
    postgres)
      echo "Building Postgres Image"
      build_image "POSTGRES"
      ;;
    heise_bpm)
      echo "Building Heise_BPM Image"
      build_image "HEISE_BPM"
      ;;
    heise_fsw)
      echo "Building Heise_FSW Image"
      build_image "HEISE_FSW"
      ;;
    all)
      echo "Building All Images"
      build_image "EAP"
      build_image "BPM"
      build_image "FSW"
      build_image "POSTGRES"
      build_image "HEISE_BPM"
      build_image "HEISE_FSW"
      ;;
    *)
      echo "usage: ${NAME} build (bpm|fsw|eap|postgres|heise_bpm|heise_fsw|all)"
      exit 1
    esac
    ;;
stop)
  case "$2" in
    heise_bpm)
      stop_image "HEISE_BPM"
      ;;
    heise_fsw)
      stop_image "HEISE_FSW"
      ;;
    all)
      stop_image "HEISE_BPM"
      stop_image "HEISE_FSW"
      ;;
    *)
      stop_image "HEISE_BPM"
      stop_image "HEISE_FSW"
      stop_image "POSTGRES"
    esac
    ;;
status)
    docker ps
    ;;
help)
    echo "usage: ${NAME} (remove|start|build|status)"
    ;;
*)
    echo "usage: ${NAME} (remove|start|build|status)"
    exit 1
esac

