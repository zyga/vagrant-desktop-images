# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 :

Vagrant::Config.run do |config|

  config.ssh.timeout = 60

  [:precise, :quantal, :raring, :saucy, :trusty].each do |release|
    config.vm.define release do |conf|
      conf.vm.box = "#{release}-cloud-i386"
      conf.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/#{release}/current/#{release}-server-cloudimg-i386-vagrant-disk1.box"
    end
  end

  # For debugging and later future GUI testing
  if ENV.key? "VAGRANT_GUI"
    config.vm.boot_mode = :gui
  end

  # Setup an apt cache if one is available
  if ENV.key? "VAGRANT_APT_CACHE"
    config.vm.provision :shell, :inline => "echo 'Acquire::http { Proxy \"#{ENV['VAGRANT_APT_CACHE']}\"; };' > /etc/apt/apt.conf"
  end

  # Update to have the latest packages, this is needed because the image comes
  # with an old (and no longer working) apt cache and links to many packages no
  # longer work.
  config.vm.provision :shell, :inline => "apt-get update && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes"
  # Install dependencies from native packages
  config.vm.provision :shell, :inline => "apt-get install --yes ubuntu-desktop"
  # Auto-login the vagrant user
  config.vm.provision :shell, :inline => "echo 'autologin-user=vagrant' >> /etc/lightdm/lightdm.conf"
  # Purge the apt cache to make the image smaller
  config.vm.provision :shell, :inline => "apt-get clean"

  # De-configure the apt cache if one was created before
  # This is important because we need to package the image afterwards
  if ENV.key? "VAGRANT_APT_CACHE"
    config.vm.provision :shell, :inline => "rm -f /etc/apt/apt.conf"
  end
end
