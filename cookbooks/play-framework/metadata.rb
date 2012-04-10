maintainer       "TODO"
maintainer_email "TODO"
license          "TODO: Apache 2.0"
description      "System-wide Installation of Play Framework 2.x for building Web Applications with Scala or Java"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.0"

%w{ debian ubuntu }.each do |os|
    supports os
end

%w{ java }.each do |cbook|
    depends cbook
end

