#!/bin/bash

# Make alt-tab switch windows instead of "applications" so we dont get grouping
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"

# Make alt-tab only switch apps in current workspace
# gsettings set org.gnome.shell.app-switcher current-workspace-only true


# Use 9 fixed workspaces
gsettings set org.gnome.shell.overrides dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 9


# Use workspaces on secondary monitor as well
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

# Make doubleclick select a whole url
puuid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$puuid/ \
    word-char-exceptions '@ms "-=&#:/.?@+~_%;"'

######################
# Keyboard shortcuts #
######################

# get a list of keys:
# $ gsettings list-keys org.gnome.desktop.wm.keybindings


for ((x=1 ; x <= 9 ; x++)) ; do
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$x "['<Super>$x']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$x "['<Super><Shift>$x']"
done

add_custom_binding() {
  # This function takes <name> <binding> <command> as parameters
  bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

  i=0
  nextbinding="custom$i"
  while [[ $bindings == *"$nextbinding"* ]]; do
    i=$((i+1))
    nextbinding="custom$i"
  done

  foo=$(echo $bindings | tr -d ']')
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$foo,'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$nextbinding/']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$nextbinding/ name "'$1'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$nextbinding/ binding "'$2'"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$nextbinding/ command "'$3'"
}

add_custom_binding "launch-terminal" "<Super>Return" "gnome-terminal"
