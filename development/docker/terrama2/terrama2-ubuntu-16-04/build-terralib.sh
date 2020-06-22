#!/bin/bash

TERRALIB_BUILD_PATH="/home/terrama2/mydevel/terrama2/terralib/build"
TERRALIB_3RD_PARTY_PATH="/home/terrama2/mydevel/terrama2/terralib/3rdparty"
TERRALIB_CODEBASE_PATH="/home/terrama2/mydevel/terrama2/terralib/codebase"
TERRAMA_MYLIBS_PATH="/home/terrama2/mydevel/terrama2/mylibs"

mkdir -p $TERRALIB_BUILD_PATH
mkdir -p $TERRALIB_3RD_PARTY_PATH
mkdir -p $TERRALIB_CODEBASE_PATH

echo "************"
echo "* TerraLib *"
echo "************"
echo ""

cd $TERRALIB_3RD_PARTY_PATH

if test -f "terralib-3rdparty-linux-ubuntu-16.04.tar.gz"; then
    echo "3RD Party already installed"
else 
	wget -c http://www.dpi.inpe.br/terralib5-devel/3rdparty/src/terralib-3rdparty-linux-ubuntu-16.04.tar.gz
	TERRALIB_DEPENDENCIES_DIR="$TERRAMA_MYLIBS_PATH" $TERRALIB_CODEBASE_PATH/install/install-3rdparty-linux-ubuntu-16.04.sh
fi

cd $TERRALIB_BUILD_PATH

cmake -G "CodeBlocks - Unix Makefiles" \
	-DCMAKE_PREFIX_PATH:PATH="$TERRAMA_MYLIBS_PATH" \
    -DTERRALIB_BUILD_AS_DEV:BOOL="ON" \
    -DTERRALIB_BUILD_EXAMPLES_ENABLED:BOOL="OFF" \
    -DTERRALIB_BUILD_UNITTEST_ENABLED:BOOL="OFF" $TERRALIB_CODEBASE_PATH/build/cmake

make -j $(($(nproc)/2))