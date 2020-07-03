#!/bin/bash

cd /

apt-get update

apt-get install -y qtcreator curl unzip zip locales supervisor wget libcurl3-dev libpython2.7-dev libproj-dev libgeos++-dev libssl-dev \
libxerces-c-dev screen gdal-bin doxygen graphviz gnutls-bin gsasl libgsasl7 libghc-gsasl-dev libgnutls-dev zlib1g-dev python-psycopg2 \
debhelper devscripts git build-essential ssh openssh-server libpq-dev sudo qt5-default nano apt-transport-https ca-certificates

TERRAMA2_USER=terrama2

groupadd $TERRAMA2_USER
useradd $TERRAMA2_USER -s /bin/bash -m -g $TERRAMA2_USER
echo $TERRAMA2_USER:$TERRAMA2_USER | chpasswd
chown -R $TERRAMA2_USER:$TERRAMA2_USER /home/$TERRAMA2_USER
chmod g-w /home/$TERRAMA2_USER
ssh-keygen -t rsa -b 4096 -C "terrama2-team@dpi.inpe.br" -N "" -f $HOME/.ssh/id_rsa
mkdir /home/$TERRAMA2_USER/.ssh
cat /root/.ssh/id_rsa.pub > /home/$TERRAMA2_USER/.ssh/authorized_keys
cp /root/.ssh/id_rsa.pub /home/$TERRAMA2_USER/.ssh/
cp /root/.ssh/id_rsa /home/$TERRAMA2_USER/.ssh/
chown -R ${TERRAMA2_USER}:${TERRAMA2_USER} /home/$TERRAMA2_USER/.ssh
chmod -R 700 /home/$TERRAMA2_USER/.ssh
echo "${TERRAMA2_USER} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

echo "********************"
echo "* Installing CMake *"
echo "********************"
echo ""

wget -c https://github.com/Kitware/CMake/releases/download/v3.11.4/cmake-3.11.4-Linux-x86_64.sh
chmod +x cmake-3.11.4-Linux-x86_64.sh
./cmake-3.11.4-Linux-x86_64.sh --skip-license --exclude-subdir --prefix=/usr/local
rm -f cmake-3.11.4-Linux-x86_64.sh

cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
echo 'deb https://deb.nodesource.com/node_8.x xenial main' > /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://deb.nodesource.com/node_8.x xenial main' >> /etc/apt/sources.list.d/nodesource.list

apt-get update

apt-get install -y nodejs

export PATH=$PATH:/usr/lib/node_modules/npm/bin

npm install -g grunt-cli

export PATH=$PATH:/usr/lib/node_modules/grunt-cli/bin