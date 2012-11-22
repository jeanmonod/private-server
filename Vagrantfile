Vagrant::Config.run do |config|

  # Base box to use

  # Ubuntu 11.10, 32 bit (no more working with latest vagrant/chef-solo/cookbooks stack)
  # config.vm.box     = "oneiric32"
  # config.vm.box_url = "http://files.travis-ci.org/boxes/bases/oneiric32_base.box"

  # Travis-CI base boxes are configured with:
  # - sudoer called 'travis' instead 'vagrant'
  # - another "insecure" keypair as vagrant default:
  config.ssh.username = "travis"
  config.ssh.private_key_path = "vagrant.key"

  # Ubuntu 12.04, 32 bit
  # config.vm.box     = "precise32"
  # config.vm.box_url = "http://files.travis-ci.org/boxes/bases/precise32_base_v2.box"

  # Ubuntu 12.04, 64 bit
  config.vm.box     = "precise64"
  config.vm.box_url = "http://files.travis-ci.org/boxes/bases/precise64_base_v2.box"

  # Network configuration
  config.vm.forward_port 80, 8080 # http

  # Provisionning with chef solo
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.log_level      = :info

    # List of the recipe to execute
    chef.add_recipe     "apt"
    chef.add_recipe     "php_stack" 
  end

  # Use apt-mirror from host, only if .vagrant-shared/var/cache/apt/archives/partial exists
  if File.directory? File.expand_path "./.vagrant-shared/var/cache/apt/archives/partial/"
    config.vm.share_folder "apt-cache", "/var/cache/apt/archives", "./.vagrant-shared/var/cache/apt/archives", :owner => "root", :group => "root"
  end

end
