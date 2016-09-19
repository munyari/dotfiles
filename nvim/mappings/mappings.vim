" source init.vim
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>ev :e $MYVIMRC<CR>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" indent and return to the same line
nnoremap <Leader>i mmgg=G`m<CR>

" paste from system clipboard at proper indentation level
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

if (has('nvim'))
  " terminal naviagation mappings
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" remove search highlighting in normal mode
nnoremap <silent> <Esc> :nohlsearch<Esc>

" make arrow keys do something useful
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Easily upcase a word in normal mode
nnoremap <leader><c-u> viWU
"
inoremap <leader><c-u> <esc>viWUi

iabbrev <buffer> re return<left>
iabbrev <buffer> return NOPENOPENOPE

" A simple mapping to move lines down
nnoremap <leader><down> ddp

" vertical split with previous buffer
nnoremap <leader>vs :execute "rightbelow vsplit " . bufname("#")<cr>

" automatically make searches "very magic"
nnoremap / /\v

" change working directory to that of the current file
nnoremap <silent><leader>cd :cd %:p:h<cr>
