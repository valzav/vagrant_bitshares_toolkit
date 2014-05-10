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


### Deploying to Digital Ocean

Install vagrant-digitalocean plugin:

	$ vagrant plugin install vagrant-digitalocean

On Mac you may need to install a CA bundle to enable SSL communication with the Digital Ocean API:

	$ brew install curl-ca-bundle
	$ export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

Then define two environement variables with Digital Ocean's client id and API key:

	$ export ENV['DIGITALOCEAN_CLIENT_ID'] = 'xxxxxxx'
	$ export ENV['DIGITALOCEAN_API_KEY'] = 'xxxxxxxxxxxx' 

Now you can fire up your Digital Ocean isntance:

	$ vagrant up --provider digital_ocean
