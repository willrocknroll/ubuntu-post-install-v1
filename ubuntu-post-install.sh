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
sudo apt-get autoclean -y
sudo apt-get autoremove -y

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

echo "Instalando Google Chrome"
sudo apt-get install google-chrome-stable -y

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

echo "Instalando VS Code"
sudo apt update
sudo apt install -y curl apt-transport-https
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/ms-vscode-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ms-vscode-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
sudo snap refresh
sudo snap install code --classic


#
# Finalizando instalações
#

echo "Finalizando instalações"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "Fim do Script de instalação"

