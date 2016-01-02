" line numbers
set number

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

Plug 'scrooloose/nerdtree'
call plug#end()
" }}}
