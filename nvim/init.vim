" line numbers
set number

if (!has('nvim'))
  set smarttab
  set autoindent
  set wildmenu
  source $VIMRUNTIME/defaults.vim " TODO: unnecessary with Vim8
else
  " Convenient command to see the difference between the current buffer and the
  " file it was loaded from, thus the changes you made.
  " Only define it when not defined already.
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
  endif
endif

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
" always round indent to a multiple of shift width
set shiftround

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
if has('persistent_undo')
  set undolevels=5000
  set undofile
endif

set background=dark

" folding settings {{{
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1
set foldcolumn=1
" }}}


" Vimscript file settings --------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldenable
augroup END
" }}}
" TODO: If syntax is set, it seems to use that foldmethod, no matter what.
" Find a way to fix this

" Rust file settings --------------------{{{
augroup filetype_rust
  autocmd!
  autocmd FileType rust setlocal tags=./rusty-tags.vi;/
  autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"
augroup END
" }}}

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

colorscheme gotham

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" swap file rotated after 10 keystrokes (never lose more than 10 keystrokes
" if something goes wrong). Default is 200
set updatecount=10

" always split below/right
set splitbelow
set splitright

" lazyredraw can make macros run faster
set lazyredraw          " redraw only when we need to.



" Automatically enter insert when entering a terminal window
autocmd BufEnter * if &buftype == "terminal" | startinsert | endif
let g:tex_conceal = ""

let g:markdown_fenced_languages = ['ruby', 'bash=sh', 'python']
let g:markdown_syntax_conceal = 0

" never conceal text from me. Ever
let g:conceallevel=0

if (has('nvim'))
  set termguicolors
endif

" These mappings are more for inspiration than anything useful
" Markdown file settings -------------------------------------------------{{{
augroup filetype_md
  autocmd!
  autocmd FileType markdown   onoremap ih :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rkvg_"<cr>
  autocmd FileType markdown   onoremap ah :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}
