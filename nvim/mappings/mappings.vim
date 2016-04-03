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
