# vim:ft=vim
''
let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = '∎'
let g:gitgutter_sign_removed = '⨯'
let g:gitgutter_sign_column_always = 1
nnoremap <unique> [g :GitGutterPrevHunk<cr>
nnoremap <unique> ]g :GitGutterNextHunk<cr>
nnoremap <unique> <leader>hs :GitGutterStageHunk<cr>
nnoremap <unique> <leader>hp :GitGutterPreviewHunk<cr>
nnoremap <unique> <leader>hu :GitGutterUndoHunk<cr>
''
