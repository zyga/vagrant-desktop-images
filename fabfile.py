from fabric.api import local


release_list = ['precise', 'quantal', 'raring']


def build(release):
    local("vagrant up {release}".format(release=release))
    local("vagrant package {release} --output {release}-desktop-i386".format(
        release=release))


def build_all():
    for release in release_list:
        build(release)
