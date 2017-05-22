#/bin/bash
# Peter KT Yu, 2015


function ask {
    echo $1        # add this line
    read -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return 1;
    else
        exit
        echo "Abort.."
    fi
}

if [ "$#" == 0 ] || [ "$1" == "BASH" ]; then
  echo "Initialize the bashrc"
  if [ -f $HOME/.bashrc  ]; then
    mv $HOME/.bashrc $HOME/.bashrc_bak
  fi
  if [ -f $HOME/.bash_aliases  ]; then
    mv $HOME/.bash_aliases $HOME/.bashrc_bak
  fi
  ln -s "$HOME/me212bashrc/.bashrc" "$HOME/.bashrc"
  ln -s "$HOME/me212bashrc/.bash_aliases" "$HOME/.bash_aliases"
  cp -r $HOME/me212bashrc/.config $HOME/.config
  cp -r $HOME/me212bashrc/.local $HOME/.local
  sudo cp $HOME/me212bashrc/etc/rc.local /etc/rc.local
fi

if [ "$#" == 0 ] || [ "$1" == "APT" ]; then
    echo "Install useful packages from apt-get"
    sudo apt-get update
    sudo apt-get --yes install git gitk git-gui geany geany-plugins vim terminator meshlab recordmydesktop meld sagasu openssh-server retext filezilla vlc ipython mesa-utils bmon libyaml-0-2 python-pip
    sudo apt-get --yes install hardinfo cpufrequtils   # for speedup cpu
        
    sudo apt-get --yes install kcachegrind kcachegrind-converters
    sudo apt-get --yes install build-essential cmake debhelper freeglut3-dev gtk-doc-tools libboost-filesystem-dev libboost-iostreams-dev libboost-program-options-dev libboost-random-dev libboost-regex-dev libboost-signals-dev libboost-system-dev libboost-thread-dev libcurl4-openssl-dev libfreeimage-dev libglew-dev libgtkmm-2.4-dev libltdl-dev libgsl0-dev libportmidi-dev libprotobuf-dev libprotoc-dev libqt4-dev libqwt-dev libtar-dev libtbb-dev libtinyxml-dev libxml2-dev ncurses-dev pkg-config protobuf-compiler python-matplotlib libvtk5.8 libvtk5-dev libvtk5-qt4-dev libqhull-dev python-pygame doxygen mercurial libglib2.0-dev openjdk-6-jdk python-dev gfortran f2c libf2c2-dev spacenavd libspnav-dev python-numpy python-scipy python-vtk python-pip libgmp3-dev libblas-dev liblapack-dev libv4l-dev subversion libxmu-dev libusb-1.0-0-dev python-pymodbus graphviz curl libwww-perl libterm-readkey-perl g++-4.4

    sudo apt-get --yes install libopenal-dev # for drake converting wrl file
    sudo apt-get --yes install libgl1-mesa-dev  # for libbot libGL.so
    # sudo apt-get --yes install virtualbox
    sudo apt-get --yes install compizconfig-settings-manager
    sudo apt-get --yes install libudev-dev  # for realsense
    sudo apt-get --yes install libopencv-*  
    sudo apt-get --yes install libcgal-qt5-dev libcgal-dev  # for pr apriltags
    #sudo pip install --upgrade scipy
    sudo pip install chan 
    sudo pip install openpyxl
    sudo pip install sklearn
    sudo pip install plyfile
    sudo pip install tabulate
    sudo pip install ipdb
    sudo pip install pyprof2calltree
    sudo pip install tabulate
    sudo easy_install pycollada
    sudo apt-get --yes install byacc flex
    sudo apt-get --yes install kazam
fi

if [ "$#" == 0 ] || [ "$1" == "ARDUINO" ]; then
    cd ~/Downloads/
    wget -O arduino-1.6.11-linux64.tar.xz -P ~/Downloads https://downloads.arduino.cc/arduino-1.6.11-linux64.tar.xz
    mkdir -p $HOME/software
    tar -xvf ~/Downloads/arduino-1.6.11-linux64.tar.xz -C $HOME/software
    cd $HOME/software/arduino-1.6.11
    ./install.sh
    sudo ln -s $HOME/software/arduino-1.6.11/arduino /usr/local/bin/arduino
    sudo usermod -aG dialout robot
    
    
    cd ~/Downloads/
    git clone https://github.com/mit212/DualMC33926MotorShield.git
    cp -r DualMC33926MotorShield/ $HOME/Arduino/libraries/
    rm -rf DualMC33926MotorShield/
    
    cd ~/Downloads/
    git clone https://github.com/mit212/LS7366.git
    cp -r LS7366/ $HOME/Arduino/libraries/
    rm -rf LS7366/

    cd ~/Downloads/
    git clone https://github.com/mit212/ServoTimer2.git
    cp -r ServoTimer2/ $HOME/Arduino/libraries/
    rm -rf ServoTimer2/
    
    echo 'ARDUINO install done'
fi

if [ "$#" == 0 ] || [ "$1" == "LCM" ]; then
  # install LCM
  wget -P ~/Downloads -q https://github.com/lcm-proj/lcm/releases/download/v1.3.1/lcm-1.3.1.zip
  mkdir -p $HOME/software
  unzip -o ~/Downloads/lcm-1.3.1.zip -d $HOME/software
  
  cd $HOME/software/lcm-1.3.1
  ./configure
  make
  sudo make install
fi

if [ "$#" == 0 ] || [ "$1" == "ROSK" ]; then
    echo "Install ROS Kinetic"
    
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
    sudo apt-get update
    sudo apt-get --yes install ros-kinetic-desktop-full
    sudo rosdep init
    rosdep update
    sudo apt-get --yes install python-rosinstall
    source /opt/ros/kinetic/setup.bash
    
    sudo apt-get --yes install ros-kinetic-moveit
    sudo apt-get --yes install ros-kinetic-pcl-ros
    sudo apt-get --yes install ros-kinetic-joy
    sudo apt-get --yes install ros-kinetic-perception  # for cv_bridge
    sudo apt-get --yes install ros-kinetic-dynamixel-* # dynamixel
    
    cd /opt/ros/kinetic/share/dynamixel_workbench_toolbox/
    sudo mkdir dynamixel
    sudo cp -r AX EX MX PR RX XL XM dynamixel/
    sudo cp dynamixel/MX/MX_64.device dynamixel/MX/MX64.device
    sudo cp dynamixel/MX/MX_106.device dynamixel/MX/MX106.device
    sudo cp dynamixel/AX/AX_12A.device dynamixel/AX/AX12A.device
    
    sudo cp joint_state_publisher/joint_state_publisher /opt/ros/kinetic/lib/joint_state_publisher/joint_state_publisher
fi

if [ "$#" == 0 ] || [ "$1" == "LIBBOT" ]; then
  mkdir -p $HOME/software
  cd $HOME/software
  git clone https://github.com/mit212/libbot.git
  cd libbot
  make -j
  sudo cp -r build/* /usr/local/
fi


if [ "$#" == 0 ] || [ "$1" == "APRILTAGCPP" ]; then
    mkdir -p $HOME/software
    cd $HOME/software
    #git clone git@github.com:personalrobotics/apriltags-cpp.git
    git clone https://github.com/mit212/apriltags-cpp.git
    cd apriltags-cpp
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    make
    sudo make install
fi




