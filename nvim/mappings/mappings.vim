" source init.vim
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>ev :e $MYVIMRC<CR>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
