-- vim: foldmethod=marker foldlevel=0

--- {{{ Ensure packer.nvim is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
--- }}}

return require('packer').startup(function(use)

  -- NeoTree {{{
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      -- {{{ Icons 
      {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        config = function()
          require'nvim-web-devicons'.setup {
            default = true,
            override = {
              dockerfile = { icon = "", name = "Dockerfile", color = "#458ee6" },
              containerfile = { icon = "", name = "Dockerfile", color = "#458ee6" },
              ["docker-compose.yaml"] = { icon = "", name = "Dockerfile", color = "#458ee6" },
              ["docker-compose.yml"] = { icon = "", name = "Dockerfile", color = "#458ee6" },
              [".dockerignore"] = { icon = "", name = "Dockerfile", color = "#458ee6" },
              deb = { icon = "", name = "Deb" },
              lock = { icon = "", name = "Lock" },
              mp3 = { icon = "", name = "Mp3" },
              mp4 = { icon = "", name = "Mp4" },
              out = { icon = "", name = "Out" },
              ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
              ttf = { icon = "", name = "TrueTypeFont" },
              rpm = { icon = "", name = "Rpm" },
              woff = { icon = "", name = "WebOpenFontFormat" },
              woff2 = { icon = "", name = "WebOpenFontFormat2" },
              xz = { icon = "", name = "Xz" },
              zip = { icon = "", name = "Zip" },
            }
          }
        end
      },
      -- }}}
      -- {{{ Nui
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        ops = { use_winbar = true },
        tag = "v1.*",
        config = function()
          require'window-picker'.setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', "quickfix" },
              },
            },
            other_win_hl_color = '#e35e4f',
          })
        end,
      }
      -- }}}
    },

    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint",
        {text = "", texthl = "DiagnosticSignHint"})

      require("neo-tree").setup({
        add_blank_line_at_top = true,
        default_source = "filesystem",
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        use_default_mappings = false,
        source_selector = {
          statusline = true,
        },
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "*",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "",-- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            -- ["S"] = "open_split",
            -- ["s"] = "open_vsplit",
            ["S"] = "split_with_window_picker",
            ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["zc"] = "close_all_nodes",
            ["zo"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["<Leader>f"] = "fuzzy_finder",
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              ".gitkeep",
              ".github",
              ".config",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },

          follow_current_file = false, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",

              ["<F5>"] = "refresh",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["ff"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            }
          }
        }
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end
  }
  -- }}}

  -- {{{ lualine
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
  }
  -- }}}

  -- {{{ telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = function ()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  }

  -- }}}
  
  -- {{{ hop
    use {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function ()
        local hop = require 'hop'
        local directions = require('hop.hint').HintDirection
        hop.setup {
          keys = 'asdfjkletovxqpygbzhciurn',
        }
        vim.keymap.set('n', '<leader>h', function()
          hop.hint_words()
        end, {remap=true})
        vim.keymap.set('', 'f', function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end, {remap=true})
        vim.keymap.set('', 'F', function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end, {remap=true})
        vim.keymap.set('', 't', function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end, {remap=true})
        vim.keymap.set('', 'T', function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end, {remap=true})
      end
    }
  -- }}}

  -- {{{ toggleterm
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup({
        terminal_mapping = "true",
        size = 10,
        shading_factor = 2,
      })
      vim.cmd([[
        nnoremap <leader>t :ToggleTerm<cr>
        tnoremap <C-w>h <C-\><C-n><C-w>h
        tnoremap <C-w>j <C-\><C-n><C-w>j
        tnoremap <C-w>k <C-\><C-n><C-w>k
        tnoremap <C-w>l <C-\><C-n><C-w>l
      ]])
    end
  }
  -- }}}

-- {{{ treesitter 
use {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup({
      ignore_install = { "help" }, -- https://github.com/LazyVim/LazyVim/issues/524
      ensure_installed = { "c", "lua", "vim", "help", "query", "rust", "bash", "json", "yaml", "regex", "javascript", "typescript", "tsx", "cpp", "haskell", "gitcommit" },
      sync_install = true,
      auto_install = true,
      highlight = {
        enable = true,
      },
    })

    local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
    parser_config.gotmpl = {
      install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = {"src/parser.c"}
      },
      filetype = "gotmpl",
      used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
    }
  end
}
-- }}}

  -- {{{ mason lsp
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        }
      })
    end
  }
  use 'williamboman/mason-lspconfig.nvim'
  --- }}}

  -- {{{ lsp
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use {
    'simrat39/rust-tools.nvim',
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true
          },
          debuggables = {
            use_telescope = true
          },
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
          },
        },
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>c", rt.code_action_group.code_action_group, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>m", rt.expand_macro.expand_macro, { buffer = bufnr })
          end,
        }
      })
    end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.tsserver.setup {}
      lspconfig.rust_analyzer.setup {}

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  }
  -- }}}

  -- {{{ cmp
  -- Completion framework:
  use 'hrsh7th/nvim-cmp' 

  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'

  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'                             
  use 'hrsh7th/cmp-path'                              
  use 'hrsh7th/cmp-buffer'                            
  use 'hrsh7th/vim-vsnip'
  
  -- }}}

  -- {{{ copilot
  use { "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function ()
      vim.keymap.set('i', '<M-a>', require("copilot.suggestion").accept, { remap = false })

      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-h>",
            prev = "<M-l>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end
  }
  -- }}}

  -- {{{ vimspector
  use 'puremourning/vimspector'
  -- }}}
  
  -- {{{ harpoon
  use {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup({
        vim.keymap.set('n', '<leader>s', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>'),
        vim.keymap.set('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>'),
        vim.keymap.set('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>'),
        vim.keymap.set('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>'),
        vim.keymap.set('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>'),
        vim.keymap.set('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>'),
        vim.keymap.set('n', '<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>'),
        vim.keymap.set('n', '<leader>6', '<cmd>lua require("harpoon.ui").nav_file(6)<CR>'),
        vim.keymap.set('n', '<leader>7', '<cmd>lua require("harpoon.ui").nav_file(7)<CR>'),
        vim.keymap.set('n', '<leader>8', '<cmd>lua require("harpoon.ui").nav_file(8)<CR>'),
        vim.keymap.set('n', '<leader>9', '<cmd>lua require("harpoon.ui").nav_file(9)<CR>'),
        vim.keymap.set('n', '<leader>0', '<cmd>lua require("harpoon.ui").nav_file(0)<CR>'),
      })
    end
  }
  -- }}}

  use 'hashivim/vim-terraform'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'RRethy/vim-illuminate'

  use 'rktjmp/lush.nvim'
  use '~/.config/nvim/wombat'

  use 'lewis6991/impatient.nvim'
end)
