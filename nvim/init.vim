" line numbers
set number
" highlight text as you search
set incsearch

" disable arrow keys --{{{
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
" }}}

" split window navigation --{{{
nnoremap <silent> <A-h> :wincmd h<CR>
nnoremap <silent> <A-j> :wincmd j<CR>
nnoremap <silent> <A-k> :wincmd k<CR>
nnoremap <silent> <A-l> :wincmd l<CR>
" }}}

" stop vim's annoying habit of moving one left when moving from i to n
inoremap <silent> <Esc> <C-O>:stopinsert<CR>

" NERDTree mapping
nnoremap <leader>e :NERDTreeToggle<CR>
" clear search higlights when done
nnoremap <leader>q :nohlsearch<CR>
" cycle between two most recent buffers
nnoremap <C-e> :e#<CR>
" cycle through all buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bnext<CR>
" wrap lines (soft wrap)
nnoremap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

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

" automatically closes do-end block (rb)
Plug 'tpope/vim-endwise'

" status bar
Plug 'bling/vim-airline'

" auto-close parentheses
Plug 'vim-scripts/AutoClose'

" base16 colors
Plug 'chriskempson/base16-vim'

" Gist
Plug 'vim-scripts/Gist.vim'

" allows relative numbering in normal, absolute in insert
Plug 'myusuf3/numbers.vim'

" comments
Plug 'tpope/vim-commentary'

" file tree browser
Plug 'scrooloose/nerdtree'

" shows git file changes
Plug 'airblade/vim-gitgutter'

" show space indents
Plug 'Yggdroot/indentline'

" syntax checking
Plug 'scrooloose/syntastic'
call plug#end()
" }}}

"" Show the 80th column
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif


" eof character
set list
set listchars=extends:…,precedes:…,tab:\ \

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
set nofoldenable
set foldnestmax=10
set foldlevel=1
set foldcolumn=1
" }}}


" Vimscript file settings --------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


" Cucumber file settings -------------------------------------------------{{{
augroup filetype_cu
  autocmd!
  autocmd FileType cucumber   setlocal spell spelllang=en_us
augroup END
" }}}

syntax keyword javaType new

" GitGutter settings --{{{
let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = '∎'
let g:gitgutter_sign_removed = '⨯'
" }}}


" Airline settings --{{{
let g:airline_powerline_fonts=1
" }}}


" Syntastic settings --{{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" color scheme settings
source $XDG_CONFIG_HOME/nvim/colors.vim
