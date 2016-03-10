" line numbers
set number

" stop vim's annoying habit of moving cursor one left when leaving insert
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" make space bar leader key
let mapleader="\<Space>"

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
call s:SourceConfigFilesIn('plugins')

" RSpec.vim mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR> 
" Vim better whitespace mappings
nnoremap <Leader>w :StripWhitespace<CR>
nnoremap <Leader>W :ToggleWhitespace<CR>

" rainbow parentheses mappings
nnoremap <Leader>r :RainbowParenthesesToggle<CR>

" vtr mappings
nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>

" auto save mapping
nnoremap <leader>as :AutoSaveToggle<CR>

" tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

syntax enable

" search highlighting --{{{
set hlsearch
highlight Search cterm=NONE ctermfg=black ctermbg=blue
" }}}

" vim-plug --{{{
call plug#begin('~/.vim/plugged')
" sensible defaults we can all agree on
Plug 'tpope/vim-sensible'

" Git wrapper
Plug 'tpope/vim-fugitive'

" status bar
Plug 'bling/vim-airline'

" auto-close parentheses
Plug 'jiangmiao/auto-pairs'

" Gist
Plug 'vim-scripts/Gist.vim'

" allows relative numbering in normal, absolute in insert
Plug 'myusuf3/numbers.vim'

" comments
Plug 'tpope/vim-commentary'

" shows git file changes
Plug 'airblade/vim-gitgutter'

" C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" rspec in vim
Plug 'thoughtbot/vim-rspec'

" Rails in vim
Plug 'tpope/vim-rails'

" autocloses def end in ruby, etc
Plug 'tpope/vim-endwise'

" whitespace stuff
Plug 'ntpeters/vim-better-whitespace'

" fancy start screen
Plug 'mhinz/vim-startify'

" rainbow parentheses
Plug 'kien/rainbow_parentheses.vim'

Plug 'Yggdroot/indentLine'

" Plug 'wikitopian/hardmode'
Plug 'takac/vim-hardtime'

if has('nvim')
  " asynchronus autocompletion
  Plug 'Shougo/deoplete.nvim'
endif

" vim tmux integration
Plug 'christoomey/vim-tmux-navigator'

" vim tmux runner
Plug 'christoomey/vim-tmux-runner'

" gotham color scheme
Plug 'whatyouhide/vim-gotham'

Plug 'edkolev/tmuxline.vim'

Plug 'amirh/HTML-AutoCloseTag'

Plug '907th/vim-auto-save'

"Fuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()
" }}}
"" Show the 80th column
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

" make vim write to swap file more frequently
set updatetime=250

" minimal number of screen lines to keep below and above the cursor
set scrolloff=3
" set cursorline

" creates undofile, allows undo even after closing
set undofile

set background=dark

" folding settings {{{
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1
" }}}


" Vimscript file settings --------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldenable
augroup END
" }}}

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" vim hard mode is default
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
let g:hardtime_default_on = 1
let g:hardtime_timeout = 1000
let g:list_of_disabled_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:hardtime_allow_different_key = 1

" GitGutter settings --{{{
let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = '∎'
let g:gitgutter_sign_removed = '⨯'
" }}}

" rainbow parentheses settings --{{{
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}

" powerline symbols in airline
let g:airline_powerline_fonts = 1

" deoplete settings ---{{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

" vim rspec settings
let g:rspec_command = "call VtrSendCommand('rspec {spec}')"

" vim startify settings
let g:startify_bookmarks = [{'v':'~/.config/nvim/init.vim'}]

"auto save settings
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0

colorscheme gotham

"" A hack around a small nvim/vim
" incompatability about how they handle <C-h> https://goo.gl/NCkU2D
" This makes vim-tmux-navigator work. Hopefully will be fixed upstream
" soon
if has('nvim')
  nnoremap <BS> <C-w>h
endif
