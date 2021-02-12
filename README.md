<!-- https://daringfireball.net/projects/markdown/syntax.text -->

[Ubuntu Server 20.04 LTS](https://ubuntu.com/server)
================================================================================

- [Setup](#setup)
- [Install i3](#install-i3)
- [Install Software](#install-software)
  - [Core](#core)
  - [LaTeX](#latex)
  - [LLVM](#llvm)
  - [Libraries](#libraries)
  - [Java](#java)
  - [SSH](#ssh)
  - [GPG](#gpg)
  - [HPLIP](#hplip)
    - [USB](#usb)
    - [Network](#network)
  - [Misc](#misc)

Setup
--------------------------------------------------------------------------------

```console
$ curl https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-live-server-amd64.iso -O
```

<!-- https://ubuntu.com/download/iot/installation-media#ubuntu -->

```console
$ lsblk
$ dd if=ubuntu-20.04.1-live-server-amd64.iso of=/dev/<DEVICE> bs=32M status=progress
```

```console
$ shutdown -r now
```

Install [i3](https://i3wm.org/)
--------------------------------------------------------------------------------

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
```

<!-- https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login -->

```console
$ nano ~/.profile
### + if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] ; then
### +   exec startx >/dev/null 2>&1
### + fi
```

<!-- https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console -->

```console
$ systemctl edit getty@tty1
### + [Service]
### + ExecStart=
### + ExecStart=-/sbin/agetty --noissue --autologin <USER> %I $TERM
### + Type=idle

```

```console
$ lsblk 
$ mkdir -p /media/usb
$ mount /dev/sdx /media/usb
```

```console
$ mkdir -p <PATH>
$ id -u $USER
$ id -g $USER
$ nano /etc/fstab
### + /dev/disk/by-uuid/<UUID> <PATH> <FILESYSTEM> uid=<UID>,gid=<GID>,sync,auto,rw 0 0
```

```console
$ shutdown -r now
```

Install Software
--------------------------------------------------------------------------------

### Core ###

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
$ usermod -aG pulse,pulse-access $USER
```

### LaTeX ###

```console
$ apt install -y --no-install-recommends texlive-full latexmk gimp
```

### LLVM ###

```console
$ apt install -y --no-install-recommends graphviz gcc-9 g++-9 ninja-build
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
$ apt install -y --no-install-recommends clang-11 llvm-11-dev clang-tidy-11 lld-11
```

```console
$ ln -sf /usr/bin/clang-tidy-11 ~/.local/bin/clang-tidy
$ ln -sf /usr/bin/clang++-11 ~/.local/bin/clang++
$ ln -sf /usr/bin/clang-11 ~/.local/bin/clang
$ ln -sf /usr/bin/lld-11 ~/.local/bin/lld
$ ln -sf /usr/bin/gcc-9 ~/.local/bin/gcc
$ ln -sf /usr/bin/gcc-9 ~/.local/bin/cc
$ ln -sf /usr/bin/g++-9 ~/.local/bin/g++
```

#### Libraries ####

```console
$ apt install -y --no-install-recommends libboost-all-dev python-dev libsqlite3-dev libssl-dev
$ apt install -y --no-install-recommends libxml2-dev libz3-dev libcurl4-openssl-dev
```

### Java ###

```console
$ apt install -y --no-install-recommends openjdk-11-jdk
```

```console
$ update-alternatives --config java
$ update-alternatives --config javac
$ nano ~/.profile
### + JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
### + PATH=$JAVA_HOME/bin:$PATH
```

### SSH ###

```console
$ ssh-keygen -f ~/.ssh/id_rsa
```

### GPG ###

<!-- https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key -->

```console
$ gpg --full-generate-key
$ gpg --list-secret-keys --keyid-format LONG
$ gpg --armor --export <KEYID>
```

```console
$ nano ~/.profile
### + GPGKEY=<KEYID>
### + export GPG_TTY=$(tty)
```

```console
$ nano ~/.gnupg/gpg-agent.conf 
### + use-agent
### + default-cache-ttl 18000
### + max-cache-ttl 86400
### + ignore-cache-for-signing
```

```console
$ git config --global gpg.program gpg
$ git config --global user.signingkey <KEYID>
$ git config --global commit.gpgsign true
```

### [HPLIP](https://developers.hp.com/hp-linux-imaging-and-printing) ###

```console
$ apt install -y --no-install-recommends hplip
```

#### USB ####

```console
$ hp-setup -i
```

#### Network ####

<!-- https://support.hp.com/us-en/document/c02480766 -->

```console
$ apt install -y --no-install-recommends nmap
$ ifconfig
$ nmap -p 515,631,9100 <SUBNET>/24
$ hp-setup -i <IP>
```

### Misc ###

```console
$ apt install -y --no-install-recommends fortune-mod fortunes-off lm-sensors
```

<!--       _
       .__(.)< (SHIBBOLEET)
        \___)   
 ~~~~~~~~~~~~~~~~~~-->
