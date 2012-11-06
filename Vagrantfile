Vagrant::Config.run do |config|

  # Base box to use
  config.vm.box = "ubuntu-121064"   # Ubuntu 12.10 64 bit, with Chef-solo 10.16.2 and VirtualBox Guest Additions 4.2.4
  config.vm.box_url = "https://dl.dropbox.com/u/10717540/vagrant/ubuntu-121064.box"

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
