#!/bin/bash

if [ ! $( docker ps | grep fsw | wc -l ) -gt 0 ]; then 
  if [ ! $( docker ps -a | grep fsw | wc -l ) -gt 0 ]; then
    docker run -P -h fsw --name fsw -d psteiner/heise_fsw
  else
    docker start fsw
  fi
fi

docker run -P --rm --link fsw:fsw psteiner/heise_bpm


