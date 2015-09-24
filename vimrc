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
set expandtab
set shiftwidth=2
set softtabstop=2
set shiftround

set smarttab

set ai "Auto indent
set si "Smart indent

syntax enable
set background=dark
"
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif


"" Plugin that fixes trailing whitespaces
"Plug 'bronson/vim-trailing-whitespace'

"" Show the 80th column
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

"" Airblade - git
"Plug 'airblade/vim-gitgutter'


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
"
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" airline status bar
Plugin 'bling/vim-airline'
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" Plugin: better whitespace
Bundle 'ntpeters/vim-better-whitespace'

" Plugin: vim-snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Optional:
Plugin 'honza/vim-snippets'

" base16
Plugin 'chriskempson/base16-vim'
colorscheme base16-ocean
let base16colorspace=256

" eof character
set list
set listchars=eol:¬,extends:…,precedes:…,tab:\ \


"Molokai colorscheme
Plugin 'tomasr/molokai'

" Colorscheme settings
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Settings for iTerm2 on OS X
    set background=dark
    let base16colorspace=256
    colorscheme base16-ocean
  else
    " Settings for Terminator on Linux
    let g:molokai_original=1
    let g:rehash256=1
    colorscheme molokai
    " Transparent background
    hi Normal guibg=NONE ctermbg=NONE
  endif
endif

" Ctags path
set tags=./tags,tags;$HOME

" leader keys
let mapleader = ","
let maplocalleader = "\\"

" email abbreviation
iabbrev pfeml Panashe Fundira<cr>fundirap@gmail.com

" Mappings ---------------{{{
" A simple mapping to move lines down
noremap <leader>- ddp
" Easily upcase a word in insert mode
inoremap <leader><c-u> <esc>viwUi
" Easily upcase a word in normal mode
nnoremap <leader><c-u> viwU
" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" vertical split with previous buffer
nnoremap <leader>vs :execute "rightbelow vsplit " . bufname("#")

inoremap jk <esc>
inoremap <esc> <nop>

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>

onoremap il( :<c-u>normal! F)vi(<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>

onoremap an( :<c-u>normal! f(v%<cr>
onoremap an{ :<c-u>normal! f{v%<cr>
onoremap an[ :<c-u>normal! f[v%<cr>

onoremap al( :<c-u>normal! F)v%<cr>
onoremap al{ :<c-u>normal! F{v%<cr>
onoremap al[ :<c-u>normal! F[v%<cr>
" }}}

" Javascript file settings -------------------------------------------{{{
augroup filetype_javascript
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
  autocmd FileType javascript :iabbrev <buffer> re return<left>
  autocmd FileType javascript :iabbrev <buffer> return NOPENOPENOPE
augroup END
" }}}

" Java file settings -------------------------------------------------{{{
augroup filetype_java
  autocmd!
  autocmd FileType java       nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType java       iabbrev <buffer> iff if ()<left>
  autocmd FileType java       :iabbrev <buffer> re return<left>
  autocmd FileType java       :iabbrev <buffer> return NOPENOPENOPE
augroup END
" }}}

" Python file settings ---------------------------------------------------{{{
augroup filetype_python
  autocmd!
  autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
  autocmd FileType python     :iabbrev <buffer> iff if:<left>
  autocmd FileType python     :iabbrev <buffer> re return<left>
  autocmd FileType python     :iabbrev <buffer> return NOPENOPENOPE
augroup END
" }}}

" Ruby file settings ---------------------------------------------------{{{
augroup filetype_ruby
  autocmd!
  autocmd FileType ruby       nnoremap <buffer> <localleader>c I#<esc>
  autocmd FileType ruby       :iabbrev <buffer> re return<left>
  autocmd FileType ruby       :iabbrev <buffer> return NOPENOPENOPE
augroup END
" }}}


" TeX file settings -------------------------------------------------{{{
augroup filetype_tex
  autocmd!
  autocmd FileType tex   setlocal spell spelllang=en_us
augroup END
" }}}

" Markdown file settings -------------------------------------------------{{{
augroup filetype_md
  autocmd!
  autocmd FileType markdown   setlocal spell spelllang=en_us
  autocmd FileType markdown   onoremap ih :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rkvg_"<cr> 
  autocmd FileType markdown   onoremap ah :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rg_vk0"<cr> 
augroup END
" }}}

" Vimscript file settings --------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
