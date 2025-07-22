#!/bin/bash
#
# Script para atualizar o sistema e instalar programas após a instalação do Ubuntu e derivados.
# Agora com menus interativos para seleção de programas e submenu de Flatpaks.
#
# Autor: Willian Alves da Silva
# E-mail: willrocknroll@gmail.com
# Atualizado em 10/06/2025 (Adaptado para menu interativo em 02/07/2025 e submenu Flatpak em 05/07/2025)
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

# Submenu para Flatpaks
function flatpak_submenu {
    local choice
    while true; do
        clear
        echo "================================================"
        echo "  Submenu de Instalação de Flatpaks             "
        echo "================================================"
        echo "1. Extension Manager"
        echo "2. Google Chrome (Flatpak)"
        echo "3. Microsoft Edge (Flatpak)"
        echo "4. Teams for Linux (Flatpak)"
        echo "5. qBittorrent (Flatpak)"
        echo "6. Discord (Flatpak)"
        echo "7. VLC (Flatpak)"
        echo "8. GitHub Desktop (Flatpak)"
        echo "9. CPU-X (Flatpak)"
        echo "10. Angry IP Scanner (Flatpak)"
        echo "11. Obsidian (Flatpak)"
        echo "12. KeePassXC (Flatpak)"
        echo "13. SaveDesktop (Flatpak)"
        echo "14. OBS Studio (Flatpak)"
        echo "15. VS Code (Flatpak)"
        echo "99. Instalar TODOS os Flatpaks da lista"
        echo "0. Voltar ao Menu Principal"
        echo "================================================"
        read -p "Escolha uma ou mais opções (separe por espaço): " choice

        IFS=' ' read -r -a choices_array <<< "$choice"

        for opt in "${choices_array[@]}"; do
            case $opt in
                1)
                    log_message "Instalando Extension Manager (Flatpak)..."
                    flatpak install flathub com.mattjakeman.ExtensionManager -y
                    log_message "Extension Manager instalado."
                    ;;
                2)
                    log_message "Instalando Google Chrome (Flatpak)..."
                    flatpak install flathub com.google.Chrome -y
                    log_message "Google Chrome (Flatpak) instalado."
                    ;;
                3)
                    log_message "Instalando Microsoft Edge (Flatpak)..."
                    flatpak install flathub com.microsoft.Edge -y
                    log_message "Microsoft Edge (Flatpak) instalado."
                    ;;
                4)
                    log_message "Instalando Teams for Linux (Flatpak)..."
                    flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y
                    log_message "Teams for Linux (Flatpak) instalado."
                    ;;
                5)
                    log_message "Instalando qBittorrent (Flatpak)..."
                    flatpak install flathub org.qbittorrent.qBittorrent -y
                    log_message "qBittorrent (Flatpak) instalado."
                    ;;
                6)
                    log_message "Instalando Discord (Flatpak)..."
                    flatpak install flathub com.discordapp.Discord -y
                    log_message "Discord (Flatpak) instalado."
                    ;;
                7)
                    log_message "Instalando VLC (Flatpak)..."
                    flatpak install flathub org.videolan.VLC -y
                    log_message "VLC (Flatpak) instalado."
                    ;;
                8)
                    log_message "Instalando GitHub Desktop (Flatpak)..."
                    flatpak install flathub io.github.shiftey.Desktop -y
                    log_message "GitHub Desktop (Flatpak) instalado."
                    ;;
                9)
                    log_message "Instalando CPU-X (Flatpak)..."
                    flatpak install flathub io.github.thetumultuousunicornofdarkness.cpu-x -y
                    log_message "CPU-X (Flatpak) instalado."
                    ;;
                10)
                    log_message "Instalando Angry IP Scanner (Flatpak)..."
                    flatpak install flathub org.angryip.ipscan -y
                    log_message "Angry IP Scanner (Flatpak) instalado."
                    ;;
                11)
                    log_message "Instalando Obsidian (Flatpak)..."
                    flatpak install flathub md.obsidian.Obsidian -y
                    log_message "Obsidian (Flatpak) instalado."
                    ;;
                12)
                    log_message "Instalando KeePassXC (Flatpak)..."
                    flatpak install flathub org.keepassxc.KeePassXC -y
                    log_message "KeePassXC (Flatpak) instalado."
                    ;;
                13)
                    log_message "Instalando SaveDesktop (Flatpak)..."
                    flatpak install flathub io.github.vikdevelop.SaveDesktop -y
                    log_message "SaveDesktop (Flatpak) instalado."
                    ;;
                14)
                    log_message "Instalando OBS Studio (Flatpak)..."
                    flatpak install flathub com.obsproject.Studio -y
                    log_message "OBS Studio (Flatpak) instalado."
                    ;;
                15)
                    log_message "Instalando VS Code (Flatpak)..."
                    flatpak install flathub com.visualstudio.code -y
                    log_message "VS Code (Flatpak) instalado."
                    ;;
                99)
                    log_message "Instalando TODOS os programas FlatPak (pode demorar)..."
                    flatpak install flathub com.mattjakeman.ExtensionManager com.google.Chrome com.microsoft.Edge com.github.IsmaelMartinez.teams_for_linux org.qbittorrent.qBittorrent com.discordapp.Discord org.videolan.VLC io.github.shiftey.Desktop io.github.thetumultuousunicornofdarkness.cpu-x org.angryip.ipscan md.obsidian.Obsidian org.keepassxc.KeePassXC io.github.vikdevelop.SaveDesktop com.obsproject.Studio com.visualstudio.code -y
                    log_message "TODOS os programas FlatPak instalados."
                    ;;
                0)
                    log_message "Voltando ao Menu Principal..."
                    return # Sai da função do submenu
                    ;;
                *)
                    echo "Opção inválida: $opt. Por favor, tente novamente."
                    sleep 2
                    ;;
            esac
        done
        echo "" # Adiciona uma linha em branco para melhor leitura
        echo "Pressione Enter para continuar com o submenu Flatpak..."
        read -s -n 1 # Espera qualquer tecla
    done
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
        echo "9. Entrar no submenu de Flatpaks" # Opção para o submenu
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
                    flatpak_submenu # Chama o submenu Flatpak
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
        echo "Pressione Enter para continuar com o menu principal..."
        read -s -n 1 # Espera qualquer tecla
    done
}

# Inicia o menu principal
main_menu

