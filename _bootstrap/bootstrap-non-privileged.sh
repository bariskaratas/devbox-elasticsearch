#!/usr/bin/env bash

# define elasticsearch version and build
ES_VERSION="7.15.1"
ES_BUILD="linux-x86_64"

# get elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION-$ES_BUILD.tar.gz

# extract elasticsearch
tar -zxvf elasticsearch-$ES_VERSION-$ES_BUILD.tar.gz

# remove downloaded file
rm elasticsearch-$ES_VERSION-$ES_BUILD.tar.gz

# update elasticsearch configuration file
cp /home/vagrant/_bootstrap/config/elasticsearch.yml /home/vagrant/elasticsearch-$ES_VERSION/config/elasticsearch.yml

# prepare rvm installation
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

# install rvm
curl -L https://get.rvm.io | bash -s stable --ruby --autolibs=enable --auto-dotfiles
source /home/vagrant/.rvm/scripts/rvm

# install dependencies for ELK
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudp apt-get update
sudo apt-get install -y logstash
wget https://artifacts.elastic.co/downloads/kibana/kibana-$ES_VERSION-$ES_BUILD.tar.gz
tar -zxvf kibana-$ES_VERSION-$ES_BUILD.tar.gz
rm kibana-$ES_VERSION-$ES_BUILD.tar.gz
