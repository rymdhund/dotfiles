#!/bin/bash
set -e

git clone https://github.com/powerline/fonts /tmp/fonts-xyz

font="DejaVu Sans Mono for Powerline Book 11"

find_command="find \"/tmp/fonts-xyz\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

font_dir="$HOME/.fonts"
mkdir -p $font_dir

# Copy all fonts to user fonts directory
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
echo "Resetting font cache, this may take a moment..."
fc-cache -v -f $font_dir

echo "All Powerline fonts installed to $font_dir"

if [ ! $(command -v gsettings >/dev/null 2>&1) ]; then
  # setup gnome terminal
  profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
  echo $profile
  profile=${profile:1:-1} # remove leading and trailing single quotes
  gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" font "$font"
  gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" use-system-font false

  echo "Gnome terminal setup to use $font"
fi
