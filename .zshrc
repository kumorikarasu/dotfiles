#
# Look in ~/.oh-my-zsh/themes/
# export ZSH_THEME="kumori"
#export TERM="xterm-256color"
#export ZSH_THEME="powerlevel9k/powerlevel9k"
#export DEFAULT_USER="kumori"

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export DEFAULT_USER="kumori"
export TERM="xterm-256color"
export ZSH=/home/sean/.oh-my-zsh
export LANG="en_US.UTF-8"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-fontconfig"

source $ZSH/custom/themes/$ZSH_THEME.zsh-theme
source ~/.fonts/*.sh

POWERLEVEL9K_FOLDER_ICON=""
POWERLEVEL9K_HOME_ICON=""

POWERLEVEL9K_HOME_SUB_ICON="$(print_icon "HOME_ICON")"
#POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

#POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_NVM_BACKGROUND="238"
POWERLEVEL9K_NVM_FOREGROUND="green"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"

POWERLEVEL9K_TIME_BACKGROUND='255'
#POWERLEVEL9K_COMMAND_TIME_FOREGROUND='gray'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs background_jobs command_execution_time time)
POWERLEVEL9K_SHOW_CHANGESET=true

#vi Mode config
POWERLEVEL9K_VI_MODE_INSERT_ICON="$(print_icon "HOME_ICON")"
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='227'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND="blue"
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='teal'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="blue"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
# /!\ do not use with zsh-autosuggestions


plugins=(tmux k knife tig gitfast colored-man-pages colorize command-not-found cp dirhistory autojump sudo fast-syntax-highlighting zsh-history-substring-search zsh-autosuggestions)
#plugins=(chef k tig gitfast colored-man colorize command-not-found cp dirhistory zsh-syntax-highlighting)
#plugins=(colorize)
# /!\ zsh-syntax-highlighting and then zsh-autosuggestions must be at the end

source $ZSH/oh-my-zsh.sh

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='bold'

ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'

# 
# 
# rule () {
# 	print -Pn '%F{blue}'
# 	local columns=$(tput cols)
# 	for ((i=1; i<=columns; i++)); do
# 	   printf "\u2588"
# 	done
# 	print -P '%f'
# }
# 
# function _my_clear() {
# 	echo
# 	rule
# 	zle clear-screen
# }
# zle -N _my_clear
# bindkey '^l' _my_clear
# 
# 
# 
# # Ctrl-O opens zsh at the current location, and on exit, cd into ranger's last location.
# ranger-cd() {
# 	tempfile=$(mktemp)
# 	ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
# 	test -f "$tempfile" &&
# 	if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
# 	cd -- "$(cat "$tempfile")"
# 	fi
# 	rm -f -- "$tempfile"
# 	# hacky way of transferring over previous command and updating the screen
# 	VISUAL=true zle edit-command-line
# }
# zle -N ranger-cd
# bindkey '^o' ranger-cd



# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"
#
#source $ZSH/oh-my-zsh.sh

# vi
bindkey -v

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export EDITOR=vim
export TEXBIN=/usr/texbin
export PLAY_HOME=$HOME/dev/play-2.0.2
export SCALA_HOME=$HOME/dev/scala-2.9.2
export HASKELL_HOME=$HOME/Library/Haskell
export CABALBIN=$HOME/.cabal/bin
export DEPOT_TOOLS=$HOME/dev/depot_tools
export ECLIPSE_WORKSPACE=$HOME/src/java
export MIRAH_BIN=$HOME/dev/mirah-0.0.8.dev/bin
export SCHEME_DIR=$HOME/dev/scheme
export COSH_BIN=$SCHEME_DIR/cosh/bin
export VICARE_LIBRARY_PATH=$SCHEME_DIR/scheme-tools:$SCHEME_DIR/bher:$SCHEME_DIR/scheme-transforms:$SCHEME_DIR/cosh:$SCHEME_DIR/board
export ROY_BIN=$HOME/dev/roy
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_BIN=$JAVA_HOME/bin
export CLOJURESCRIPT_HOME=$HOME/dev/clojurescript
export REDO_HOME=$HOME/dev/redo
export CONSUL_HOME=$HOME/dev/consul
export VAULT_HOME=$HOME/dev/vault
export VIMV_HOME=$HOME/dev/vimv
export KITTY_HOME=$HOME/.local/kitty.app

export NODE_PATH=/usr/local/lib/node_modules
export NODE_MODULES=./node_modules

export LUA_HOME=/opt/local/share/luarocks
export LUA_BIN=$LUA_HOME/bin

# GO
export GOPATH=$HOME/dev/go
export GOOS=linux
export GOARCH=amd64

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$PATH:~/.local/bin/

export PATH=$CABALBIN:$PATH
export PATH=$TEXBIN:$PATH
export PATH=$DEPOT_TOOLS:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$MIRAH_BIN:$PATH
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$HASKELL_HOME/bin:$PATH
export PATH=$COSH_BIN:$PATH
export PATH=$LUA_BIN:$PATH
export PATH=$ROY_BIN:$PATH
export PATH=$PLAY_HOME:$PATH
export PATH=$JAVA_BIN:$PATH
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$CLOJURESCRIPT_HOME/bin:$PATH
export PATH=$REDO_HOME:$PATH
export PATH=$NODE_MODULES/.bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$CONSUL_HOME/:$PATH
export PATH=$VAULT_HOME/:$PATH
export PATH=$VIMV_HOME/:$PATH
export PATH=$KITTY_HOME/bin:$PATH

source $HOME/.profile

# Groovy
source $HOME/.sdkman/bin/sdkman-init.sh

# other
export EDITOR=vim
export PAGER=less

# alias
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias ack="ack --pager='less -R'"
alias glg="git log --graph"
alias csv="column -s, -t <"
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias vnc_once="x11vnc -safer -nopw -once -display :0"
alias wget="wget -c"
alias tmux="tmux -2"
alias page=$PAGER
alias mvne="mvn -Declipse.workspace=$ECLIPSE_WORKSPACE eclipse:add-maven-repo"
alias crontab="VIM_CRONTAB=true crontab"
alias st="git sourcetree"
alias clip="xclip -selection clipboard"
alias tf=terraform
alias kbs='kubectl -n services'
alias kbd='kubectl -n core-dev'
alias kbl='kubectl -n elk'
alias gts='git status'
alias gits='git status'
alias sdkms='sdkms-cli'

eval `dircolors ~/.dircolors`

if [ $commands[chef] ]; then
  eval "$(chef shell-init zsh)"
fi

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

if [ $commands[thefuck] ]; then
  eval $(thefuck --alias)
fi

# Helm autocompletion
source ~/.helmrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
