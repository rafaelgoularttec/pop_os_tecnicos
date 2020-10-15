#!/usr/bin/env bash

#HABILITAR ARQUITETURA 32 BITS
dpkg --add-architecture i386;

#INSTALA O FLATPAK
apt install flatpak
#ADICIONA REPOSITORIO FLATPAK
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
#PROGRAMAS FLATPACK
APP_FLAT=(
	flathub com.wps.Office
	flathub com.bitwarden.desktop
	flathub com.anydesk.Anydesk
	flathub org.remmina.Remmina
	flathub com.visualstudio.code
	flathub org.wireshark.Wireshark
	flathub org.videolan.VLC
)

#PROGRAMAS DEB
APP_DEB=(
	flameshot
	xterm
	google-chrome-stable
	timeshift
	htop
)

for flat in ${APP_FLAT[@]}; do
  if ! dpkg -l | grep -q $flat; then # Só instala se já não estiver instalado
    flatpak install "$flat" -y
  else
    echo "[INSTALADO] - $flat"
  fi
done

for deb in ${APP_DEB[@]}; do
  if ! dpkg -l | grep -q $deb; then # Só instala se já não estiver instalado
    apt install "$deb" -y
  else
    echo "[INSTALADO] - $deb"
  fi
done

wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -

#ADD REPOSITORIO
add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'

#ATUALIZA OS REPOSITORIOS
apt update

#BAIXA E INSTALA O WINEHQ
apt install --install-recommends winehq-stable

#DOWNLOADS E INSTALAÇÃO DO WINEHQ
add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' 

#REMOVE ESTES APLICATIVOS
sudo apt remove --purge libreoffice*
sudo apt autoremove kdeconnect
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update
sudo apt install bashtop
sudo apt install vim

echo "Finalizado com sucesso"
