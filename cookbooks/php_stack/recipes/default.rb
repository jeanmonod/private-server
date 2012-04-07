require_recipe "apache2"
require_recipe "apache2::mod_php5"
require_recipe "php"

# Remove the default apache site
execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :restart, resources(:service => "apache2")
end

# Create a basic PHP website in /tmp
directory "/var/www/hello-world" do
  mode 0777
  action :create
end
template "/var/www/hello-world/index.php" do
  source "hello-world.php"
  mode 0666
end

# Configure the apache vhost
web_app "hello-world" do
  template "hello-world.conf.erb"
  docroot "/var/www/hello-world"
  notifies :restart, resources(:services => "apache2")
end