# me212bashrc
## Purpose
This bash scripts installs everything needed to run 2.12 ROS labs (except the labs themselves) on a clean install of Ubuntu 16.04 LTS (with whatever the current release is when you are reading this).

## Installation
The script may be executed by downloading this repository to the home folder as a git repo.  First, you'll need to make sure git is installed:
```bash
sudo apt-get --yes install git
cd ~
git clone https://github.com/mit212/me212bashrc.git
```

After downloading, the script can be run:
```bash
cd ~/me212bashrc
./install_software.sh
```

## Usage
For staff attempting to test the installation, and students working on their **final** projects, the [prc repo](https://github.com/mit212/prc) holds essentially the sum of all the labs, completed, so that students can work from an organized and identical starting point.  This can be cloned and tested without hardware to ensure proper installation:
```bash
cd ~
git clone https://github.com/mit212/prc.git
cd ~/prc/catkin_ws/
catkin_make
rebash
```
The previous commands simply build the required files, and allow the terminal to understand the shortcut commands.  To test the installation:
```bash
pman
```
will open up the process manager with the current $ENV's procman.pmd, found in $ENV/software/config/

## Shortcuts
|Command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|Notes|
|---|---|
|```setenv <env_name>```|Changes the directory in ~/ that is used as the ROS/catkin workspace (stored as $ENV).  Typically PRC or LAB1/2/etc.|
|```getenv```|Shows the current ROS/catkin workspace.|
|```gituser <github_user>```|Sets the github username and email for commits.  Super helpful once working as teams.  See the ~/.bash_aliases file, and add email addresses as needed.|
|```pman```|Shortcut for starting libbot-procman, using the config file in the current ROS/catkin workspace under ```$ENV/software/config/procman.pmd``` .|
|```catkin_make```|Starts ROS's built-in build system, to generate message types for topics, make C code, and generally get modified packages ready for execution.  Sometimes requires invoking rebash afterwords.  Must be invoked in the ROS/catkin workspace that needs building (e.g. ```~/prc/catkin_workspace/```).|
|```rebash```|Updates environmental variables in the current terminal.  This must be done anytime running catkin_make would have added message types, or if packages have been added.|
