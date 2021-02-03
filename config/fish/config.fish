set -x JAVA_HOME ~/.local/share/openjdk-14.0.2

set -gx PATH ~/.local/bin $PATH
set -x OPENSSL_ROOT_DIR /usr/include/openssl

alias please="sudo"
alias table="lsblk"

alias reboot="shutdown -r now"
alias halt="shutdown -h now"

alias clone="git clone --recurse-submodules"
alias checkout="git checkout"
alias branch="git checkout -b"
alias commit="git commit -m"
alias log="git log -3"

alias install="sudo apt install --no-install-recommends"

function fish_greeting
    run-parts /etc/update-motd.d/ 
    printf "\n\e[31m"
    fortune -a -s
    printf "\n\e[0m"
end

function sense
    watch -n 1 -d sensors
end

function print_git 
  set -lx ROOT (pwd)
  cd $argv
  printf "\e[1;33m=== $argv ===\e[0m\n"
  set -lx HEAD (git rev-parse --abbrev-ref HEAD)
  set -lx TEST (git log origin/$HEAD..HEAD -1)
  if test -n "$TEST"
    git log origin/$HEAD..HEAD
    echo ""
    git log origin/$HEAD -1
  else  
    git log -1
  end
  echo ""
  cd $ROOT 
end
