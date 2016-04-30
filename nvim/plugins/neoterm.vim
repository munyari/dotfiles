Plug 'kassio/neoterm'

" set statusline+='%#NeotermTestRunning#%{neoterm#test#status("running")}%*'
" set statusline+='%#NeotermTestSuccess#%{neoterm#test#status("success")}%*'
" set statusline+='%#NeotermTestFailed#%{neoterm#test#status("failed")}%*'
" set statusline+='%#StatusWarning#%{neoterm#test#status("running")}%*'
" set statusline+='%#StatusSuccess#%{neoterm#test#status("success")}%*'
" set statusline+='%#StatusError#%{neoterm#test#status("failed")}%*'

nnoremap <leader>repl :T pry<CR>
let g:neoterm_position = "vertical"
" g:neoterm_position = 'horizontal'
