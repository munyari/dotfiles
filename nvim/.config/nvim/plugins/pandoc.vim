Plug 'vim-pandoc/vim-pandoc'

let g:pandoc#formatting#mode = 'haA'
let g:pandoc#formatting#textwidth = 80
let g:pandoc#folding#fold_yaml = 1
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#folding#level = 0
let g:pandoc#filetypes#handled = ["pandoc", "markdown", "latex"]
let g:pandoc#folding#fdc = 0

nnoremap <localleader>p :Pandoc! pdf<cr>
nnoremap <localleader>w :au BufWritePost *.md :Pandoc pdf<cr>
