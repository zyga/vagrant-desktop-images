Vagrant Desktop Images
======================

Ubuntu Desktop images for Vagrant


Why?
====

Because some people like Vagrant and Ubuntu only publishes cloud images (server)


How?
====

By taking the vanilla Ubuntu cloud images and installing
``ubuntu-desktop`` meta-package and setting up ``lightdm`` to
automatically login the ``vagrant`` user.

Usage
=====

Because actual .box files are very large, updating them would require
a lot of bandwidth, and make peer review harder, the actual images are
provided as a recipe that modifies official cloud images. To generate
your set you will need the following tools:

1) vagrant (>= 1.0.6)

2) GNU make

To generate all images simply run::

    $ make

To generate a specific release only::

    $ make raring

Ready to bring up your image and start using it?

    $ make launch-raring

This will create a new Vagrant project using the raring desktop box,
and boot directly into Unity. When you're done, just delete the raring
directory that was created.
