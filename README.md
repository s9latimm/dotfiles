# [Ubuntu Server 20.04.1 LTS](https://ubuntu.com/server)

- [Setup](#setup)
- [Install i3](#install-i3)
- [Install Software](#install-software)

## Setup

```console
$ curl https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-live-server-amd64.iso -O
```

<!-- https://wiki.archlinux.org/index.php/USB_flash_installation_medium#Using_basic_command_line_utilities -->
```console
$ lsblk
$ dd if=ubuntu-20.04.1-live-server-amd64.iso of=/dev/sdc bs=64K status=progress
```

```console
$ shutdown -r now
```

## Install [i3](https://i3wm.org/)

```console
$ sudo -i
```

```console
$ timedatectl set-timezone Europe/Berlin
```

```console
$ apt update
$ apt -y upgrade
```

```console
$ apt install -y i3 xinit xterm
$ nano ~/.profile
### https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
```

```console
$ systemctl edit getty@tty1
### https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console
```

```console
$ lsblk 
$ mkdir -p /media/usb
$ mount /dev/sdc1 /media/usb
```

```console
$ id -u $USER
$ id -g $USER
$ nano /etc/fstab
### + /dev/disk/by-uuid/<UUID> <PATH> <FILESYSTEM> uid=<UID>,gid=<GID>,sync,auto,rw 0 0
### mkdir -p <PATH>
```

```console
$ shutdown -r now
```

## Install Software

```console
$ apt install -y --no-install-recommends fish fonts-cmu ttf-ancient-fonts fonts-firacode
```

```console
$ apt install -y --no-install-recommends python3 python3-dev python3-pip
```

```console
$ apt install -y --no-install-recommends firefox thunderbird git meld okular mpv feh xfe
```

```console
$ apt install -y --no-install-recommends nvidia-driver-460 xrandr x11-xserver-utils
```

```console
$ apt install -y --no-install-recommends pulseaudio pulseaudio-utils pulsemixer
$ usermod -aG pulse,pulse-access "$USER"
```

```console
$ apt install -y --no-install-recommends texlive-full latexmk graphviz gcc-9 g++-9 ninja-build
```

```console
$ apt-key adv --fetch-keys  https://apt.kitware.com/keys/kitware-archive-latest.asc
$ apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main'
$ apt update
$ apt install -y --no-install-recommends cmake
```

```console
$ apt-key adv --fetch-keys https://apt.llvm.org/llvm-snapshot.gpg.key
$ add-apt-repository -y 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main'
$ apt update
$ apt install -y --no-install-recommends clang-11 llvm-11-dev clang-tidy-11
```

```console
$ ln -sf /usr/bin/clang-tidy-11 ~/.local/bin/clang-tidy
$ ln -sf /usr/bin/clang++-11 ~/.local/bin/clang++
$ ln -sf /usr/bin/clang-11 ~/.local/bin/clang
$ ln -sf /usr/bin/gcc-9 ~/.local/bin/gcc
$ ln -sf /usr/bin/gcc-9 ~/.local/bin/cc
$ ln -sf /usr/bin/g++-9 ~/.local/bin/g++
```

```console
$ ssh-keygen -f ~/.ssh/id_rsa
```

```console
$ apt install -y --no-install-recommends fortune-mod fortunes-off
```

```console
$ shutdown -h now
```

<!--       _
       .__(.)< (SHIBBOLEET)
        \___)   
 ~~~~~~~~~~~~~~~~~~-->
