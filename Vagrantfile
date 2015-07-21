VAGRANTFILE_API_VERSION = '2'


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'ubuntu_trusty_x64'
  config.vm.provision "shell", path: "provision.sh", privileged: false
  config.ssh.username = 'vagrant'

  # look for more options here https://github.com/smdahlen/vagrant-digitalocean
  config.vm.provider :digital_ocean do |provider, override|
    override.vm.hostname = 'graphene'
    override.ssh.private_key_path = ENV['VAGRANT_KEY_PATH']
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
    provider.setup = true
    provider.region = 'nyc2'
    provider.image = 'ubuntu-14-04-x64'
    provider.size = '4GB'
    provider.token = ENV['DIGITALOCEAN_TOKEN']
    provider.ssh_key_name = 'vagrant'
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
  end

  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--memory', '4096']
    v.customize ['modifyvm', :id, '--cpus', 4]
  end

end
