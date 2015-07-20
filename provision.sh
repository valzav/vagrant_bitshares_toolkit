#!/bin/sh

sudo apt-get update
sudo apt-get install -y git libreadline-dev uuid-dev g++ libdb++-dev libdb-dev zip
sudo apt-get install -y libssl-dev openssl build-essential python-dev autotools-dev libicu-dev build-essential
sudo apt-get install -y libbz2-dev automake doxygen cmake ncurses-dev libtool nodejs nodejs-legacy npm mc

[ ! -d "bts" ] && mkdir bts && cd bts
[ ! -d "tmp" ] && mkdir tmp
[ ! -d "build" ] && mkdir build
  
# if [ ! -d "graphene" ]; then
#   git clone https://github.com/cryptonomex/graphene.git
#   cd graphene
#   git submodule update --init --recursive
#   cd ~/bts
# fi

# if [ ! -d "tmp/boost_1_57_0" ]; then
#     cd tmp/
#     wget -nv 'http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download'
#     tar -xf download
#     cd boost_1_57_0/
#     ./bootstrap.sh --prefix=/usr/local/
#     sudo ./b2 install
#     cd ~/bts
# fi    

# if [ ! -d "graphene-ui" ]; then
#   git clone https://github.com/cryptonomex/graphene-ui.git
#   cd graphene-ui
#   cd web
#   npm install
#   cd ../dl
#   npm install
#   cd ~/bts
# fi


# cd build
# cmake -DCMAKE_BUILD_TYPE=Debug ../graphene
# make


# below is needed to run ruby, comment this out if you are not planning to use ruby
sudo apt-get install libgdbm-dev libncurses5-dev bison libffi-dev curl gawk libyaml-dev libsqlite3-dev sqlite3

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
rvm install 2.2.2
rvm use 2.2.2 --default
