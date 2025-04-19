#!/bin/sh

nixos-rebuild switch --flake /home/ayushmaan/.dotfiles/server-system#nextcloud --target-host nixadmin@nextcloud --use-remote-sudo
nixos-rebuild switch --flake /home/ayushmaan/.dotfiles/server-system#adguard --target-host nixadmin@adguard --use-remote-sudo
#nixos-rebuild switch --flake /home/ayushmaan/.dotfiles/server-system# --target-host nixadmin@nextcloud --use-remote-sudo
