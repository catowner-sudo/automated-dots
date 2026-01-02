#!/bin/bash

main() {
    echo "Installing packages..."
    sleep 2
    clear

    sudo pacman -S --noconfirm python python-pip git curl openssh hyprland kitty waybar rofi sddm thunar nerd-fonts ttf-fira-code fastfetch
    sudo systemctl enable sddm

    mkdir -p ~/.config/waybar ~/.config/rofi

    git clone https://github.com/soaddevgit/WaybarTheme ~/.config/waybar
    git clone https://github.com/OuterFrog/outtheme-rofi-theme ~/.config/rofi

    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si
    cd ..

    yay -S --noconfirm brave-bin

    echo -n "Install grub theme? (Y/N): "
    read -r option
    if [[ "$option" == "y" || "$option" == "Y" ]]; then
        echo "Installing grub theme..."
        git clone --depth=1 https://github.com/uiriansan/LainGrubTheme
        cd LainGrubTheme || exit
        ./install.sh
        ./patch_entries.sh
        cd ..
        clear
        echo "Finished!"
    elif [[ "$option" == "n" || "$option" == "N" ]]; then
        finished
    else
        echo "Invalid option. Skipping GRUB theme installation."
    fi
    
    chsh -s /usr/bin/fish

    finished
}

finished() {
    echo "Finished!"
    echo "NOTE: replace ~/.config/hypr/hyprland.conf with the hyprland config file from the repo, same as ~/.config/kitty/kitty.conf and ~/.config/fish/config.fish"
    exit
}

main