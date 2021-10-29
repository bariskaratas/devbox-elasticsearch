#!/usr/bin/env bash

# update machine
apt-get update

# prepare rvm installation - remove current installtion for clean setup later
rvm cleanup all
sudo apt-get --purge remove ruby-rvm
sudo rm -rf /usr/share/ruby-rvm /etc/rvmrc /etc/profile.d/rvm.sh

# install curl
sudo apt-get install -y curl

# install java 8
sudo apt-get install -y openjdk-8-jdk

# install unzip
sudo apt-get install -y unzip

# install git
sudo apt-get install -y git

# prepare vm specific requirements for elasticsearch
echo vm.max_map_count=262144 > /etc/sysctl.d/vm_max_map_count.conf
sysctl --system
grep -qF 'vagrant - nofile 65536' /etc/security/limits.conf || echo 'vagrant - nofile 65536' >> /etc/security/limits.conf

# install pip
sudo apt-get install -y python-pip

# install npm
sudo apt-get install -y npm