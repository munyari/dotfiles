" basic settings {{{
" line numbers
set number
set relativenumber

" stop vim's annoying habit of moving cursor one left when leaving insert
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" make space bar leader key
let mapleader="\<Space>"

" " tab settings
set expandtab
set shiftwidth=2
set softtabstop=2
" always round indent to a multiple of shift width
set shiftround

" Show the 100th and 120th columns
if exists('+colorcolumn')
  set colorcolumn=100
  set colorcolumn=120
  highlight ColorColumn ctermbg=9
endif

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

" sensible defaults when searching
set smartcase
set ignorecase

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" " lazyredraw can make macros run faster
" set lazyredraw          " redraw only when we need to.

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

if empty(glob('~/.config/nvim/pack/minpac'))
silent !git clone https://github.com/k-takata/minpac.git
      \ ~/.config/nvim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()

if !exists("g:gui_oni")
    " status bar
    call minpac#add('bling/vim-airline')
endif

" asynchronus autocompletion
call minpac#add('Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' })

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

call minpac#add('junegunn/fzf', { 'do': 'terminal ~/.fzf/install --all' })
call minpac#add('junegunn/fzf.vim')
nnoremap <unique><silent><c-p> :Files<cr>
nnoremap <unique><silent><leader>bc :BCommits<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

call minpac#add('kassio/neoterm')
nnoremap <unique><leader>t :TREPLSendLine<cr>
vnoremap <unique><leader>t :TREPLSendSelection<cr>

let g:neoterm_default_mod = "vertical"
let g:neoterm_autoinsert = 1

call minpac#add('whatyouhide/vim-gotham')

" async linting and fixing support
call minpac#add('w0rp/ale')
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'python':     ['yapf'],
      \ }

let g:ale_pattern_options = {
      \ '\v.*\.(j|t)sx?': {
      \     'ale_fix_on_save': 1,
      \   },
      \ }

let g:ale_lint_on_save = 0
let g:ale_max_signs = 50
nnoremap <leader>af :ALEFix<cr>

" Does what it says on the tin
call minpac#add('907th/vim-auto-save')
nnoremap <leader>as :AutoSaveToggle<CR>
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1 " disable the AutoSave notification

call minpac#add('tpope/vim-commentary')

" Git wrapper
call minpac#add('tpope/vim-fugitive')

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

call minpac#add('airblade/vim-gitgutter')

let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = '∎'
let g:gitgutter_sign_removed = '⨯'

" rainbow parentheses
call minpac#add('junegunn/rainbow_parentheses.vim')
au VimEnter * RainbowParentheses

call minpac#add('tpope/vim-surround')

call minpac#add('ntpeters/vim-better-whitespace')

" Vim better whitespace mappings
nnoremap <silent> <Leader>w :StripWhitespace<CR>
nnoremap <silent> <Leader>W :ToggleWhitespace<CR>

" vim tmux integration
call minpac#add('christoomey/vim-tmux-navigator')

" vim language pack
call minpac#add('sheerun/vim-polyglot')

call minpac#add('lervag/vimtex')


" Required for operations modifying multiple buffers like rename.
set hidden
call minpac#add('autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'terminal bash install.sh'
      \ })
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'Quickfix'
let g:LanguageClient_diagnosticsEnable = 0

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

call minpac#add('Shougo/echodoc.vim')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('hynek/vim-python-pep8-indent')
call minpac#add('michaeljsmith/vim-indent-object')
call minpac#add('bps/vim-textobj-python')
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

if has('nvim') && executable('nvr')
  let $VISUAL = 'nvr --remote-wait'
endif

autocmd BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=100
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix


autocmd BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

let work_config = '~/.config/nvim/work.vim'
if filereadable(glob(work_config))
  execute 'source' work_config
endif

function! SetupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction
call SetupCommandAlias("grep", "GrepperRg")
