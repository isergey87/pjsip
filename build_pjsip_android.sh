#!/bin/bash

#  build_pjsip.sh
#
#
#  Created by Administrator on 11/12/15.
#


configsite=`cat config_site.h`
DIRSTART=$PWD

if [ ! -d "$2" ]; then
echo "please input correct ANDROID_NDK_ROOT path as parameter 2"
exit 1
fi
cd "$2"
ndk=$PWD
cd $DIRSTART
export ANDROID_NDK_ROOT=$ndk

if [ -z "$3" ]; then
dest=$PWD
else
if [ ! -d "$3" ]; then
echo "please input correct destination path as parameter 3"
exit 1
fi
cd "$3"
dest=$PWD
echo $dest
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

DEST_FOLDER="$dest/build-android"


if [ -d "$DEST_FOLDER" ]; then
rm -r "$DEST_FOLDER"
fi

mkdir -p "$DEST_FOLDER"

source=$PWD

PJSUA="$source/pjsip-apps/src/swig"

echo "Create config site file"
cat <<EOF > "$source/pjlib/include/pj/config_site.h"
#define PJ_CONFIG_ANDROID 1
$configsite
EOF


LIB_PATHS=("pjlib" \
"pjlib-util" \
"pjmedia" \
"pjnath" \
"pjsip" \
"third_party")

PLATFORMS=("armeabi" \
"armeabi-v7a" \
"x86" \
"mips" \
"arm64-v8a" \
"x86_64" \
"mips64")


LIB="$DEST_FOLDER/lib"
mkdir -p "$LIB"


for platform in "${PLATFORMS[@]}"
do
APP_PLATFORM=android-14 TARGET_ABI=$platform ./configure-android --use-ndk-cflags
make dep && make realclean && make
mkdir -p "$LIB/$platform"

cd "$PJSUA"
make

mv "$PJSUA/java/android/libs/armeabi/libpjsua2.so" "$LIB/$platform"
done


mkdir -p "$DEST_FOLDER/src"

cp -r "$PJSUA/java/android/src" "$DEST_FOLDER"
exit 0

