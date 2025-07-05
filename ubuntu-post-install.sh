#!/bin/bash
#
# Script para atualizar o sistema e instalar programas após a instalação do Ubuntu e derivados.
# Agora com menus interativos para seleção de programas.
#
# Autor: Willian Alves da Silva
# E-mail: willrocknroll@gmail.com
# Atualizado em 10/06/2025 (Adaptado para menu interativo em 02/07/2025)
#################################################################################################

# Função para exibir mensagens de status
function log_message {
    echo "----------------------------------------------------"
    echo "$1"
    echo "----------------------------------------------------"
}

# Função para atualizar o sistema
function update_system {
    log_message "Atualizando o sistema..."
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoclean -y
    sudo apt-get autoremove -y
    log_message "Sistema atualizado."
}

# Funções de instalação de programas

function install_flatpak_gnome_software {
    log_message "Instalando Flatpak e Gnome Software..."
    sudo apt install flatpak -y
    sudo apt install gnome-software-plugin-flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    log_message "Flatpak e Gnome Software instalados e Flathub configurado."
}

function install_putty {
    log_message "Instalando Putty..."
    sudo add-apt-repository universe -y
    sudo apt-get update -y
    sudo apt-get install putty -y
    log_message "Putty instalado."
}

function install_virt_manager {
    log_message "Instalando Virt-manager e dependências..."
    sudo apt-get install ssh-askpass -y
    sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager -y
    
    # Adicionando usuário aos grupos libvirt e kvm
    log_message "Adicionando $USER aos grupos libvirt e kvm. Pode ser necessário reiniciar a sessão para que as mudanças tenham efeito."
    sudo adduser $USER libvirt
    sudo adduser $USER kvm
    
    # Verificando e iniciando/habilitando o serviço libvirtd
    log_message "Verificando e garantindo que o serviço libvirtd esteja ativo..."
    sudo systemctl enable --now libvirtd
    sudo systemctl status libvirtd --no-pager # --no-pager para evitar que a saída pareça no less
    
    log_message "Virt-manager e dependências instalados e configurados."
}

function install_unzip {
    log_message "Instalando Unzip..."
    sudo apt-get install unzip -y
    log_message "Unzip instalado."
}

function install_zip {
    log_message "Instalando Zip..."
    sudo apt-get install zip -y
    log_message "Zip instalado."
}

function install_gnome_tweaks {
    log_message "Instalando Ajustes do Gnome (Gnome Tweak Tool)..."
    sudo apt install gnome-tweaks -y # Nome do pacote mudou de gnome-tweak-tool para gnome-tweaks
    log_message "Ajustes do Gnome instalados."
}

function install_git {
    log_message "Instalando Git..."
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt update -y && sudo apt install git -y
    log_message "Git instalado."
}

function install_flatpak_apps {
    log_message "Instalando programas em FlatPak (pode demorar)..."
    flatpak install flathub com.mattjakeman.ExtensionManager -y
    flatpak install flathub com.google.Chrome -y
    flatpak install flathub com.microsoft.Edge -y
    flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y
    flatpak install flathub org.qbittorrent.qBittorrent -y
    flatpak install flathub com.discordapp.Discord -y
    flatpak install flathub org.videolan.VLC -y
    flatpak install flathub io.github.shiftey.Desktop -y # GitHub Desktop
    flatpak install flathub io.github.thetumultuousunicornofdarkness.cpu-x -y
    flatpak install flathub org.angryip.ipscan -y
    flatpak install flathub md.obsidian.Obsidian -y
    flatpak install flathub org.keepassxc.KeePassXC -y
    flatpak install flathub io.github.vikdevelop.SaveDesktop -y
    flatpak install flathub com.obsproject.Studio -y # OBS Studio
    flatpak install flathub com.visualstudio.code -y # VS Code via Flatpak
    log_message "Programas FlatPak instalados."
}

# Menu principal
function main_menu {
    local choice
    while true; do
        clear
        echo "================================================"
        echo "  Menu de Instalação Pós-Ubuntu                 "
        echo "================================================"
        echo "1. Atualizar o sistema (recomendado primeiro)"
        echo "2. Instalar Flatpak e Gnome Software"
        echo "3. Instalar Putty"
        echo "4. Instalar Virt-manager (QEMU/KVM)"
        echo "5. Instalar Unzip"
        echo "6. Instalar Zip"
        echo "7. Instalar Ajustes do Gnome"
        echo "8. Instalar Git"
        echo "9. Instalar TODOS os programas FlatPak"
        echo "0. Sair e finalizar o script"
        echo "================================================"
        read -p "Escolha uma ou mais opções (separe por espaço): " choice

        # Converte a entrada para um array para múltiplos comandos
        IFS=' ' read -r -a choices_array <<< "$choice"

        for opt in "${choices_array[@]}"; do
            case $opt in
                1)
                    update_system
                    ;;
                2)
                    install_flatpak_gnome_software
                    ;;
                3)
                    install_putty
                    ;;
                4)
                    install_virt_manager
                    ;;
                5)
                    install_unzip
                    ;;
                6)
                    install_zip
                    ;;
                7)
                    install_gnome_tweaks
                    ;;
                8)
                    install_git
                    ;;
                9)
                    install_flatpak_apps
                    ;;
                0)
                    log_message "Saindo do script. Finalizando instalações..."
                    sudo apt-get update -y
                    sudo apt-get upgrade -y
                    sudo apt-get autoremove -y
                    sudo apt-get autoclean -y
                    log_message "Fim do Script de instalação. Até mais!"
                    exit 0
                    ;;
                *)
                    echo "Opção inválida: $opt. Por favor, tente novamente."
                    sleep 2
                    ;;
            esac
        done
        echo "" # Adiciona uma linha em branco para melhor leitura
        echo "Pressione Enter para continuar com o menu..."
        read -s -n 1 # Espera qualquer tecla
    done
}

# Inicia o menu principal
main_menu


