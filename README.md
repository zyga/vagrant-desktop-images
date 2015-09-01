Vagrant Desktop Images
======================

Ubuntu Desktop images for Vagrant

Why?
====

Because some people like Vagrant and Canonical only publishes server, cloud
images.

How?
====

By taking the vanilla Ubuntu cloud images and installing ``ubuntu-desktop``
meta-package and setting up ``lightdm`` to automatically login the ``vagrant``
user.

Usage (premade images)
======================
These instructions should work on Linux, OS X and Cygwin.

Recommended on Ubuntu, install apt-cacher-ng:

```shell
    sudo apt-get install apt-cacher-ng
```

Make the Ubuntu 14.04 image (i386 version):

```shell
    make trusty-desktop-i386.box
    vagrant box add -f trusty-desktop-i386 trusty-desktop-i386.box
```

Then create this Vagrantfile somewhere and 'vagrant up' it:

```ruby
    # -*- mode: ruby -*-
    # vi: set ft=ruby sw=2 ts=2 :

    Vagrant.configure("2") do |config|
      # Use a basic trusty desktop image from git://github.com/zyga/vagrant-destop-images.git
      config.vm.box = "trusty-desktop-i386"
      # TODO: offer premade images for download
      config.vm.box_url = ""

      # Tweak VirtualBox configuration for GUI applications
      config.vm.provider :virtualbox do |vb|
        vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", 1024]
        vb.customize ["modifyvm", :id, "--vram", 64]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
      end

      # Automatically use local apt-cacher-ng if available
      if File.exists? "/etc/apt-cacher-ng"
        # If apt-cacher-ng is installed on this machine then just use it.
        require 'socket'
        guessed_address = Socket.ip_address_list.detect{|intf| !intf.ipv4_loopback?}
        if guessed_address
          config.vm.provision :shell, :inline => "echo 'Acquire::http { Proxy \"http://#{guessed_address.ip_address}:3142\"; };' > /etc/apt/apt.conf.d/00proxy"
        end
      end

      # Update to have the latest packages, remove if you don't need that
      config.vm.provision :shell, :inline => "apt-get update"
      config.vm.provision :shell, :inline => "DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes"

      # Ready :-)
    end
```
