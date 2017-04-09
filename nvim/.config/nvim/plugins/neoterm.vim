" Plug 'kassio/neoterm'

" " set statusline+='%#NeotermTestRunning#%{neoterm#test#status("running")}%*'
" " set statusline+='%#NeotermTestSuccess#%{neoterm#test#status("success")}%*'
" " set statusline+='%#NeotermTestFailed#%{neoterm#test#status("failed")}%*'
" " set statusline+='%#StatusWarning#%{neoterm#test#status("running")}%*'
" " set statusline+='%#StatusSuccess#%{neoterm#test#status("success")}%*'
" " set statusline+='%#StatusError#%{neoterm#test#status("failed")}%*'

" nnoremap <leader>pry :T pry<CR><c-w><c-w>
" nnoremap <leader>gh :T ghci<CR><c-w><c-w>
" nnoremap <leader>no :T node<CR><c-w><c-w>
" let g:neoterm_position = "vertical"
" " g:neoterm_position = 'horizontal'
" nnoremap <F3> :Ttoggle<cr><esc><C-w><C-w>
" inoremap <F3> <esc>:Ttoggle<cr><esc><C-w><C-w>
