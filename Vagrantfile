# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 :

Vagrant.configure("2") do |config|

  # Quantal is broken
  [:precise, :raring, :saucy, :trusty].each do |release|
    config.vm.define "#{release}-desktop-i386" do |conf|
      conf.vm.box = "#{release}-cloud-i386"
      conf.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/#{release}/current/#{release}-server-cloudimg-i386-vagrant-disk1.box"
    end
    config.vm.define "#{release}-desktop-amd64" do |conf|
      conf.vm.box = "#{release}-cloud-amd64"
      conf.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/#{release}/current/#{release}-server-cloudimg-amd64-vagrant-disk1.box"
    end
  end

  # Tweak VirtualBox configuration for GUI applications
  config.vm.provider :virtualbox do |vb|
    if ENV.key? "VAGRANT_GUI"
      vb.gui = true
    end
    vb.customize ["modifyvm", :id, "--memory", 1024]
    #vb.customize ["modifyvm", :id, "--vram", 64]
    #vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
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

  # Provision the machine with puppet
  config.vm.provision :puppet

  # Do post-provisioning cleanup
  config.vm.provision :shell, :inline => "apt-get autoremove --purge --yes"
  config.vm.provision :shell, :inline => "apt-get clean"
  config.vm.provision :shell, :inline => "rm -f /etc/apt/apt.conf.d/00proxy"

end
