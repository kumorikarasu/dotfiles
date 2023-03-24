
set nocp
set nocompatible

call pathogen#infect()

syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Settings {{{
set mouse=a
set expandtab
set ts=2
set tabstop=2
set shiftwidth=2
set ai
set hlsearch
set hidden
set nowrap
set ruler
set colorcolumn=95
set relativenumber
set dir=~/.vim/tmp
exe 'set t_kB=' . nr2char(27) . '[Z'
set vb t_vb=

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" gvim fonts
if has("gui_running")
  colorscheme wombat
else
 set t_Co=256
 set clipboard=unnamed
 colorscheme wombat256
"  set termguicolors
"  colorscheme wombattrue
endif

" }}}

" Mappings {{{

let mapleader = "\\"
let maplocalleader = "\\"

" digraphs


" lambda λ
imap <C-j> <C-k>l*

" right arrow →
imap <C-l> <C-k>->

" left arrow ←
imap <C-g> <C-k><-

" left arrow ←
imap <C-o> <C-k>Ob

nnoremap <F10> :set invpaste paste?<CR>
imap <F10> <C-O><F10>
set pastetoggle=<F10>
nmap <F9> :TagbarToggle<CR>
map <F8> :make tags<CR>
map <F12> :TlistToggle<CR>
map <F11> :Neotree toggle<CR>
map <F3> "yyiw:grep -r <C-R>y *<CR>
"map <F3> :silent make \| redraw! \| cc<CR>
map <F4> :call RCmd("make")<CR>
map <F6> :!make deploy<CR>
map <F5> :make<CR>

nnoremap * #
nnoremap # *
map <C-S-j> kddpkJi<CR>
map <Leader>] :tnext<CR>
map <Leader>[ :tprev<CR>
vmap <Leader>c :!xclip -selection clipboard<CR>
map <S-l> :tabn<CR>
map <S-h> :tabp<CR>
map <Leader>n :tabnew<CR>
map <C-m> :cnext<CR>
map <C-n> :cprevious<CR>
map <Leader>a :%s/\ at\ /\r\ at\ /g<CR>

map <Leader>y :Lodgeit<CR>
nmap <Leader>r ma:%s/\s\+$//g<CR>`a
nmap <Leader>rr :call ReloadSnippets(&filetype)<CR>
map <Leader><Leader>x :silent %!xmllint --encode UTF-8 --format -<CR>
vmap <Leader><Leader>j !jade -p % -o "{ prettyprint: true }"<CR>

map <Leader>cr :!newclay % && ./main<CR>

cmap w!! %!sudo tee > /dev/null %
cmap c! call RCmd("")<Left><Left>
cmap g! call GRCmd("")<Left><Left>

cmap wg !git commit % -m ""<Left>
cmap wag !git commit -am ""<Left>

nnoremap x "_x
nnoremap X "_X

nmap <Leader>== :Tabularize /=<CR>
vmap <Leader>== :Tabularize /=<CR>
nmap <Leader>=, :Tabularize /,<CR>
vmap <Leader>=, :Tabularize /,<CR>
nmap <Leader>=<Bar> :Tabularize /<Bar><CR>
vmap <Leader>=<Bar> :Tabularize /<Bar><CR>
nmap <Leader>=:: :Tabularize /::<CR>
vmap <Leader>=:: :Tabularize /::<CR>
nmap <Leader>=: :Tabularize /:\zs<CR>
vmap <Leader>=: :Tabularize /:\zs<CR>

nmap <Leader>cp :Copilot panel<CR>
nmap <Leader>co :Copilot open<CR>

com! FormatJSON %!python -m json.tool

map <Leader>t :ToggleTerm<CR>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l


" Coc Configuration {{{
set cmdheight=2
set shortmess+=c
set signcolumn=number

highlight CocFloating ctermfg=Grey ctermbg=238 guibg=LightYellow

" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-@> coc#refresh()
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
let g:copilot_no_tab_map = v:true
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
      \ CheckBackSpace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif



" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}


" Debug {{{
nmap <silent> <Leader><F5> <Plug>VimspectorContinue
nmap <silent> <Leader><F3>	<Plug>VimspectorStop
nmap <silent> <Leader><F4>	<Plug>VimspectorRestart
nmap <silent> <Leader><F6>	<Plug>VimspectorPause
nmap <silent> <Leader><F9>	<Plug>VimspectorToggleBreakpoint
" nmap <silent> <Leader><>F9	<Plug>VimspectorToggleConditionalBreakpoint
" nmap <silent> <Leader><F8>	<Plug>VimspectorAddFunctionBreakpoint
nmap <silent> <Leader><F8>	<Plug>VimspectorRunToCursor
nmap <silent> <Leader><F10>	<Plug>VimspectorStepOver
nmap <silent> <Leader><F11>	<Plug>VimspectorStepInto
nmap <silent> <Leader><F12>	<Plug>VimspectorStepOut
nmap <silent> <Leader><F1>	:VimspectorReset<CR>
 
" for normal mode - the word under the cursor
nmap <Leader>vi <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>vi <Plug>VimspectorBalloonEval
 
" }}}

" Plugin Options {{{

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let g:clj_highlight_builtins=1 " Highlight Clojure's builtins
let g:clj_paren_rainbow=1      " Rainbow parentheses'!

let g:clang_complete_copen = 1
let g:clang_snippets = 1
let g:clang_use_library = 1

set wildignore+=*/.git/*,*/.hg/*,/.svn/*,*/.redo/*
let g:ctrlp_custom_ignore = 'node_modules$'

let g:syntastic_javascript_checkers = 'jshint'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_exec = '/opt/chefdk/bin/cookstyle'
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']

let g:ctrlp_extensions = ['tag']
let g:EasyMotion_leader_key = '<Leader>'

let g:ctrlp_switch_buffer=0


set noshowmode
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

call lightline#coc#register()

"let g:ctrlp_prompt_mappings = {
    "\ 'PrtBS()': ['<c-h>'],
    "\ 'PrtCurLeft()': ['<left>'],
    "\ }

" }}}

" Autocommands {{{
au BufRead,BufNewFile *.c,*.cpp,*.h set cindent
au BufRead,BufNewFile *.c,*.cpp,*.h set cino=(0
au BufRead,BufNewFile *.clay set syn=clay
au BufRead,BufNewFile *.clj set syntax=clojure
au BufRead,BufNewFile *.coffee set ft=coffee
au BufRead,BufNewFile *.do set syn=sh
au BufRead,BufNewFile *.galaxy set syn=galaxy
au BufRead,BufNewFile *.glsl set syntax=glsl
au BufRead,BufNewFile *.gnu set syn=gnuplot
au BufRead,BufNewFile *.go set syntax=go
au BufRead,BufNewFile *.gotmpl set syntax=gotmpl
au BufRead,BufNewFile *.groovy set syn=groovy
au BufRead,BufNewFile *.hx set syn=haxe
au BufRead,BufNewFile *.java set sw=4
au BufRead,BufNewFile *.java set ts=4
au BufRead,BufNewFile *.json set ft=json
au BufRead,BufNewFile *.less set syn=less
au BufRead,BufNewFile *.ll set syn=llvm
au BufRead,BufNewFile *.ls set ft=ls
au BufRead,BufNewFile *.ly set syn=bn
au BufRead,BufNewFile *.material set syn=ogre3d_material
au BufRead,BufNewFile *.md,*.mkd,*.markdown set ft=pdc
au BufRead,BufNewFile *.mirah set syn=mirah
au BufRead,BufNewFile *.moon set syn=moon
au BufRead,BufNewFile *.rkt set syn=racket
au BufRead,BufNewFile *.rs set syn=rust
au BufRead,BufNewFile *.scala set syn=scala
au BufRead,BufNewFile *.swig set syn=swig
au BufRead,BufNewFile *.td set syn=tablegen
au BufRead,BufNewFile *.thrift set syn=thrift
au BufRead,BufNewFile *.x set syn=alex
au BufRead,BufNewFile *.xsl let g:xml_syntax_folding = 1
au BufRead,BufNewFile *.xsl set foldmethod=syntax
au BufRead,BufNewFile *.xsl set syn=xml
au BufRead,BufNewFile *.y set syn=bnf
au BufRead,BufNewFile *.y.pp set syn=happy
au BufRead,BufNewFile *.yaml set syn=yaml
au BufRead,BufNewFile *.yml set syn=yaml
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile wscript set syn=python
au BufRead,BufNewFile *.dockerfile set syn=dockerfile
au BufRead,BufNewFile *.ts set syn=typescript
au BufRead,BufNewFile *.hcl set syn=hcl
au BufRead,BufNewFile *.tf set syn=terraform
" }}}

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

function! PlaySound()
" uncomment to annoy coworkers
" silent! exec '!afplay ~/audio/typewriter_keystroke.wav &'
endfunction
autocmd CursorMovedI * call PlaySound()

"Fold Config
hi Folded ctermbg=234 ctermfg=171
au BufWinEnter * silent! loadview
autocmd FileType coffee set foldmethod=marker|set commentstring=#%s
autocmd FileType ls set foldmethod=marker|set commentstring=#%s
autocmd FileType vim set foldmethod=marker|set commentstring="%s
autocmd FileType rb set foldmethod=marker|set commentstring=#%s
autocmd FileType sh set foldmethod=marker|set commentstring=#%s

set exrc
set secure

"set makeprg=livescript\ -c\ %

"set errorformat=%EFailed\ at:\ %f,
               "\%ECan't\ find:\ %f,
               "\%CSyntaxError:\ %m\ on\ line\ %l,
               "\%EError:\ Parse\ error\ on\ line\ %l:\ %m,
               "\%C,%C\ %.%#

function! RCmd(cmd)
  :silent! exe '!echo "cd ' . getcwd() . ' && ' . a:cmd . '" > /tmp/cmds'
  :redraw!
endfunction

function! GRCmd(cmd)
  :call RCmd("git --no-pager " . a:cmd)
endfunction

"let g:vimspector_enable_mappings = 'HUMAN'
packadd! vimspector

"Autoreload .vimrc
"au! BufWritePost .vimrc source %

"Autoreload plugins.lua
 augroup packer_user_config
   autocmd!
   autocmd BufWritePost plugins.lua source ~/.config/nvim/lua/plugins.lua | PackerCompile
 augroup end
