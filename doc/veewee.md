## Mini User Guide

### Usage as vagrant plug-in

The typical cycle that just rocks:

Note: chef (as puppet) is installed during the build

```
$ vagrant basebox define 'myubuntu' 'ubuntu-12.10-amd64'
$ vi definitions/myunbuntu/definition.rb
     --> tune vRAM ?
$ vi definitions/myunbuntu/postinstall.sh 
     --> change ssh public key ?
$ vagrant basebox  build 'myubuntu'
$ vagrant basebox  validate 'myubuntu'
$ vagrant basebox  export 'myubuntu'

$ vagrant box add 'myubuntu' 'myubuntu.box'
$ vagrant init 'mybuntu'
$ vagrant up
$ vagrant ssh
```

### Other veewee commands

* `veewee vbox up 'myfirstbox'` to start an existing vm with virtualbox, but outside from vagrant
* `veewee vbox list` to list existing definitions 
* `veewee vbox undefine 'myubuntu'` to remove a definition 

### User Documentation Links

* [vagrant.md](https://github.com/jedi4ever/veewee/blob/master/doc/vagrant.md): How to build a new box for vagrant/virtualbox platform
* [running.md](https://github.com/jedi4ever/veewee/blob/master/doc/running.md): Summary of all commands
* [definition.md](https://github.com/jedi4ever/veewee/blob/master/doc/definition.md): Definitions management

## Setup

**requirements:** `rvm` with ruby 1.9.2

```
$ rvm install 1.9.2 #if not yet available on your system
```

```
$ git clone https://github.com/jedi4ever/veewee.git
$ cd veewee
```

Optionally select a final release (stay on master or checkout a tag)

```
$ git checkout v0.3.1
```

Fetch gem dependencies and install

```
$ gem install bundler
$ bundle install
```

for more details: https://github.com/jedi4ever/veewee/blob/master/doc/installation.md

### Troubleshooting the Installation on Mac OS X (10.7)

**Context/History:** 

* macox 10.7, with Xcode cl-tools will be updated from 4.3.x(?) to 4.5.2
* when entering in 'veewee' folder, I receive a warning to invite me to install `1.9.2-p320` (note I had already two older build/version of 1.9.2, but veewee requires p320):

```
   ruby-1.8.7-p352 [ i686 ]
   ruby-1.9.2-p180 [ x86_64 ]
=> ruby-1.9.2-p320 [ x86_64 ]
   ruby-1.9.3-p286 [ x86_64 ]
```

* when running `rvm -debug install 1.9.2`, I get following warning: *No binary rubies available for: osx/10.7/x86_64/ruby-1.9.2-p320.* and thus rvm tries to install ruby from source... **but it fails:** because of a library conflict/duplicate : **libiconv** is standard installed from macosx in /usr/lib/libiconv.*, but I also have a version in `/usr/local/lib/libiconv.*`. There are some known problems around:
 * http://nokogiri.org/tutorials/installing_nokogiri.html
 * https://github.com/sparklemotion/nokogiri/issues/442. A fix may consist to install the brew version, and override autoconf/configure/make parameters to force to use this library (or take the risk to `brew link` it)
 * I ran `brew doctor`, that stressed many warnings, where 2 things sound important to me:
  * the libiconv files were not installed/managed my a brew package... 
  * recommend to install the latest *Mac Command Line Tools* from Apple, **what I did BTW**.
 * I backup the libiconv files and removed them from /usr/local/lib:

```
-rwxrwxr-x  1 gilles  gilles  2014520 27 oct  2009 libiconv.2.dylib
lrwxr-xr-x  1 gilles  gilles       16  4 nov 01:03 libiconv.dylib -> libiconv.2.dylib
-rwxrwxr-x  1 gilles  gilles      908 27 oct  2009 libiconv.la
```
*After I disabled this libaries and rebooted the mac, I could find the owner:* **gnupg + MacGPG2 plugin for Mail App.** Actually `brew doctor` warns about MacGPG2 conflicting setup:

```
Warning: You may have installed MacGPG2 via the package installer.
Several other checks in this script will turn up problems, such as stray
dylibs in /usr/local and permissions issues with share and man in /usr/local/.
```

* Retry `rvm -debug install 1.9.2`, and get new compilation errors...

```
gcc-4.2: error trying to exec '/usr/bin/i686-apple-darwin11-gcc-4.2.1': execvp: No such file or directory
found compiler: gcc-4.2
gcc-4.2: error trying to exec '/usr/bin/i686-apple-darwin11-gcc-4.2.1': execvp: No such file or directory
Installing Ruby from source to: /Users/gilles/.rvm/rubies/ruby-1.9.2-p320, this may take a while depending on your cpu(s)...
ruby-1.9.2-p320 - #downloading ruby-1.9.2-p320, this may take a while depending on your connection...
[2012-11-04 02:00:51] /Users/gilles/.rvm/scripts/fetch http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p320.tar.bz2
current path: /Users/gilles/.rvm/src
command(2): /Users/gilles/.rvm/scripts/fetch http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p320.tar.bz2
ruby-1.9.2-p320 - #extracted to /Users/gilles/.rvm/src/ruby-1.9.2-p320 (already extracted)
Trying patch 'default'.
Partch name 'default'.
All found patches(0): .
ruby-1.9.2-p320 - #configuring
[2012-11-04 02:00:52] env CFLAGS=-I/Users/gilles/.rvm/usr/include LDFLAGS=-L/Users/gilles/.rvm/usr/lib ./configure --enable-shared --disable-install-doc --prefix=/Users/gilles/.rvm/rubies/ruby-1.9.2-p320
current path: /Users/gilles/.rvm/src/ruby-1.9.2-p320
command(7): env CFLAGS=-I/Users/gilles/.rvm/usr/include LDFLAGS=-L/Users/gilles/.rvm/usr/lib ./configure --enable-shared --disable-install-doc --prefix=/Users/gilles/.rvm/rubies/ruby-1.9.2-p320
Error running 'env CFLAGS=-I/Users/gilles/.rvm/usr/include LDFLAGS=-L/Users/gilles/.rvm/usr/lib ./configure --enable-shared --disable-install-doc --prefix=/Users/gilles/.rvm/rubies/ruby-1.9.2-p320', please read /Users/gilles/.rvm/log/ruby-1.9.2-p320/configure.log
There has been an error while running configure. Halting the installation.
gcc-4.2: error trying to exec '/usr/bin/i686-apple-darwin11-gcc-4.2.1': execvp: No such file or directory
```
 * This time the problem was (certainly?) due to the new macosx command line tools:
  * `brew doctor` complaigns with same error, see https://github.com/mxcl/homebrew/issues/11401
  * http://stackoverflow.com/questions/11710568/os-x-10-8-error-trying-to-exec-usr-bin-i686-apple-darwin11-gcc-4-2-1-inst
  * http://jtimberman.housepub.org/blog/2012/02/26/xcode-command-line-tools/
  * https://github.com/mxcl/homebrew/issues/10245
  * **FIXED with following:**

```
$ sudo xcode-select -switch /usr/bin
$ sudo ln -sf /usr/bin/llvm-gcc-4.2 /usr/bin/gcc-4.2
```

* now the installation from source of ruby 1.9.2-p320 succeeds and I could enjoy peewee magic :-)
