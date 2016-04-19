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

" terminal naviagation mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
