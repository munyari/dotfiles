Plug 'eagletmt/ghcmod-vim' | Plug 'Shougo/vimproc.vim', {'do' : 'make'}

nnoremap <silent> tw :GhcModTypeInsert<CR>
nnoremap <silent> ts :GhcModSplitFunCase<CR>
nnoremap <silent> tq :GhcModType<CR>
nnoremap <silent> te :GhcModTypeClear<CR>
