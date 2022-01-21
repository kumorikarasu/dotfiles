#!/bin/bash

OSDISTRO=`grep '^NAME' /etc/os-release`

if [[ $OSTYPE == darwin* ]]; then
AWK_CMD=gawk
else
AWK_CMD=awk
fi

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

S_BREW="${C_ORANGE} ${C_MAGENTA}BREW ${C_STOP}"
  S_GIT="${C_GREEN} ${C_MAGENTA}GIT  ${C_STOP}"
 S_APT="${C_YELLOW} ${C_MAGENTA}APT  ${C_STOP}"

log() {
  if [[ -z $2 ]]; then
    echo -e "${C_BLUE} ${C_MAGENTA}SETUP${C_STOP}: $1"
  else
    echo -e "${!2}: $1"
  fi
}

function execute() {
  SEDCMP="s/^/${C_DGREEN}${!1}${C_STOP}|/; s/[eE][rR][rR][oO][rR]/$S_ERROR/; s/[wW][aA][rR][nN][iI][nN][gG]/$S_WARNING/; s/[sS][uU][cC][cC][eE][sS][sS]/$S_SUCCESS/; s/[cC][hH][eE][cC][kK][iI][nN][gG]/$S_CHECKING/;"
 
  if [[ $OSTYPE == darwin* ]]; then
    echo -e $(stdbuf -o0 ${@:2} 2>&1 \
      | sed "$SEDCMP" \
      | sed "s/x1B\[/\\\\\x1B\[/g;" \
      | $AWK_CMD 'BEGIN { FS = "|" } ; { printf "%-24s: %s\\n", $1, $2 }')
  else
    stdbuf -o0 "${@:2}" 2>&1 \
      | sed "$SEDCMP" \
      | $AWK_CMD 'BEGIN { FS = "|" } ; { printf "%-24s: %s\n", $1, $2 }'
  fi
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


## Setup SUDO so we don't have to enter our password anymore
log "Setting SUDO to non-interactive mode"
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers &>/dev/null

## Install Brew
if ! command -v brew &> /dev/null; then
  log "Install Brew" 'S_BREW'
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apt Packages
function aptstall() {
  LIST=$(sudo dpkg --get-selections)
  for pkg in $@ 
  do
    if [ `echo $LIST | grep -c "$pkg"` -eq 0 ]; then
      execute 'S_APT' sudo apt-get install -y $CMD
      if sudo apt-get -qq install $pkg; then
        log "Installed $pkg" 'S_APT'
      else
        log "${C_RED}ERROR${C_STOP} installing $pkg" 'S_APT'
      fi
    else
      log "$pkg Installed" 'S_APT'
    fi
  done
}

log "Apt Update" 'S_APT' 
sudo apt-get update &> /dev/null
aptstall zsh vim clang tmux autojump curl build-essential apt-transport-https ca-certificates gnupg containerd.io docker-ce docker-ce-cli docker-compose cmake python3 silversearcher-ag

# Brew Packages
function brewstall() {
  for CMD in $@ 
  do
    if ! command -v $CMD &> /dev/null; then
      execute 'S_BREW' brew install $CMD
    fi
    log "$CMD Installed" 'S_BREW'
  done
}

brewstall k9s helm terraform jq
execute 'S_BREW' brew upgrade

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
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

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
VIM_CUSTOM=${VIM_CUSTOM:-~/.vim}
clone  https://github.com/mileszs/ack.vim.git $VIM_CUSTOM/bundle/ack.vim
clone  https://github.com/Rip-Rip/clang_complete.git $VIM_CUSTOM/bundle/clang_complete
clone  https://github.com/kien/ctrlp.vim.git $VIM_CUSTOM/bundle/ctrlp
clone  https://github.com/Lokaltog/vim-easymotion.git $VIM_CUSTOM/bundle/easymotion
clone  https://github.com/tpope/vim-fugitive.git $VIM_CUSTOM/bundle/fugitive
clone  https://github.com/eagletmt/ghcmod-vim.git $VIM_CUSTOM/bundle/ghcmod
clone  https://github.com/itchyny/lightline.vim $VIM_CUSTOM/bundle/lightline.vim
clone  https://github.com/scrooloose/nerdtree.git $VIM_CUSTOM/bundle/nerdtree
clone  https://github.com/Xuyuanp/nerdtree-git-plugin.git $VIM_CUSTOM/bundle/nerdtree-git-plugin
clone  https://github.com/Lokaltog/vim-powerline.git $VIM_CUSTOM/bundle/powerline
clone  https://github.com/jb55/Vim-Roy.git $VIM_CUSTOM/bundle/roy
clone  https://github.com/jb55/snipmate-snippets.git $VIM_CUSTOM/bundle/snippets
clone  https://github.com/tpope/vim-surround.git $VIM_CUSTOM/bundle/surround
clone  https://github.com/scrooloose/syntastic.git $VIM_CUSTOM/bundle/syntastic
clone  https://github.com/godlygeek/tabular.git $VIM_CUSTOM/bundle/tabular
clone  https://github.com/c9s/vikube.vim.git $VIM_CUSTOM/bundle/vikube.vim
clone  https://github.com/tpope/vim-fugitive.git $VIM_CUSTOM/bundle/vim-fugitive
clone  https://github.com/airblade/vim-gitgutter.git $VIM_CUSTOM/bundle/vim-gitgutter
clone  https://github.com/pangloss/vim-javascript.git $VIM_CUSTOM/bundle/vim-javascript
clone  https://github.com/terryma/vim-multiple-cursors.git $VIM_CUSTOM/bundle/vim-multiple-cursors
clone  https://github.com/flazz/vim-colorschemes.git $VIM_CUSTOM/bundle/vim-colorschemes

clone https://github.com/puremourning/vimspector.git $VIM_CUSTOM/pack/vimspector

log "Changing shell to /bin/zsh ..."
sudo chsh -s /bin/zsh $USER
