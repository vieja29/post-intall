#!/bin/bash
##
## COMO SE USA
## 1) se descarga a cualquier ubicación
## 2) se le da permisos de ejecución, desde un terminal con el siguiente comando:
## >>> chmod +x post_install.sh
## 3) ahora se debe convertir en root
## >>> sudo su
## 4) Se ejecuta
## >>> ./post_install.sh

### Version1.01
## Por Ricardo Villar
sudo su
######################################################################################################################################


#							Instalación DE LOS REPOSITORIOS DE COMUNIDAD HUAYRA y de espejos de los repositorios oficiales


####################################################################################################################################
## agrego repos espejo de repositorios principales ( para evitar problemas cuando los repos oficiales estan caidos)
echo "" >> /etc/apt/sources.list.d/huayra.list
# Repositorio de Huayra GNU/Linux (espejo comhuayra)
echo "deb http://repositorio.comunidadhuayra.org/huayra sud main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
echo "deb-src http://repositorio.comunidadhuayra.org/huayra sud main contrib non-free" >> /etc/apt/sources.list.d/huayra.list

# Repositorio de Huayra GNU/Linux (actualizaciones) (espejo comhuayra)
echo "deb http://repositorio.comunidadhuayra.org/huayra sud-updates main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
echo "deb-src http://repositorio.comunidadhuayra.org/huayra sud-updates main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
#-----------------------------------------------------------------------------------------------
## agrego repos de la comunidad

echo "## Comunidad Huayra" >> /etc/apt/sources.list.d/huayra.list
echo "deb http://repositorio.comunidadhuayra.org/comhuayra huayra main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
echo "deb-src http://repositorio.comunidadhuayra.org/comhuayra huayra main contrib non-free" >> /etc/apt/sources.list.d/huayra.list


#######################################################################################################################################
#habilitación de la clave de verificación del repositorio
#----------------------------------------------------

cd ~                                                          # opcional
wget repositorio.comunidadhuayra.org/comhuayra/ComHuayra.asc  # Habilita Llave de Verificación
sudo apt-key add ComHuayra.asc
rm ComHuayra.asc                                              # opcional

########################################################################################################################################

#  sincronizar 
#--------------

sudo apt-get update

#actualización de la distro
#--------------------------

apt-get upgrade -y
apt-get dist-upgrade -y


##########################################################################################################################################
#								INSTALACION DE DRIVER Y PAQUETES


# actualizo plugin de flash para chromium (no se si es redundante con el último paso)
update-pepperflashplugin-nonfree --install --verbose
# actualizo plugin de flash para firefox
update-flashplugin-nonfree ----install --verbose

#actualizo firefox
update-firefox
# instalacion de comhuayra-okular gfortran comhuayra-libreoffice, man español
apt-get install comhuayra-okular gfortran comhuayra-libreoffice manpages-es manpages-es-extra

sleep 5
echo "Congifurar el idioma para las man pages "
sleep 5

dpkg-reconfigure locales


sleep 5
echo "descaga e instalacion de topcat "
#descaga de topcat
wget -c http://www.star.bris.ac.uk/~mbt/topcat/starjava.tar.gz
# mover script a /bin
mv
tar tzvf starjava.tar.gz
rm starjava.tar.gz
mv 

#instalcion de iraf
chmod +x install_ureka_1.5.2
./install_ureka_1.5.2

