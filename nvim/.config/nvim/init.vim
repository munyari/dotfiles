" basic settings {{{
" line numbers
set number
set relativenumber

" if !has('nvim')
"   set smarttab
"   set autoindent
"   set wildmenu
"   syntax enable
" else
"   " Convenient command to see the difference between the current buffer and the
"   " file it was loaded from, thus the changes you made.
"   " Only define it when not defined already.
"   if !exists(":DiffOrig")
"     command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
"           \ | wincmd p | diffthis
"   endif
" endif

" " stop vim's annoying habit of moving cursor one left when leaving insert
" let CursorColumnI = 0 "the cursor column position in INSERT
" autocmd InsertEnter * let CursorColumnI = col('.')
" autocmd CursorMovedI * let CursorColumnI = col('.')
" autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" " make space bar leader key
" let mapleader="\<Space>"

" " tab settings
" set expandtab
" set shiftwidth=2
" set softtabstop=2
" " always round indent to a multiple of shift width
" set shiftround

" "" Show the 80th column
" if exists('+colorcolumn')
"   set colorcolumn=80
"   highlight ColorColumn ctermbg=9
" endif

" " make vim write to swap file more frequently
" set updatetime=250

" " minimal number of screen lines to keep below and above the cursor
" set scrolloff=3
" " set cursorline

" " creates undofile, allows undo even after closing
" if has('persistent_undo')
"   set undolevels=5000
"   set undofile
" endif

" set background=dark

" " always split below/right
" set splitbelow
" set splitright

" " never conceal text from me. Ever
" let g:conceallevel=0

" if executable('rg')
"   set grepprg=rg\ --vimgrep
"   set grepformat=%f:%l:%c:%m
" elseif executable('sift')
"   set grepprg=sift\ -nMs\ --no-color\ --binary-skip\ --column\ --no-group\ --git\ --follow
"   set grepformat=%f:%l:%c:%m
" elseif executable('ag')
"   set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
"   set grepformat=%f:%l:%c:%m,%f:%l:%m
" elseif executable('ack')
"   set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
"   set grepformat=%f:%l:%c:%m,%f:%l:%m
" endif

" " automatically rebalance windows on vim resize
" autocmd VimResized * :wincmd =

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
call s:SourceConfigFilesIn('plugins')
call plug#end()
" }}}

" color settings {{{
colorscheme jellybeans
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
set inccommand=nosplit

" automatically put additions to unnamed reg in clipboard ('+' reg)
set clipboard=unnamedplus
