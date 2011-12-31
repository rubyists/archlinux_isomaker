#!/usr/bin/env bash

BUILD_TREE="$HOME/build/archlinux_isomaker/configs/releng"
cd $BUILD_TREE

# Update root-image
cd $BUILD_TREE/root-image/home/arch/
rm -rf tcc_arch_installer
git clone git://github.com/rubyists/tcc_arch_installer
cd tcc_arch_installer

# Update any changes to within $BUILD_TREE
sudo cp -R rubyists/aif_build_module $BUILD_TREE/root-image/usr/lib/aif/user/
sudo cp rubyists/default_build/root-image/root/rubyists_configure_box $BUILD_TREE/root-image/root/

cd $BUILD_TREE

# Clean ArchISO work and out trees, then rebuild.
sudo rm -f out/*.iso
sudo bash ./build.sh purge single all
sudo /usr/bin/time -p bash ./build.sh build single all

# Now copy the core ISO off to the host for the VM(s)
scp out/archlinux*-core-x86_64.iso pgpmbp:~/

