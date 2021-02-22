''
" vim:ft=lua
lua << EOF
local cmd = vim.cmd   -- to execute vim commands e.g. cmd('pwd')
local fn = vim.fn     -- to call vim functions e.g. fn.bufnr()
local g = vim.g       -- a table to access global variables

-- ensure packager is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  cmd 'packadd packer.nvim'
end

cmd 'packadd packer.nvim'
require'packer'.startup(function()
  use {'wbthomason/packer.nvim', opt=true} -- package manager

  ---- Colors
  use 'norcalli/nvim-colorizer.lua' -- renders colors inline
  use 'arcticicestudio/nord-vim'    -- colorscheme

  
  -- LSP
  use 'neovim/nvim-lspconfig'  -- sane defaults for the built-in LSP
  use 'ojroques/nvim-lspfuzzy' -- FZF integration
  use 'shougo/deoplete-lsp'    -- Deoplete integration

  -- FZF
  use {'junegunn/fzf', cmd = 'call fzf#install()'}
  use 'junegunn/fzf.vim'
  use 'vijaymarupudi/nvim-fzf'
  use 'vijaymarupudi/nvim-fzf-commands'

  -- Misc
  use {'shougo/deoplete.nvim', cmd = 'UpdateRemotePlugins'}                      -- completions
  use {'godlygeek/tabular', opt = true, cmd = {'Tabular'}}                       -- alignment
  use 'tpope/vim-commentary'                                                     -- manipulate comments
  use 'tpope/vim-surround'                                                       -- manipulate parenthesizing characters
  use {'tpope/vim-fugitive', opt = true, cmd = {'Gstatus', 'Gcommit', 'Gwrite'}} -- git client
  use 'nvim-treesitter/nvim-treesitter'                                          -- fast syntax highlighting
end)

--TODO: section comments plugin?

-- Unix Editor variables
if fn.executable('nvr') then
  vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  vim.env.EDITOR = vim.env.VISUAL
end

---------------------------BASIC OPTIONS----------------------------------
--[[
 vim has different scopes for the basic options. Setting an option
 correctly will require setting it in the global scope as well as either
 buffer or window scope (otherwise it would only be set for the first
 buffer/window).

 The :h <opt> will tell you whether an options is buffer or window local,
 or global
--]]
local scopes = {
  g = vim.o,  -- global scope
  b = vim.bo, -- buffer scope
  w = vim.wo  -- window scope
}

--[[
helper function for setting options
if value is not passed, it is set to true
--]]
local function opt(scope, key, value)
  if value == nil then value = true end
  scopes[scope][key] = value
  if scope ~= 'g' then scopes['g'][key] = value end
end


-- line numbers
opt('w', 'number')         -- show line numbers
opt('w', 'relativenumber') -- show relative line numbers. Set after number so the current line is always numbered

-- tab settings
opt('b', 'expandtab')      -- inserts spaces when you press tab
opt('b', 'shiftwidth', 2)  -- number of spaces to use for each step of autoindent
opt('b', 'softtabstop', 2) -- number of spaces Tab counts for while editing
opt('g', 'shiftround')     -- always round indent to a multiple of shift width

-- search
opt('g', 'ignorecase') -- Ignore case in search
opt('g', 'smartcase')  -- Override ignorecase if search pattern has uppercase
opt('g', 'splitbelow') -- Always split below
opt('g', 'splitright') -- Always split to the right

opt('g', 'hidden')  -- Required for operations modifying multiple buffers like rename.

-- UI
opt('w', 'signcolumn', 'yes')                                         -- always show the gutter
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}' -- highlight yanked area. On visual stops it from erring when we delete

-- stop vim's annoying habit of moving cursor one column left when leaving insert
cmd [[let CursorColumnI = 0]] -- the cursor column position in INSERT
cmd [[autocmd InsertEnter * let CursorColumnI = col('.')]]
cmd [[autocmd CursorMovedI * let CursorColumnI = col('.')]]
cmd [[autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif]]

opt('g', 'scrolloff', 3)      -- minimum number of screen lines to keep below and above the cursor
opt('g', 'joinspaces', false) -- don't add additional space when joining after period
opt('w', 'wrap', false)       -- disable line wrap

-- TODO: make this togglable off
-- autosave
function auto_save()
  current_buffer = vim.fn.bufnr()
  if vim.fn.getbufvar(current_buffer, "&modified") then
    cmd "silent! w"
  end
end

autosave_events = {
  'InsertLeave',
  'TextChanged',
}
for i = 1, #autosave_events do
  event = autosave_events[i]
  cmd(string.format('autocmd %s * lua auto_save()', event))
end


opt('g', 'clipboard', 'unnamedplus') -- automatically put additions to unnamed reg in clipboard ('+' reg)
opt('g', 'inccommand', 'split')      -- preview searches in a split
-----------------------------COLORSCHEME----------------------------------
cmd 'colorscheme nord'
opt('g', 'termguicolors') -- enable 24 bit RGB color in TUI

require'colorizer'.setup()


---------------------------------KEY MAPPINGS----------------------------------
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  -- tbl_extend merges two tables. 'force' means overwrite with keys from the latter
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = ' ' -- make space bar leader key
-- terminal
map('t', '<esc>', [[<C-\><C-n>]]) -- esc to enter normal mode in terminal
map('t', '<C-v><Esc>', '<esc>') -- <C-v> + esc to enter literal esc
map('t', '<C-h>', [[<C-\><C-n><C-w>h]]) -- C-h to move to left window
map('t', '<C-j>', [[<C-\><C-n><C-w>j]]) -- C-j to move to window below
map('t', '<C-k>', [[<C-\><C-n><C-w>k]]) -- C-k to move to window above
map('t', '<C-l>', [[<C-\><C-n><C-w>l]]) -- C-l to move to right window
cmd 'autocmd TermOpen * startinsert'

-- navigation
map('n', '<C-h>', '<C-w>h') -- C-h to move to left window
map('n', '<C-j>', '<C-w>j') -- C-j to move to window below
map('n', '<C-k>', '<C-w>k') -- C-k to move to window above
map('n', '<C-l>', '<C-w>l') -- C-l to move to right window
map('n', '[b', [[<cmd>bprevious<cr>]]) -- previous buffer
map('n', ']b', [[<cmd>bprevious<cr>]]) -- next buffer

-- Fuzzy finder

map('n', '<C-p>', [[<cmd>lua require('fzf-commands').files()<cr>]])
map('n', '<esc>', [[<esc><cmd>nohlsearch<cr>]]) -- escape to get rid of search highlight
map('n', '<leader><leader>', [[<cmd>Buffers<cr>]])

-- config
map('n', '<leader>ev', [[<cmd>e $MYVIMRC<cr>]])
map('n', '<leader>sv', [[<cmd>luafile $MYVIMRC<cr>]])

-- make arrow keys do something useful
map('n', '<Right>', [[<cmd>vertical resize +2<CR>]])
map('n', '<Up>', [[<cmd>resize +2<CR>]])
map('n', '<Left>', [[<cmd>vertical resize -2<CR>]])
map('n', '<Down>', [[<cmd>resize -2<CR>]])
---------------------------------LSP-----------------------------------------
-- deoplete
g['deoplete#enable_at_startup'] = 1


local nvim_lsp = require'lspconfig'

require 'lspfuzzy'.setup {}
-- TODO: lspfuzzy can be operated with :LspDiagnostics<bufnr> and :LspDiagnosticsAll

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    require('lspconfig').util.nvim_multiline_command [[
      :hi LspReferenceRead cterm=bold ctermbg=red guibg=#252525
      :hi LspReferenceText cterm=bold ctermbg=red guibg=#252525
      :hi LspReferenceWrite cterm=bold ctermbg=red guibg=#252525
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end


--------------------------TREESITTER---------------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', -- ensure all maintained parsers are installed
  highlight = {enable = true}
}
EOF
''
