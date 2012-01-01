#/usr/bin/env bash
#
# Script executes package installs fromwithin chroot env.

pacman -Syy --noconfirm
pacman --noprogressbar --noconfirm --logfile $HOME/pacman_install_and_upgrade.log -Syu

# Add 'callcenter' user now that we've populated it's homedir with the authorized_keys file.
/usr/sbin/useradd -g users -G wheel -s /bin/bash callcenter
# Ensure that callcenter owns it's homedir and files, then su to callcenter to start pkg builds.
/bin/chown -R callcenter:users /home/callcenter

# Configure our preferred, minimalistic, sudoers file
# Removing here ensures sudo package has no reason to fail.
if [ -f "/etc/sudoers" ]; then
  rm -f /etc/sudoers
fi

pacman -S fakeroot tmux git devtools sudo --needed --noconfirm

# Configure our preferred, minimalistic, sudoers file
# Removing here ensures sudo package has no reason to fail.
if [ -f "/etc/sudoers" ]; then
  rm -f /etc/sudoers
fi

# Create our own sudoers file, and ensure perms and ownerships
echo "root ALL=(ALL) ALL" > ./sudoers
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> ./sudoers
mv -f ./sudoers /etc/sudoers
chmod 0440 /etc/sudoers
chown root:root /etc/sudoers

# Now we start the builds themselves. Pacman should be happy now, dang it!
echo "**** STARTING BUILDS ****"
 
mkdir /tmp/builds
cd /tmp/builds
wget http://aur.archlinux.org/packages/fg/fgetty/fgetty.tar.gz
wget http://aur.archlinux.org/packages/ru/runit-dietlibc/runit-dietlibc.tar.gz
wget http://aur.archlinux.org/packages/ru/runit-run/runit-run.tar.gz
wget http://aur.archlinux.org/packages/ru/runit-services/runit-services.tar.gz
wget http://aur.archlinux.org/packages/sv/sv-helper/sv-helper.tar.gz
wget http://aur.archlinux.org/packages/so/socklog-dietlibc/socklog-dietlibc.tar.gz
wget http://aur.archlinux.org/packages/fr/freeswitch-git/freeswitch-git.tar.gz

  # Now extract, build, create, and install AUR packages we grabbed
  # TODO: Change this to a sourced, ordered, file for package install
for name in ./*.gz ; do tar -xzvf $name ; done

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