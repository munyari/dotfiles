" basic settings {{{
" line numbers
set number
set relativenumber

" stop vim's annoying habit of moving cursor one left when leaving insert
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" " make space bar leader key
let mapleader="\<Space>"

" " tab settings
set expandtab
set shiftwidth=2
set softtabstop=2
" always round indent to a multiple of shift width
set shiftround

" "" Show the 80th column
" if exists('+colorcolumn')
"   set colorcolumn=80
"   highlight ColorColumn ctermbg=9
" endif

" minimal number of screen lines to keep below and above the cursor
set scrolloff=3
" always show the gutter
set signcolumn=yes

" creates undofile, allows undo even after closing
if has('persistent_undo')
  set undolevels=5000
  set undofile
endif

" always split below/right
set splitbelow
set splitright

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('sift')
  set grepprg=sift\ -nMs\ --no-color\ --binary-skip\ --column\ --no-group\ --git\ --follow
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" " lazyredraw can make macros run faster
" set lazyredraw          " redraw only when we need to.


" " Automatically enter insert when entering a terminal window
" autocmd BufEnter * if &buftype == "terminal" | startinsert | endif
" " autocmd BufEnter * if &buftype == "terminal" | setlocal nonumber | endif
" }}}

" plugins and mappings {{{
" credit to Chris Toomey
function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.config/nvim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

call s:SourceConfigFilesIn('mappings')

" autoinstall vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" status bar
Plug 'bling/vim-airline'

" asynchronus autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <unique><silent><c-p> :Files<cr>
nnoremap <unique><silent><leader>bc :BCommits<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

Plug 'kassio/neoterm'
nnoremap <unique><leader>t :TREPLSendLine<cr>
vnoremap <unique><leader>t :TREPLSendSelection<cr>

let g:neoterm_position = "vertical"
let g:neoterm_autoinsert = 1

Plug 'whatyouhide/vim-gotham'

" async linting and fixing support
Plug 'w0rp/ale'
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'python':     ['yapf'],
      \ }

let g:ale_pattern_options = {
      \ '\v\.(j|t)sx?': {
      \     'ale_fix_on_save': 1,
      \   },
      \ }

let g:ale_lint_on_save = 0
let g:ale_max_signs = 50

" Does what it says on the tin
Plug '907th/vim-auto-save'
nnoremap <leader>as :AutoSaveToggle<CR>
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1 " disable the AutoSave notification

Plug 'tpope/vim-commentary'

" Git wrapper
Plug 'tpope/vim-fugitive'

nnoremap <silent><leader>gbl      :Gblame<cr>
nnoremap <silent><leader>gbr      :Gbrowse<cr>
nnoremap <silent><leader>gc       :Gcommit -v<cr>
nnoremap <silent><leader>gd       :Gdiff<cr>
nnoremap <silent><leader>gg       :Ggrep<cr>
nnoremap <silent><leader>gm       :Gmerge<cr>
nnoremap <silent><leader>gpl      :Gpull<cr>
nnoremap <silent><leader>gps      :Gpush<cr>
nnoremap <silent><leader>grd      :Gread<cr>
nnoremap <silent><leader>grm      :Gremove<cr>
nnoremap <silent><leader>gs       :Gstatus<cr>
nnoremap <silent><leader>gw       :Gwrite<cr>

Plug 'airblade/vim-gitgutter'

let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = '∎'
let g:gitgutter_sign_removed = '⨯'

" rainbow parentheses
Plug 'junegunn/rainbow_parentheses.vim'
au VimEnter * RainbowParentheses

Plug 'tpope/vim-surround'

Plug 'ntpeters/vim-better-whitespace'

" Vim better whitespace mappings
nnoremap <silent> <Leader>w :StripWhitespace<CR>
nnoremap <silent> <Leader>W :ToggleWhitespace<CR>

" vim tmux integration
Plug 'christoomey/vim-tmux-navigator'

" vim language pack
Plug 'sheerun/vim-polyglot'

Plug 'lervag/vimtex'

Plug 'mhartington/nvim-typescript', { 'do': ':UpdateRemotePlugins' }
autocmd FileType typescript nnoremap <unique>gd :TSDef<cr>
autocmd FileType typescript nnoremap <unique><F2> :TSRename<cr>
autocmd FileType typescript nnoremap <unique>ti :TSImport<cr>
" display type info on hover
let g:nvim_typescript#type_info_on_hold = 1

Plug 'Shuogo/echodoc.vim'
call plug#end()
" }}}

" color settings {{{
colorscheme gotham
set termguicolors
" }}}

" " folding settings {{{
" set foldnestmax=10
" set nofoldenable
" set foldlevel=1
" " }}}

" " Filetype settings {{{
" " Vimscript file settings --------------------{{{
" augroup filetype_vim
"   autocmd!
"   autocmd FileType vim setlocal foldcolumn=1
"   autocmd FileType vim setlocal foldmethod=marker
"   autocmd FileType vim setlocal foldenable
" augroup END
" " }}}

" " Rust file settings --------------------{{{
" augroup filetype_rust
"   autocmd!
"   autocmd FileType rust setlocal tags=./rusty-tags.vi;/
"   autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"
" augroup END
" " }}}

" " These mappings are more for inspiration than anything useful
" " Markdown file settings -------------------------------------------------{{{
" augroup filetype_md
"   autocmd!
"   autocmd FileType markdown   onoremap ih :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rkvg_"<cr>
"   autocmd FileType markdown   onoremap ah :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rg_vk0"<cr>
" augroup END
" " }}}
" " " }}}

" " Other filetype specific settings {{{
" let g:tex_conceal = ""

" let g:markdown_fenced_languages = ['ruby', 'bash=sh', 'python']
" let g:markdown_syntax_conceal = 0
" " }}}

" " Have Vim jump to the last position when
" " " reopening a file
" if has("autocmd")
"   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"         \| exe "normal! g'\"" | endif
" endif


" " source init.vim when it is changed
" autocmd! bufwritepost init.vim source %

" " Automatically open, but do not go to (if there are errors) the quickfix /
" " location list window, or close it when is has become empty.
" "
" " Note: Must allow nesting of autocmds to enable any customizations for quickfix
" " buffers.
" " Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" " (but not if it's already open). However, as part of the autocmd, this doesn't
" " seem to happen.
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow

" " list format  {{{
" " Set up formatlistpat to handle various denotions of indention/ hierarchy
" set formatlistpat=
" " Leading whitespace
" set formatlistpat+=^\\s*
" " Start class
" set formatlistpat+=[
" " Optionially match opening punctuation
" set formatlistpat+=\\[({]\\?
" " Start group
" set formatlistpat+=\\(
" " A number
" set formatlistpat+=[0-9]\\+
" " Roman numerals
" set formatlistpat+=\\\|[iIvVxXlLcCdDmM]\\+
" " A single letter
" set formatlistpat+=\\\|[a-zA-Z]
" " End group
" set formatlistpat+=\\)
" " Closing punctuation
" set formatlistpat+=[\\]:.)}
" " End class
" set formatlistpat+=]
" " One or more spaces
" set formatlistpat+=\\s\\+
" " Or ASCII style bullet points
" set formatlistpat+=\\\|^\\s*[-+o*]\\s\\+
" " apply formatting to lists
" set formatoptions+=n
" " }}}

" nvim's new inccommand feature to see live previews
if has('nvim')
  set inccommand=nosplit
endif

" automatically put additions to unnamed reg in clipboard ('+' reg)
set clipboard=unnamedplus

" ignore files matching this pattern
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,node_modules

" completion options for wildmenu
set wildmode=longest,list,full

set completeopt+=longest,menuone

" write a file with sudo
command Sudo write !sudo tee % > /dev/null

" Make vim colors work!
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Make transparency work too!
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

