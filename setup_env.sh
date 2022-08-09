#!/bin/bash

# Colours
C_RED='\x1B[01;91m'
C_GREEN='\x1B[01;92m'
C_DGREEN='\x1B[01;38;5;28m'
C_YELLOW='\x1B[01;93m'
C_BLUE='\x1B[01;94m'
C_ORANGE='\x1B[01;38;5;208m'
C_MAGENTA='\x1B[01;95m'
C_CYAN='\x1B[01;96m'
C_BOLD='\x1B[01;1m'
C_STOP='\x1B[0m'

S_INFO="${C_BLUE}INFO${C_STOP}"
S_CHECKING="${C_BLUE}CHECKING${C_STOP}"
S_SKIPPING="${C_BLUE}SKIPPING${C_STOP}"
S_COMPLETED="${C_GREEN}COMPLETED${C_STOP}"
S_SUCCESS="${C_GREEN}SUCCESS${C_STOP}"
S_WARNING="${C_YELLOW}${C_BOLD}WARNING${C_STOP}"
S_ERROR="${C_RED}${C_BOLD}ERROR${C_STOP}"
S_CRITICAL="${C_RED}${C_BOLD}CRITICAL${C_STOP}"

 S_BREW="${C_ORANGE} ${C_MAGENTA}BREW  ${C_STOP}"
   S_GIT="${C_GREEN} ${C_MAGENTA}GIT   ${C_STOP}"
  S_APT="${C_YELLOW} ${C_MAGENTA}APT   ${C_STOP}"
    S_RUBY="${C_RED} ${C_MAGENTA}RUBY  ${C_STOP}"
S_PYTHON="${C_GREEN} ${C_MAGENTA}PYTHON${C_STOP}"
  S_NODE="${C_GREEN} ${C_MAGENTA}NODE  ${C_STOP}"
 S_RUST="${C_ORANGE} ${C_MAGENTA}RUST  ${C_STOP}"

function log() {
  if [[ -z $2 ]]; then
    echo -e "${C_BLUE} ${C_MAGENTA}SETUP ${C_STOP}: $1"
  else
    echo -e "${!2}: $1"
  fi
}

function entry() {

if [[ $OSTYPE == darwin* ]]; then
  AWK_CMD=awk
  log "OSX Requirements: gawk coreutils"
  # On osx first thing we do is install brew and the core packages

  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/sean.stacey/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  brew install gawk coreutils &> /dev/null
else
  log "Linux Requirements: gawk sed"
  AWK_CMD=gawk
  OSDISTRO=`grep '^NAME' /etc/os-release`

  if ! command -v awk &> /dev/null; then
    echo "Missing core utils requires to run this script, running update"
    sudo apt-get update
    sudo apt-get install -y gawk sed
  fi
fi


function execute() {
  SEDCMP="s/^/${C_DGREEN}${!1}${C_STOP}: /; s/[eE][rR][rR][oO][rR]/$S_ERROR/; s/[wW][aA][rR][nN][iI][nN][gG]/$S_WARNING/; s/[sS][uU][cC][cC][eE][sS][sS][ :]/$S_SUCCESS/; s/[cC][hH][eE][cC][kK][iI][nN][gG]/$S_CHECKING/;"
 
  stdbuf -o0 "${@:2}" 2>&1 \
    | sed "$SEDCMP"
}

function execute_nobuf() {
  SEDCMP="s/^/${C_DGREEN}${!1}${C_STOP}: /; s/[eE][rR][rR][oO][rR]/$S_ERROR/; s/[wW][aA][rR][nN][iI][nN][gG]/$S_WARNING/; s/[sS][uU][cC][cC][eE][sS][sS][ :]/$S_SUCCESS/; s/[cC][hH][eE][cC][kK][iI][nN][gG]/$S_CHECKING/;"
 
  ${@:2} 2>&1 | sed "$SEDCMP"
}

function clone() {
  if [[ ! -d $2 ]]; then
    execute 'S_GIT' git clone --depth=1 $1 $2
  else
    execute 'S_GIT' git -C $2 pull
  fi
}


## Script Start
OHMY=.oh-my-zsh
OLD=/tmp/old

if [ ! -d $OLD ]; then
  mkdir $OLD
fi


## ====================== Sudo Setup and Removal Trap
#log "Setting SUDO to non-interactive mode temporarily"
#function finish {
#  sudo sed -i "s/kumori ALL=(ALL) NOPASSWD:ALL//g" /etc/sudoers
#}
#trap finish EXIT
#echo 'kumori ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers &>/dev/null

## ====================== Apt Packages
function aptstall() {
  LIST=$(sudo dpkg --get-selections)
  for pkg in $@ 
  do
    if [ `echo $LIST | grep -c "$pkg"` -eq 0 ]; then
      if sudo apt-get -qq install $pkg; then
        log "Installed $pkg" 'S_APT'
      else
        log "ERROR installing $pkg" 'S_APT'
      fi
    fi
  done
}

if [[ $OSTYPE != darwin* ]]; then
  ## tzdata 'hack'
  sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

  log "apt update" 'S_APT' 
  sudo apt-get update &> /dev/null

  # Apps
  aptstall rsync zsh vim tmux autojump curl build-essential apt-transport-https ca-certificates gnupg containerd.io docker-ce docker-ce-cli cmake silversearcher-ag g++-5 apache2-utils clang ghc 

  # dev libs
  aptstall libasound2-dev portaudio19-dev libpulse-dev libdbus-1-dev libz-dev libssl-dev pkg-config libx11-dev libudev-dev alsa-base libwayland-dev libxkbcommon-dev

  execute 'S_APT' sudo apt-get upgrade -y
fi


## ====================== Brew
if ! command -v brew &> /dev/null; then
  log "Install Brew" 'S_BREW'
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brew Packages
function brewstall() {
  for CMD in $@ 
  do
    if ! command -v $CMD &> /dev/null; then
      execute 'S_BREW' brew install -q $CMD
    fi
    log "$CMD Installed" 'S_BREW'
  done
}

if [[ $OSTYPE == darwin* ]]; then
  brewstall ruby-build llvm tmux autojump 
fi
brewstall nvm python3 pip3 k9s helm kind tfenv jq go-task/tap/go-task docker-compose awscli rbenv linkerd kubectl argocd hugo sops yq deno mongosh hashicorp/tap/terraform-ls nvim tfsec datawire/blackbird/telepresence packer rustup
execute 'S_BREW' brew upgrade

## ====================== Ruby
# Ruby Install and Setup
# TODO setup ruby version to latest automatically and update path accordingly, otherwise gem install fails
RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" execute 'S_RUBY' rbenv install -s 3.1.2
execute 'S_RUBY' rbenv global 3.1.2
execute 'S_RUBY' gem install --user-install terraspace


## ====================== Python
execute 'S_PYTHON' pip3 install pynvim --upgrade
execute 'S_PYTHON' pip3 install thefuck --upgrade

## ====================== Node

## ====================== Node
# Load NVM
export NVM_DIR="$HOME/.nvm"
. $HOME/.nvm/nvm.sh
execute_nobuf 'S_NODE' nvm install 16
execute_nobuf 'S_NODE' nvm use 16
execute 'S_NODE' npm install -g neovim

## ====================== Rust
execute 'S_RUST' rustup-init -q -y

## ====================== Config Folders
function configFolders() {
  log "create folders"
  mkdir -p $HOME/.config
  mkdir -p $HOME/.ssh

  # set up symlinks
  log "Creating sym links..."

  FILES=`ls -a symfiles | grep "^\." \
    | sed \
        -e "1,2d" \
        -e "/\.git$/d" \
        -e "/\.gitmodules$/d" \
        -e "/\.config$/d" \
        -e "/\.ssh$/d" \
  `

  for FILE in $FILES
  do
    execute 'S_INFO' ln -sf `pwd`/symfiles/$FILE $HOME/$FILE
  done

  function linkFolder(){
    log "linking $1"
    for FILE in `ls -A $1`
    do
      execute 'S_INFO' ln -sf `pwd`/$1/$FILE $HOME/$2/$FILE
    done
  }
  linkFolder symfiles/.config .config
  linkFolder symfiles/.ssh .ssh

  for FILE in `ls -A symfiles/.config`
  do
    ln -sf `pwd`/symfiles/.config/$FILE $HOME/.config/$FILE
  done

  # Create code directories
  mkdir -p $HOME/code
  mkdir -p $HOME/code/home

  # Symlink gitconfig based on code directory, more todo here
  ln -sf `pwd`/symfiles/.gitconfig $HOME/code/home/.gitconfig

  # install vim config
  log "Installing vim config..."
  ln -sf $HOME/.vim/.vimrc $HOME/.vimrc

  # install zsh config
  log "Installing zsh config..."
  clone http://github.com/robbyrussell/oh-my-zsh.git $HOME/$OHMY
  ln -sf `pwd`/kumori.zsh-theme $HOME/$OHMY/themes/kumori.zsh-theme

  # oh-my-zsh plugins
  ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
}

configFolders

log "Installing ZSH Plugins"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k
clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# oh-my-zsh themes
clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Vim Plugins
log "Installing VIM Plugins"
VIM_CUSTOM=${VIM_CUSTOM:-$HOME/.vim}
clone https://github.com/mileszs/ack.vim.git $VIM_CUSTOM/bundle/ack.vim
clone https://github.com/Rip-Rip/clang_complete.git $VIM_CUSTOM/bundle/clang_complete
clone https://github.com/kien/ctrlp.vim.git $VIM_CUSTOM/bundle/ctrlp
clone https://github.com/Lokaltog/vim-easymotion.git $VIM_CUSTOM/bundle/easymotion
clone https://github.com/tpope/vim-fugitive.git $VIM_CUSTOM/bundle/fugitive
clone https://github.com/eagletmt/ghcmod-vim.git $VIM_CUSTOM/bundle/ghcmod
clone https://github.com/itchyny/lightline.vim $VIM_CUSTOM/bundle/lightline.vim
clone https://github.com/scrooloose/nerdtree.git $VIM_CUSTOM/bundle/nerdtree
clone https://github.com/Xuyuanp/nerdtree-git-plugin.git $VIM_CUSTOM/bundle/nerdtree-git-plugin
clone https://github.com/Lokaltog/vim-powerline.git $VIM_CUSTOM/bundle/powerline
clone https://github.com/jb55/Vim-Roy.git $VIM_CUSTOM/bundle/roy
clone https://github.com/jb55/snipmate-snippets.git $VIM_CUSTOM/bundle/snippets
clone https://github.com/tpope/vim-surround.git $VIM_CUSTOM/bundle/surround
clone https://github.com/scrooloose/syntastic.git $VIM_CUSTOM/bundle/syntastic
clone https://github.com/godlygeek/tabular.git $VIM_CUSTOM/bundle/tabular
clone https://github.com/c9s/vikube.vim.git $VIM_CUSTOM/bundle/vikube.vim
clone https://github.com/tpope/vim-fugitive.git $VIM_CUSTOM/bundle/vim-fugitive
clone https://github.com/airblade/vim-gitgutter.git $VIM_CUSTOM/bundle/vim-gitgutter
clone https://github.com/pangloss/vim-javascript.git $VIM_CUSTOM/bundle/vim-javascript
clone https://github.com/terryma/vim-multiple-cursors.git $VIM_CUSTOM/bundle/vim-multiple-cursors
clone https://github.com/flazz/vim-colorschemes.git $VIM_CUSTOM/bundle/vim-colorschemes
clone https://github.com/hashivim/vim-terraform.git $VIM_CUSTOM/bundle/vim-terraform
clone https://github.com/josa42/vim-lightline-coc.git $VIM_CUSTOM/bundle/vim-lightline-coc
clone https://github.com/puremourning/vimspector.git $VIM_CUSTOM/pack/vimspector/opt/vimspector

if [ ! -d "$VIM_CUSTOM/pack/coc" ]; then
  log "Installing CoC"
  log "CoC plugins have to be installed manually from inside vim"
fi

# Use release build of CoC
mkdir -p $HOME/.vim/pack/coc/start
cd $HOME/.vim/pack/coc/start
[[ ! -d $HOME/.vim/pack/coc/start/coc.nvim ]] || git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1

log "Changing shell to /bin/zsh ..."
[ $(echo $SHELL) != '/bin/zsh' ] && sudo chsh -s /bin/zsh $USER
}

TIMEFORMAT="Update took %Rs"
time entry "$@"

