#!/bin/env bash

#  AUTHOR: RBRGMN <roman.bergman@tutanota.com>
#    DATE: 2023-11-28
# RELEASE: 0.0.7




function msg_info() {
    local MSG=${1}
    if [ "${MSG}" ]; then
        echo -e "\e[34m<INFO>\e[0m\t\e[30m${MSG}\e[0m"
    fi
}

function msg_ok() {
    local MSG=${1}
    if [ "${MSG}" ]; then
        echo -e "\e[32m<OK>\e[0m\t\e[30m${MSG}\e[0m"
    fi
}

function msg_error() {
    local MSG=${1}
    if [ "${MSG}" ]; then
        echo -e "\e[31m<ERROR>\e[0m\t\e[30m${MSG}\e[0m"
    fi
}

function msg_input() {
    local MSG=${1}
    if [ "${MSG}" ]; then
        echo -e "\e[33m<INPUT>\e[0m\t\e[30m${MSG}\e[0m"
    fi
}

function check_root_permissions() {
    if [ "$(id -u)" -eq 0 ]; then 
        msg_error "Please run script in non root user"
        exit 1;
    fi
}

function sudo_password() {
    msg_input "TYPE SUDO PASSWORD:"
    sudo sleep 0.1
}

function check_arch_os() {
    if [ "$(grep '^ID=' /etc/os-release)" != "ID=arch" ]; then
        msg_error "Not Arch Linux Release"
        exit 1;
    fi
}

function pacman_parralel_downloads() {
    sudo sed -i '/ParallelDownloads/c\ParallelDownloads=66' /etc/pacman.conf
}

function install_sway_pkg() {
    sudo pacman -Sy --noconfirm \
        sway \
        wofi \
        polkit \
        swaybg \
        waybar \
        swayidle \
        swaylock > /dev/null
}

function install_system_pkg() {
    sudo pacman -Sy --nocorfirm \
        grim \
        mako \
        kitty \
        slurp \
        kanshy \
        mandoc \
        pipewire \
        libnotify \
        wireplumber \
        wl-clipboard \
        brightnessctl \
        pipewire-pulse \
        xdg-desktop-session \
        xdg-desktop-session-wlr > /dev/null
}

# INIT
check_arch_os
check_root_permissions
sudo_password
install_sway_pkg
install_system_pkg