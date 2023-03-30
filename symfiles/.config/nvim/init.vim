set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
let &packpath = &runtimepath

lua require('plugins')
lua require('init')

syntax on
set expandtab
set ts=2
set tabstop=2
set shiftwidth=2
set relativenumber
set t_Co=256
set clipboard=unnamed
set nowrap

if (has("termguicolors"))
 set termguicolors
endif

colorscheme wombat

" Tab Page Config
map <S-l> :tabn<CR>
map <S-h> :tabp<CR>

nmap <Leader>cp :Copilot panel<CR>
nmap <Leader>co :Copilot open<CR>

" Fold Config
hi Folded ctermbg=234 ctermfg=171
au BufWinEnter * silent! loadview
autocmd FileType  ls set foldmethod=marker|set commentstring=#%s
autocmd FileType vim set foldmethod=marker|set commentstring="%s
autocmd FileType  sh set foldmethod=marker|set commentstring=#%s

let g:vimspector_enable_mappings = 'HUMAN'

" Autoreload plugins.lua
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source ~/.config/nvim/lua/plugins.lua | PackerCompile
augroup end
