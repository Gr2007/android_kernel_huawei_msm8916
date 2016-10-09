#!/bin/bash

#Datos
VERSION="V9"
zimagen="/home/gr2_srk/msm8916/arch/arm/boot/zImage"
zp="/home/gr2_srk/msm8916/zip/"
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
nocol='\033[0m'

#Menu

#Opcion 1
echo -e "$green Desea limpiar el directorio? (y/n)"
read REPLY1

	if [[ $REPLY1 =~ ^[Yy]$ ]]  #INCIO DEL IF
		then
   		echo -e  "$red Borrando directorio"
   		make clean && make mrproper

		#COMPILACION

		#Opcion2
    		echo -e "$blue Desea compilar el kernel?"
    		read REPLY2

        	if [[ $REPLY2 =~ ^[Yy]$ ]]
        	then
		echo -e "$yellow*****************************************************"
		echo "                Iniciando Compilación DemoniacTeam         "
		echo -e "*****************************************************$nocol"
           	 export CROSS_COMPILE=/home/gr2/UBERTC-arm-eabi-6.0/bin/arm-eabi-
            	export ARCH=arm
            	make gr2_defconfig
            	make -j5
		echo -e "$cyan Creando zip"
		mv $zimagen $zp
        	cd $zp
		zip -r DemonacTeam-Kernel-$VERSION *
		cd       
		BUILD_END=$(date +"%s")
		DIFF=$(($BUILD_END - $BUILD_START))
		echo -e "$yellow COmpilacion completa en $(($DIFF / 60)) minuto(s) con $(($DIFF % 60)) segundos.$nocol"    
       fi #FIN DEL IF

#CASO CONTRARIO 
elif [[ $REPLY1 =~ ^[Nn]$ ]]
then

#OPCION 3    
echo -e "$blue Desea compilar el kernel?"
read REPLY3

        if [[ $REPLY3 =~ ^[Yy]$ ]] #INICO DEL IF
        	then
	#COMPILACION   
		echo -e "$yellow*****************************************************"
		echo "          Iniciando Compilación DemoniacTeam          "
		echo -e "*****************************************************$nocol"             
            	export CROSS_COMPILE=/home/gr2/UBERTC-arm-eabi-6.0/bin/arm-eabi-
            	export ARCH=arm
            	make gr2_defconfig
            	make -j5
		echo -e "$cyan Creando zip"
		mv $zimagen $zp
        	cd $zp
		zip -r DemonacTeam-Kernel-$VERSION *
		cd       
		BUILD_END=$(date +"%s")
		DIFF=$(($BUILD_END - $BUILD_START))
		echo -e "$yellow COmpilacion completa en $(($DIFF / 60)) minuto(s) con $(($DIFF % 60)) segundos.$nocol"                
	fi #FIN DEL IF
fi

#MENSAJE
echo -e "$yellow*****************************************************"
echo "                       Compilacion completa!         "
echo -e "*****************************************************$nocol" 


