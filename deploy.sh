#!/bin/bash

set -eu

ssh pi@raspberrypi.local <<EOS
cd ~/workspace/home_api
docker-compose down
git pull
docker-compose build
docker-compose up -d
EOS
