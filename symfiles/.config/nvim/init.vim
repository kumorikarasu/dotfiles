set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

lua require('plugins')
source ~/.vimrc

"Autoreload plugins.lua
 augroup packer_user_config
   autocmd!
   autocmd BufWritePost plugins.lua source ~/.config/nvim/lua/plugins.lua | PackerCompile
 augroup end
