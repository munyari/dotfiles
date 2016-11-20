Plug 'let-def/vimbufsync' | Plug 'the-lambda-church/coquille'

augroup filetype_coq
  autocmd!
  " autocmd BufEnter *.v :CoqLaunch<cr>
  autocmd Filetype coq :CoqLaunch<cr>
  autocmd FileType coq nnoremap <right> :CoqToCursor<cr>
  autocmd FileType coq nnoremap U :CoqUndo<cr>
augroup END
