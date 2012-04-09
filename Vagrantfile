Vagrant::Config.run do |config|

  # Base box to use
  config.vm.box     = "oneiric32"
  config.vm.box_url = "http://files.travis-ci.org/boxes/bases/oneiric32_base.box"

  # Provisionning with chef solo
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.log_level      = :info

    # List of the recipe to execute
    chef.add_recipe     "apt"

  end

  # Use apt-mirror from host, only if .vagrant-shared/var/cache/apt/archives/partial exists
  if File.directory? File.expand_path "./.vagrant-shared/var/cache/apt/archives/partial/"
    config.vm.share_folder "apt-cache", "/var/cache/apt/archives", "./.vagrant-shared/var/cache/apt/archives", :owner => "root", :group => "root"
  end

end
