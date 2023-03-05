#!/bin/bash
sudo apt-get install docker
sudo mkdir -p /app/opencex
chown `whoami` /app/opencex
source ./opencex.sh
