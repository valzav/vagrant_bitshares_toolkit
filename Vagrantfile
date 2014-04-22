VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'ubuntu_trusty_x64'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.provision 'shell', :privileged => false, :path => 'provision.sh'
  #config.ssh.forward_agent = true
  #config.ssh.forward_x11 = true
  if ENV['BITSHARES_DEV_DIR']
    bitshares_dir = ENV['BITSHARES_DEV_DIR']
    config.vm.synced_folder bitshares_dir, '/home/vagrant/bitshares'
  end

  config.vm.provider :virtualbox do |v|
    v.customize ['modifyvm', :id, '--memory', '1024']
    v.customize ['modifyvm', :id, '--cpus', 4]
  end

end
