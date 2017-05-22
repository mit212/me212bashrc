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
