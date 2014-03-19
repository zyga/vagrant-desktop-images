# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 :

Vagrant.configure("2") do |config|

  [:precise, :quantal, :raring, :saucy, :trusty].each do |release|
    config.vm.define release do |conf|
      conf.vm.box = "#{release}-cloud-i386"
      conf.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/#{release}/current/#{release}-server-cloudimg-i386-vagrant-disk1.box"
    end
    config.vm.define "#{release}64" do |conf|
      conf.vm.box = "#{release}-cloud-amd64"
      conf.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/#{release}/current/#{release}-server-cloudimg-amd64-vagrant-disk1.box"
    end
  end

  config.vm.provider :virtualbox do |vb|
    if ENV.key? "VAGRANT_GUI"
      vb.gui = true
    end

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", 1024]
    #vb.customize ["modifyvm", :id, "--vram", 64]
    #vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end

  # Provision the machine with puppet
  config.vm.provision :puppet
end
