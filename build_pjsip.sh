#!/bin/bash

#  build_pjsip.sh
#  
#
#  Created by Administrator on 11/12/15.
#


configsite=`cat config_site.h`
DIRSTART=$PWD

if [ -z "$2" ]; then
    dest=$PWD
else
    if [ ! -d "$2" ]; then
        echo "please input correct destination path as parameter 2"
        exit 1
    fi
    cd "$2"
    dest=$PWD
    cd $DIRSTART
fi



if [ ! -d "$1" ]; then
    echo "please input correct path to pjsip source as parameter 1"
    exit 1
fi

cd "$1"

if [ ! -f ./configure-iphone ]; then
    echo "configure-iphone not found!"
    exit 1
fi


DEST_FOLDER="$dest/build-ios"


if [ -d "$DEST_FOLDER" ]; then
    rm -r "$DEST_FOLDER"
fi

mkdir -p "$DEST_FOLDER"

source=$PWD

echo "Create config site file"
cat <<EOF > "$source/pjlib/include/pj/config_site.h"
#define PJ_CONFIG_IPHONE 1
$configsite
EOF


LIB_PATHS=("pjlib" \
"pjlib-util" \
"pjmedia" \
"pjnath" \
"pjsip" \
"third_party")

PLATFORMS=("armv7" \
"armv7s" \
"arm64")


SIM=("i386" \
"x86_64")


for platform in "${PLATFORMS[@]}"
do
    ARCH="-arch $platform" CFLAGS="-miphoneos-version-min=7.0" LDFLAGS="-miphoneos-version-min=7.0" ./configure-iphone
    make dep && make realclean && make
done

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer
for platform in "${SIM[@]}"
do

    ARCH="-arch $platform" CFLAGS="-O2 -m32 -mios-simulator-version-min=7.0" LDFLAGS="-O2 -m32 -mios-simulator-version-min=7.0" ./configure-iphone
    make dep && make realclean && make
done



mkdir -p "$DEST_FOLDER/lib"
mkdir -p "$DEST_FOLDER/tmplib"
mkdir -p "$DEST_FOLDER/include"

for libpath in "${LIB_PATHS[@]}"
do
    cp -R "$source/$libpath/lib/." "$DEST_FOLDER/tmplib/"
    if [ -d "$source/$libpath/include/" ]; then
        cp -R "$source/$libpath/include/." "$DEST_FOLDER/include/"
    fi
done



REAL_IFS=IFS

LIB_SUFFIX="-apple-darwin_ios.a"

echo "lipo files"
for file in $DEST_FOLDER/tmplib/*-${PLATFORMS[0]}$LIB_SUFFIX ; do

    filename=$(basename "$file")
    IFS='-' read -ra LIBNAME <<< "$filename"

    lib=""
    for fileNamePath in "${LIBNAME[@]}" ; do
        if [ $fileNamePath == ${PLATFORMS[0]} ]; then
            break;
        fi
        lib="$lib-$fileNamePath"
    done

    lib=${lib#"-"}
    #echo "$lib"

    lipocommand="lipo"
    for platform in "${PLATFORMS[@]}" ; do
        lipocommand="$lipocommand -arch $platform $DEST_FOLDER/tmplib/$lib-$platform$LIB_SUFFIX"
    done
    for platform in "${SIM[@]}" ; do
        lipocommand="$lipocommand -arch $platform $DEST_FOLDER/tmplib/$lib-$platform$LIB_SUFFIX"
    done

    lipocommand="$lipocommand -create -output $DEST_FOLDER/lib/$lib$LIB_SUFFIX"
#echo "$lipocommand"
    eval $lipocommand

done

IFS=REAL_IFS

rm -r "$DEST_FOLDER/tmplib"


exit 0

