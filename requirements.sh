#!/bin/bash

main() {
    echo "Installing packages..."
    sleep 2
    clear

    sudo pacman -S --noconfirm python python-pip git curl openssh hyprland kitty waybar rofi sddm thunar nerd-fonts ttf-fira-code fastfetch fish
    sudo systemctl enable sddm

    mkdir -p ~/.config/waybar ~/.config/rofi ~/.config/hypr ~/.config/fish

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

    mv hyprland.conf ~/.config/hypr
    mv kitty.conf ~/.config/kitty
    mv config.fish ~/.config/fish

    finished
}

finished() {
    clear
    echo "Finished, You may reboot at any time!"    
    exit
}

main
