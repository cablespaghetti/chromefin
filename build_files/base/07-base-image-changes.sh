#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

# Create symlinks from old to new wallpaper names for backwards compatibility
ln -s "/usr/share/backgrounds/bluefin/01-bluefin.xml" "/usr/share/backgrounds/bluefin/bluefin-winter-dynamic.xml"
ln -s "/usr/share/backgrounds/bluefin/04-bluefin.xml" "/usr/share/backgrounds/bluefin/bluefin-spring-dynamic.xml"
ln -s "/usr/share/backgrounds/bluefin/08-bluefin.xml" "/usr/share/backgrounds/bluefin/bluefin-summer-dynamic.xml"
ln -s "/usr/share/backgrounds/bluefin/11-bluefin.xml" "/usr/share/backgrounds/bluefin/bluefin-autumn-dynamic.xml"
ln -s "/usr/share/backgrounds/xe_clouds.jxl" "/usr/share/backgrounds/xe_clouds.jpeg"
ln -s "/usr/share/backgrounds/xe_foothills.jxl" "/usr/share/backgrounds/xe_foothills.jpeg"
ln -s "/usr/share/backgrounds/xe_space_needle.jxl" "/usr/share/backgrounds/xe_space_needle.jpeg"
ln -s "/usr/share/backgrounds/xe_sunset.jxl" "/usr/share/backgrounds/xe_sunset.jpeg"

# Test bluefin gschema override for errors. If there are no errors, proceed with compiling bluefin gschema, which includes setting overrides.
mkdir -p /tmp/bluefin-schema-test
find /usr/share/glib-2.0/schemas/ -type f ! -name "*.gschema.override" -exec cp {} /tmp/bluefin-schema-test/ \;
cp /usr/share/glib-2.0/schemas/zz0-bluefin-modifications.gschema.override /tmp/bluefin-schema-test/
#cp /usr/share/glib-2.0/schemas/zz1-bluefin-modifications-mutter-exp-feats.gschema.override /tmp/bluefin-schema-test/
echo "Running error test for bluefin gschema override. Aborting if failed."
# We should ideally refactor this to handle multiple GNOME version schemas better
glib-compile-schemas --strict /tmp/bluefin-schema-test
echo "Compiling gschema to include bluefin setting overrides"
glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null

# Watermark for Plymouth
cp /usr/share/plymouth/themes/spinner/{silverblue-,}watermark.png

echo "::endgroup::"
