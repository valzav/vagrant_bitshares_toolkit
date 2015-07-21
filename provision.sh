#!/bin/sh

export USER_NAME="vagrant"
export USER_HOME="/home/$USER_NAME"

echo_bmsg() {
  /bin/echo -e "\e[1;36m *** $1 ***\e[0m"
}

echo_emsg() {
  /bin/echo -e "\e[1;33m *** $1 ***\e[0m\n"
}

cd $USER_HOME

echo_bmsg "Current user name: `id`"
echo_bmsg "Current dir: `pwd`"

echo_bmsg "updating system.."
sudo apt-get -y update
sudo apt-get -yfV dist-upgrade
echo_emsg "system updated"

echo_bmsg "installing packages.."
sudo apt-get install -yfV git libreadline-dev uuid-dev g++ libdb++-dev libdb-dev zip
sudo apt-get install -yfV libssl-dev openssl build-essential python-dev autotools-dev libicu-dev build-essential
sudo apt-get install -yfV libbz2-dev automake doxygen cmake ncurses-dev libtool nodejs nodejs-legacy npm mc
sudo apt-get -y autoremove
echo_emsg "packages were installed"


[ ! -d "bts" ] && mkdir bts && cd bts
[ ! -d "tmp" ] && mkdir tmp
[ ! -d "build" ] && mkdir build

if [ ! -d "tmp/boost_1_57_0" ]; then
    echo_bmsg "building boost.."
    cd tmp/
    wget -nv 'http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download'
    tar -xf download
    cd boost_1_57_0/
    ./bootstrap.sh --prefix=/usr/local/ > /dev/null
    sudo ./b2 install > /dev/null
    cd ~/bts
    echo_emsg "finished with boost"
fi 
  
echo_bmsg "building bitshares graphene toolkit.."  
if [ ! -d "graphene" ]; then
  git clone https://github.com/cryptonomex/graphene.git
  cd graphene
  git submodule update --init --recursive
  cd ~/bts
fi

if [ ! -d "graphene-ui" ]; then
  git clone https://github.com/cryptonomex/graphene-ui.git
  cd graphene-ui
  cd web
  npm install
  cd ../dl
  npm install
  cd ~/bts
fi

cd build
cmake -DCMAKE_BUILD_TYPE=Debug ../graphene
make -j 4
echo_emsg "finished with graphene"


# below is needed to run ruby and nginx, comment things out if you don't need any of them
echo_bmsg "installing ruby and it's dependencies"
sudo apt-get install -yfV libgdbm-dev libncurses5-dev bison libffi-dev curl gawk libyaml-dev libsqlite3-dev sqlite3
sudo apt-get install -yfV libcurl4-openssl-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev libffi-dev python-software-properties

export DEFAULT_RUBY="2.2.2"

git clone https://github.com/sstephenson/rbenv.git $USER_HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $USER_HOME/.rbenv/plugins/ruby-build

echo '' >> $USER_HOME/.bashrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $USER_HOME/.bashrc
echo 'eval "$(rbenv init -)"'               >> $USER_HOME/.bashrc
echo 'gem: --no-document'                   >> $USER_HOME/.gemrc
$USER_HOME/.rbenv/bin/rbenv install -s $DEFAULT_RUBY
$USER_HOME/.rbenv/bin/rbenv global $DEFAULT_RUBY
mkdir $USER_HOME/.rbenv/plugins
git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
echo_emsg "finished with ruby"

echo_bmsg "installing passenger and nginx"
$USER_HOME/.rbenv/bin/rbenv exec gem install bundler rails passenger
$USER_HOME/.rbenv/bin/rbenv sudo passenger-install-nginx-module --auto > /dev/null

sudo ln -s /opt/nginx/ /usr/local/nginx
sudo ln -s /opt/nginx/conf/ /etc/nginx

sudo wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d -f nginx defaults
sudo service nginx start

echo_emsg "done."
