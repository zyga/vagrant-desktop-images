class base {
  $apt_proxy = ""
  if $apt_proxy {
    file { 'apt-get proxy config':
      before  => Exec['apt-get update', 'apt-get dist-upgrade'],
      path    => '/etc/apt/apt.conf.d/00proxy',
      ensure  => present,
      content => "Acquire::http::Proxy \"${apt_proxy}\";\n"
    }
  }
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
  exec { 'apt-get dist-upgrade':
    require => Exec['apt-get update'],
    command => '/usr/bin/apt-get dist-upgrade --yes'
  }
}

class virtualbox_x11 {
  package {
      "virtualbox-guest-dkms":      ensure => installed;
      "virtualbox-guest-x11":       ensure => installed;
  }
}

class unity_desktop {
  package { "ubuntu-desktop":
    ensure => present
  }
  file { 'lightdm.conf':
    require => Package['ubuntu-desktop'],
    path    => '/etc/lightdm/lightdm.conf',
    ensure  => present,
    mode    => 0644,
    owner   => root,
    group   => root,
    content => "[SeatDefaults]\ngreeter-session=unity-greeter\nuser-session=ubuntu\nautologin-user=vagrant\n"
  }
  service { 'lightdm':
    require => File['lightdm.conf'],
    ensure  => running,
  }
}

class screensaver_settings {
  package { "dconf-tools":
    ensure  => present
  }
  exec {
      'disable screensaver lock':
          command => "/bin/sh -c 'DISPLAY=:0 dconf write /org/gnome/desktop/screensaver/lock-enabled false'",
          onlyif  => "/bin/sh -c 'test $(DISPLAY=:0 dconf read /org/gnome/desktop/screensaver/lock-enabled) != false'",
          require => [Package['dconf-tools', 'ubuntu-desktop'], Service['lightdm']],
          user    => 'vagrant',
       ;
      'disable screensaver lock after suspend':
          command => "/bin/sh -c 'DISPLAY=:0 dconf write /org/gnome/desktop/screensaver/ubuntu-lock-on-suspend false'",
          onlyif  => "/bin/sh -c 'test $(DISPLAY=:0 dconf read /org/gnome/desktop/screensaver/ubuntu-lock-on-suspend) != false'",
          require => [Package['dconf-tools', 'ubuntu-desktop'], Service['lightdm']],
          user    => 'vagrant',
       ;
       'set idle delay to zero':
          command => "/bin/sh -c 'DISPLAY=:0 dconf write /org/gnome/session/idle-delay 0'",
          onlyif  => "/bin/sh -c 'test $(DISPLAY=:0 dconf read /org/gnome/session/idle-delay) != 0'",
          require => [Package['dconf-tools', 'ubuntu-desktop'], Service['lightdm']],
          user    => 'vagrant',
       ;
       'disable monitor sleep on AC':
          command => "/bin/sh -c 'DISPLAY=:0 dconf write /org/gnome/settings-daemon/plugins/power/sleep-display-ac 0'",
          onlyif  => "/bin/sh -c 'test $(DISPLAY=:0 dconf read /org/gnome/settings-daemon/plugins/power/sleep-display-ac) != 0'",
          require => [Package['dconf-tools', 'ubuntu-desktop'], Service['lightdm']],
          user    => 'vagrant',
       ;
       'disable monitor sleep on battery':
          command => "/bin/sh -c 'DISPLAY=:0 dconf write /org/gnome/settings-daemon/plugins/power/sleep-display-battery 0'",
          onlyif  => "/bin/sh -c 'test $(DISPLAY=:0 dconf read /org/gnome/settings-daemon/plugins/power/sleep-display-battery) != 0'",
          require => [Package['dconf-tools', 'ubuntu-desktop'], Service['lightdm']],
          user    => 'vagrant',
       ;
       'disable remind-reload query':
          command => "/bin/sh -c 'DISPLAY=:0 dconf write /apps/update-manager/remind-reload false'",
          onlyif  => "/bin/sh -c 'test $(DISPLAY=:0 dconf read /apps/update-manager/remind-reload) = true'",
          user    => 'vagrant',
          require => [Package['dconf-tools', 'ubuntu-desktop'], Service['lightdm']],
          ;
  }
}

include base
include virtualbox_x11
include unity_desktop
include screensaver_settings
