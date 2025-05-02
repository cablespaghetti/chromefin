#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

# Watermark for Plymouth
cp /usr/share/plymouth/themes/spinner/{silverblue-,}watermark.png

echo "::endgroup::"
