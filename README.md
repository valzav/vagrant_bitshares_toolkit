# vagrant_bitshares_toolkit

Creates development environment based on Ubuntu 14.04 to build Bitshares Toolkit using Vagrant and VirtualBox.


## Installation

Install VirtualBox, see https://www.virtualbox.org for details.

Install Vagrant, see http://www.vagrantup.com for details.

Clone this project and run vagrant:

    $ git clone https://github.com/valzav/vagrant_bitshares_toolkit.git

    $ cd vagrant_bitshares_toolkit

    $ vagrant up

## Usage

Connect to vagrant VM:

    $ vagrant ssh

Find the source code in ~/bitshares/bitshares_toolkit dir and binaries in ~/bitshares/linux_build

If you want it to use your host machine's development directory instead of creating a new one on guest,
just define BITSHARES_DEV_DIR environment variable before creating VM, e.g.

    $ export BITSHARES_DEV_DIR=/Users/user/bitshares_dev
