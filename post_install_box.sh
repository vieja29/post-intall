#!/bin/bash
########################################################################################################################################3
#Rutina para actualización de Huayra 3.2 con los repositorios de la comunidad Huayra e instalación de software: gfortran, topcat-full okular libreoffice, man español, gedit
#AUTOR: RICARDO VILLAR, Mariano Francisco      
#MAIL:rvillarbravo@gmail.com
#Version: 1.04.1
#
#########################################################################################################################################
## COMO SE USA
## 1) se descarga a cualquier ubicación
## 2) se le da permisos de ejecución, desde un terminal con el siguiente comando:
## >>> chmod +x post_install.sh
## 3) ahora se debe convertir en root
## >>> sudo su
## 4) Se ejecuta
## >>> ./post_install.sh
alias rm="rm -i"
#sudo su
######################################################################################################################################


#					Instalación DE LOS REPOSITORIOS DE COMUNIDAD HUAYRA y de espejos de los repositorios oficiales


######################################################################################################################################
## agrego repos espejo de repositorios principales ( para evitar problemas cuando los repos oficiales estan caidos)
#echo "" >> /etc/apt/sources.list.d/huayra.list
#echo "# Repositorio de Huayra GNU/Linux (espejo comhuayra) " >> /etc/apt/sources.list.d/huayra.list
#echo "deb http://repositorio.comunidadhuayra.org/huayra sud main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
#echo "deb-src http://repositorio.comunidadhuayra.org/huayra sud main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
#
#echo "" >> /etc/apt/sources.list.d/huayra.list
#echo "# Repositorio de Huayra GNU/Linux (actualizaciones) (espejo comhuayra)" >> /etc/apt/sources.list.d/huayra.list
#echo "deb http://repositorio.comunidadhuayra.org/huayra sud-updates main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
#echo "deb-src http://repositorio.comunidadhuayra.org/huayra sud-updates main contrib non-free" >> /etc/apt/sources.list.d/huayra.list

echo "30 segundo para cancelar actualizacion, para ello precione 'Ctrl+z'"
sleep 30

file="/etc/apt/sources.list.d/huayra.list.orig" 
if [ ! -f "$file" ]
then   
	sudo cp /etc/apt/sources.list.d/huayra.list /etc/apt/sources.list.d/huayra.list.orig
	sudo sed -i 's/repo.huayra.conectarigualdad.gob.ar/repo-huayra.conectarigualdad.gob.ar/g' "/etc/apt/sources.list.d/huayra.list"
#
    sudo echo "" >> /etc/apt/sources.list.d/huayra.list
    sudo echo " # Repositorios temporales" >> /etc/apt/sources.list.d/huayra.list
    sudo echo "# deb http://huayra.tom.pressenter.com.ar/huayra sud main contrib non-free # temporal" >> /etc/apt/sources.list.d/huayra.list
    sudo echo "" 

## agrego repos de la comunidad

    sudo echo "## Comunidad Huayra" >> /etc/apt/sources.list.d/huayra.list
    sudo echo "#deb http://repositorio.comunidadhuayra.org/comhuayra huayra main contrib non-free" >> /etc/apt/sources.list.d/huayra.list
    sudo echo "#deb-src http://repositorio.comunidadhuayra.org/comhuayra huayra main contrib non-free" >> /etc/apt/sources.list.d/huayra.list

    else
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.orig
	    sudo sed -i 's/repo.huayra.conectarigualdad.gob.ar/repo-huayra.conectarigualdad.gob.ar/g' "/etc/apt/sources.list"
#
        sudo echo "" >> /etc/apt/sources.list   
        sudo echo " # Repositorios temporales" >> /etc/apt/sources.list
        sudo echo "# deb http://huayra.tom.pressenter.com.ar/huayra sud main contrib non-free # temporal" >> /etc/apt/sources.list
        sudo echo ""
#
##      agrego repos de la comunidas
        sudo echo "" >> /etc/apt/sources.list
        sudo echo "## Comunidad Huayra" >> /etc/apt/sources.list
        sudo echo "#deb http://repositorio.comunidadhuayra.org/comhuayra huayra main contrib non-free" >> /etc/apt/sources.list
        sudo echo "#deb-src http://repositorio.comunidadhuayra.org/comhuayra huayra main contrib non-free" >> /etc/apt/sources.list
fi

 sleep 5 

echo "Repositorios termporales agregados"
########################################################################################################################################


#  sincronizar 
#--------------

 sudo apt-get update

#######################################################################################################################################
#habilitación de la clave de verificación del repositorio de la comunidad huayra
#----------------------------------------------------

cd ~                                                          # opcional
wget -c repositorio.comunidadhuayra.org/comhuayra/huayra.gpg.asc  # Habilita Llave de Verificación
sudo apt-key add huayra.gpg.asc
rm huayra.gpg.asc                                              # opcional


# Instala los Keyring para evitar error por claves de apt-get update
echo
if [ $(sudo dpkg-query -W -f='${Status}' debian-keyring 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install -y debian-keyring
else
	echo "debian-keyring instalado"
	echo
fi
if [ $(sudo dpkg-query -W -f='${Status}' debian-archive-keyring 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install -y debian-archive-keyring
else
	echo "debian-archive-keyring instalado"
	echo
fi
####################################################################################################################
#actualización de la distro
#--------------------------
#sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y


##########################################################################################################################################
#								INSTALACION DE DRIVER Y PAQUETES


#echo "Actualización plugin de flash para chromium "
#sudo update-pepperflashplugin-nonfree --install 

#echo "Actualización de  plugin de flash para firefox"
#sudo update-flashplugin-nonfree --install 

echo "actualización de firefox"
sudo update-firefox

# instalacion de okular gfortran libreoffice, man español, gnudatalanguage (IDL)
sudo apt-get autoremove -y libreoffice
sudo apt-get autoclean -y
sudo apt-get install -y comhuayra-okular gfortran gnuplot comhuayra-libreoffice manpages-es manpages-es-extra gnudatalanguage screenfetch huayra-grub-themes-limbo locate pdftk


echo" modificacion del screemfetch para que reconozca Huayra/GNU-LINUX"
sleep 5 
wget -c https://cloud.openmailbox.org/index.php/s/he8e00YZvD3Hg5G
chmod +x screenfetch 
sudo mv screenfetch /usr/bin 
sleep 4
echo "Instalacón completada"
 

sleep 5
echo "Congifurar el idioma para las man pages "
sleep 5

sudo dpkg-reconfigure locales


sleep 5
echo "descaga de TOPCAT e instalacion "
#descaga de topcat
wget -c http://www.star.bris.ac.uk/~mbt/topcat/topcat-full.jar
chmod +x topcat-full.jar
#wget -c http://www.star.bris.ac.uk/~mbt/topcat/topcat-full.jnlp
#javaws topcat-full.jnlp 
#rm topcat-full.jnlp
echo "Instalacón completada"

sleep 5
echo "descarga de Aladin e instalación"
wget -c http://aladin.u-strasbg.fr/java/download/Aladin.tar
tar -xvf Aladin.tar
rm Aladin.tar

#wget -c http://aladin.u-strasbg.fr/java/download/aladin.jnlp
#javaws aladin.jnlp
#rm aladin.jnlp
sleep 5 
echo "Instalacón completada"

sleep 5


echo "instalcion de iraf"
wget -c https://www.dropbox.com/s/ue71jfxubc9gb2u/install_iraf_32bit.sh?dl=0
#chmod +x install_iraf_32bit.sh
sudo ./install_iraf_32bit.sh
sleep 5
rm install_iraf_32bit.sh

echo "Pugar archivos de configuracion de app desinstaladas."
# para borrar ficheros de configuracion de aplicaciones desistaladas 
#        grep ^rc busca en la primera columna la cadena "rc"
#        cut -d " "  es para saltar el primer cadena de caractres, -f 3 es para saltar las 3 primeras columnas
#        xargs pone la cadena de caracteres adelante de los comandos a utilizar,
sudo  dpkg -l |grep ^rc |cut -d " " -f 3 |xargs apt-get purge -y
exit

