Plug 'lervag/vimtex', { 'for': 'tex' }

let g:vimtext_enabled = 0
let g:vimtex_view_method = 'zathura'

Plug 'xuhdev/vim-latex-live-preview'
let g:livepreview_previewer='zathura'
" make this local to tex
autocmd! BufWritePost * VimtexCompile
