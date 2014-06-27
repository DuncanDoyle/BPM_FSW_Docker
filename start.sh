#!/bin/bash

docker run -p 49260:8080 -p 49270:9990 -h fsw --name fsw -d psteiner/fsw_heise
docker run -p 49160:8080 -p 49170:9990 --link fsw:fsw --name bpms -d psteiner/heise_bpm

