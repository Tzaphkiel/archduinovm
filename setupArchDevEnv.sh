# update system
sudo pacman -Syuu
sudo reboot

#==========================
# enable system services
sudo pacman -S openssh
sudo systemctl enable sshd
sudo systemctl enable sshd
sudo systemctl start sshd
# enable network manager
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd

#==========================
# install yaourt
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si
cd ..
rm -rf yaourt/ package-query/

#==========================
# install base system packages
sudo pacman -S tmux vim git curl wget httpie
sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils
sudo pacman -Sy extra/python-pip

#==========================
# configure my env
curl https://raw.githubusercontent.com/Tzaphkiel/ZshEnv/master/setupGitEnv.sh > setupGit.sh
curl https://raw.githubusercontent.com/Tzaphkiel/ZshEnv/master/.tmux.conf > .tmux.conf
chmod +x setupGit.sh
./ setupGit.sh
rm ./setupGit.sh
# powerline
sudo -H pip install powerline-status
# https://fedoramagazine.org/add-power-terminal-powerline/
# add to the .bashrc:
#  powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  . /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
# add to tmux.conf:
#  source "/usr/lib/python3.6/site-packages/powerline/bindings/tmux/powerline.sh"

#==========================
# install arduino env
sudo yaourt -S arduino-mk
sudo pacman -S arduino arduino-avr-core arduino-docs
gpasswd -a $USER lock
sudo gpasswd -a $USER staff
sudo gpasswd -a $USER lock
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER vboxsf
stty -F /dev/ttyACM0 cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts
# just in case
pip install pyserial
sudo pacman -S colorgcc
# @see https://github.com/sudar/Arduino-Makefile
mkdir ~/bin
ln -s /usr/bin/colorgcc ~/bin/avr-gcc
ln -s /usr/bin/colorgcc ~/bin/avr-g++
# add to .bashrc: PATH=${HOME}/bin:${PATH}

# prepare vbox share
sudo mkdir /mnt/share
cd /home/$USER
ln -s /mnt/share
touch mountshare.sh
echo "sudo mount -t vboxsf vboxsf share" >> mountshare.sh
chmod +x mountshare.sh





