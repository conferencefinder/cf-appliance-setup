#!/usr/bin/env bash
# Install CCF and setup local symlinks into /etc, /usr/lib, etc.

export CCF_HOME="${CCF_HOME:-/etc/appliance-setup-framework/container-config-framework}"

sudo apt install make git jq

sudo chmod +x $CCF_HOME/bin/*
sudo ln -s $CCF_HOME/bin/ccfinit /usr/bin/ccfinit
sudo ln -s $CCF_HOME/bin/ccfmake /usr/bin/ccfmake
sudo ln -s $CCF_HOME/bin/jsonnet-v0.11.2 /usr/bin/jsonnet
