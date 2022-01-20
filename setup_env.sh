#!/bin/bash
function clone {
  git -C $2 pull 2>/dev/null || git clone $1 $2
}

OHMY=.oh-my-zsh
OLD=/tmp/old

if [ ! -d $OLD ]; then
  mkdir $OLD
fi

# set up symlinks
echo "Creating sym links..."

FILES=`ls -a symfiles | grep "^\." \
  | sed \
      -e "1,2d" \
      -e "/\.git$/d" \
      -e "/\.gitmodules$/d" \
      -e "/\.config$/d" \
`

for FILE in $FILES
do
  DEST=$HOME/$FILE
  ln -sf `pwd`/symfiles/$FILE $HOME/$FILE
done

## Create .config and symlink it
mkdir -p $HOME/.config

FILES=`ls -a symfiles/.config | sed \
      -e "1,2d"
`

for FILE in $FILES
do
  DEST=$HOME/.config/$FILE
  ln -sf `pwd`/symfiles/.config/$FILE $HOME/.config/$FILE
done

# Create code directories
mkdir -p $HOME/code
mkdir -p $HOME/code/home

# Symlink gitconfig based on code directory, more todo here
ln -sf `pwd`/symfiles/.gitconfig $HOME/code/home/.gitconfig

# install vim config
echo "Installing vim config..."
ln -sf $HOME/.vim/.vimrc $HOME/.vimrc

# install zsh config
echo "Installing zsh config..."
git -C $HOME/$OHMY pull || git clone http://github.com/robbyrussell/oh-my-zsh.git $HOME/$OHMY
ln -sf `pwd`/kumori.zsh-theme $HOME/$OHMY/themes/kumori.zsh-theme

# oh-my-zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

REPO=$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git -C $REPO pull 2>/dev/null || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $REPO

REPO=$ZSH_CUSTOM/plugins/k
git -C $REPO pull || git clone https://github.com/supercrabtree/k $REPO

REPO=$ZSH_CUSTOM/plugins/fast-syntax-highlighting
git -C $REPO pull || git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $REPO

REPO=$ZSH_CUSTOM/plugins/zsh-history-substring-search
git -C $REPO pull || git clone https://github.com/zsh-users/zsh-history-substring-search $REPO

REPO=$ZSH_CUSTOM/plugins/zsh-autosuggestions
git -C $REPO pull || git clone https://github.com/zsh-users/zsh-autosuggestions $REPO

# oh-my-zsh themes
REPO=$ZSH_CUSTOM/themes/powerlevel10k
git -C $REPO pull || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git  $REPO

# Update vim submodules
# cd symfiles/.vim/bundle && git submodule update --init --recursive

echo "Changing shell to /bin/zsh ..."
# chsh -s /bin/zsh
