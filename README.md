<!-- https://daringfireball.net/projects/markdown/syntax.text -->

[Ubuntu Server 20.04 LTS](https://ubuntu.com/server)
====================================================================================================

Setup
----------------------------------------------------------------------------------------------------

```console
$ curl -OL https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-live-server-amd64.iso
```

<!-- https://ubuntu.com/download/iot/installation-media#ubuntu -->

```console
$ lsblk
$ dd if=ubuntu-20.04.1-live-server-amd64.iso of=/dev/<DEVICE> bs=32M status=progress
```

Install [i3](https://i3wm.org/)
----------------------------------------------------------------------------------------------------

```console
$ sudo timedatectl set-timezone Europe/Berlin
```

```console
$ sudo apt update
$ sudo apt upgrade -y
```

```console
$ sudo apt install -y i3 xinit xterm
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
$ sudo systemctl edit getty@tty1
### + [Service]
### + ExecStart=
### + ExecStart=-/sbin/agetty --noissue --autologin <USER> %I $TERM
### + Type=idle

```

```console
$ lsblk 
$ sudo mkdir -p /media/usb
$ sudo mount /dev/<DEVICE> /media/usb
```

```console
$ sudo mkdir -p <PATH>
$ id -u $USER
$ id -g $USER
$ sudo nano /etc/fstab
### + /dev/disk/by-uuid/<UUID> <PATH> <FILESYSTEM> uid=<UID>,gid=<GID>,sync,auto,rw 0 0
```

```console
$ shutdown -r now
```

Install Software
----------------------------------------------------------------------------------------------------

```console
$ alias apt-install="apt install -y --no-install-recommends"
```

### Core ###

```console
$ sudo apt-install fish fonts-cmu ttf-ancient-fonts fonts-firacode
```

```console
$ sudo apt-install python3 python3-dev python3-pip
```

```console
$ sudo apt-install firefox thunderbird git meld okular mpv feh xfe
```

```console
$ sudo apt-install nvidia-driver-460 xrandr x11-xserver-utils
```

```console
$ sudo apt-install pulseaudio pulseaudio-utils pulsemixer
$ usermod -aG pulse,pulse-access $USER
```

### LaTeX ###

```console
$ sudo apt-install texlive-full latexmk gimp
```

### CMake / LLVM 11 ###

```console
$ sudo apt-install graphviz gcc-9 g++-9 ninja-build
```

```console
$ sudo apt-key adv --fetch-keys  https://apt.kitware.com/keys/kitware-archive-latest.asc
$ sudo apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main'
$ sudo apt update
$ sudo apt-install cmake
```

```console
$ sudo apt-key adv --fetch-keys https://apt.llvm.org/llvm-snapshot.gpg.key
$ sudo add-apt-repository -y 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main'
$ sudo apt update
$ sudo apt-install clang-11 llvm-11-dev clang-tidy-11 lld-11
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
$ sudo apt-install libboost-all-dev python-dev libsqlite3-dev libssl-dev
$ sudo apt-install libxml2-dev libz3-dev libcurl4-openssl-dev
```

### Java 11 ###

```console
$ sudo apt-install openjdk-11-jdk
```

```console
$ sudo update-alternatives --config java
$ sudo update-alternatives --config javac
$ nano ~/.profile
### + JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
### + PATH=$JAVA_HOME/bin:$PATH
```

### Gradle (latest) ###

<!-- https://gradle.org/releases -->

```console
$ sudo apt-install jq
$ URL="$(curl -sL https://services.gradle.org/versions/current | jq -r '.downloadUrl')"
$ curl -OL $URL
$ unzip -u ${URL##*/} -d ~/.local/share/ && rm -f ${URL##*/}
$ ln -sf $(ls -1at $HOME/.local/share/*/bin/gradle | head -1) ~/.local/bin/gradle
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
$ sudo apt-install hplip
```

#### USB Printer ####

```console
$ hp-setup -i
```

#### Network Printer ####

<!-- https://support.hp.com/us-en/document/c02480766 -->

```console
$ sudo apt-install nmap
$ ifconfig
$ nmap -p 515,631,9100 <SUBNET>/24
$ hp-setup -i <IP>
```

### Misc ###

```console
$ sudo apt-install fortune-mod fortunes-off lm-sensors
```

<!--       _
       .__(.)< (SHIBBOLEET)
        \___)   
 ~~~~~~~~~~~~~~~~~~-->
