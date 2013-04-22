from fabric.api import local


release_list = ['precise', 'quantal', 'raring']


def build(release):
    local("vagrant up %s" % release)
    local("vagrant package %s --output %s-desktop-i386" % release)


def build_all():
    for release in release_list:
        build(release)
