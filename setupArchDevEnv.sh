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
# configure my env
curl https://raw.githubusercontent.com/Tzaphkiel/ZshEnv/master/setupGitEnv.sh > setupGit.sh
curl https://raw.githubusercontent.com/Tzaphkiel/ZshEnv/master/.tmux.conf > .tmux.conf
chmod +x setupGit.sh
./ setupGit.sh
rm ./setupGit.sh

#==========================
# install base system packages
sudo pacman -S tmux vim git curl wget httpie
sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils
sudo pacman -Sy extra/python-pip

#==========================
# install arduino env
sudo yaourt -S arduino-mk
sudo pacman -S arduino arduino-avr-core arduino-docs
gpasswd -a $USER lock
sudo gpasswd -a $USER staff
sudo gpasswd -a $USER lock
sudo gpasswd -a $USER uucp
stty -F /dev/ttyACM0 cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts
# just in case
pip install pyserial