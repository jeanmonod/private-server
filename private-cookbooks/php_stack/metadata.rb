maintainer        "TODO"
maintainer_email  "TODO"
license           "Apache 2.0"
description       "TODO"
version           "0.0.0"

%w{ debian ubuntu centos redhat fedora scientific amazon }.each do |os|
  supports os
end

%w{ apache2 php }.each do |cb_dep|
  depends cb_dep 
end

recipe "php_stack", "Enable PHP5 module in apache and setup a basic web site"

