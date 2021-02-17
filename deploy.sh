#!/bin/bash

set -eu

ssh pi@raspberrypi.local <<EOS
cd ~/workspace/home_api
docker-compose down
git pull
docker-compose build
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
EOS
