#!/usr/bin/env bash
#
#  If you aren't Michael, you probably will never need to run this
#

#echo "Make sure you're connected to a local or remote Docker host, this build takes a long time!"
export DOCKER_HOST=tcp://sysplex2.internal.logitbot.com:2376

gcloud docker -a
docker --tls build --pull --no-cache --rm --tag us.gcr.io/vnext-1254/miniconda2:0.3 .
docker --tls tag us.gcr.io/vnext-1254/miniconda2:0.3 us.gcr.io/vnext-1254/miniconda2:latest
docker --tls push us.gcr.io/vnext-1254/miniconda2:latest

