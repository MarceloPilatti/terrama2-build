#!/bin/bash

TERRALIB_BUILD_PATH="/home/terrama2/mydevel/terrama2/terralib/build"
TERRAMA_BUILD_PATH="/home/terrama2/mydevel/terrama2/build"
TERRAMA_3RD_PARTY_PATH="/home/terrama2/mydevel/terrama2/3rdparty"
TERRAMA_MYLIBS_PATH="/home/terrama2/mydevel/terrama2/mylibs"
TERRAMA_CODEBASE_PATH="/home/terrama2/mydevel/terrama2/codebase"

mkdir -p $TERRAMA_BUILD_PATH
mkdir -p $TERRAMA_3RD_PARTY_PATH
mkdir -p $TERRAMA_MYLIBS_PATH
mkdir -p $TERRAMA_CODEBASE_PATH

echo "************"
echo "* TerraMA² *"
echo "************"
echo ""

cd $TERRAMA_3RD_PARTY_PATH

if test -f "terrama2-3rdparty.zip"; then
    echo "3RD Party already installed"
else 
	wget -c http://www.dpi.inpe.br/jenkins-data/terradocs/terrama2-3rdparty.zip
	unzip terrama2-3rdparty.zip
fi

cd $TERRAMA_BUILD_PATH

cmake -G "CodeBlocks - Unix Makefiles" \
	-DCMAKE_PREFIX_PATH:PATH="$TERRAMA_MYLIBS_PATH" \
	-DCMAKE_BUILD_TYPE:STRING="Debug" \
	-DCMAKE_SKIP_BUILD_RPATH:BOOL="OFF" \
	-DCMAKE_BUILD_WITH_INSTALL_RPATH:BOOL="OFF" \
	-DCMAKE_INSTALL_RPATH_USE_LINK_PATH:BOOL="ON" \
	-DCMAKE_PREFIX_PATH:PATH="$TERRAMA_MYLIBS_PATH" \
	-Dterralib_DIR:PATH="$TERRALIB_BUILD_PATH" \
	-DBoost_INCLUDE_DIR="$TERRAMA_MYLIBS_PATH/include" \
	-DQUAZIP_INCLUDE_DIR="$TERRAMA_3RD_PARTY_PATH/quazip-install/include/quazip" \
	-DQUAZIP_LIBRARIES="$TERRAMA_3RD_PARTY_PATH/quazip-install/lib/libquazip.so" \
	-DQUAZIP_LIBRARY_DIR="$TERRAMA_3RD_PARTY_PATH/quazip-install/lib" \
	-DQUAZIP_ZLIB_INCLUDE_DIR="$TERRAMA_3RD_PARTY_PATH/quazip-install/include" \
	-DVMIME_INCLUDE_DIR="$TERRAMA_3RD_PARTY_PATH/vmime-install/include" \
	-DVMIME_LIBRARY="$TERRAMA_3RD_PARTY_PATH/vmime-install/lib/libvmime.so" \
	-DVMIME_LIBRARY_DIR="$TERRAMA_3RD_PARTY_PATH/vmime-install/lib" $TERRAMA_CODEBASE_PATH/build/cmake

make -j $(($(nproc)/2))