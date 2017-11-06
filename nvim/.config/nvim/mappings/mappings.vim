" source init.vim
nnoremap <unique> <Leader>sv :source $MYVIMRC<CR>
nnoremap <unique> <Leader>ev :e $MYVIMRC<CR>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <unique> <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <unique> <leader>= :wincmd =<cr>

" indent and return to the same line
nnoremap <unique> <Leader>i mmgg=G`m<CR>

" paste from system clipboard at proper indentation level
nnoremap <unique> <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

if has('nvim')
  " terminal naviagation mappings
  " TODO: I'm having some weird issues where I open a new terminal buffer
  " and the window doesn't change, just enter insert mode
  tnoremap <Esc><Esc> <C-\><C-n>:q<cr>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" remove search highlighting in normal mode
nnoremap <unique> <silent> <Esc> :nohlsearch<Esc>

" make arrow keys do something useful
nnoremap <unique> <Left> :vertical resize +2<CR>
nnoremap <unique> <Right> :vertical resize -2<CR>
nnoremap <unique> <Up> :resize +2<CR>
nnoremap <unique> <Down> :resize -2<CR>

" Easily upcase a word in normal mode
nnoremap <unique> <leader><c-u> viWU
"
" inoremap <leader><c-u> <esc>viWUi

" A simple mapping to move lines down
nnoremap <unique> <leader><down> ddp

" vertical split with previous buffer
nnoremap <unique> <leader>vs :execute "rightbelow vsplit " . bufname("#")<cr>

" change working directory to that of the current file
nnoremap <unique> <silent><leader>cd :cd %:p:h<cr>

" edit the previous buffer
nnoremap <unique> <BS> <C-^>

" move to next and previous location
nnoremap <unique> [l :lprevious<cr>
nnoremap <unique> ]l :lnext<cr>

" move to next previous quickfix
nnoremap <unique> [q :cprevious<cr>
nnoremap <unique> ]q :cnext<cr>

" move to next and previous buffer
nnoremap <unique> [b :bprevious<cr>
nnoremap <unique> ]b :bnext<cr>
