VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :digital_ocean do |provider, override|
    override.vm.hostname = 'bitsharesxt'
    override.ssh.private_key_path = ENV['VAGRANT_KEY_PATH']
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
    provider.setup = true
    provider.ca_path = '/etc/ssl/certs/ca-certificates.crt'
    provider.region = 'New York 1'
    provider.image = 'Ubuntu 14.04 x64'
    provider.size = '1GB'
    provider.client_id = ENV['DIGITALOCEAN_CLIENT_ID']
    provider.api_key = ENV['DIGITALOCEAN_API_KEY']
    override.ssh.forward_agent = true
    override.ssh.forward_x11 = true
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_KEY']
    aws.keypair_name = $1 if ENV['VAGRANT_KEY_PATH'] =~ /([\w]+)[\.\w]*$/
    aws.region = "us-east-1"
    aws.ami = 'ami-018c9568'
    aws.instance_type = 'm1.small'
    aws.security_groups = [ 'bitsharesxt' ]
    override.vm.hostname = 'bitsharesxt-aws'
    override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = ENV['VAGRANT_KEY_PATH']
    override.vm.box = 'dummy'
    override.ssh.forward_agent = true
    override.ssh.forward_x11 = true
  end

  config.vm.provider :virtualbox do |v|
    v.customize ['modifyvm', :id, '--memory', '2048']
    v.customize ['modifyvm', :id, '--cpus', 4]
    v.vm.box = 'ubuntu_trusty_x64'
    v.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
    v.vm.provision 'shell', :privileged => false, :path => 'provision.sh'
    v.ssh.private_key_path = ENV['VAGRANT_KEY_PATH']
    v.ssh.forward_agent = true
    v.ssh.forward_x11 = true
    if ENV['BITSHARES_DEV_DIR']
      bitshares_dir = ENV['BITSHARES_DEV_DIR']
      v.vm.synced_folder bitshares_dir, '/home/vagrant/bitshares'
    end
  end

  config.vm.provision 'shell', :privileged => false, :path => 'provision.sh'

end
