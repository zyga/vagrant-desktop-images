Vagrant Desktop Images
======================

Ubuntu Desktop images for Vagrant


Why?
====

Because some people like Vagrant and Ubuntu only publishes cloud images (server)


How?
====

By taking the vanilla Ubuntu cloud images and installing ``ubuntu-desktop``
meta-package and setting up ``lightdm`` to automatically login the ``vagrant``
user.

Usage
=====

Because actual .box files are very large, updating them would require a lot of
bandwidth, and make peer review harder, the actual images are provided as a
recipe that modifies official cloud images. To generate your set you will only
need vagrant.
