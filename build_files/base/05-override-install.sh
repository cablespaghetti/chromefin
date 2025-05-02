#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

# Fix for ID in fwupd
dnf5 -y swap \
    --repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
    fwupd fwupd

# Automatic wallpaper changing by month
dnf5 install -y bluefin-backgrounds

# Required for bluefin faces to work without conflicting with a ton of packages
rm -f /usr/share/pixmaps/faces/* || echo "Expected directory deletion to fail"
mv /usr/share/pixmaps/faces/bluefin/* /usr/share/pixmaps/faces
rm -rf /usr/share/pixmaps/faces/bluefin

dnf5 -y swap fedora-logos bluefin-logos

# Register Fonts
fc-cache -f /usr/share/fonts/ubuntu
fc-cache -f /usr/share/fonts/inter

echo "::endgroup::"
