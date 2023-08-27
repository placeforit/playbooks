#! /bin/bash

# Install system packages
sudo apt install -y git python3-pip

# Download playbooks
mkdir -p ~/github.com/placeforit/playbooks
git clone https://github.com/placeforit/playbooks ~/github.com/placeforit/playbooks

# Install python packages
cd ~/github.com/placeforit/playbooks
sudo pip3 install -r requirements.txt
