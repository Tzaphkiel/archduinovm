# archduinovm
Arch Linux Arduino development VirtualBox VM related scripts, setup, etc.

# VM creation
First boot on an Arch linux ISO,
then partition the disk

```sh
# boot partition
n    # Add a new partition
p    # primary
1    # partition number
2048 # Start, as proposed on 2048 to align the blocks correctly
+200M # end it 200M later
a     # MArk it as active/bootable
 
# swap partition
n       
p
2
[enter]
+1G     # Should be enough swap for a VM
t
2
82      # Mark it as swap

# next partition
n
p 
3
[enter]
[enter]
 
w       # Write to disk
```

Then format the partitions
```sh
$ mkfs.ext2 /dev/sda1
$ e2label /dev/sda1 boot
$ mkfs.ext4 /dev/sda3
$ mkswap -L swap01 /dev/sda2
$ swapon /dev/sda2

$ mount /dev/sda3 /mnt
$ mkdir /mnt/boot
$ mount /dev/sda1 /mnt/boot

# double check
$ lsblk
```


Bootstrap the system
```sh
$ pacstrap /mnt base base-devel wget curl git vim tmux httpie 

$ genfstab -U /mnt >> /mnt/etc/fstab
```

Configure
```sh
$ arch-chroot /mnt
$ ln -sf /usr/share/Europe/Brussels /etc/localtime
$ hwclock --systohc
$ vim /etc/locale.gen

# un-comment the ones needed

$ locale-gen
$ vim /etc/locale.conf
# add LANG=en_US.UTF-8

$ vim /etc/vconsole.conf
# add KEYMAP=be-latin1

$ vim /etc/hostname
# name it : archsl ?

$ vim /etc/hosts
# 127.0.0.1	localhost
# ::1		localhost
# 127.0.1.1	myhostname.localdomain	myhostname

$ mkinitcpio -p linux
$ passwd

$ pacman -S grub
$ grub-install /dev/sda
$ grub-mkconfig -o /boot/grub/grub.cfg

# exit chroot
$ exit

$ umount -R /mnt
$ reboot
```

Post installation steps:

```sh
$ useradd -m -G wheel leroyse
$ passwd leroyse

# allow sudo from new user
$ vim /etc/sudoers

# add line : leroyse ALL=(ALL) ALL
$ logout

# log back in as leroyse
$ sudo pacman -S zsh
$ chsh -s /bin/zsh
$ logout
```


