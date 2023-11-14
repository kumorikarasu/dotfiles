--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

-- Some starting color influneces taken from: https://github.com/catppuccin/nvim
--
-- Base Scheme Colors
local white = hsl("#EEEEEE")
local text = hsl("#CCCCCC")
local subtext0 = hsl('#70758F')
local subtext1 = hsl("#A5ADCB")
local subtext2 = hsl("#B8C0E0")
local subtext3 = hsl("#CAD3F5")
-- local overlay0 = hsl('#70758F')
local overlay0 = hsl("#959DAB")
local overlay1 = hsl("#8087A2")
local overlay2 = hsl("#939AB7")
local surface0 = hsl("#363A4F")
local surface2 = hsl("#5B6078")
local surface1 = hsl("#494D64")

-- local background = hsl("#242424")
-- local base = hsl("#1E2030")
local base = hsl("#14151F")
local baseHighlight = hsl("#24273A")
local baseHighlight2 = hsl("#34374A")
local baseDark = hsl("#181926")

-- Accent Colors
local Crosewater = hsl("#F4DBD6")
local Cflamingo = hsl("#F0C6C6")
local Cpink = hsl("#F5BDE6")
local Cmauve = hsl("#C6A0F6")
local Cred = hsl("#ED8796")
local Cmaroon = hsl("#EE99A0")
local Cpeach = hsl("#F5A97F")
local Cyellow = hsl("#EED49F")
local Cgreen = hsl("#A6DA95")
local Cteal = hsl("#8BD5CA")
local Csky = hsl("#91D7E3")
local Csapphire = hsl("#7DC4E4")
local Cblue = hsl("#8AADF4")
local Clavender = hsl("#B7BDF8")

-- local darkRed = hsl("#E5786D")
local darkRed = hsl("#D75F87")
local darkYellow2 = hsl("#E6C07B")
local yellow = hsl("#CAEB82")
local darkYellow = hsl("#c0bc6c")

-- local green = hsl("#8BCA7F")
local green = hsl("#95E454")

-- Wombat
local wKeyword = hsl("#88b8f6")
local wStatement = hsl("#88b8f6")
local wConstant = hsl("#e5786d")
local wNumber = hsl("#e5786d")
local wPreProc		 = hsl("#e5786d")
local wFunction		 = hsl("#cae982")
local wIdentifier	 = hsl("#cae982")
local wType			 = hsl("#d4d987")
local wSpecial	 = hsl("#eadead")
local wString	 = hsl("#95e454")
local wComment	 = hsl("#9c998e")
local wTodo		 = hsl("#857b6f")


-- Overlay Colors

-- local overlay0 = hsl("#6E738D")

-- Schema 
local number = hsl("#e5786d")
local string = hsl("#95e454")


-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {

    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    Normal       { fg = text, bg = base }, -- Normal text
    -- ColorColumn  { }, -- Columns set with 'colorcolumn'
    -- Conceal      { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- Character under the cursor
    -- lCursor      { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { fg = Normal.fg, bg = "#2d2d2d"}, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine { fg = Normal.fg, bg = "#32322e"},
    Directory    { fg = Normal.fg }, -- Directory names (and other special names in listings)
    DiffAdd { fg = green, bg = Normal.bg, gui = "bold"}, -- Diff mode: Added line |diff.txt|
    DiffAdded { fg = green, bg = Normal.bg, gui = "bold"}, -- Diff mode: Added line |diff.txt|
    DiffChange   { fg = Clavender, bg = Normal.bg }, -- Diff mode: Changed line |diff.txt|
    DiffDelete { fg = Cred, bg = baseHighlight, gui = ""}, -- Diff mode: Deleted line |diff.txt|
    DiffRemoved { fg = Cred, gui = ""}, -- Diff mode: Deleted line |diff.txt|
    DiffIndexLine { fg = subtext1 },
    DiffFile { fg = subtext0 },
    DiffText { fg = subtext3, bg = baseHighlight, gui = ""}, -- Diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer  { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- Cursor in a focused terminal
    -- TermCursorNC { }, -- Cursor in an unfocused terminal
    ErrorMsg     { bg = darkRed, fg = baseDark} , -- Error messages on the command line
    VertSplit { fg = baseHighlight, bg = baseHighlight, gui = "none" }, -- Column separating vertically split windows
    Folded { fg = subtext3, bg = baseHighlight, gui = "none" }, -- Line used for closed folds
    FoldedColumn { fg = subtext3, bg = baseHighlight, gui = "none" }, -- 'foldcolumn'
    SignColumn { fg = subtext0, bg = baseDark, gui = "bold" }, -- Column where |signs| are displayed
    -- IncSearch    { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    LineNr { fg = subtext0, bg = baseDark, gui = "none"}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { fg = yellow }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen   { fg = yellow, bg = "#857b6f", gui = "bold" }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { fg = Cgreen }, -- |more-prompt|
    NonText { fg = overlay0, bg = base, gui = "none"}, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    -- NormalFloat  { }, -- Normal text in floating windows.
    -- NormalNC     { }, -- normal text in non-current windows
    Pmenu { fg = subtext0, bg = baseHighlight, gui = ""}, -- Popup menu: Normal item.
    PmenuSel { fg = subtext2, bg = baseHighlight, gui = ""}, -- Popup menu: Selected item.
    -- PmenuSbar    { }, -- Popup menu: Scrollbar.
    -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
    Question     { fg  = Cgreen }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    -- Search       { }, 
    Search { fg = "#222222", bg = "#b5a3ff", gui = ""}, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    SpecialKey { fg = "#6c6c6c", bg = "#202020", gui = "none"}, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine { fg = subtext2, bg = baseHighlight, gui = "italic"}, -- Status line of current window
    StatusLineNC { fg = subtext0, bg = base, gui = "none"}, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { fg = subtext0, bg = base }, -- Tab pages line, not active tab page label
    TabLineFill  { fg = subtext0, bg = base }, -- Tab pages line, where there are no labels
    TabLineSel   { fg = subtext3, bg = baseHighlight, gui = "bold" }, -- Tab pages line, active tab page label
    -- Title        { }, 
    Title { fg = text, bg = Normal.bg, gui = "bold"}, -- Titles for output from ":set all", ":autocmd" etc.
    Visual { fg = yellow, bg = "#597418", gui = "none"}, -- Visual mode selection
    VisualNOS { fg = yellow, bg = "#597418", gui = "none"}, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg { fg = Cred, bg = Normal.bg, gui = ""}, -- Warning messages
    Whitespace   { fg = subtext0, bg = base }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- WildMenu     { }, -- Current match in 'wildmenu' completion

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment { fg = subtext0, bg = Normal.bg, gui = "italic"}, -- Any comment

    Constant { fg = Cpink, bg = Normal.bg, gui = "none"}, -- (*) Any constant
    String { fg = green, bg = Normal.bg, gui = "italic"}, --   A string constant: "this is a string"
    -- Character      { }, --   A character constant: 'c', '\n'
    Number { fg = Cpink, bg = Normal.bg, gui = "none"}, --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Identifier { fg = yellow, bg = Normal.bg, gui = "none"}, -- (*) Any variable name
    Function { fg = Cyellow, bg = Normal.bg, gui = "none"}, --   Function name (also: methods for classes)

    Statement         { fg = Cblue, bg = base, gui = "none"}, -- (*) Any statement
    -- Conditional    { }, --   if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --   case, default, etc.
    -- Operator       { }, --   "sizeof", "+", "*", etc.
    Keyword           { fg = Cblue, bg = Normal.bg, gui = "none"}, --   any other keyword
    -- Exception      { }, --   try, catch, throw

    PreProc           { fg = Cred, bg = Normal.bg, gui = "none"}, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type              { fg = yellow, bg = Normal.bg, gui = "none"}, -- (*) int, long, char, etc.
    -- StorageClass   { }, --   static, register, volatile, etc.
    -- Structure      { }, --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special           { fg = Cyellow, bg = Normal.bg, gui = "none"}, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    -- Delimiter      { }, --   Character that needs attention
    -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    -- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error             { bg = darkRed, fg = baseDark} , -- Error messages on the command line
    Todo { fg = subtext0, bg = Normal.bg, gui = "italic"}, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    --
    
    -- Neo Tree Highlights
    
    NeoTreeBufferNumber        { fg = subtext1 }, -- The buffer number shown in the buffers source.
    NeoTreeCursorLine          { bg = baseHighlight }, -- |hl-CursorLine| override in Neo-tree window.
    NeoTreeDimText             { fg = subtext0 }, -- Greyed out text used in various places.
    NeoTreeDirectoryIcon       { fg = subtext3 }, -- Directory icon.
    NeoTreeDirectoryName       { fg = subtext3 }, -- Directory name.
    NeoTreeDotfile             { fg = subtext0 }, -- Used for icons and names when dotfiles are filtered.
    -- NeoTreeFileIcon            { }, -- File icon, when not overridden by devicons.
    -- NeoTreeFileName            { fg = Normal.fg }, -- File name, when not overwritten by another status.
    -- NeoTreeFileNameOpened      { fg = Normal.fg }, -- File name when the file is open. Not used yet.
    NeoTreeFilterTerm          { fg = subtext1 }, -- The filter term, as displayed in the root node.
    -- NeoTreeFloatBorder         { }, -- The border for pop-up windows.
    NeoTreeFloatTitle          { fg = subtext3 }, -- Used for the title text of pop-ups when the border-style is set to another style than "NC". This is derived from NeoTreeFloatBorder.
    -- NeoTreeTitleBar            { }, -- Used for the title bar of pop-ups, when the border-style is set to "NC". This is derived from NeoTreeFloatBorder.
    NeoTreeGitAdded            { fg = Cgreen }, -- File name when the git status is added.
    NeoTreeGitConflict         { fg = Cblue }, -- File name when the git status is conflict.
    NeoTreeGitDeleted          { fg = Cred }, -- File name when the git status is deleted.
    NeoTreeGitIgnored          { fg = subtext0 }, -- File name when the git status is ignored.
    NeoTreeGitModified         { fg = Cmauve }, -- File name when the git status is modified.
    -- NeoTreeGitUnstaged         { }, -- Used for git unstaged symbol.
    NeoTreeGitUntracked        { fg = Cblue }, -- File name when the git status is untracked.
    NeoTreeGitStaged           { fg = Cgreen }, -- Used for git staged symbol.
    NeoTreeHiddenByName        { fg = subtext0 }, -- Used for icons and names when `hide_by_name` is used.
    -- NeoTreeIndentMarker        { }, -- The style of indentation markers (guides). By default, the "Normal" highlight is used.
    -- NeoTreeExpander            { }, -- Used for collapsed/expanded icons.
    NeoTreeNormal              { fg = subtext2 }, -- |hl-Normal| override in Neo-tree window.
    -- NeoTreeNormalNC            { }, -- |hl-NormalNC| override in Neo-tree window.
    -- NeoTreeSignColumn          { }, -- |hl-SignColumn| override in Neo-tree window.
    -- NeoTreeStatusLine          { }, -- |hl-StatusLine| override in Neo-tree window.
    -- NeoTreeStatusLineNC        { }, -- |hl-StatusLineNC| override in Neo-tree window.
    -- NeoTreeVertSplit           { }, -- |hl-VertSplit| override in Neo-tree window.
    -- NeoTreeWinSeparator        { }, -- |hl-WinSeparator| override in Neo-tree window.
    -- NeoTreeEndOfBuffer         { }, -- |hl-EndOfBuffer| override in Neo-tree window.
    -- NeoTreeRootName            { }, -- The name of the root node.
    -- NeoTreeSymbolicLinkTarget  { }, -- Symbolic link target.
    NeoTreeWindowsHidden       { fg = subtext1 }, -- Used for icons and names that are hidden on Windows.


    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { fg = text }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
       sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    sym"@parameter"         { fg = Cmaroon }, -- Identifier
    sym"@method"            { fg = yellow }, -- Function
    sym"@field"             { fg = Cyellow }, -- Identifier
    sym"@property"          { fg = Cyellow }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    sym"@variable"          { fg = text }, -- Identifier
    sym"@type"              { fg = Cmauve }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
