Plug 'takac/vim-hardtime'

" default - hardtime is on
let g:hardtime_default_on = 1
" timeout for disabled keys
let g:hardtime_timeout = 1000
let g:list_of_disabled_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" two different disabled keys are allowed in sequence
let g:hardtime_allow_different_key = 1
