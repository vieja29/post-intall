#!/bin/bash
echo"###################################### IRAF 2.16 Setup on Ubuntu/Debian/Huayra 3.3 Linux ###############################"
#
#This page describes how to setup IRAF on a 32-bit/64-bit Ubuntu/Debian}/Huayra 3.3 machine.
#Installation of X11IRAF, DS9 and key packages are also included. 
#
#For 64-bit installation, please see -
#http://www.astronomy.ohio-state.edu/~khan/iraf/iraf_step_by_step_installation_64bit
#
#An excellent and easy alternative installation option is provided by the Ureka project -
#http://ssb.stsci.edu/ureka/
#
#Authors:
# Rubab Khan
#khan@astronomy.ohio-state.edu
#Ricardo Villar
#rvillarbravo@gmail.com
#Version:1.1.0
#---------------------------------------------------------------------------------------
failed=0
#local_version=0
#check_sha512=1

#work_dir=`mktemp -d -t update-iraf.XXXXXX`

arch=`dpkg --print-architecture`

if [ "$arch" = "amd64" ]; then
	#parametro para la descarga
	ir_os="lnux"
	ir_arch="x86_64"
elif [ "$arch" = "i386" ]; then
	ir_os="lnux"
	ir_arch="x86"
else
	echo "Arquitectura no soportada por este script :("
	failed=1
fi
ir_url="ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.$ir_os.$ir_arch.tar.gz"

echo "Install depend"
if [$failed = 0]; then
 if [$ir_arch ="x86"]; then
 
sudo apt-get install -y tcsh libxss1 libncurses5 libXmu6:i386
   elif [$ir_arch ="x86_64"]; then
sudo apt-get install tcsh libxss1 lib32z1 lib32ncurses5 lib32bz2-1.0 libXmu6:i386
  fi
fi
echo "Descargando $ir_url"
wget -c $ir_url
    #    ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86_64.tar.gz
sleep 5
echo "If the prompt does not return after 100% then hit ctrl+c and proceed"
sleep 5

sudo mkdir /iraf

sudo mkdir /iraf/iraf

sudo mv iraf.lnux.$ir_arch.tar.gz /iraf/iraf/

cd /iraf/iraf

sudo tar -zxf iraf.lnux.$ir_arch.tar.gz

sudo rm iraf.lnux.$ir_arch.tar.gz

sleep 5
echo "Keep hitting Enter for all prompts"
sleep 5
 
sudo ./install

sleep 5
echo "Install x11"
sleep 5

sudo mkdir /iraf/x11iraf

cd /iraf/x11iraf

sudo wget -c http://iraf.noao.edu/iraf/ftp/iraf/x11iraf/x11iraf-v2.0BETA-bin.linux.tar.gz

sudo tar -zxf x11iraf-v2.0BETA-bin.linux.tar.gz

sudo rm x11iraf-v2.0BETA-bin.linux.tar.gz

sleep 5
echo "Keep hitting Enter for all prompts"
sleep 5

sudo ./install

sleep 5
echo "Install DS9 v6.2 "
sleep 5

#if [$ir_arch= "x86"]; then
sudo wget -c http://ds9.si.edu/download/ubuntu14/ds9.ubuntu14.7.5.tar.gz
sudo tar-zxf ds9.ubuntu14.7.5.tar.gz
sudo rm ds9.ubuntu14.7.5.tar.gz
 
#sudo wget -c http://ds9.si.edu/archive/linux/ds9.linux.6.2.tar.gz
 #sudo tar-zxf ds9.linux.6.2.tar.gz
 #sudo rm ds9.linux.6.2.tar.gz


sudo mv ds9 /usr/local/bin/.
sleep 5
echo "installation complete"

cd
#wget -c https://freeshell.de/~rgh/arch/iraf/xgterm.STATIC
wget -c https://www.dropbox.com/s/9w27s5vjwqfetx1/iraf.sh?dl=0
#wget -c http://www.astronomy.ohio-state.edu/~khan/iraf/iraf

sudo chmod u=rwx iraf

mkdir IRAF

cd IRAF

sleep 5
echo "Select "xgterm" as your IRAF shell when prompted"

mkiraf
sleep2
echo"The command ./iraf from home directory will now launch a complete IRAF session containing DS9, xgterm and ecl, based in the IRAF direcory"
sleep 10
exit

#----------------------------------------------------------------------------------------------
#
#The command ./iraf from home directory will now launch a complete IRAF session containing DS9,
#xgterm and ecl, based in the IRAF direcory. Alternately, start "xgterm' (typing xgterm), 
#cd into the directory where you did "mkiraf", type "ecl" for enhanced IRAF or 
#"cl" for VO IRAF, and "ds9" for standalone DS9 launch. 
#----------------------------------------------------------------------------------------------
#The following steps show how to add external packages. If you don't need extra packages, 
#then you are done already.


#cd /iraf/iraf/extern

#sudo ./configure

#sleep 5
#echo "will take some time to complete, even with fast internet. Be patient"
#sleep5

#[[The next two lines will take some time to complete, even with fast internet. Be patient.]]

#sudo make adccdrom ctio cfh12k esowfi mscdb mscred stsdas nfextern optic

#sudo make deitab euv mem0 mtools rvsao song sqiid stecf ucsclris upsqiid xdimsum

#exit



