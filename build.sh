#!/bin/sh

docker build --tag rinohtype-travis .
docker run --name=rinohtype-travis-container rinohtype-travis
docker cp rinohtype-travis-container:/root/dotlocal.tar.xz .
