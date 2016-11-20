if has('nvim')
  " asynchronus autocompletion
  Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
endif

let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
