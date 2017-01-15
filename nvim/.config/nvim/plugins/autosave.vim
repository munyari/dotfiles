Plug '907th/vim-auto-save'

" auto save mapping
nnoremap <leader>as :AutoSaveToggle<CR>

"auto save settings
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1 " disable the AutoSave notification
