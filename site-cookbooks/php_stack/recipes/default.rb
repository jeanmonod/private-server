require_recipe "apache2"
require_recipe "apache2::mod_php5"

# Disable the default apache site
apache_site 'default' do
  enable false
end

# Create a basic PHP website 
directory "/var/www/hello-world" do
  mode 0777
  action :create
  not_if do 
    File.directory? "/var/www/hello-world"
  end
end
template "/var/www/hello-world/index.php" do
  source "hello-world.php"
  mode 0666
end

# Configure and enable basic apache vhost
web_app "hello-world" do
  template "hello-world.conf.erb"
  docroot "/var/www/hello-world"
end

