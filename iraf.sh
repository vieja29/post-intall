#!/bin/bash

# After the complete installation, put this file in your home directory and make it executable (chmod u=rwx iraf). The command "./iraf" will then launch a complete IRAF session containing DS9, xgterm and ecl, based in ~/IRAF.

# Please send questions or comments to: khan@astronomy.ohio-state.edu

cd ~/IRAF

ds9 &

xgterm -fn 8x16 -sb -title "Image Reduction and Analysis Facility (IRAF)" -e "ecl" &
#-fn 10x20 -bg black
