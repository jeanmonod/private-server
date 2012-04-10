Vagrant::Config.run do |config|

  # Base box to use
  config.vm.box     = "oneiric32"
  config.vm.box_url = "http://files.travis-ci.org/boxes/bases/oneiric32_base.box"

  # Network configuration
  config.vm.forward_port 80,   8080     # HTTP Web Server (Apache or Nginx)
  config.vm.forward_port 9000, 9090     # Play embedded application server

  # Provisionning with chef solo
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.log_level      = :info

    # List of the recipe to execute
    chef.add_recipe     "apt"

    chef.add_recipe     "php_stack"

    chef.add_recipe     "play-framework"
  end

  # Use apt-mirror from host, only if .vagrant-shared/var/cache/apt/archives/partial exists
  if File.directory? File.expand_path "./.vagrant-shared/var/cache/apt/archives/partial/"
    config.vm.share_folder "apt-cache", "/var/cache/apt/archives", "./.vagrant-shared/var/cache/apt/archives", :owner => "root", :group => "root"
  end

end
