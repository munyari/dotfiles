Plug 'airblade/vim-gitgutter'

let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = '∎'
let g:gitgutter_sign_removed = '⨯'
let g:gitgutter_sign_column_always = 1

nnoremap <unique><silent>]g :GitGutterNextHunk<cr>
nnoremap <unique><silent>[g :GitGutterPrevHunk<cr>
