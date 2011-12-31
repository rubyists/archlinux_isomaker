#/usr/bin/env bash
#
# Script executes package installs fromwithin chroot env.

pacman -Syy --noconfirm

# Now we start the builds themselves. Pacman should be happy now, dang it!
echo "**** STARTING BUILDS ****"
echo "**** STARTING BUILDS ****" > 1>&2 
mkdir /tmp/builds
wget http://aur.archlinux.org/packages/fg/fgetty/fgetty.tar.gz
wget http://aur.archlinux.org/packages/ru/runit-dietlibc/runit-dietlibc.tar.gz
wget http://aur.archlinux.org/packages/ru/runit-run/runit-run.tar.gz
wget http://aur.archlinux.org/packages/ru/runit-services/runit-services.tar.gz
wget http://aur.archlinux.org/packages/sv/sv-helper/sv-helper.tar.gz
wget http://aur.archlinux.org/packages/so/socklog-dietlibc/socklog-dietlibc.tar.gz
wget http://aur.archlinux.org/packages/fr/freeswitch-git/freeswitch-git.tar.gz

  # Now extract, build, create, and install AUR packages we grabbed
  # TODO: Change this to a sourced, ordered, file for package install
/bin/su -l callcenter -c 'cd $HOME/builds ; for name in ./*.gz ; do tar -xzvf $name ; done'
/bin/chown -R callcenter:users /home/callcenter/builds
/bin/mknod /dev/null c 1 3
/bin/chmod 0666 /dev/null
cd /tmp/builds/fgetty
makepkg -si --asroot --noconfirm
cd /tmp/builds/runit-dietlibc
makepkg -si --asroot --noconfirm
cd /tmp/builds/runit-run
makepkg -si --asroot --noconfirm
cd /tmp/builds/socklog-dietlibc
makepkg -si --asroot --noconfirm
cd /tmp/builds/runit-services
makepkg -si --asroot --noconfirm
cd /tmp/builds/sv-helper
makepkg -si --asroot --noconfirm
cd /tmp/builds/freeswitch-git
makepkg -si --asroot --noconfirm


