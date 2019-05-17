#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

export CCF_PATH=/opt/event-navigator-containers
cd $CCF_PATH

title "Update liquibase database changelog file"
sudo git fetch
sudo git checkout origin/master cf-hasura/etc/liquibase/nen.postgresql.sql

title "Remove Dangling untagged container images"
sudo ccfmake clean-dangling-untagged-container-images

title "Update image to latest"
sudo docker pull hasura/graphql-engine

title "Recreate api and web containers"
cd $CCF_PATH/cf-hasura
sudo ccfmake stop
sudo ccfmake start
cd $CCF_PATH/cf-ui
sudo ccfmake stop
sudo ccfmake build
sudo ccfmake start
