-- vim: foldmethod=marker foldlevel=0 commentstring=--%s
--

require('plugins')
require('evil_lualine')

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- {{{ Vimscript Configuration
vim.cmd([[
  syntax on
  set expandtab
  set ts=2
  set tabstop=2
  set shiftwidth=2
  set relativenumber
  set t_Co=256
  set clipboard=unnamed
  set nowrap
  set signcolumn=yes
  let mapleader = ' '

  if (has("termguicolors"))
   set termguicolors
  endif

  colorscheme wombat

  " Swap * and #
  nnoremap * #
  nnoremap # *


  " Tab Page Config
  map <S-l> :tabn<CR>
  map <S-h> :tabp<CR>

  nmap <Leader>cp :Copilot panel<CR>
  nmap <Leader>co :Copilot open<CR>

  nmap <Leader><F1> :Neotree toggle<CR>

  " Fold Config
  hi Folded ctermbg=234 ctermfg=171
  au BufWinEnter * silent! loadview
  autocmd FileType  ls set foldmethod=marker|set commentstring=#%s
  autocmd FileType  sh set foldmethod=marker|set commentstring=#%s
  autocmd FileType vim set foldmethod=marker|set commentstring="%s

  let g:vimspector_enable_mappings = 'HUMAN'

  " Autoreload plugins.lua
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source ~/.config/nvim/lua/plugins.lua | PackerCompile
  augroup end

  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
-- }}}

-- {{{ Completion Plugin Setup (nvim-cmp)
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
      { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
      { name = 'path' },                              -- file paths
      { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
      { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
      { name = 'buffer', keyword_length = 2 },        -- source current buffer
      { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
      { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
--- }}}
