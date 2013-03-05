maintainer       "TODO"
maintainer_email "TODO"
license          "TODO: Apache 2.0"
description      "TODO"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.0"

%w{ debian ubuntu }.each do |os|
    supports os
end

%w{ apache2 php }.each do |cb|
    depends cb
end

