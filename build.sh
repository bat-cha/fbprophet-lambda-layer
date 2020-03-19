#!/bin/bash -x

set -e

rm -rf layer
docker build -t fbprophet-lambda-layer .
CONTAINER=$(docker run -d fbprophet-lambda-layer false)
docker cp $CONTAINER:/var/task/venv/lib/python3.7/site-packages layer
docker rm $CONTAINER