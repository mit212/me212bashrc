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

if [ "$#" == 0 ] || [ "$1" == "APT" ]; then
    echo "Install useful packages from apt-get"
    sudo apt-get update
    sudo apt-get --yes install git gitk git-gui geany geany-plugins vim terminator meshlab recordmydesktop meld sagasu openssh-server retext filezilla vlc ipython mesa-utils bmon libyaml-0-2
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
    wget -O arduino-1.6.11-linux64.tar.xz -P ~/Downloads http://web.mit.edu/peterkty/www/shared/arduino/arduino-1.6.11-linux64.tar.xz  
    mkdir -p $HOME/software
    tar -xvf ~/Downloads/arduino-1.6.11-linux64.tar.xz -C $HOME/software
    cd $HOME/software/arduino-1.6.11
    ./install.sh
    sudo ln -s $HOME/software/arduino-1.6.11/arduino /usr/local/bin/arduino
    sudo usermod -aG dialout robot
    
    
    cd ~/Downloads/
    wget -P ~/Downloads -q http://web.mit.edu/peterkty/www/shared/arduino/DualMC33926MotorShield.zip
    unzip -o ~/Downloads/DualMC33926MotorShield.zip -d $HOME/Arduino/libraries
    echo 'ARDUINO install done'
fi

if [ "$#" == 1 ] && [ "$1" == "MATLABBYCOPY" ]; then
    echo "Please download matlab to ~/Downloads/MATLAB.tar.gz"
    ask "Ready? [y/N]" 
    tar -zxf ~/Downloads/MATLAB.tar.gz -C ~/
    
    sudo ln -s $HOME/MATLAB/R2016b/bin/matlab /usr/local/bin/matlab
    sudo ln -s $HOME/MATLAB/R2016b/bin/mbuild /usr/local/bin/mbuild
    sudo ln -s $HOME/MATLAB/R2016b/bin/mcc /usr/local/bin/mcc
    sudo ln -s $HOME/MATLAB/R2016b/bin/mex /usr/local/bin/mex
    matlab
fi

if [ "$#" == 0 ] || [ "$1" == "LCM" ]; then
  # install LCM
  wget -P ~/Downloads -q https://github.com/lcm-proj/lcm/releases/download/v1.3.1/lcm-1.3.1.zip
  mkdir -p $HOME/software
  unzip -o ~/Downloads/lcm-1.3.1.zip -d $HOME/software
  
  cd $HOME/software/lcm-1.3.1
  ./bootstrap.sh
  ./configure
  make
  sudo make install
fi

if [ "$#" == 0 ] || [ "$1" == "LIBBOT" ]; then
  cd $HOME/software
  git clone git@github.com:RobotLocomotion/libbot.git
  cd libbot
  make -j
  sudo cp -r build/* /usr/local/
fi

if [ "$#" == 0 ] || [ "$1" == "ROS" ]; then
    echo "Install ROS"
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
    wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
    sudo apt-get update
    sudo apt-get --yes install ros-indigo-desktop-full
    sudo rosdep init
    rosdep update
    sudo apt-get --yes install python-rosinstall
    source /opt/ros/indigo/setup.bash
    
    sudo apt-get --yes install ros-indigo-moveit-full
    sudo apt-get --yes install ros-indigo-pcl-ros
    sudo apt-get --yes install ros-indigo-joy
    sudo apt-get --yes install ros-indigo-perception  # for cv_bridge
    sudo apt-get --yes install ros-indigo-libpcan # for wsg hand
    
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
    
    sudo apt-get --yes install ros-kinetic-moveit-full
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
    
fi


if [ "$#" == 1 ] && [ "$1" == "MATLAB" ]; then
    echo "Please download matlab to ~/Downloads/matlab_R2016b_glnxa64.zip"
    ask "Ready? [y/N]" 
    cd ~/Downloads/
    unzip -o matlab_R2016b_glnxa64.zip -d matlab_R2016b_glnxa64
    cd matlab_R2016b_glnxa64
    echo "In the install wizard, install the matlab to your home folder e.g. $HOME/MATLAB/R2016b"
    ./install
    
    sudo rm /usr/local/bin/matlab
    sudo rm /usr/local/bin/mbuild
    sudo rm /usr/local/bin/mcc
    sudo rm /usr/local/bin/mex
    sudo ln -s $HOME/MATLAB/R2016b/bin/matlab /usr/local/bin/matlab
    sudo ln -s $HOME/MATLAB/R2016b/bin/mbuild /usr/local/bin/mbuild
    sudo ln -s $HOME/MATLAB/R2016b/bin/mcc /usr/local/bin/mcc
    sudo ln -s $HOME/MATLAB/R2016b/bin/mex /usr/local/bin/mex
fi

if [ "$#" == 1 ] && [ "$1" == "MATLABCOMPILER" ]; then  # for drake
    cd $HOME/MATLAB/R2016b/sys/os/glnxa64
    rm libgfortran.so.3
    ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3.0.0 libgfortran.so.3
    rm libstdc++.so.6
    ln -s /usr/lib/gcc/x86_64-linux-gnu/4.4/libstdc++.so libstdc++.so.6
fi

if [ "$#" == 0 ] || [ "$1" == "ABB" ]; then
    echo "Make abb-ros"
    git submodule update --init --recursive ros_ws/abb-ros
    rosmake robot_comm robot_node
fi

if [ "$#" == 0 ] || [ "$1" == "SOFTWARE" ]; then
    echo "Make SOFTWARE"
    git submodule update --init --recursive software/externals/snopt software/externals/drake
    cd $APC_BASE/software/
    make -j
fi


if [ "$#" == 1 ] && [ "$1" == "FFMPEG" ]; then  ## needed to compile drake movies
    cd ~/Downloads/
    wget -P ~/Downloads -q http://web.mit.edu/peterkty/www/shared/ffmpeg/ffmpeg-2.4.2-64bit-static.tar.gz  # should move to some labspace
    mkdir -p $HOME/software
    tar -zxvf ~/Downloads/ffmpeg-2.4.2-64bit-static.tar.gz -C $HOME/software
    echo 'FFMPEG install done'
fi

if [ "$#" == 0 ] || [ "$1" == "HAND" ]; then 
    git submodule update --init --recursive catkin_ws/src/wsg50-ros-pkg
    echo 'Do catkin_make --pkg wsg_50_common wsg_50_driver wsg_50_simulation'
    cd $APC_BASE/catkin_ws
    catkin_make 
    source $APC_BASE/software/config/apc_environment.sh
    catkin_make 
fi

if [ "$#" == 0 ] || [ "$1" == "CATKIN" ]; then 
    git submodule update --init --recursive catkin_ws/src/apriltags_ros catkin_ws/src/realsense_camera
    echo "Make CATKIN"
    cd $APC_BASE/catkin_ws
    catkin_make
fi

if [ "$#" == 1 ] && [ "$1" == "OPENCV" ]; then
    cd ~/Downloads/
    #wget -q https://github.com/Itseez/opencv/archive/2.4.11.tar.gz
    wget -q http://web.mit.edu/peterkty/www/shared/opencv/2.4.11.zip
    unzip -o 2.4.11.zip -d $HOME/software
    cd $HOME/software/opencv-2.4.11
    mkdir release
    cd release
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D CUDA_GENERATION=Auto ..
    #cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D CUDA_GENERATION=Maxwell ..
    make -j 
    sudo make install
    cd $APC_BASE
fi

if [ "$#" == 1 ] && [ "$1" == "APCSENSOR" ]; then
    git submodule update --init --recursive catkin_ws/src/apc_sensor
    cd $APC_BASE/catkin_ws
    catkin_make --pkg apc_sensor
fi

if [ "$#" == 1 ] && [ "$1" == "REALSENSE" ]; then
    mkdir -p $HOME/software
    cd $HOME/software
    git clone git@github.com:IntelRealSense/librealsense.git
    cd librealsense
    sudo apt-get --yes update && sudo apt-get upgrade
    scripts/install_glfw3.sh
    make -j && sudo make install
    
    scripts/install_glfw3.sh
    
    cd $APC_BASE
    
    git submodule update --init --recursive catkin_ws/src/apc_sensor
    cd $APC_BASE/catkin_ws
    catkin_make --pkg apc_sensor
fi

if [ "$#" == 1 ] && [ "$1" == "V4L" ]; then
    sudo cp $HOME/software/librealsense/config/99-realsense-libusb.rules /etc/udev/rules.d/
    sudo udevadm control --reload-rules && udevadm trigger
    
    export IGNORE_CC_MISMATCH=1  # for conflict with nvidia driver
    sudo $HOME/software/librealsense/scripts/install_dependencies-4.4.sh
    cd $HOME/software/librealsense
    scripts/patch-uvcvideo-4.4.sh v4.4-wily
    cd -
    sudo modprobe uvcvideo
fi


if [ "$#" == 0 ] || [ "$1" == "CMAKE32" ]; then
    cd ~/Downloads/
    wget http://web.mit.edu/peterkty/www/shared/cmake/cmake_3.2.2-1_amd64.deb
    sudo dpkg -i cmake_3.2.2-1_amd64.deb
    sudo mv /usr/bin/cmake /usr/bin/cmake_bak
    sudo mv /usr/bin/ccmake /usr/bin/ccmake_bak
    sudo ln -s /usr/local/bin/cmake /usr/bin/cmake
    sudo ln -s /usr/local/bin/ccmake /usr/bin/ccmake
fi

if [ "$#" == 1 ] && [ "$1" == "CMAKE32BUILD" ]; then
    sudo apt-get --yes install build-essential
    sudo apt-get --yes install checkinstall
    cd ~/Downloads/
    wget http://web.mit.edu/peterkty/www/shared/cmake/cmake-3.2.2.tar.gz
    tar -zxvf cmake-3.2.2.tar.gz -C $HOME/software
    
    cd $HOME/software/cmake-3.2.2
    ./configure
    cmake . -DCMAKE_USE_OPENSSL:BOOLEAN=ON
    make -j
    sudo checkinstall -y --pkgname=cmake3.2
    sudo ln -s /usr/local/bin/cmake /usr/bin/cmake 
fi

if [ "$#" == 1 ] && [ "$1" == "APRIL" ]; then
  sudo apt-get --yes install emacs git-core ant subversion gtk-doc-tools libglib2.0-dev libusb-1.0-0-dev gv libncurses-dev openjdk-7-jdk autopoint libgl1-mesa-dev libpng12-dev
  
  
  sudo apt-get --yes install libdc1394-22-dev
  
  # april Toolkit
  cd $HOME/software
  git clone git://april.eecs.umich.edu/home/git/april.git
  cd april/src
  make all
  cd $HOME/software
  cd april/java
  ant
fi

if [ "$#" == 1 ] && [ "$1" == "APRILTAGCPP" ]; then
    mkdir -p $HOME/software
    cd $HOME/software
    git clone git@github.com:personalrobotics/apriltags-cpp.git
    cd apriltags-cpp
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    make
    sudo make install
fi

if [ "$#" == 0 ] || [ "$1" == "POSEST" ]; then
  git submodule update --init --recursive catkin_ws/src/apc_posest
  echo "Make POSEST"
  cd $APC_BASE/catkin_ws
  catkin_make
  
  cd $APC_BASE/catkin_ws/src/apc_posest/src/
  /usr/local/cuda/bin/nvcc -ptx KNNSearch.cu
  echo "You are fine if you don't have /usr/local/cuda/bin/nvcc and you don't need to run real vision on your computer"
  #/usr/local/cuda/bin/nvcc -ptx -arch=sm_53 KNNSearch.cu
fi


if [ "$#" == 0 ] || [ "$1" == "APCVISION" ]; then
    git submodule update --init --recursive catkin_ws/src/apc_vision
    
    cd $APC_BASE/catkin_ws
    catkin_make --pkg apc_vision
fi

if [ "$#" == 1 ] && [ "$1" == "MATLABROS" ]; then
  matlab -softwareopengl -r 'roboticsAddons'  # install matlab ros
fi


if [ "$#" == 1 ] && [ "$1" == "GRASPCHECK" ]; then
  git submodule update --init --recursive catkin_ws/src/apc_graspcheck
  echo "Make GRASPCHECK"
  cd $APC_BASE/catkin_ws
  catkin_make
fi

if [ "$#" == 1 ] && [ "$1" == "APCPOINTCLOUD" ]; then
  git submodule update --init --recursive catkin_ws/src/apc_pointcloud
  echo "Make APCPOINTCLOUD"
  cd $APC_BASE/catkin_ws
  catkin_make
fi

if [ "$#" == 1 ] && [ "$1" == "MATLABROSMSG" ]; then
  mv $APC_BASE/catkin_ws/src/wsg50-ros-pkg $APC_BASE/catkin_ws/wsg50-ros-pkg 
  mv $APC_BASE/catkin_ws/src/pr_apriltags $APC_BASE/catkin_ws/pr_apriltags
  matlab -softwareopengl -nosplash -r 'cd $APC_BASE/catkin_ws/src/apc_graspcheck/src; make; exit'  # generate messages
  mv $APC_BASE/catkin_ws/wsg50-ros-pkg  $APC_BASE/catkin_ws/src/wsg50-ros-pkg
  mv $APC_BASE/catkin_ws/pr_apriltags $APC_BASE/catkin_ws/src/pr_apriltags
fi


