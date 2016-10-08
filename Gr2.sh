#!/bin/bash

#Variables
VERSION="V9"
KERNEL="/home/gr2_srk/msm8916/arch/arm/boot/zImage"
ZIP="/home/gr2_srk/zip"
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
nocol='\033[0m'

echo -e "$green Desea limpiar el directorio?"
read REPLY1
if [[ $REPLY1 =~ ^[Yy]$ ]]
then
    echo -e  "$red Borrando directorio"
    make clean && make mrproper
    git reset --hard
#COMPILACION
    echo -e "$blue Desea compilar el kernel?"
    read REPLY2

        if [[ $REPLY2 =~ ^[Yy]$ ]]
        then
	echo -e "$yellow*****************************************************"
	echo "                Iniciando Compilación DemoniacTeam         "
	echo -e "*****************************************************$nocol"
            export CROSS_COMPILE=/home/gr2_srk/arm-linux-androideabi-5.x/bin/arm-eabi-
            export ARCH=arm
            make gr2_defconfig
            make -j5
	echo -e "$red >>>Creando zip<<<"
	rm -rvf $ZIP/tools/zImage
	mv $KERNEL $ZIP/tools
	rm -f $ZIP/*.zip
        cd $ZIP
	zip -r DemonacTeam-Kernel-$VERSION *
	cd
	BUILD_END=$(date +"%s")
	DIFF=$(($BUILD_END - $BUILD_START))
	echo -e "$yellow COmpilacion completa en $(($DIFF / 60)) minuto(s) con $(($DIFF % 60)) segundos.$nocol"    
        fi

elif [[ $REPLY1 =~ ^[Nn]$ ]]
then

    echo -e "$blue Desea compilar el kernel?"
    read REPLY3

        if [[ $REPLY3 =~ ^[Yy]$ ]]
        then
#COMPILACION   
	echo -e "$yellow*****************************************************"
	echo "          Iniciando Compilación DemoniacTeam "$DEVICE"         "
	echo -e "*****************************************************$nocol"             
            export CROSS_COMPILE=/home/gr2_srk/arm-linux-androideabi-5.x/bin/arm-eabi-
            export ARCH=arm
            make gr2_defconfig
            make -j5
	echo -e "$red Creando zip"
	rm -rvf $ZIP/tools/zImage
	mv $KERNEL $ZIP/tools
	rm -f $ZIP/*.zip
        cd $ZIP
	zip -r DemonacTeam-Kernel-$VERSION *
	cd       
	BUILD_END=$(date +"%s")
	DIFF=$(($BUILD_END - $BUILD_START))
	echo -e "$yellow COmpilacion completa en $(($DIFF / 60)) minuto(s) con $(($DIFF % 60)) segundos.$nocol"                
	fi
fi
read -rsp $ 'presiona cualquier tecla para continuar...\n' -n 1 key
# echo $key
