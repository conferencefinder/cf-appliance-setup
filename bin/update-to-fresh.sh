#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

export CCF_PATH=/opt/event-navigator-containers
export ASF_PATH=/etc/appliance-setup-framework

title "Update ASF to latest"
cd $ASF_PATH
sudo git fetch
sudo git reset --hard origin/master > /dev/null

title "Remove current cf-containers"
for CONTAINER in $(ls $CCF_PATH)
do
    if [[ $CONTAINER =~ ^cf-* ]];
    then
        cd $CCF_PATH/$CONTAINER
        sudo ccfmake kill
        sudo ccfmake clean-images > /dev/null 2>&1
    fi
done
cd $ASF_PATH
sudo rm -rf $CCF_PATH

title "Update the following images to latest"
sudo docker pull hasura/graphql-engine:latest
sudo docker pull grafana/loki:latest
sudo docker pull grafana/promtail:latest
sudo docker pull webdevops/liquibase:postgres
sudo docker pull nginx:alpine
sudo docker pull alpine:latest
sudo docker pull postgres:latest
sudo docker pull grafana/grafana:latest
sudo docker pull ubuntu:18.04
sudo docker pull prom/prometheus:latest
sudo docker pull traefik:v1.7.9-alpine
sudo docker pull node:8.12-alpine

title "Remove Exited containers"
sudo ccfmake clean-exited-containers > /dev/null 2>&1

title "Remove Dangling untagged container images"
sudo ccfmake clean-dangling-untagged-container-images

title "Container installation playbook"
sudo ansible-playbook -i "localhost," -c local playbooks/05_ccf-containers.ansible-playbook.yml --extra-vars="asf_user=$(whoami)"
