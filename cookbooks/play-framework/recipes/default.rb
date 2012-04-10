#
# Cookbook Name:: play-framework
# Recipe:: default
#
# Copyright 2012, Gilles Cornu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# include_recipe "zip"
# from https://github.com/fooforge/chef-cookbook_zip.git 
# or
# from https://github.com/phlipper/chef-zip.git
# or simply:
package "unzip"

include_recipe "java"

#TODO
#user node[:playframework][:owner] 
#  shell "/bin/bash"
#  #home...
#  action :create
#end

group node[:playframework][:group] do
  members node[:playframework][:users] 
  append true #add new members, if group already exists
end

directory node[:playframework][:setupdir] do
  owner node[:playframework][:owner] 
  group node[:playframework][:group]
  mode '2775' #enable 'setgid' bit to force inheritance of group write permission
end

play_release = "play-#{node[:playframework][:version]}"
play_package = "#{play_release}.zip"
zippath = File.join(node[:playframework][:downloadsdir], play_package)

remote_file "#{zippath}" do
  source "http://download.playframework.org/releases/#{play_package}"
  backup false
  owner node[:playframework][:owner] 
  group node[:playframework][:group] 
  #checksum
  action :create_if_missing
end

releasedir = File.join(node[:playframework][:setupdir], play_release)

execute "unzip #{zippath} -d #{node[:playframework][:setupdir]}" do
  user  node[:playframework][:owner] 
  group node[:playframework][:group]
  umask "002" # unfortunately it has no effect, because unzip does not respect umask (see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=314832)
  # timeout?
  not_if do 
    File.directory? releasedir
  end 
end

# remove windows .bat script
windows_script = File.join(releasedir, 'play.bat')
execute "rm #{windows_script}" do
  only_if do 
    File.exists? windows_script
  end
end

# Workaround unzip/umask issue mentionned above
# chown root.group for setgid sticky bit inheritance
execute "chmod -R g+w #{releasedir}" do
 #TODO only if folder exists and current permissions differ
end

# chmod o-x
execute "chmod o-x ./play" do
  cwd releasedir
  #TODO only if file exists and current permissions differ
end

#TODO rename as play2
# vagrant@nettuno:~$ play
# The program 'play' is currently not installed.  You can install it by typing:
#  sudo apt-get install sox


#TODO remove this symlink ? template below is maybe enough...
# link new package as default version (for profile.d path) 
# Note: no need to remove exising 'default' link, Chef 'link' resource will replace it by default
# Note: 'link' does not support cwd option, hence impossible to define relative symlink
link File.join(node[:playframework][:setupdir], 'default') do
  to releasedir
end

# Add Play framework to PATH, only for root and member of playframework group
template "/etc/profile.d/playframework.sh" do
  source "profile.d.playframework.sh.erb"
  owner node[:playframework][:owner]
  group node[:playframework][:group]
  mode 0640
  variables(
    :path_to_play => releasedir
  )
end
