
" rainbow parentheses
Plug 'kien/rainbow_parentheses.vim'

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" rainbow parentheses mappings
nnoremap <Leader>r :RainbowParenthesesToggle<CR>

