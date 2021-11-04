#!/bin/bash

## meu primeiro shell script / baseado no diolinux##

# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_LIBRATBAG="ppa:libratbag-piper/piper-libratbag-git"
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_KADENLIVE="ppa:kdenlive/kdenlive-stable"
PPA_SCRIBUS="ppa:scribus/ppa"
PPA_INKSCAPE="ppa:inkscape.dev/stable"
PPA_KRITA="ppa:kritalime/ppa"


URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.18.4-1_amd64.deb"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.5.4.50130-focal_amd64.deb"



## Removendo travas eventuais do apt ##

sudo rm /var/lib/dpkg/lock-frontend; sudo rm /var/cache/apt/archives/lock ;

## Atualizando o repositório ##

sudo apt update


## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
# wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
# wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo apt-add-repository "$PPA_LIBRATBAG" -y
sudo add-apt-repository "$PPA_LUTRIS" -y
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
sudo add-apt-repository "$PPA_KADENLIVE" -y
sudo add-apt-repository "$PPA_SCRIBUS" -y
sudo add-apt-repository "$PPA_INKSCAPE" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE bionic main"
sudo apt install inkscape -y

sudo apt update

## Krita ##
sudo add-apt-repository ppa:kritalime/ppa -y
sudo apt-get update
sudo apt-get install krita -y

# If you also want to install translations:

sudo apt-get install krita-l10n -y

# If would also like to download debugging symbols for Krita:

sudo add-apt-repository \
"http://ppa.launchpad.net/kritalime/ppa/ubuntu main/debug"

sudo apt-get update
sudo apt-get install krita-dbgsym


# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

## Atualizando o repositório ##
sudo apt update &&

## Adicionando repositório Flathub ##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 

## Instalando pacotes Flatpak ##
flatpak install flathub com.obsproject.Studio -y
flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref -y
flatpak install flathub fr.handbrake.ghb -y

flatpak update

## Instalando pacotes e programas do repositório deb do Ubuntu ##
sudo apt install python3 python-pip wine nautilus-dropbox docker docker-compose git build-essential libssl-dev flatpak gnome-software-plugin-flatpak -y &&

## Instalando pacotes Snap ##
sudo snap install blender --classic
sudo apt install snapd -y
sudo apt install discord -y
sudo snap install spotify -y
sudo snap install slack --classic
sudo snap install wps-office-multilang -y
sudo snap install photogimp -y
sudo apt install winff -y
sudo apt install guvcview -y
# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
