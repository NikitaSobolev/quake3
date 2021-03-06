#!/bin/bash
# this script builds q3 with SDL
# invoke with ./build.sh
# or ./build.sh clean to clean before build

# directory containing the ARM shared libraries (rootfs, lib/ of SD card)
# specifically libEGL.so and libGLESv2.so
LIBS=<path-to-buildroot>/output/staging/usr/lib

# directory containing baseq3/ containing .pk3 files - baseq3 on CD
BASEQ3_DIR="/home/${USER}/"

# directory to find khronos linux make files (with include/ containing
# headers! Make needs them.)
INCLUDES="-I<path-to-buildroot>/output/staging/usr/include "

# prefix of arm cross compiler installed
CROSS_COMPILE=arc-linux-

# clean
if [ $# -ge 1 ] && [ $1 = clean ]; then
   echo "clean build"
   rm -rf build/*
fi

# sdl not disabled
make V=1 -j48 -f Makefile COPYDIR="$BASEQ3_DIR" ARCH=arc \
        CC=""$CROSS_COMPILE"gcc" USE_SVN=0 USE_CURL=0 USE_OPENAL=0 \
        CFLAGS="-DVCMODS_MISC  -DVCMODS_DEPTH -DVCMODS_REPLACETRIG $INCLUDES" \
        LDFLAGS="  -L$LIBS -lSDL  -lEGL -lGLESv2 -lrt"

# copy the required pak3 files over
# cp "$BASEQ3_DIR"/baseq3/*.pk3 "build/release-linux-arm/baseq3/"
# cp -a lib build/release-linux-arm/baseq3/
exit 0

