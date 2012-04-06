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
end
