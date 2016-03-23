Plug 'thoughtbot/vim-rspec'

" vim rspec settings
let g:rspec_command = "call VtrSendCommand('rspec {spec}')"

" RSpec.vim mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR> 
" Vim better whitespace mappings
nnoremap <Leader>w :StripWhitespace<CR>
nnoremap <Leader>W :ToggleWhitespace<CR>
