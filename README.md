# vagrant_bitshares_toolkit

Creates development environment based on Ubuntu 14.04 to build Bitshares Toolkit using Vagrant and VirtualBox.


## Installation

Install VirtualBox, see https://www.virtualbox.org for details.

Install Vagrant, see http://www.vagrantup.com for details.

Define VAGRANT_KEY_PATH env variable - this is a path to your private key that you would use to connect your instance via ssh:
e.g. :

	$ export VAGRANT_KEY_PATH="~/.ssh/vagrant_key"

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

Login to your Digital Account, create ssh key named "vagrant" using vagrant_key.pub, go to API section and create personal access token.
Then define environement variable with Digital Ocean's API token:

	$ export DIGITALOCEAN_TOKEN="xxxxxxx"

Now you can fire up a Digital Ocean isntance:

	$ vagrant up --provider digital_ocean


### Deploying to Amazon EC2

Install aws plugin and dummy box (vagrant needs a box to be specified, so dummy box is used):

	$ vagrant plugin install vagrant-aws
	$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box

Login to AWS console and create security group 'bitsharesxt' and allow SSH access.
Define two env variables with your AWS security credentials:

	$ export AWS_ACCESS_KEY="xxxxxxxxxx"
	$ export AWS_SECRET_KEY="xxxxxxxxxxxxxxxxxxxxxxx"

Start your instance:

	$ vagrant up --provider=aws
