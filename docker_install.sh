#!/bin/bash
project='/home/wangdigang'

function addSources() {
echo '
# China Ubuntu Sources
deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-updates main restricted
deb http://cn.archive.ubuntu.com/ubuntu/ xenial universe
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-updates universe
deb http://cn.archive.ubuntu.com/ubuntu/ xenial multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-updates multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list
}

function installZlib() {
  cd ${project}/software
  tar -zxvf zlib-1.2.11.tar.gz
  cd zlib-1.2.11
  ./configure --prefix=/usr/local/
  make clean
  make -j16
  make install
  cd ..
  rm -rf zlib-1.2.11
}

function installOpenssl() {
  cd ${project}/software
  tar -zxvf openssl-1.1.1i.tar.gz
  cd openssl-1.1.1i
  ./config
  make clean
  make -j16
  make install
  cd ..
  rm -rf openssl-1.1.1i
}

function installCmake() {
  cd ${project}/software
  tar -zxvf cmake-3.19.2.tar.gz
  cd cmake-3.19.2
  ./bootstrap
  ./configure --prefix=/usr/local/
  make clean
  make -j16
  make install
  cd ..
  rm -rf cmake-3.19.2
}

function installDependences() {
  apt-get update
  apt-get install -y vim net-tools iputils-ping gcc g++ lsb-release
  installZlib
  installOpenssl
  installCmake
}

function installRos() {
  # sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
  # sh -c 'echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  # sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
  # wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | apt-key add -
  # apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116
  # apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
  sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
  apt-get update --fix-missing
  apt-get install -y ros-kinetic-desktop-full --fix-missing
}

# docker install
# addSources
# installDependences
# bash ${project}/Anaconda3-2020.11-Linux-x86_64.sh
installRos
