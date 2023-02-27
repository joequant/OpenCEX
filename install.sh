#!/bin/bash
sudo mkdir -p /app/opencex
sudo chown `whoami` /app/opencex
source ./config.sh
bash ./opencex.sh
