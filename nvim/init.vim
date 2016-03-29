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

call plug#begin('~/.vim/plugged')
call s:SourceConfigFilesIn('plugins')
call plug#end()

" tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

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

colorscheme gotham

"" A hack around a small nvim/vim
" incompatability about how they handle <C-h> https://goo.gl/NCkU2D
" This makes vim-tmux-navigator work. Hopefully will be fixed upstream
" soon
if has('nvim')
  nnoremap <BS> <C-w>h
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
