#!/bin/bash

function clone {
  echo "Installing $1"
  exec 3>&1
  exec 1> >(paste /dev/null -)
  git -C $2 pull 2>/dev/null || git clone --depth=1 $1 $2
  exec 1>&3 3>&-
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
      -e "/\.ssh$/d" \
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

clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k
clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# oh-my-zsh themes
clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Vim Plugins
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

clone https://github.com/puremourning/vimspector.git $VIM_CUSTOM/pack/vimspector

echo "Changing shell to /bin/zsh ..."
chsh -s /bin/zsh
