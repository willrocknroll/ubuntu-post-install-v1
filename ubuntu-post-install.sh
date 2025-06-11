#!/bin/bash
#
# Script para atualizar o sistema e instalar programas após a instalação do Ubuntu e derivados.#
#
# Autor: Willian Alves da Silva
# E-mail: willrocknroll@gmail.com
#
# Atualizado em 10/06/2025
#################################################################################################
#
# Atualizando o sistema #
#
echo "Atualizando o sistema..."
sudo apt-get update
sudo apt-get upgrade -y


#
# Instalando programas
#
echo "Instalando programas..."
echo "Instalando Flatpak e Gnome Software"
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Instalando Putty"
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install putty -y

echo "Instalando Virt-manager"
sudo apt-get install ssh-askpass
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
sudo adduser $USER libvirt
sudo adduser $USER kvm
sudo systemctl status libvirtd
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo apt install virt-manager -y
sudo systemctl status libvirtd

echo "Instalando Unzip"
sudo apt-get install unzip -y

echo "Instalando Zip"
sudo apt-get install zip -y

echo "Instalando Ajustes do Gnome"
sudo apt install gnome-tweak-tool -y

echo "Instalando Git"
sudo add-apt-repository ppa:git-core/ppa
sudo apt update && apt install git -y

echo "Instalando programas em FlatPak"
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub com.microsoft.Edge -y
flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub io.github.shiftey.Desktop -y
flatpak install flathub io.github.thetumultuousunicornofdarkness.cpu-x -y
flatpak install flathub org.angryip.ipscan -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub org.keepassxc.KeePassXC -y
flatpak install flathub io.github.vikdevelop.SaveDesktop -y
flatpak install flathub com.obsproject.Studio -y

#
# Finalizando instalações
#

echo "Finalizando instalações"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "Fim do Script de instalação"

