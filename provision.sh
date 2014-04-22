#!/bin/sh

# install packages
sudo apt-get update
sudo apt-get install -y git libreadline-dev uuid-dev g++ libdb++-dev libdb-dev zip
sudo apt-get install -y libssl-dev openssl build-essential python-dev autotools-dev libicu-dev build-essential
sudo apt-get install -y libbz2-dev libboost-dev libboost-all-dev cmake

# create directories structure
[ ! -d "bitshares" ] && mkdir bitshares # bitshares dir can be already mounted from host machine

# download bitshares_toolkit if not already present
cd bitshares
if [ ! -d "bitshares_toolkit" ]; then
  git clone https://github.com/BitShares/bitshares_toolkit.git
  cd bitshares_toolkit
  git submodule init
  git submodule update
  cd ..
fi

# build bitshares_toolkit
mkdir linux_build
cd linux_build
cmake ../bitshares_toolkit
make
